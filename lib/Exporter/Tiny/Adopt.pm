use 5.006001;
use strict;
use warnings;

package Exporter::Tiny::Adopt;

our $VERSION    = '0.001';
our $AUTHORITY  = 'cpan:TOBYINK';

sub import {
	my $class = shift;
	my $next  = $_[0] eq -noimport ? (shift and undef) : 'import';
	my ($pkg, @args) = @_;

	unless (eval "require $pkg; 1") {
		require Carp;
		Carp::croak("Could not load package $pkg");
	}
	my $importer = $pkg->can("import");
	
	if ($INC{'Exporter/Tiny.pm'} && $importer eq \&Exporter::Tiny::import) {
		return unless $next;
		@_ = ($pkg, @args);
		goto $importer;
	}
	
	if ($INC{'Exporter.pm'} && $importer eq \&Exporter::import) {
		my $adopter = $class->can('adopt_exporterpm');
		@_ = ($class, $next, $pkg, @args);
		goto $adopter;
	}
	
	require Carp;
	Carp::croak("Could not adopt package $pkg");
}

sub adopt_exporterpm {
	no warnings qw(redefine);
	
	my $class = shift;
	my $next  = shift;
	my ($pkg, @args) = @_;
	
	require Exporter::Tiny;	
	no strict 'refs';
	
	if (@{"$pkg\::EXPORT_FAIL"}) {
		require Carp;
		Carp::croak("Could not adopt package $pkg");
	}
	
	@{"$pkg\::ISA"} = ('Exporter::Tiny', grep $_ ne 'Exporter', @{"$pkg\::ISA"});
	
	if ($pkg->can('import') ne \&Exporter::Tiny::import) {
		*{"$pkg\::import"} = \&Exporter::Tiny::import;
	}
	
	if ($next and not ref ($next)) {
		$next = $pkg->can($next);
	}
	
	goto $next if $next;
	return;
}

1;


__END__

=pod

=encoding utf-8

=head1 NAME

Exporter::Tiny::Adopt - make Exporter::Tiny adopt an Exporter.pm module

=head1 SYNOPSIS

  use Exporter::Tiny::Adopt "Scalar::Util" => (
    looks_like_number => { -as => "lln" },
    blessed           => { -as => "is_blessed" },
  );
  
  lln("42");  # true

=head1 DESCRIPTION

Given an L<Exporter.pm|Exporter>-based module, Exporter::Tiny::Adopt will
monkey-patch it to use Exporter::Tiny instead. This should work for any
exporter that uses:

  use Exporter qw(import);

Or:

  use parent qw(Exporter);  # or equivalent @ISA stuff

Exporters which wrap/override the C<import> method are not suitable for
adoption. If the module you're trying to adopt doesn't seem suitable for
adoption, Exporter::Tiny::Adopt will throw an exception.

Why would you want to monkey-patch a module to use Exporter::Tiny instead
of Exporter.pm? Well, Exporter::Tiny has a bunch of features that the
latter lacks, such as the ability to rename imported functions (shown in
the L</SYNOPSIS>) and the ability to unimport functions when you're done
with them.

The general way to use this module is:

  use Exporter::Tiny::Adopt "Some::Module" => (@args);

It is also possible to do the adoption without calling the module's
C<import> method this way:

  use Exporter::Tiny::Adopt "Some::Module", -noimport;

So, for example, the L</SYNOPSIS> example could be done in two steps:

  use Exporter::Tiny::Adopt "Scalar::Util", -noimport;
  use Scalar::Util (
    looks_like_number => { -as => "lln" },
    blessed           => { -as => "is_blessed" },
  );

This might be kinder to source code scanners looking for dependencies.

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=Exporter-Tiny-Adopt>.

=head1 SEE ALSO

L<adopt> — shorter alias for Exporter::Tiny::Adopt.

L<Exporter::Tiny>, L<Exporter.pm|Exporter>.

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

