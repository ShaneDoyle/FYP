//Tell the server we're joining the game
buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u8, 6);
buffer_write(global.buffer, buffer_u32, global.playerId);
buffer_write(global.buffer, buffer_u8, global.playerType);
buffer_write(global.buffer, buffer_u32, global.playerX);
buffer_write(global.buffer, buffer_u32, 0);
buffer_write(global.buffer, buffer_u8, 1);
network_send_packet(obj_controller.socket, global.buffer, scr_getBufferSize());