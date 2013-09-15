/*
===========================================================================

  Copyright (c) 2010-2012 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

  This file is part of DarkStar-server source code.

===========================================================================
*/

#include "transport.h"

#include "entities/charentity.h"
#include "map.h"
#include "vana_time.h"
#include "zone.h"
#include "utils/zoneutils.h"
#include "utils/charutils.h"
#include "packets/event.h"
#include "packets/char.h"
#include "packets/entity_update.h"
#include "packets/char_abilities.h"
#include "packets/char_appearance.h"
#include "packets/char_jobs.h"
#include "packets/char_job_extra.h"
#include "packets/char_equip.h"
#include "packets/char_health.h"
#include "packets/char_skills.h"
#include "packets/char_spells.h"
#include "packets/char_stats.h"
#include "packets/char_sync.h"
#include "packets/char_update.h"
#include "packets/chat_message.h"
#include "packets/chat_message_string.h"
#include "packets/position.h"


/************************************************************************
*                                                                       *
*  Создание глобальной ссылки на объект класса                          *
*                                                                       *
************************************************************************/

CTransportHandler* CTransportHandler::_instance = NULL;

CTransportHandler* CTransportHandler::getInstance() 
{
	if(_instance == NULL) {
		_instance = new CTransportHandler();
	}
	return _instance;
}

/************************************************************************
*                                                                       *
*  В конструкторе инициализируем всю транспортную систему               *
*                                                                       *
************************************************************************/

CTransportHandler::CTransportHandler() 
{
   InitializeTransport();
   //InitializeElevators();
}

/************************************************************************
*                                                                       *
*  Инициализация транспорта (корабли и самолеты)                        *
*                                                                       *
************************************************************************/
CTransportHandler::CTransportHandler(CBaseEntity* PEntity)
{
	m_PBaseEntity = PEntity;
}
void CTransportHandler::InitializeTransport()
{
	
    

    const int8* fmtQuery = "SELECT id, transport, door, dock_x, dock_y, dock_z, dock_rot, boundary, zone, anim_arrive, anim_depart, time_offset, time_interval, time_waiting, time_anim_arrive, time_anim_depart  FROM transport;";

	int32 ret = Sql_Query(SqlHandle, fmtQuery);

	if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS) 
		{
            Transport_t* PTransport = new Transport_t;

            PTransport->Dock.zone = zoneutils::GetZone((Sql_GetUIntData(SqlHandle,1) >> 12) & 0x0FFF);
            PTransport->Dock.p.x  = Sql_GetFloatData(SqlHandle,3);
            PTransport->Dock.p.y  = Sql_GetFloatData(SqlHandle,4);
            PTransport->Dock.p.z  = Sql_GetFloatData(SqlHandle,5);
            PTransport->Dock.p.rotation = (uint8) Sql_GetIntData(SqlHandle,6);
            PTransport->Dock.boundary   = (uint16)Sql_GetIntData(SqlHandle,7);
            PTransport->Dock.prevzone   = (uint8) Sql_GetIntData(SqlHandle,8);

            PTransport->PDoorNPC      = zoneutils::GetEntity(Sql_GetUIntData(SqlHandle,2), TYPE_NPC);
            PTransport->PTransportNPC = zoneutils::GetEntity(Sql_GetUIntData(SqlHandle,1), TYPE_SHIP);

            PTransport->AnimationArrive = (uint8)Sql_GetIntData(SqlHandle, 9);
            PTransport->AnimationDepart = (uint8)Sql_GetIntData(SqlHandle,10);

            PTransport->TimeOffset   = (uint16)Sql_GetIntData(SqlHandle,11);
            PTransport->TimeInterval = (uint16)Sql_GetIntData(SqlHandle,12);
            PTransport->TimeWaiting  = (uint16)Sql_GetIntData(SqlHandle,13);
            PTransport->TimeAnimationArrive = (uint16)Sql_GetIntData(SqlHandle,14);
            PTransport->TimeAnimationDepart = (uint16)Sql_GetIntData(SqlHandle,15);

            if (PTransport->PDoorNPC == NULL ||
                PTransport->PTransportNPC == NULL)
            {
                ShowError("Transport <%u>: transport or door not found\n", (uint8)Sql_GetIntData(SqlHandle,0));
                delete PTransport;
                continue;
            }
            if (PTransport->TimeAnimationArrive < 10)
            {
                ShowError("Transport <%u>: time_anim_arrive must be > 10\n", (uint8)Sql_GetIntData(SqlHandle,0));
                delete PTransport;
                continue;
            }
            if (PTransport->TimeInterval < PTransport->TimeAnimationArrive + PTransport->TimeWaiting + PTransport->TimeAnimationDepart)
            {
                ShowError("Transport <%u>: time_interval must be > time_anim_arrive + time_waiting + time_anim_depart\n", (uint8)Sql_GetIntData(SqlHandle,0));
                delete PTransport;
                continue;
            }
            PTransport->PTransportNPC->name.resize(8);
            TransportList.push_back(PTransport);
        }
    }
	return;
}


