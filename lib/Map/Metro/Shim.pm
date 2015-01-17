use Map::Metro::Standard::Moops;

# VERSION
# PODNAME: Map::Metro::Shim
# ABSTRACT: Easily load a map file

class Map::Metro::Shim using Moose  {

    use Map::Metro::Graph;

    has filepath => (
        is => 'rw',
        isa => AbsFile,
        required => 1,
        coerce => 1,
    );
    has hooks => (
        is => 'ro',
        isa => ArrayRef,
        traits => ['Array'],
        default => sub { [] },
        handles => {
            all_hooks => 'elements',
        }
    );

    around BUILDARGS($orig: $class, @args) {
        return $class->$orig(@args) if scalar @args == 2;
        return $class->$orig(filepath => shift @args) if scalar @args == 1;

        my %args;
        if(scalar @args % 2 != 0) {
            my $filepath = shift @args;
            %args = @args;
            $args{'filepath'} = $filepath;
        }
        else {
            %args = @args;
        }
        if(exists $args{'hooks'} && !ArrayRef->check($args{'hooks'})) {
            $args{'hooks'} = [$args{'hooks'}];
        }

        return $class->$orig(%args);
    };

    method parse(:$override_line_change_weight) {
        return Map::Metro::Graph->new(filepath => $self->filepath,
                                      wanted_hook_plugins => [$self->all_hooks],
                                      defined $override_line_change_weight ? (override_line_change_weight => $override_line_change_weight) : (),
                               )->parse;
    }
}

1;

__END__

=pod

=head1 SYNOPSIS

    use Map::Metro::Shim;

    my $graph = Map::Metro::Shim->new('../path/to/mapfile.txt')->parse;

=head1 DESCRIPTION

If you want to test a map file without creating a module, use this class instead of L<Map::Metro> and pass the path to the map file.

=head2 Methods

=head3 new($filepath)

B<C<$filepath>>

The path to the map file.

Apart from that this module works just like L<Map::Metro>.

=head1 SEE ALSO

L<Map::Metro>

=cut
