use 5.006001;
use strict;
use warnings;

package adopt;

require Exporter::Tiny::Adopt;

our $VERSION    = '0.001';
our $AUTHORITY  = 'cpan:TOBYINK';
our @ISA        = 'Exporter::Tiny::Adopt';

1;

__END__

=pod

=encoding utf-8

=head1 NAME

adopt - shorter alias for Exporter::Tiny::Adopt

=head1 SYNOPSIS

  use adopt "Scalar::Util" => (
    looks_like_number => { -as => "lln" },
    blessed           => { -as => "is_blessed" },
  );
  
  lln("42");  # true

=head1 DESCRIPTION

This is an alias for L<Exporter::Tiny::Adopt>, suitable for one-liners
and such.

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=Exporter-Tiny-Adopt>.

=head1 SEE ALSO

L<Exporter::Tiny::Adopt>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2018 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

