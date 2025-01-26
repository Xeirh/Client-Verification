is_host()
{
    return isdefined( self ) && self == level.players[ 0 ];
}

is_admin()
{
    if( !isdefined( level.guid_list ) || !isarray( level.guid_list ) || !level.guid_list.size )
        return false;

    for( a = 0; a < level.guid_list.size; a++ )
    {
        if( level.guid_list[ a ] == self.guid )
            return true;
    }

    return false;
}