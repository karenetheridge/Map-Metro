use Map::Metro::Standard::Moops;
use strict;
use warnings;

# VERSION
# PODNAME: Map::Metro::Graph::Transfer
# ABSTRACT: What is a transfer?

class Map::Metro::Graph::Transfer using Moose {

    has origin_station => (
        is => 'ro',
        isa => Station,
        required => 1,
    );
    has destination_station => (
        is => 'ro',
        isa => Station,
        required => 1,
    );
    has weight => (
        is => 'ro',
        isa => Int,
        default => 5,
    );

}

1;

__END__

=pod

=head1 DESCRIPTION

Transfers are used during the graph building phase. Its main purpose is to describe the combination of two L<Stations|Map::Metro::Graph::Station>
when the following holds true:

=over 4

=item There are no L<Lines|Map::Metro::Graph::Line> connecting the two stations.

=item The two stations are a common place for transfers:

=over 4

=item It could be the same physical station, but known under different
names for different types of transport.

=item It could be two subway stations on different lines known under different names.

=back

=back

=cut
