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
#include <string.h>

#include "../common/mmo.h"
#include "../common/showmsg.h"
#include "../common/sql.h"

#include <algorithm>

#include "data_loader.h"
#include "search.h"

CDataLoader::CDataLoader()
{
    SqlHandle = Sql_Malloc();

	//ShowStatus("sqlhandle is allocating\n");
    if( Sql_Connect(SqlHandle,"root","Livingroom3","ffxi-a.com",3306,"fix") == SQL_ERROR )
	{
		//ShowError("cant connect\n");
		return;
	}
}

CDataLoader::~CDataLoader()
{
    Sql_Free(SqlHandle);
}

/************************************************************************
*                                                                       *
*  История продаж предмета                                              *
*                                                                       *
************************************************************************/

std::vector<ahHistory*> CDataLoader::GetAHItemHystory(uint16 ItemID, bool stack)
{
    std::vector<ahHistory*> HistoryList;

    const int8* fmtQuery = "SELECT sale, sell_date, seller_name, buyer_name \
                            FROM auction_house \
                            WHERE itemid = %u AND stack = %u AND buyer_name IS NOT NULL \
                            ORDER BY sell_date DESC \
                            LIMIT 10";

	int32 ret = Sql_Query(SqlHandle, fmtQuery, ItemID, stack);

	if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS) 
		{
            ahHistory* PAHHistory = new ahHistory;

            PAHHistory->Price = Sql_GetUIntData(SqlHandle,0);
            PAHHistory->Data  = Sql_GetUIntData(SqlHandle,1);

            snprintf((int8*)PAHHistory->Name1, 15, "%s", Sql_GetData(SqlHandle,2));
            snprintf((int8*)PAHHistory->Name2, 15, "%s", Sql_GetData(SqlHandle,3));

            HistoryList.push_back(PAHHistory);
        }
        std::reverse(HistoryList.begin(),HistoryList.end());
    }
    return HistoryList;
}

/************************************************************************
*                                                                       *
*  Список продаваемых предметов в указанной категории                   *
*  The list of items sold in this category                              *
************************************************************************/

std::vector<ahItem*> CDataLoader::GetAHItemsToCategory(uint8 AHCategoryID, int8* OrderByString)
{
    ShowDebug("try find category %u\n", AHCategoryID);

    std::vector<ahItem*> ItemList;

    const int8* fmtQuery = "SELECT item_basic.itemid, item_basic.stackSize, COUNT(*)-SUM(stack), SUM(stack) \
                            FROM item_basic \
	                        LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid AND auction_house.buyer_name IS NULL \
                            LEFT JOIN item_armor ON item_basic.itemid = item_armor.itemid \
                            LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid \
                            WHERE aH = %u \
                            GROUP BY item_basic.itemid \
                            %s";

	int32 ret = Sql_Query(SqlHandle, fmtQuery, AHCategoryID, OrderByString);

	if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS) 
		{
			ahItem* PAHItem   = new ahItem;

            PAHItem->ItemID	= Sql_GetIntData(SqlHandle,0);

            PAHItem->SinglAmount = Sql_GetIntData(SqlHandle,2);
            PAHItem->StackAmount = Sql_GetIntData(SqlHandle,3);

            if (Sql_GetIntData(SqlHandle,1) == 1)
            {
                PAHItem->StackAmount = -1;
            }

            ItemList.push_back(PAHItem);
        }
    }
	return ItemList;
}

/************************************************************************
*                                                                       *
*  Количество активных игроков в мире                                   *
*                                                                       *
************************************************************************/

