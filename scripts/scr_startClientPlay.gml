if(global.playerId == 1)
{
    obj_localplayer.x = random_range(900,1100);
    obj_localplayer.y = 500;
}
else if (global.playerId == 2)
{
        obj_localplayer.x = random_range(2000,2200);
        obj_localplayer.y = random_range(1200,1400);
        obj_localplayer.dir = "right";
        obj_localplayer.image_angle = -90;
}
else if (global.playerId == 3)
{
        obj_localplayer.x = random_range(0,0);
        obj_localplayer.y = random_range(1200,1400);
        obj_localplayer.dir = "left";
        obj_localplayer.image_angle = 90;
}
