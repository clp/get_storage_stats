package Parse::StorageArrayLog;

use warnings;
use strict;

use Exporter ();

our @ISA       = qw/Exporter/;
our @EXPORT_OK = qw/match_line match_paragraph /;

# given a line from the i/p file,
#  return a hash ref containing one or more records from the line where:
#   the key and value are the name & value of a desired field.
# if a desired field is not found '' is returned in its place.

sub match_line {
    my $line = shift;
    my %stats;
    return('') unless $line;
    if ( m/(\S+)\s+\w+\s+([\d,.]+ \s \w+)\s+ 
            (RAID \s \d+) \s+\w+\s+(\S+)\s*/smx ) {
        # volname is $1.
        $stats{capacity} = $2  ;
        $stats{raid} = $3  ;
        $stats{pool} = $4  ;
        return ($1, \%stats);
    }

    # Note: 
    # The field used here for hostname is really domain name, 
    # which need not be the same as the hostname.  This solution
    # is OK for now, according to the user.
    if ( m/^(\S+)\s+(\d+)\s+Tray\S+\s+(\S+)\s+\S+\s+$/ ) {
        # volname is $1.
        $stats{hostname} = $3  ;
        $stats{lun} = $2  ;
        return ($1, \%stats);
    }
    return('');
} # End sub match_line.


sub match_paragraph {
    my $block = shift;
    my %stats;
    return('') unless $block;

    if ( m/\s+ Volume.name:\s+ (\S+).*  # .*  gets anything including newline,
                                        # until next anchor text (Volume.WWN).
            Volume.WWN: \s+(\S+) .*     # Capture value of WWN 
            Status:/msx ) {             # /s: allows dot to match newline.
        # volname is $1.
        $stats{volname} = $1  ;
        $stats{wwn} = $2  ;
        return ($1, \%stats);
        next;
    }
    return('');
} # End sub match_paragraph.






=head1 NAME

Parse::StorageArrayLog - The great new Parse::StorageArrayLog!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Parse::StorageArrayLog;

    my $foo = Parse::StorageArrayLog->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 match_line

A line from the input file
is provided by the calling software.

Examine the line for a match with the patterns provided here,
which search for 
volume name, capacity, RAID level, RAID pool, hostname, and LUN.

If a match is found, return volume name, and a reference to a hash
with these keys:
  volname
  capacity
  raid
  pool
  hostname
  lun

=cut


=head2 match_paragraph

A paragraph, or block, of lines from the input file,
is provided by the calling software.

Examine the block for a match with the pattern provided here,
which searches for volume name and volume WWN.

If found, return volume name, and a reference to a hash
with these keys,
that holds volume name and WWN:
  volname
  wwn

=cut



=head1 AUTHOR

C. Poda, C<< <clp301 -at- poda -dot- net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-parse-storagearraylog at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Parse-StorageArrayLog>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Parse::StorageArrayLog


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Parse-StorageArrayLog>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Parse-StorageArrayLog>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Parse-StorageArrayLog>

=item * Search CPAN

L<http://search.cpan.org/dist/Parse-StorageArrayLog>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2011 C. Poda, all rights reserved.

This program is released under the following license: artistic


=cut

1; # End of Parse::StorageArrayLog
