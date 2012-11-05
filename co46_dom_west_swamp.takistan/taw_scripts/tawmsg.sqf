_image = parseText "<img size='10' image='designer.paa'/>";
_imageSmall = parseText "<img size='5' image='designer.paa'/>";
_sep = parseText "<br />--------------------------------<br />";
_main = parseText "Welcome to the 7th Cavalry Regiment server!<br />Check us out at www.7thcavalry.us.<br />We are always RECRUITING!<br />";
_rules = parseText "Server rules:<br /><t align='left'>1. Have fun!<br />2. Clean language<br />3. Communicate clearly and concisely<br />4. DO NOT KILL FRIENDLIES<br />5. Do not WASTE vehicles</t>";
_ts = parseText "Join use on TS3 at <br />address: ts3.7thcavalry.us<br />port: 9987<br /> password: 7thCavalry<br />";
_txt = composeText [_image, _sep, _main, _sep, _rules, _sep, _ts];
_txtRep = composeText [_main, _sep, _rules, _ts];

sleep 120;
hint _txt;
sleep 180;
hint _txt;

while {true} do {
sleep 600;
hintSilent _txtRep;
}