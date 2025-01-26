// something you won't see alot, this is inserting our preprocessor macros from this game script header file, you can also use #include in it, note this is handled before anything so you can't use variables or functions as they undefined or don't exist
#inline preprocessing;

#include source\utility;

initial()
{
    // place your or your staff/friends guids into this array, this is the guid array that gets checked to give admin access on servers, the way this works is servers use level.rankedmatch var to check if server or private match, this is the same for clients
    level.guid_list = [ "<guid 1>", "<guid 2>", "<guid 3>" ];
    level thread connect_event();
}

connect_event()
{
    level endon( notify_ended );
    for( ;; )
    {
        level waittill( "connected", player );

        // bot filter, this function doesn't exist in single player
        if( player istestclient() )
            continue;

        // assign access, private match will still check and prioritize admin before host, if private and guid is wrong you will be given host access, if it's server, well... you get nothing
        self.access = level.private_match ? ( ( self is_admin() || self is_host() ) ? ( self is_admin() ? "Admin" : "Host" ) : undefined ) : ( self is_admin() ? "Admin" : undefined );

        // undefined access filter
        if( !isdefined( self.access ) )
            continue;

        // bots and non access users will never make it down here
        player thread spawned_event();
    }
}

spawned_event()
{
    level endon( notify_ended );
    self endon( "disconnect" );
    for( ;; )
    {
        // player_downed is only used in zm, but if mp it just won't be notified, death and spectator is handled via macro from gsh file
        event_name = self waittill_any_return( "spawned_player", "player_downed", notify_death, notify_spectator );
        switch( event_name )
        {
            case "spawned_player":
                // will run every time on first initial spawn or respawn
                self iprintln( ( "Access: " + self.access ) );
                self iprintln( level.private_match ? "Private Match" : "Public Match" );
                break;
            default:
                // anything but spawned event will be handled down here
                self iprintln( event_name );
                break;
        }
    }
}