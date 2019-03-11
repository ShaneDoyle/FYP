obj_localplayer.playerhp += (obj_localplayer.playermaxhp * 0.2);
obj_localplayer.playerenergy += (obj_localplayer.playermaxenergy * 0.4);

if(obj_localplayer.playerhp > obj_localplayer.playermaxhp)
{
    obj_localplayer.playerhp = obj_localplayer.playermaxhp;
}

if(obj_localplayer.playerenergy > obj_localplayer.playermaxenergy)
{
    obj_localplayer.playerenergy = obj_localplayer.playermaxenergy;
}
