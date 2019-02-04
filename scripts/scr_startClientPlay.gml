if(global.playerId == 1)
{
    obj_localplayer.x = (32*20) + random_range(32*10, 32*20);
    obj_localplayer.y = (32*20) - (32*10);
    obj_localplayer.dir = "up";
    obj_localplayer.image_angle = 0;
}
else if (global.playerId == 2)
{
    obj_localplayer.x = (32*20) + (32*30) + (32*10);
    obj_localplayer.y = (32*20) + random_range(32*10, 32*20)
    obj_localplayer.dir = "right";
    obj_localplayer.image_angle = -90;
}
else if (global.playerId == 3)
{
    obj_localplayer.x = (32*10)
    obj_localplayer.y = (32*20) + random_range(32*10, 32*20)
    obj_localplayer.dir = "left";
    obj_localplayer.image_angle = 90;
}
else if (global.playerId == 4)
{
    obj_localplayer.x = (32*20) + random_range(32*10, 32*20);
    obj_localplayer.y = (32*20) + (32*30) + (32*30);
    obj_localplayer.dir = "down";
    obj_localplayer.image_angle = 180;
}