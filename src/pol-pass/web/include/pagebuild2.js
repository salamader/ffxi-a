/* pagbuild.js */

var gpdPath = 'http://' + location.host + '/include/getPlayerData.php';

var jobs = new Array('', 'WAR', 'MNK', 'WHM', 'BLM', 'RDM', 'THF', 'PLD', 'DRK', 'BST', 'BRD', 'RNG', 'SAM', 'NIN', 'DRG', 'SMN', 'BLU', 'COR', 'PUP', 'DNC', 'SCH');

function loadStartPage() {
	buildPlayerTable();
	setInterval("buildPlayerTable()", 5000);
}

loadStartPage();

function buildPlayerTable() {
	sendAJAXRequest(gpdPath, null, function (playerData) {
		var html;

		if (typeof playerData == 'undefined' || playerData == null) {
			html = '<h2>No one currently on!</h2>';
		} else {
			var playerRows = '';
			var cnt = 0;
			for (var i = 0; i < playerData.length; i++) {
				playerRows += '<th scope="row"><tr><td>';
				
				
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

				playerRows += '  <td>' + playerData[i].area.replace(/_/g, " ") + '</td>' +
				'  <td>' + jobs[playerData[i].mjob] + playerData[i].mjoblvl;
				if (playerData[i].sjob != 0) playerRows += '/';
				playerRows += jobs[playerData[i].sjob] + playerData[i].sjoblvl + '</td>' +
				'  <td>' + playerData[i].bazaar_message + '</td>' +
				'</tr></th>';
			}
			html = '<span id="playerCnt">Total: ' + i + '</span>' +
					'<table class="playerrows">' +
					'<thead>' +
					'  <tr>' +
					'    <th scope="col">Player</th>' +
					'    <th scope="col">Area</th>' +
					'    <th scope="col">Job</th>' +
					'    <th scope="col">Bazaar Message</th>' +
					'  </tr>' +
					'</thead>' +
					'<tbody>' +
					playerRows +
					'</tbody>' +
					'<table>';
		}
		replace('PlayerList', html);
	});
}

function sendAJAXRequest(url, parameter, callback) {
	var http;
	if (window.XMLHttpRequest) { http = new XMLHttpRequest(); }
	else if (window.ActiveXObject) { http = new ActiveXObject('Microsoft.XMLHTTP'); }

	url = url + '?t=' + new Date().getTime();
	var params = '';

	if (parameter != null && parameter.length != 0) {
		params = parameter.join('&');
	}
	http.open("POST", url, true);

	http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	http.setRequestHeader("Content-length", params.length);
	http.setRequestHeader("Connection", "close");

	http.onreadystatechange = function () {
		if (http.readyState == 4 && http.status == 200) {
			callback(JSON.parse(http.responseText));
		}
	}
	http.send(params);
}

function replace(parentId, html) {
	var parent = document.getElementById(parentId), child;
	while (child = parent.firstChild)
		parent.removeChild(child);
	parent.innerHTML = html;
}