/************************************************************************
*                                                                       *
*  Инициализация лифтов и автоматических дверей                         *
*                                                                       *
************************************************************************/

void CTransportHandler::InitializeElevators(CBaseEntity* PEntity)
{
	if(m_PBaseEntity == NULL)
	{
		//ELEVATORS ARE CALLED BY PLAYERS IN ZONE OR IN DISTANCE OF OR WITH NPC TRIGGER
		return;
	}
    
	const int8* fmtQuery = "SELECT id, elevator, lowerDoor, upperDoor, status, regime,animation FROM elevators ;";

	int32 ret = Sql_Query(SqlHandle, fmtQuery);

	if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS) 
		{
			Elevator_t* elevator = new Elevator_t;

			elevator->id = (uint8)Sql_GetUIntData(SqlHandle,0);
			elevator->zone = (uint16)((Sql_GetUIntData(SqlHandle,1) >> 12) & 0x0FFF);

			elevator->Elevator  = (CNpcEntity*)zoneutils::GetEntity(Sql_GetUIntData(SqlHandle,1), TYPE_NPC);

			if (elevator->Elevator != NULL)
			{
			elevator->Elevator->animation = (uint8)Sql_GetUIntData(SqlHandle,6);
			}
			elevator->LowerDoor = (CNpcEntity*)zoneutils::GetEntity(Sql_GetUIntData(SqlHandle,2), TYPE_NPC);
			elevator->UpperDoor = (CNpcEntity*)zoneutils::GetEntity(Sql_GetUIntData(SqlHandle,3), TYPE_NPC);

			
			
			if (elevator->Elevator != NULL)
			{
				elevator->Elevator->name.resize(10);
				ElevatorList.push_back(elevator);
				
			}
			
		}
	}
	return;
}

/************************************************************************
*                                                                       *
*  Все логика передвижения транспорта                                   *
*                                                                       *
************************************************************************/

