// redirected to central init -> new_main.gsc

init()
{
    if( !isdefined( level.initialized ) )
    {
        level.initialized   = true;
        level.private_match = !level.rankedmatch;
        level new_main::initial();
    }
}