uint32 CDataLoader::GetPlayersCount(search_req sr)
{
	ShowStatus(CL_RED"GET PLAYERS COUNT\n"CL_RESET);
	uint8 jobid = sr.jobid;
	if(jobid > 0 && jobid < 21){
		if( Sql_Query(SqlHandle, "SELECT COUNT(*) FROM chars LEFT JOIN char_stats USING (charid) WHERE mjob = %u",jobid) 
			!= SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
		{
			if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		    {
		        return Sql_GetUIntData(SqlHandle, 0);
		    }
		}
	}
	else{
		if( Sql_Query(SqlHandle, "SELECT COUNT(*) FROM chars") != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
		{
			if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		    {
		        return Sql_GetUIntData(SqlHandle, 0);
		    }
		}
	}
    return 0;
}

/************************************************************************
*                                                                       *
*  Список найденных персонажей в игровом мире                           *
*          Job ID is 0 for none specified.                              *
************************************************************************/

std::list<SearchEntity*> CDataLoader::GetPlayersList(search_req sr,int* count)
{
	ShowStatus(CL_RED"GET PLAYER LIST.\n"CL_RESET);
	ShowStatus(CL_RED"SEARCH REQUEST IN ZONE %u.\n"CL_RESET,sr.zoneid);
    std::list<SearchEntity*> PlayersList;
	std::string filterQry = "";
	if(sr.jobid > 0 && sr.jobid < 21){ 
        filterQry.append(" AND "); 
		filterQry.append(" mjob = ");
        filterQry.append(std::to_string(static_cast<unsigned long long>(sr.jobid)));
	}
	if(sr.zoneid[0] > 0) { 
        string_t zoneList;
        int i = 1;
        zoneList.append(std::to_string(static_cast<unsigned long long>(sr.zoneid[0])));
        while (i < 10 && sr.zoneid[i] != 0)
        {
            zoneList.append(", ");
            zoneList.append(std::to_string(static_cast<unsigned long long>(sr.zoneid[i])));
            i++;
        }
        filterQry.append(" AND ");
        filterQry.append("(pos_zone IN (");
        filterQry.append(zoneList);
        
        filterQry.append("))) ");
	}

	int32 ret = SQL_ERROR;

	std::string fmtQuery = "SELECT charid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, \
                        war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng, sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run \
                        FROM chars \
                        LEFT JOIN char_look USING (charid) \
                        LEFT JOIN char_stats USING (charid) \
                        LEFT JOIN char_jobs USING(charid) \
						LEFT JOIN char_profile USING(charid) \
						WHERE online ='1' ORDER BY charid ASC";
	fmtQuery.append(filterQry);
	//fmtQuery.append("ORDER BY charname ASC");

	ret = Sql_Query(SqlHandle, fmtQuery.c_str());

	if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		int totalResults = 0; //gives ALL matching criteria (total)
		int visibleResults = 0; //capped at first 20
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS) 
		{
            SearchEntity* PPlayer = new SearchEntity;
            memset(PPlayer, 0, sizeof(SearchEntity));

            

            PPlayer->id			= (uint32)Sql_GetUIntData(SqlHandle, 0);
			//uint32 partyid  = (uint32)Sql_GetUIntData(SqlHandle, 1);
			memcpy(PPlayer->name, Sql_GetData(SqlHandle, 1), 15);
            PPlayer->zone		= (uint16) Sql_GetIntData(SqlHandle,  2);
			ShowNotice(CL_GREEN"TRACER: zoneID %u\n" CL_RESET,PPlayer->zone );
            PPlayer->nation		= (uint8) Sql_GetIntData(SqlHandle,  3);
			PPlayer->rank		= (uint8) Sql_GetIntData(SqlHandle,  4 + PPlayer->nation);
			PPlayer->race		= (uint8) Sql_GetIntData(SqlHandle,  7);
			uint32 nameflag = (uint32)Sql_GetUIntData(SqlHandle, 8);
            PPlayer->mjob		= (uint8) Sql_GetIntData(SqlHandle, 9);
            PPlayer->sjob		= (uint8) Sql_GetIntData(SqlHandle, 10);
            PPlayer->mlvl		= (uint8) Sql_GetIntData(SqlHandle, 10 + PPlayer->mjob);
            PPlayer->slvl		= (uint8) Sql_GetIntData(SqlHandle, 10 + PPlayer->sjob);
           
            

            PPlayer->slvl = (PPlayer->slvl > (PPlayer->mlvl >> 1) ? (PPlayer->mlvl == 1 ? 1 : (PPlayer->mlvl >> 1)) : PPlayer->slvl);
			//PPlayer->zone = (PPlayer->zone == 0 ? PPlayer->prevzone : PPlayer->zone);

            
           

           // if (partyid == PPlayer->id) PPlayer->flags1 |= 0x0008;
            if (nameflag & FLAG_AWAY)   PPlayer->flags1 |= 0x0100;
            if (nameflag & FLAG_DC)     PPlayer->flags1 |= 0x0800;
          //  if (partyid != 0)           PPlayer->flags1 |= 0x2000;
            if (nameflag & FLAG_ANON)   PPlayer->flags1 |= 0x4000;
            if (nameflag & FLAG_INVITE) PPlayer->flags1 |= 0x8000;

            PPlayer->flags2 = PPlayer->flags1;

			if(sr.minlvl >0 && sr.maxlvl >= sr.minlvl){ //filter by level
				if(PPlayer->mlvl < sr.minlvl || PPlayer->mlvl > sr.maxlvl){
					continue;
				}
			}
			if(sr.nameLen>0){ //filter by name
				string_t dbname;
				dbname.insert(0,(int8*)PPlayer->name);
				if(sr.nameLen > dbname.length()){//can't be this name, too long
					continue;
				}
				bool validName = true;
				for(int i=0;i<sr.nameLen; i++){
					//convert to lowercase for both
					if(tolower(sr.name[i]) != tolower(PPlayer->name[i])){
						validName = false;
						break;
					}
				}
				if(!validName){
					continue;
				}
			}
			if(visibleResults<20){
				PlayersList.push_back(PPlayer);
				visibleResults++;
			}
			totalResults++;
        }
		if(totalResults>0){
			*count = totalResults;
		}
		ShowMessage("Found %i results, displaying %i. \n",totalResults,visibleResults);
    }
	
    return PlayersList;
}

