instance_create(obj_Camera.x, obj_Camera.y, obj_transition_gamestart);
instance_create(0,0,obj_localplayer_spawner);

///Revive player.
obj_localplayer.playerhp = obj_localplayer.playermaxhp;
obj_localplayer.PlayerDeath = false;
obj_localplayer.image_alpha = 1;
