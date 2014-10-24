package Crypt::KDF::KDF1Generator;

use strict;
use vars qw($VERSION @ISA @EXPORT_OK);

($VERSION) = sprintf '%i.%03i', split(/\./,('$Revision: $' =~ /Revision: (\S+)\s/)[0]);  # $Date: $

require Exporter;
@EXPORT_OK = qw(kdf1_generate);

@ISA=qw{ Crypt::KDF::BaseKDFGenerator };

=head1 NAME

Crypt::KDF::KDF1Generator - KDF1 generator for derived keys and ivs as defined by IEEE P1363a/ISO 18033.

=head1 SYNOPSIS

=head1 DESCRIPTION

This implementation is based on ISO 18033/P1363a.

=head1 FUNCTIONS

=head2 $derivedKey = kdf1_generate( $digest, $seed, $len )

Quick functional interface to use KDF1.

=cut 

sub kdf1_generate
{
	my ($digest, $seed, $len) = @_;
	my $kdf = __PACKAGE__->new(-digest => $digest, -seed => $seed);
	return $kdf->kdf($len);
}

=head1 METHODS

=head2 $kdf = Crypt::KDF::KDF1Generator->new( [options] )

Construct a KDF1 generator.

	-digest the digest to be used as the source of derived keys.
	-digestparam optional parameters for the digest used to derive keys.
	-seed the seed to be used to derive keys.
	-iv optional iv to be used to derive keys.

=cut

sub new
{
	my $class = shift @_;
	my $self = {};
	bless($self, (ref($class) ? ref($class) : $class));
	my %opts = @_;
	if(exists $opts{-digest})
	{
		$self->{-digest} = (ref($opts{-digest}) ? ref($opts{-digest}) : $opts{-digest});
	}
	if(exists $opts{-digestparam})
	{
		$self->{-digestparam} = $opts{-digestparam});
	}
	if(exists $opts{-seed})
	{
		$self->{-seed} = $opts{-seed};
	}
	if(exists $opts{-iv})
	{
		$self->{-iv} = $opts{-iv};
	}
	$self->{-counter} = 0;
	return $self;
}

=head2 $kdf->init( [options] )

Initialize the KDF1 generator.

	-digest the digest to be used as the source of derived keys.
	-digestparam optional parameters for the digest used to derive keys.
	-seed the seed to be used to derive keys.
	-iv optional iv to be used to derive keys.

=cut

sub init
{
	my $self = shift @_;
	my %opts = @_;
	if(exists $opts{-digest})
	{
		$self->{-digest} = (ref($opts{-digest}) ? ref($opts{-digest}) : $opts{-digest});
	}
	if(exists $opts{-digestparam})
	{
		$self->{-digestparam} = $opts{-digestparam});
	}
	if(exists $opts{-seed})
	{
		$self->{-seed} = $opts{-seed};
	}
	if(exists $opts{-iv})
	{
		$self->{-iv} = $opts{-iv};
	}
	$self->{-counter} = 0;
	return $self;
}

sub counter
{
	my $self = shift @_;
	return $self->{-counter};
}

__END__

=head1 EXAMPLES

=head1 SEE ALSO

=head1 COPYRIGHT

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 AUTHORS 

=cut