/************************************************************************
*                                                                       *
*  Список персонажей, состоящих в одной группе                          *
*                                                                       *
************************************************************************/

std::list<SearchEntity*> CDataLoader::GetPartyList(uint32 PartyID)
{
	ShowStatus(CL_RED"GET PARTY LIST\n"CL_RESET);
    std::list<SearchEntity*> PartyList;

    const int8* Query = "SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, \
                         war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng, sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run \
                         FROM accounts_sessions \
                         LEFT JOIN chars USING (charid) \
                         LEFT JOIN char_look USING (charid) \
                         LEFT JOIN char_stats USING (charid) \
                         LEFT JOIN char_jobs USING(charid) \
						 LEFT JOIN char_profile USING(charid) \
                         WHERE partyid = %u \
                         ORDER BY charname ASC \
                         LIMIT 18";

    int32 ret = Sql_Query(SqlHandle, Query, PartyID);

	if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS) 
		{
            SearchEntity* PPlayer = new SearchEntity;
            memset(PPlayer, 0, sizeof(SearchEntity));

			

            PPlayer->id     = (uint32)Sql_GetUIntData(SqlHandle, 0);//CHARID
			memcpy(PPlayer->name, Sql_GetData(SqlHandle, 2), 15);
            PPlayer->zone   = (uint16) Sql_GetIntData(SqlHandle,  3);
            PPlayer->nation = (uint8) Sql_GetIntData(SqlHandle,  4);
			PPlayer->rank   = (uint8) Sql_GetIntData(SqlHandle,  5 + PPlayer->nation);
			PPlayer->race   = (uint8) Sql_GetIntData(SqlHandle,  8);
			uint32 nameflag = (uint32)Sql_GetUIntData(SqlHandle, 9);
            PPlayer->mjob   = (uint8) Sql_GetIntData(SqlHandle, 10);
            PPlayer->sjob   = (uint8) Sql_GetIntData(SqlHandle, 11);
            PPlayer->mlvl   = (uint8) Sql_GetIntData(SqlHandle, 11 + PPlayer->mjob);
            PPlayer->slvl   = (uint8) Sql_GetIntData(SqlHandle, 11 + PPlayer->sjob);
            
            

            PPlayer->slvl = (PPlayer->slvl > (PPlayer->mlvl >> 1) ? (PPlayer->mlvl == 1 ? 1 : (PPlayer->mlvl >> 1)) : PPlayer->slvl);

            

            if (PartyID == PPlayer->id) PPlayer->flags1 |= 0x0008;
            if (nameflag & FLAG_AWAY)   PPlayer->flags1 |= 0x0100;
            if (nameflag & FLAG_DC)     PPlayer->flags1 |= 0x0800;
            if (PartyID != 0)           PPlayer->flags1 |= 0x2000;
            if (nameflag & FLAG_ANON)   PPlayer->flags1 |= 0x4000;
            if (nameflag & FLAG_INVITE) PPlayer->flags1 |= 0x8000;

            PPlayer->flags2 = PPlayer->flags1;

            PartyList.push_back(PPlayer);
        }
    }
    return PartyList;
}

