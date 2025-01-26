// global includes
#include common_scripts\utility;
#include maps\mp\_utility;

// some junk
#define example_title "Verify Example"
#define example_author "Xeirh"

// mode switching, 1 for multiplayer and 0 for zombies
#define multiplayer 1

#if multiplayer == 1

    #define notify_ended "game_ended"
    #define notify_death "death"
    #define notify_spectator "spawned_spectator"

    #else

    #define notify_ended "end_game"
    #define notify_death "fake_death"
    #define notify_spectator "zombified"

#endif