package Apache::Session::Generate::Random;

use 5.006;

use strict;
use warnings;

use Crypt::SysRandom ();

our $VERSION = '0.001000';

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