void CTransportHandler::TransportTimer() 
{
	
	uint32 VanaTime = CVanaTime::getInstance()->getDate();
	
    for(uint32 i = 0; i < TransportList.size(); ++i)
    {
        Transport_t* PTransport = TransportList.at(i);

        uint16 ShipTimerOffset = ((VanaTime - PTransport->TimeOffset) % PTransport->TimeInterval);

        // корабль появляется на горизонте
        if (ShipTimerOffset == 0)
        {
            PTransport->PTransportNPC->status = STATUS_NORMAL;
            PTransport->PTransportNPC->animation = PTransport->AnimationArrive;
            PTransport->PTransportNPC->loc = PTransport->Dock;

            WBUFL(&PTransport->PTransportNPC->name[0],4) = CVanaTime::getInstance()->getVanaTime();

            PTransport->Dock.zone->PushPacket(NULL, CHAR_INZONE, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_SPAWN));
			PTransport->Dock.zone->PushPacket(NULL, CHAR_INRANGE, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_SPAWN));
			//PTransport->Dock.zone->PushPacket(NULL, CHAR_INRANGE_SELF, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_SPAWN));
        }
        // персонажи видят корабль, иначе ждем следующего прибытия
        else if (PTransport->PTransportNPC->status == STATUS_NORMAL) 
        {
            // пора подтягивать пассажиров к выходу
            if (ShipTimerOffset ==  PTransport->TimeAnimationArrive - 10) 
            {
                PTransport->PTransportNPC->loc.boundary = 0;
                zoneutils::GetZone(PTransport->Dock.prevzone)->TransportDepart(PTransport->PTransportNPC);
            }
            // корабль причалил, открываем двери пассажирам
            else if (ShipTimerOffset == PTransport->TimeAnimationArrive)
            {
                PTransport->PDoorNPC->animation = ANIMATION_CLOSE_DOOR;
                PTransport->Dock.zone->PushPacket(PTransport->PDoorNPC, CHAR_INZONE, new CEntityUpdatePacket(PTransport->PDoorNPC, ENTITY_UPDATE)); 
				PTransport->Dock.zone->PushPacket(PTransport->PDoorNPC, CHAR_INRANGE, new CEntityUpdatePacket(PTransport->PDoorNPC, ENTITY_UPDATE)); 
				//PTransport->Dock.zone->PushPacket(PTransport->PDoorNPC, CHAR_INRANGE_SELF, new CEntityUpdatePacket(PTransport->PDoorNPC, ENTITY_UPDATE)); 
            }
            //корабль отчаливает
            else if (ShipTimerOffset == PTransport->TimeAnimationArrive + PTransport->TimeWaiting)
            {
                PTransport->PDoorNPC->animation = ANIMATION_OPEN_DOOR;
                PTransport->PTransportNPC->animation = PTransport->AnimationDepart;
                PTransport->PTransportNPC->loc.boundary = PTransport->Dock.boundary;

                WBUFL(&PTransport->PTransportNPC->name[0],4) = CVanaTime::getInstance()->getVanaTime();

                PTransport->Dock.zone->TransportDepart(PTransport->PTransportNPC);
				PTransport->Dock.zone->PushPacket(PTransport->PDoorNPC, CHAR_INZONE, new CEntityUpdatePacket(PTransport->PDoorNPC, ENTITY_UPDATE)); 
                PTransport->Dock.zone->PushPacket(PTransport->PDoorNPC, CHAR_INRANGE, new CEntityUpdatePacket(PTransport->PDoorNPC, ENTITY_UPDATE));
				//PTransport->Dock.zone->PushPacket(PTransport->PDoorNPC, CHAR_INRANGE_SELF, new CEntityUpdatePacket(PTransport->PDoorNPC, ENTITY_UPDATE)); 
                PTransport->Dock.zone->PushPacket(NULL, CHAR_INZONE, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_UPDATE));
				PTransport->Dock.zone->PushPacket(NULL, CHAR_INRANGE, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_UPDATE));
				//PTransport->Dock.zone->PushPacket(NULL, CHAR_INRANGE_SELF, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_UPDATE));
				
            }
            //корабль исчезает
            else if (ShipTimerOffset == PTransport->TimeAnimationArrive + PTransport->TimeWaiting + PTransport->TimeAnimationDepart)
            {
                PTransport->PTransportNPC->status = STATUS_DISAPPEAR;
                PTransport->Dock.zone->PushPacket(NULL, CHAR_INZONE, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_DESPAWN));
				PTransport->Dock.zone->PushPacket(NULL, CHAR_INRANGE, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_DESPAWN));
				//PTransport->Dock.zone->PushPacket(NULL, CHAR_INRANGE_SELF, new CEntityUpdatePacket(PTransport->PTransportNPC, ENTITY_DESPAWN));
            }
        }
    }
	
	 
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/


