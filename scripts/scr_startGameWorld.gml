obj_localplayer.grav = 0.6;
global.PlayerMove = true;
obj_localplayer.movementtype = "player";

if(!audio_is_playing(SMB2Theme))
{
    var music = audio_play_sound(SMB2Theme,0,true);
}


        