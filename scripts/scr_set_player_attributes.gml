///Set attributes back to normal. 

//(1) Sword & Shield
if(powerup == 1)
{
    playermaxhp = 140;
    playerhp = 140;
    maxspeed = 2.4;
    jumpspeed = 9.001;
}
//(2) Shock Blaster
else if(powerup == 2)
{
    playermaxhp = 130;
    playerhp = 130;
    maxspeed = 2.4// + (0.3 * 1);
    jumpspeed = 9.001 //+ (0.25 * 1);
}
//(3) Summoner
else if(powerup == 3)
{
    playermaxhp = 100;
    playerhp = 100;
    maxspeed = 2.4 + (0.3 * 1);
    jumpspeed = 9.001 + (0.3 * 1);
}
//(4) Demolitioner
else if(powerup == 4)
{
    playermaxhp = 100;
    playerhp = 100;
    maxspeed = 2.4;
    jumpspeed = 9.001;
}

//(5) Ice
else if(powerup == 5)
{
    playermaxhp = 110;
    playerhp = 110;
    maxspeed = 2.4 + (0.3 * 2);
    jumpspeed = 9.001 + (0.3 * 2);
}

else
{
    playermaxhp = 100;
    playerhp = 100;
    maxspeed = 2.4;
    jumpspeed = 9.001;
}