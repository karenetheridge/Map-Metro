use 5.20.0;
use warnings;

package Map::Metro::Exception::LineIdContainsIllegalCharacter {

    use Moose;
    use Types::Standard -types;
    with qw/Map::Metro::Exception/;
    use Map::Metro::Exception -all;
    use namespace::autoclean;

    has line_id => (
        is => 'ro',
        isa => Str,
        traits => [Payload],
    );
    has illegal_character => (
        is => 'ro',
        isa => Any,
        traits => [Payload],
    );
    has info => (
        is => 'ro',
        isa => Str,
        lazy => 1,
        default => q{Line id [%{line_id}s] contains illegal character [%{illegal_character}s]},
    );
}

1;