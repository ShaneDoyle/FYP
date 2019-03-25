with(obj_block)
{
    instance_destroy();
}

with(obj_grass1)
{
    instance_destroy();
}

with(obj_bush1)
{
    instance_destroy();
}

with(obj_Portal)
{
    instance_destroy();
}

with(obj_RightPortal)
{
    instance_destroy();
}

with(obj_LeftPortal)
{
    instance_destroy();
}

with(obj_DownPortal)
{
    instance_destroy();
}

with(obj_server_cannon)
{
    instance_destroy();
}

with(obj_client_cannon)
{
    instance_destroy();
}

with(obj_old_spawn_point)
{
    instance_destroy();
}

with(obj_server_spawn_point)
{
    instance_create(x,y,obj_old_spawn_point);
    instance_destroy();
}

with(obj_client_spawn_point)
{
    instance_destroy();
}


global.planetnumber = 1;