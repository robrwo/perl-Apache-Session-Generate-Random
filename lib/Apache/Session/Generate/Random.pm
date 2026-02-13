package Apache::Session::Generate::Random;

use 5.006;

use strict;
use warnings;

use Crypt::SysRandom ();

# RECOMMEND PREREQ:  Crypt::SysRandom::XS

our $VERSION = '0.001000';

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

1;
