var buffer = argument[0];
var msgId = buffer_read(buffer, buffer_u8);// find the tag

switch(msgId)
{
    //Latency response
    case 1:
        var time = buffer_read(buffer, buffer_u32);// read in the time from the server
        global.latency = current_time - time;// update our latency
    break;
    
    //Register response
    case 2:
        var response = buffer_read(buffer, buffer_u8);
        
        switch(response)
        {
            //Failure
            case 0:
                //scr_showNotification("Registration failed! Username already exists!");
            break;
            
            //Success
            case 1:
                global.playerX = buffer_read(buffer, buffer_u32);
                global.playerY = buffer_read(buffer, buffer_u32);
                global.playerRoom = buffer_read(buffer, buffer_u8);
                
                room_goto(rm_mainMenu);
            break;
        }
    break;
    
    //Login Response
    case 3: 
        var response = buffer_read(buffer, buffer_u8);
        
        global.playerX = buffer_read(buffer, buffer_u32);
        global.playerY = buffer_read(buffer, buffer_u32);
        global.playerRoom = buffer_read(buffer, buffer_u8);
                
        room_goto(rm_lobby);
        /*
        switch(response)
        {
            //Failure
            case 0:
                scr_showNotification("Login failed! Username doesn't exist or password is incorrect!");
            break;
            
            //Success
            case 1:
                global.playerX = buffer_read(buffer, buffer_u32);
                global.playerY = buffer_read(buffer, buffer_u32);
                global.playerRoom = buffer_read(buffer, buffer_u8);
                
                room_goto(rm_lobby);
            break;
        }
        */
    break;
    
    //Player ID Response
    case 4:
        global.playerId = buffer_read(buffer, buffer_u32);
        show_message(global.playerId);
    break;
    
    //Remote player disconnect response
    case 5:
        var pId = buffer_read(buffer, buffer_u32);
        with (obj_remoteplayer)
        {
            if (remotePlayerId == pId)
            {
                instance_destroy();
            }
        }
    break;
    
    //Change player room response
    case 6:
        var pId = buffer_read(buffer, buffer_u32);
        var pType = buffer_read(buffer, buffer_u8);
        var pName = buffer_read(buffer, buffer_string);
        var pX = buffer_read(buffer, buffer_u32);
        var pY = buffer_read(buffer, buffer_u32);
        var roomId = buffer_read(buffer, buffer_u8);
        
        var instance = noone;

        with (obj_remoteplayer)
        {
            if (remotePlayerId == pId)
            {
                instance = id;
            }
        }
        
        //If this player doesn't yet exist
        if (instance == noone)
        {
            //Only if we exist in the gameworld or in the lobby
            if (instance_exists(obj_localplayer))
            {
                //if (global.playerRoom == roomId)
                //{
                    //Create a remote player
                    var remotePlayer = instance_create(pX, pY, obj_remoteplayer);
                    remotePlayer.remotePlayerId = pId;
                    remotePlayer.remotePlayerType = pType;
                    remotePlayer.remotePlayerName = pName;
                    remotePlayer.remotePlayerHP = 0;
                    remotePlayer.remotePlayerMaxHP = 0;
                    
               // }  
            }
        }
        //Otherwise destroy this player as they are leaving
        else
        {
            with (instance)
            {
                instance_destroy();
            }
        }
    break;
    
    //PROBABLY MOST IMPORTANT CASE!
    //Player movement update response
    case 7:
        var pId = buffer_read(buffer, buffer_u32);
        var xx = buffer_read(buffer, buffer_f32);
        var yy = buffer_read(buffer, buffer_f32);
        var hspd = buffer_read(buffer, buffer_f32);
        var vspd = buffer_read(buffer, buffer_f32);
       // var imageIndex = buffer_read(buffer, buffer_u8);
        var dir = buffer_read(buffer, buffer_s8);
        var imageangle = buffer_read(buffer, buffer_s16);
        var imagealpha = buffer_read(buffer, buffer_f32);
        var sprite_number = buffer_read(buffer, buffer_s16);
        var image_frame = buffer_read(buffer, buffer_s16);
        var hp = buffer_read(buffer, buffer_u8);
        var maxhp = buffer_read(buffer, buffer_u8);
        var playerscore = buffer_read(buffer, buffer_u8);
        var attacking = buffer_read(buffer, buffer_bool);
        var readytoproceed = buffer_read(buffer, buffer_bool);
        
        with (obj_remoteplayer)
        {
            if (remotePlayerId == pId)
            {
                remote_direction = dir;
                time = 0;
                prevx = x;
                prevy = y;
                tox = xx;
                toy = yy;
                y = yy;
             //   sprite_index = spriteNumber;
             //   image_index = imageIndex;
                remote_hspd = hspd;
                remote_vspd = vspd;
                remote_imageangle = imageangle;
                remote_imagealpha = imagealpha;
                remotePlayerHP = hp;
                remotePlayerMaxHP = maxhp;
                remotePlayerScore = playerscore;
                remotePlayerAttacking = attacking;
                remotePlayerxx = xx;
                remotePlayeryy = yy;
                remotePlayersprite = sprite_number;
                remotePlayerimageindex = image_frame;
                remotePlayerReadyToProceed = readytoproceed;
             
            }
        }
    break;
    
    //Chat request (unused)
    case 8:
        var pId = buffer_read(buffer, buffer_u32);
        var text = buffer_read(buffer, buffer_string);
        
        //Find the client who owns the message
        with (obj_remoteplayer)
        {
            if (remotePlayerId == pId)
            {
                //Create object that contains the message (this will follow the player!)
                var chat = instance_create(x, y, obj_chat);
                chat.text = text;
                chat.owner = id;
            }
        }
    break;
    
    //NPC creation response
    case 9:
        var npcId = buffer_read(buffer, buffer_u32);
        var xx = -1000;
        var yy = 0;
        //var xx = buffer_read(buffer, buffer_f32);
        //var yy = buffer_read(buffer, buffer_f32);
        var npcType = buffer_read(buffer, buffer_u8);
        
        var npc = instance_create(xx, yy, obj_npc);
        npc.npcId = npcId;
        npc.image_index = npcType;
    break;
    
    //Update latency request
    case 10:
        var pId = buffer_read(buffer, buffer_u32);
        var latency = buffer_read(buffer, buffer_u32);
        
        //Find the owner of the message
        with (obj_remoteplayer)
        {
            if (remotePlayerId == pId)
            {
                remotePlayerLatency = latency;
            }
        }
    break;
    
    //Create projectile / data request!
    case 11:
        var pId = buffer_read(buffer, buffer_u32);
        var projectileId = buffer_read(buffer, buffer_u32);
        var xx = buffer_read(buffer, buffer_f32);
        var yy = buffer_read(buffer, buffer_f32);
        var sprite_number = buffer_read(buffer, buffer_u16);
        var angle_image = buffer_read(buffer, buffer_s16);
        var xdir = buffer_read(buffer, buffer_s8);
        var ydir = buffer_read(buffer, buffer_s8);
        var powerup = buffer_read(buffer, buffer_u8);
        var damage = buffer_read(buffer, buffer_u8);
        var life = buffer_read(buffer, buffer_u8);
        
        var projectile = noone;
        
        with (obj_remoteProjectile)
        {
            if (self.owner == pId && self.projectileId == projectileId)
            {
                projectile = id;
            }
        }
        
        if (projectile != noone)
        {
            projectile.x = xx;
            projectile.y = yy;
            projectile.image_xscale = xdir;
            //projectile.image_yscale = ydir;
            projectile.image_angle = angle_image;
            projectile.sprite = sprite_number;
            
        }
        else
        {
            var p = instance_create(xx, yy, obj_remoteProjectile);
            p.owner = pId;
            p.projectileId = projectileId;
            p.image_angle = angle_image;
            p.sprite = sprite_number;
            p.life = life;
            p.powerup = powerup;
            p.damage = damage;
        }
    break;
    
    //Destroy projectile response
    case 12:
        var pId = buffer_read(buffer, buffer_u32);
        var projectileId = buffer_read(buffer, buffer_u32);
        
        with (obj_remoteProjectile)
        {
            if (self.owner == pId && self.projectileId == projectileId)
            {
                instance_destroy();
            }
        }
    break;
    
    //Block Creation
    case 13:
        var xx = buffer_read(buffer, buffer_s32);
        var yy = buffer_read(buffer, buffer_s32);
        var image = buffer_read(buffer, buffer_u8);
        var planetnumber = buffer_read(buffer, buffer_u8);
        
        var block = instance_create(xx, yy, obj_block);
        block.image_index = image;
        block.planetnumber = planetnumber;
    break;
    
    //Bush Creation
    case 14:
        var xx = buffer_read(buffer, buffer_s32);
        var yy = buffer_read(buffer, buffer_s32);
        var angle = buffer_read(buffer, buffer_s16);
        
        var bush = instance_create(xx, yy, obj_bush1);
        bush.image_angle = angle;
    break;
    
    //Grass Creation
    case 15:
        var xx = buffer_read(buffer, buffer_s32);
        var yy = buffer_read(buffer, buffer_s32);
        var angle = buffer_read(buffer, buffer_s16);
        
        var grass = instance_create(xx, yy, obj_grass1);
        grass.image_angle = angle;
    break;
    
    //Right Portal Creation
    case 16:
        var xx = buffer_read(buffer, buffer_s32);
        var yy = buffer_read(buffer, buffer_s32);
        var planetnumber = buffer_read(buffer, buffer_u8);
        
        var rightportal = instance_create(xx, yy, obj_RightPortal);
        rightportal.planetnumber = planetnumber;
    break;
    
    //Up Portal Creation
    case 17:
        var xx = buffer_read(buffer, buffer_s32);
        var yy = buffer_read(buffer, buffer_s32);
        var planetnumber = buffer_read(buffer, buffer_u8);
        
        var upportal = instance_create(xx, yy, obj_Portal);
        upportal.planetnumber = planetnumber;
    break;
    
    //Left Portal Creation
    case 18:
        var xx = buffer_read(buffer, buffer_s32);
        var yy = buffer_read(buffer, buffer_s32);
        var planetnumber = buffer_read(buffer, buffer_u8);
        
        var leftportal = instance_create(xx, yy, obj_LeftPortal);
        leftportal.planetnumber = planetnumber;
    break;
    
    //Down Portal Creation
    case 19:
        var xx = buffer_read(buffer, buffer_s32);
        var yy = buffer_read(buffer, buffer_s32);
        var planetnumber = buffer_read(buffer, buffer_u8);
        
        var downportal = instance_create(xx, yy, obj_DownPortal);
        downportal.planetnumber = planetnumber;
    break;
    
    //Get Server Lobby Settings
    case 20:
        var ready = buffer_read(buffer, buffer_bool);
        var serverroom = buffer_read(buffer, buffer_string);
        
        global.ClientRoom = serverroom;
        /*
        var serverlobby = instance_create(0,0,obj_remote_server_lobby);
        serverlobby.ArePlayersReady = ready;
        serverlobby.ServerLobby = serverroom;*/
        
    break;
    
    //Get client request stuff.
    case 21:
        var RequestInfo = buffer_read(buffer, buffer_string);
        
        var clientrequest = instance_create(0,0,obj_client_request);
        clientrequest.RequestInfo = RequestInfo;
    break;
    
    //Get Server Gem Settings
    case 22:
        var gemID = buffer_read(buffer, buffer_u32);
        var xx = buffer_read(buffer, buffer_f32);
        var yy = buffer_read(buffer, buffer_f32);
        var status = buffer_read(buffer, buffer_string);
        
        if(status == "active")
        {
            if(instance_number(obj_client_gem) < 1)
            {
                var gem = instance_create(xx, yy, obj_client_gem);
            }
        }
        else
        {
            with(obj_client_gem)
            {
                if(status == "death")
                {
                    instance_destroy();
                }
            }
        }
    break;
    
    //Claim gem reward.
    case 23:
        var playerclaimed = buffer_read(buffer, buffer_u32);
        if(playerclaimed == global.playerId)
        {
            //scr_getStar();
        }
        audio_play_sound(ClaimGem,0,false);
    break;
    
    //Cannon creation
    case 24:
        var xx = buffer_read(buffer, buffer_s32);
        var yy = buffer_read(buffer, buffer_s32);
        var cannondirection = buffer_read(buffer, buffer_string);
        
        var cannon = instance_create(xx, yy, obj_client_cannon);
        cannon.cannondirection = cannondirection;
    break;
}
