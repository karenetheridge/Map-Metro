use Map::Metro::Standard::Moops;
use strict;
use warnings;

# VERSION
# PODNAME: Map::Metro::Exception::DuplicateStationName

class Map::Metro::Exception::DuplicateStationName with Map::Metro::Exception using Moose {

    use Map::Metro::Exception -all;

    has name => (
        is => 'ro',
        isa => Any,
        traits => [Payload],
    );
    has info => (
        is => 'ro',
        isa => Str,
        lazy => 1,
        default => q{Station name [%{name}s] already exist in station list.},
    );
}

1;
