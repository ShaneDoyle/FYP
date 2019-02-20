var IP = argument[0];
YAdjust = instance_number(obj_JoinServer);
var JoinButton = instance_create(70,60 + (YAdjust * 40) , obj_JoinServer);
JoinButton.IP = IP;