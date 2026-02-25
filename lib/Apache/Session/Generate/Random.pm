package Apache::Session::Generate::Random;

use 5.006;

use strict;
use warnings;

use Crypt::SysRandom ();

# RECOMMEND PREREQ:  Crypt::SysRandom::XS

our $VERSION = '0.002000';

# ABSTRACT: use system randomness for generating session ids

=head1 SYNOPSIS

    use Apache::Session::Flex;

    tie %sessions, 'Apache::Session::Flex', $id, {
        Store     => 'Postgres',
        Lock      => 'Null',
        Generate  => 'Random',
        Serialize => 'Base64',
    };

=head1 DESCRIPTION

This module extends L<Apache::Session> to create secure random session ids using the system's source of randomness.

=for Pod::Coverage generate

=for Pod::Coverage validate

=cut

sub generate {
    my ($session) = @_;
    return $session->{'data'}->{'_session_id'} = unpack( 'H*', Crypt::SysRandom::random_bytes(20) );
}

sub validate {
    my ($session) = @_;
    if ( $session->{data}->{_session_id} =~ /^[0-9a-f]{40}$/ ) {
        return $session->{data}->{_session_id};
    }
    die "Invalid session ID: " . $session->{data}->{_session_id};
}

=head1 SEE ALSO

L<Apache::Session>

L<Crypt::SysRandom>

=head1 prepend:SUPPORT

Only the latest version of this module will be supported.

This module should work on very old Perl versions, such as v5.6.0.
However, only Perl versions released in the last ten years will be supported.

=head2 Reporting Bugs and Submitting Feature Requests

=head1 append:SUPPORT

If the bug you are reporting has security implications which make it inappropriate to send to a public issue tracker,
then see F<SECURITY.md> for instructions how to report security vulnerabilities.

=cut

1;