/************************************************************************
*                                                                       *
*  Список персонажей, состоящих в одной linkshell                       *
*                                                                       *
************************************************************************/

std::list<SearchEntity*> CDataLoader::GetLinkshellList(uint32 LinkshellID)
{
	ShowStatus(CL_RED"GET LINKSHELL LIST\n"CL_RESET);
    std::list<SearchEntity*> LinkshellList;
	const int8* fmtQuery = "SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, \
                            war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng, sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run, linkshellid, linkshellrank \
                            FROM accounts_sessions \
                            LEFT JOIN chars USING (charid) \
                            LEFT JOIN char_look USING (charid) \
                            LEFT JOIN char_stats USING (charid) \
                            LEFT JOIN char_jobs USING(charid) \
							LEFT JOIN char_profile USING(charid) \
							WHERE linkshellid = %u \
                            ORDER BY charname ASC \
                            LIMIT 20";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, LinkshellID);

	if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS) 
		{
            SearchEntity* PPlayer = new SearchEntity;
            memset(PPlayer, 0, sizeof(SearchEntity));

            memcpy(PPlayer->name, Sql_GetData(SqlHandle, 2), 15);

            PPlayer->id     = (uint32)Sql_GetUIntData(SqlHandle, 0);
            PPlayer->zone   = (uint16) Sql_GetIntData(SqlHandle,  3);
            PPlayer->nation = (uint8) Sql_GetIntData(SqlHandle,  4);
            PPlayer->mjob   = (uint8) Sql_GetIntData(SqlHandle, 10);
            PPlayer->sjob   = (uint8) Sql_GetIntData(SqlHandle, 11);
            PPlayer->mlvl   = (uint8) Sql_GetIntData(SqlHandle, 11 + PPlayer->mjob);
            PPlayer->slvl   = (uint8) Sql_GetIntData(SqlHandle, 11 + PPlayer->sjob);
            PPlayer->race   = (uint8) Sql_GetIntData(SqlHandle,  8);
            PPlayer->rank   = (uint8) Sql_GetIntData(SqlHandle,  5 + PPlayer->nation);
			PPlayer->linkshell = (uint8) Sql_GetIntData(SqlHandle,  35);
            PPlayer->slvl = (PPlayer->slvl > (PPlayer->mlvl >> 1) ? (PPlayer->mlvl == 1 ? 1 : (PPlayer->mlvl >> 1)) : PPlayer->slvl);

            uint32 partyid  = (uint32)Sql_GetUIntData(SqlHandle, 1);
            uint32 nameflag = (uint32)Sql_GetUIntData(SqlHandle, 9);

            if (partyid == PPlayer->id) PPlayer->flags1 |= 0x0008;
            if (nameflag & FLAG_AWAY)   PPlayer->flags1 |= 0x0100;
            if (nameflag & FLAG_DC)     PPlayer->flags1 |= 0x0800;
            if (partyid != 0)           PPlayer->flags1 |= 0x2000;
            if (nameflag & FLAG_ANON)   PPlayer->flags1 |= 0x4000;
            if (nameflag & FLAG_INVITE) PPlayer->flags1 |= 0x8000;

            PPlayer->flags2 = PPlayer->flags1;

            LinkshellList.push_back(PPlayer);
        }
    }
	
    return LinkshellList;
}