void CTransportHandler::ElevatorDown(int32 elevatorID, CBaseEntity* m_PBaseEntity)
{
	if(m_PBaseEntity == NULL)
	{
		//JUST IN CASE
		return;
	}
	//ShowDebug(CL_GREEN"START EVELVATOR %u\n"CL_RESET, m_PBaseEntity );
    for(uint32 i = 0; i < ElevatorList.size(); ++i) 
	{		
	    Elevator_t * elevator = ElevatorList.at(i);

		if (elevator->id == elevatorID)
		{
			
			CTransportHandler::ElevatorDown(elevator,m_PBaseEntity);
            return;
		}
    }
}
void CTransportHandler::ElevatorUp(int32 elevatorID, CBaseEntity* m_PBaseEntity)
{
	if(m_PBaseEntity == NULL)
	{
		//JUST IN CASE
		return;
	}
	//ShowDebug(CL_GREEN"START EVELVATOR %u\n"CL_RESET, m_PBaseEntity );
    for(uint32 i = 0; i < ElevatorList.size(); ++i) 
	{		
	    Elevator_t * elevator = ElevatorList.at(i);

		if (elevator->id == elevatorID)
		{
			
			CTransportHandler::ElevatorUp(elevator,m_PBaseEntity);

            return;
		}
    }
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/
void CTransportHandler::ELEVATOR__PALBOROUGH__MINES__ELVTR(int32 elevatorID, CBaseEntity* m_PBaseEntity)
{
	if(m_PBaseEntity == NULL)
	{
		//JUST IN CASE
		return;
	}
	//ShowDebug(CL_GREEN"START EVELVATOR %u\n"CL_RESET, m_PBaseEntity );
    for(uint32 i = 0; i < ElevatorList.size(); ++i) 
	{		
	    Elevator_t * elevator = ElevatorList.at(i);

		if (elevator->id == elevatorID)
		{
			
			CTransportHandler::ELEVATOR__PALBOROUGH__MINES__ELVTR(elevator,m_PBaseEntity);

            return;
		}
    }
}

//ON PLAYER CALL ELEVATOR
void CTransportHandler::ELEVATOR__PALBOROUGH__MINES__ELVTR(Elevator_t * elevator , CBaseEntity* m_PBaseEntity)
{
	if(m_PBaseEntity == NULL)
	{
		//JUST IN CASE
		return;
	}
	if ((elevator->LowerDoor != NULL) && (elevator->UpperDoor != NULL)) 
	{ 
	if(elevator->id == ELEVATOR_PALBOROUGH_MINES_ELVTR)
		     {
				 ShowDebug(CL_GREEN"ELEVATOR_PALBOROUGH_MINES_ELVTR\n"CL_RESET );
				
				  //NOTE: .setpos 185.192 -32.000 62.840 128 143 LOCATION OF THE EVELVATOR
				
                 elevator->Elevator->name[8] = 20; //CORRECT SPEED WITH SOUND IN GAME
                CVanaTime* VanaTime = new CVanaTime();
				//A PERSONAL EXTRA FUNCTION JUST FOR THE TIMING OF THE ELEVATORS IF ANY ONE IS SMART ENOUGH TO SOLVE IT
				//WBUFL(&elevator->Elevator->name[0],4) =VanaTime->getInstance()->getVanaElevatorTime();
				//FOR THE TIME WILL BE USING THIS FUCTION IT WORKS CORRECTLY EVERY 1 minute and 30 seconds the rest of the time its either just 
				//slams down or up or freezes so will just disable it so it works every time
				//WBUFL(&elevator->Elevator->name[0],4) =VanaTime->getInstance()->getVanaTime();
			   
			     
			        if(m_PBaseEntity != NULL)
					{
						elevator->Elevator->animation ^= 1;
						const int8* Query = "UPDATE elevators SET animation = '%u' WHERE id = %u";
                        Sql_Query(SqlHandle,Query,elevator->Elevator->animation,elevator->id);

						//THE DOORS NEED UPDATED IN THE DATABASE AS WELL IN THE NPC TABLE TO KNOW IF THEY ARE OPEN OR SHUT
						//AND THE ELEVATOR IN THE NPC TABLE TO DO FIND THE REAL IDS OF THE ELEVATOR AND THE DOORS IN THE NPC TABLE TO UPDATE

						if(elevator->Elevator->animation == ANIMATION_ELEVATOR_UP)
						{
							
						
                        ShowDebug(CL_GREEN"UP %u \n"CL_RESET,elevator->Elevator->animation );
						elevator->LowerDoor->animation =ANIMATION_CLOSE_DOOR ? elevator->LowerDoor->animation =ANIMATION_OPEN_DOOR :elevator->LowerDoor->animation =ANIMATION_CLOSE_DOOR;
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE_SELF, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));

						elevator->UpperDoor->animation =ANIMATION_OPEN_DOOR ? elevator->UpperDoor->animation =ANIMATION_CLOSE_DOOR :elevator->UpperDoor->animation =ANIMATION_OPEN_DOOR;
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE_SELF, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));

						}
						if(elevator->Elevator->animation == ANIMATION_ELEVATOR_DOWN)
						{
						
                        ShowDebug(CL_GREEN"DOWN %u \n"CL_RESET,elevator->Elevator->animation );
						elevator->LowerDoor->animation =ANIMATION_OPEN_DOOR ? elevator->LowerDoor->animation =ANIMATION_CLOSE_DOOR :elevator->LowerDoor->animation =ANIMATION_OPEN_DOOR;
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE_SELF, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));

						
						elevator->UpperDoor->animation =ANIMATION_CLOSE_DOOR ? elevator->UpperDoor->animation =ANIMATION_OPEN_DOOR :elevator->UpperDoor->animation =ANIMATION_CLOSE_DOOR;
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE_SELF, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));

						}
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
						zoneutils::GetZone(m_PBaseEntity->getZone())->PushPacket(m_PBaseEntity,CHAR_INRANGE_SELF, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
						
						ShowDebug(CL_GREEN"MOVING NOW FOR PCHAR = %s ZONE %u \n"CL_RESET,m_PBaseEntity->GetName(),m_PBaseEntity->loc.zone ); 
						
				    }
					
					 

			  }
	}
}
//ON ZONEINE ELEVATOR NOCALL IS REQUIRED OTHER THEN BEING IN THAT ZONE
void CTransportHandler::ElevatorUp(Elevator_t * elevator , CBaseEntity* m_PBaseEntity)
{
	if(m_PBaseEntity == NULL)
	{
		//JUST IN CASE
		return;
	}
	
	/*
	ELEVATOR_PSOXJA_ELVTR_1					= 1,
	ELEVATOR_PSOXJA_ELVTR_2					= 2,
	ELEVATOR_PSOXJA_ELVTR_3					= 3,
	ELEVATOR_PSOXJA_MVNG_FLR_4				= 4,
	ELEVATOR_PSOXJA_MVNG_FLR_3				= 5,
	ELEVATOR_PSOXJA_MVNG_FLR_1				= 6,
	ELEVATOR_PSOXJA_MVNG_FLR_2				= 7,
	ELEVATOR_PSOXJA_1						= 8,
	ELEVATOR_PSOXJA_2						= 9,
	ELEVATOR_PSOXJA_3						= 10,
	ELEVATOR_PSOXJA_4						= 11,
	ELEVATOR_PSOXJA_5						= 12,
	ELEVATOR_PSOXJA_6						= 13,
	ELEVATOR_PSOXJA_ELVTR_4					= 14,
	ELEVATOR_PSOXJA_ELVTR_5					= 15,
	ELEVATOR_PSOXJA_ELVTR_6					= 16,
	ELEVATOR_PSOXJA_ELVTR_7					= 17,
	ELEVATOR_PSOXJA_DSPPRNG_TLS_4			= 18,
	ELEVATOR_PSOXJA_DSPPRNG_TLS_1			= 19,
	ELEVATOR_PSOXJA_DSPPRNG_TLS_2			= 20,
	ELEVATOR_FORT_GHELSBA_ELVTR				= 21,
	ELEVATOR_PALBOROUGH_MINES_ELVTR			= 22,	// TODO: Verify NPC ID of upper and lower door
	ELEVATOR_DAVOI_ELVTR					= 23,	// in elevators.sql
	ELEVATOR_KUFTAL_TUNNEL_DSPPRNG_RCK		= 24,
	ELEVATOR_PORT_BASTOK_DRWBRDG			= 25,
	ELEVATOR_METALWORKS_ELVTR_1				= 26,
	ELEVATOR_METALWORKS_ELVTR_2				= 27
	
	*/
	
	
	
	
	

	  
		
		
		
		
		
			
	    
		
			
				 
				 
			
		
		    
		  /* if(elevator->id == ELEVATOR_METALWORKS_ELVTR_1)
		     {
				 elevator->Elevator->name[8] = 6; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_DOWN; 
			    // ShowDebug(CL_GREEN"GOING DOWN\n"CL_RESET );
			
			     zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
				 elevator->LowerDoor->animation = ANIMATION_CLOSE_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		         elevator->UpperDoor->animation = ANIMATION_OPEN_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				
				 
			}
		   if(elevator->id == ELEVATOR_METALWORKS_ELVTR_2)
		     {
                 elevator->Elevator->name[8] = 6; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_UP; 
			    // ShowDebug(CL_GREEN"GOING UP\n"CL_RESET );
			
			     zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
				 elevator->LowerDoor->animation = ANIMATION_OPEN_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		         elevator->UpperDoor->animation = ANIMATION_CLOSE_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				 
				
			 }*/
		
		
		  
	      /* if(elevator->id == ELEVATOR_PALBOROUGH_MINES_ELVTR)
		     {
				 //NOTE: .setpos 185.192 -32.000 62.840 128 143 LOCATION OF THE EVELVATOR
                 elevator->Elevator->name[8] = 7; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_UP; 
			     ShowDebug(CL_GREEN"GOING UP\n"CL_RESET );
			
			     
				
					if(m_PBaseEntity != NULL)
					{
							if (m_PBaseEntity->loc.p.y == -32.117 || m_PBaseEntity->loc.p.y == -32.000)
							{
								//TODO GET THE Y POS OF THE PLAYER .getpos
								ShowDebug(CL_GREEN"GOING UP == 32.117\n"CL_RESET ); 
								elevator->LowerDoor->animation = ANIMATION_CLOSE_DOOR;
		                        zoneutils::GetZone(elevator->zone)->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		                        elevator->UpperDoor->animation = ANIMATION_OPEN_DOOR;
		                        zoneutils::GetZone(elevator->zone)->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				              
							}
					zoneutils::GetZone(elevator->zone)->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
					}
					else
					{
                    ShowDebug(CL_GREEN"PLAYER IS NOT FOUND\n"CL_RESET );
					}
						
				 
				
				
			 }*/
		   
		       
		 /*  if(elevator->id == ELEVATOR_METALWORKS_ELVTR_1)
		     {
                 elevator->Elevator->name[8] = 6; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_UP; 
			    // ShowDebug(CL_GREEN"GOING UP\n"CL_RESET );
			
			     zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
				 elevator->LowerDoor->animation = ANIMATION_OPEN_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		         elevator->UpperDoor->animation = ANIMATION_CLOSE_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				 
				
			 }
		    if(elevator->id == ELEVATOR_METALWORKS_ELVTR_2)
		     {
                 elevator->Elevator->name[8] = 6; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_DOWN; 
			     //ShowDebug(CL_GREEN"GOING DOWN\n"CL_RESET );
			
			     zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
				 elevator->LowerDoor->animation = ANIMATION_CLOSE_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		         elevator->UpperDoor->animation = ANIMATION_OPEN_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				 
				
			 }*/
		   
		 
	
	}
	
	
	
  
	
	  
	

