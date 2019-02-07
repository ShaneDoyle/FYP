///get_computer_ip_http_event();
/*
        Place this function in a HTTP Event only!!!
*/
if ( ds_map_find_value(async_load, "id") == async ) {
    if ( ds_map_find_value(async_load, "status") == 0 ) {
        return ds_map_find_value(async_load, "result");
    }
}