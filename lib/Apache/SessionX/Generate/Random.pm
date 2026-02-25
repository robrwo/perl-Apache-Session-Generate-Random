package Apache::SessionX::Generate::Random;

use 5.006;

use strict;
use warnings;

use Apache::Session::Generate::Random;

our $VERSION = '0.002000';

# ABSTRACT: use system randomness for generating session ids

=head1 SYNOPSIS

    use Apache::SessionX::Generate::Random;
    $id = Apache::SessionX::Generate::Random::generate($string);

=head1 DESCRIPTION

This module extends L<Apache::SessionX> to create secure random session ids using the system's source of randomness.

=for Pod::Coverage generate

=for Pod::Coverage validate

=cut

BEGIN {
  *generate = \&Apache::Session::Generate::Random::generate;
  *validate = \&Apache::Session::Generate::Random::validate;
}

=head1 SEE ALSO

L<Apache::SessionX>

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