void CTransportHandler::ElevatorDown(Elevator_t * elevator , CBaseEntity* m_PBaseEntity)
{
	if(m_PBaseEntity == NULL)
	{
		//JUST IN CASE
		return;
	}
	
	/*
	ELEVATOR_PSOXJA_ELVTR_1					= 1,
	ELEVATOR_PSOXJA_ELVTR_2					= 2,
	ELEVATOR_PSOXJA_ELVTR_3					= 3,
	ELEVATOR_PSOXJA_MVNG_FLR_4				= 4,
	ELEVATOR_PSOXJA_MVNG_FLR_3				= 5,
	ELEVATOR_PSOXJA_MVNG_FLR_1				= 6,
	ELEVATOR_PSOXJA_MVNG_FLR_2				= 7,
	ELEVATOR_PSOXJA_1						= 8,
	ELEVATOR_PSOXJA_2						= 9,
	ELEVATOR_PSOXJA_3						= 10,
	ELEVATOR_PSOXJA_4						= 11,
	ELEVATOR_PSOXJA_5						= 12,
	ELEVATOR_PSOXJA_6						= 13,
	ELEVATOR_PSOXJA_ELVTR_4					= 14,
	ELEVATOR_PSOXJA_ELVTR_5					= 15,
	ELEVATOR_PSOXJA_ELVTR_6					= 16,
	ELEVATOR_PSOXJA_ELVTR_7					= 17,
	ELEVATOR_PSOXJA_DSPPRNG_TLS_4			= 18,
	ELEVATOR_PSOXJA_DSPPRNG_TLS_1			= 19,
	ELEVATOR_PSOXJA_DSPPRNG_TLS_2			= 20,
	ELEVATOR_FORT_GHELSBA_ELVTR				= 21,
	ELEVATOR_PALBOROUGH_MINES_ELVTR			= 22,	// TODO: Verify NPC ID of upper and lower door
	ELEVATOR_DAVOI_ELVTR					= 23,	// in elevators.sql
	ELEVATOR_KUFTAL_TUNNEL_DSPPRNG_RCK		= 24,
	ELEVATOR_PORT_BASTOK_DRWBRDG			= 25,
	ELEVATOR_METALWORKS_ELVTR_1				= 26,
	ELEVATOR_METALWORKS_ELVTR_2				= 27
	
	*/
	
	
	
	
	

	if ((elevator->LowerDoor != NULL) && (elevator->UpperDoor != NULL)) 
	{   

	}
		
		
		
		
			
	    
		
			
				 
				 
			
		
		    
		  /* if(elevator->id == ELEVATOR_METALWORKS_ELVTR_1)
		     {
				 elevator->Elevator->name[8] = 6; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = CVanaTime::getInstance()->getHour();;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_DOWN; 
			    // ShowDebug(CL_GREEN"GOING DOWN\n"CL_RESET );
			
			     zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
				 elevator->LowerDoor->animation = ANIMATION_CLOSE_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		         elevator->UpperDoor->animation = ANIMATION_OPEN_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				
				 
			}
		   if(elevator->id == ELEVATOR_METALWORKS_ELVTR_2)
		     {
                 elevator->Elevator->name[8] = 6; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_UP; 
			    // ShowDebug(CL_GREEN"GOING UP\n"CL_RESET );
			
			     zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
				 elevator->LowerDoor->animation = ANIMATION_OPEN_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		         elevator->UpperDoor->animation = ANIMATION_CLOSE_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				 
				
			 }*/
		
		
		  
	      /* if(elevator->id == ELEVATOR_PALBOROUGH_MINES_ELVTR)
		     {
				 //NOTE: .setpos 185.192 -32.000 62.840 128 143 LOCATION OF THE EVELVATOR
                 elevator->Elevator->name[8] = 7; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_UP; 
			     ShowDebug(CL_GREEN"GOING UP\n"CL_RESET );
			
			     
				
					if(m_PBaseEntity != NULL)
					{
							if (m_PBaseEntity->loc.p.y == -32.117 || m_PBaseEntity->loc.p.y == -32.000)
							{
								//TODO GET THE Y POS OF THE PLAYER .getpos
								ShowDebug(CL_GREEN"GOING UP == 32.117\n"CL_RESET ); 
								elevator->LowerDoor->animation = ANIMATION_CLOSE_DOOR;
		                        zoneutils::GetZone(elevator->zone)->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		                        elevator->UpperDoor->animation = ANIMATION_OPEN_DOOR;
		                        zoneutils::GetZone(elevator->zone)->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				              
							}
					zoneutils::GetZone(elevator->zone)->PushPacket(m_PBaseEntity,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
					}
					else
					{
                    ShowDebug(CL_GREEN"PLAYER IS NOT FOUND\n"CL_RESET );
					}
						
				 
				
				
			 }*/
		   
		       
		 /*  if(elevator->id == ELEVATOR_METALWORKS_ELVTR_1)
		     {
                 elevator->Elevator->name[8] = 6; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_UP; 
			    // ShowDebug(CL_GREEN"GOING UP\n"CL_RESET );
			
			     zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
				 elevator->LowerDoor->animation = ANIMATION_OPEN_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		         elevator->UpperDoor->animation = ANIMATION_CLOSE_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				 
				
			 }
		    if(elevator->id == ELEVATOR_METALWORKS_ELVTR_2)
		     {
                 elevator->Elevator->name[8] = 6; //CORRECT SPEED WITH SOUND IN GAME
                 WBUFL(&elevator->Elevator->name[0],4) = VanaTime;
                 
			     elevator->Elevator->animation = ANIMATION_ELEVATOR_DOWN; 
			     //ShowDebug(CL_GREEN"GOING DOWN\n"CL_RESET );
			
			     zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->Elevator,ENTITY_UPDATE));
				 elevator->LowerDoor->animation = ANIMATION_CLOSE_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->LowerDoor,ENTITY_UPDATE));
		         elevator->UpperDoor->animation = ANIMATION_OPEN_DOOR;
		         zoneutils::GetZone(elevator->zone)->PushPacket(NULL,CHAR_INZONE, new CEntityUpdatePacket(elevator->UpperDoor,ENTITY_UPDATE));
				 
				
			 }*/
		   
		 
	
	
	
	
	
  
	
	  
	
}
/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

