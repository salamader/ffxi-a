/* pagbuild.js */

var gpdPath = 'http://' + location.host + '/include/getPlayerData.php';
var jobs = new Array('','WAR','MNK','WHM','BLM','RDM','THF','PLD','DRK','BST','BRD','RNG','SAM','NIN','DRG','SMN','BLU','COR','PUP','DNC','SCH');

function loadStartPage() {
	buildPlayerTable();
	setInterval("buildPlayerTable()", 5000);
}

function buildPlayerTable()
{
	$.getJSON(gpdPath + '?t=' + (new Date()).getTime(), function (playerData) {
		var html;
		var playerCnt = 0;
		
		if (jQuery.isEmptyObject(playerData)) {
			html = '<h2>No one currently on!</h2>';
		} else {
			var playerRows = '';
			for (var i in playerData) {
				playerCnt += 1;

				playerRows += '<tr><td>';
				
			/* see if the user is a GM or not!*/

if (playerData[i].nameflags & 0x0400000) //GM
	{ 
		playerRows += '<img src ="icons/GMIcon.gif" alt="GM" title="GM"></img>';
	}

else if (playerData[i].nameflags & 0x05000000) //GM Senior
	{
		playerRows += '<img src ="icons/SGMIcon.gif" alt="SGM" title="SGM"></img>';
	}

else if (playerData[i].nameflags & 0x06000000) //GM Leader
	{
		playerRows += '<img src ="icons/LGMIcon.gif" alt="LGM" title="LGM"></img>';
	}
	
else if (playerData[i].nameflags & 0x07000000) //SE Producer
	{ 
		playerRows += '<img src ="icons/firmware-dev-icon.png" alt="DEV" title="DEV"></img>';
	}
			/*end finding out if the user is a GM or not*/
			
			/*add an icon to the user's name. a sword in this case.*/ 
				playerRows += '  <img src="icons/Campaign-icon.png" alt="SWORD" title="SWORD">' + playerData[i].player + '</img></td>';
	
				playerRows +='  <td>' + playerData[i].area.replace(/_/g," ") + '</td>' +
						      '  <td>' + jobs[playerData[i].mjob] + playerData[i].mjoblvl;
							  if (playerData[i].sjob != 0) playerRows += '/';
							  playerRows += jobs[playerData[i].sjob] + playerData[i].sjoblvl + '</td>' +
						      '  <td>' + playerData[i].bazaar_message + '</td>' +
						      '</tr>';
			}
			html = '<span id="playerCnt">Total: ' + playerCnt + '</span>' +
					'<table class="playerrows">' +
					'  <tr>' +
					'    <th>Player</th>' +
					'    <th>Area</th>' +
					'    <th>Job</th>' +
					'    <th>Bazaar Message</th>' +
					'  </tr>' +
					playerRows +
					'<table>';
		}
		replace('PlayerList', html);
	});
}

function replace(parentId, html) {
    var parent = document.getElementById(parentId), child;
    while (child = parent.firstChild)
        parent.removeChild(child);
    $('#' + parentId).append(html);
}