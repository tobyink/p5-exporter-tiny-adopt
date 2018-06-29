=pod

=encoding utf-8

=head1 PURPOSE

Test that Exporter::Tiny::Adopt works.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2018 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

use strict;
use warnings;
use Test::More tests => 2;

use adopt "Scalar::Util" => (
	looks_like_number => { -as => "lln" },
);

ok lln("42");
ok !lln("hi");
