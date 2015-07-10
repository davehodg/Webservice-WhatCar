package Webservice::WhatCar;

use strict;
use warnings;

use Carp;

use Digest::MD5 qw(md5 md5_hex md5_base64);
use MIME::Base64;
use Data::Dumper;
use File::Slurp;
use DateTime;
use DateTime::Format::XSD;
use LWP::UserAgent;
use XML::Simple;
use Encode;

our $VERSION = '1.0';

sub new {
  my $class = shift;

  my $self = {};
  bless $self, $class;

  $self->{username} = $ENV{WHATCAR_USERNAME};
  $self->{password} = $ENV{WHATCAR_PASSWORD};

  return $self;
}

sub get_manufacturers {
  my $self = shift;

  my $xml = $self->_get_data("GetNewCarMakes");
  my $models = XMLin($xml);

  # i like having it as a hash, means we can look stuff
  # up easily
  return $models->{makes}->{"NewCar.Make"} ;
}


sub get_new_car_data {
  my ($self, $make) = @_;
  my $xml;

  while (!defined $xml) {
    $xml = $self->_get_data("GetNewCarData?makeName=$make&includeReviews=true&includeSpecification=true&includeVideo=true");
  }
  return $xml;
}



sub _get_data {
  my ($self, $call) = @_;

  my $ua = LWP::UserAgent->new;
  $ua->agent("TuskerApp/1.0 ");
  $ua->timeout(3600) ; # BIG timeout!

  my $url = "http://feeds.whatcar.com/HaymarketMotoring.asmx/$call";
  my $req = HTTP::Request->new(GET => $url);
  $req->header( 'x-authentication-signatures' =>
                $self->_access_authentication() ) ;

  my $res =  $ua->request($req);

  # Check the outcome of the response
  if (!$res->is_success) {
    carp $res->status_line, "\n";
    return;
  }
  return decode_utf8($res->content);
}


sub _access_authentication {
  my $self = shift;

  my $dt = DateTime->now;
  my $timestamp = DateTime::Format::XSD->format_datetime($dt);
  $timestamp =~ s/\+00:00//x;

  my $checksum = md5_hex($self->{username}.$self->{password}.$timestamp);
  my $xml =  '<?xml version="1.0" encoding="utf-8"?><Signatures xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><user>'.$self->{username}.'</user><code>'.$checksum.'</code><timestamp>'.$timestamp.'</timestamp></Signatures>';
  return encode_base64($xml);
}

1;

=pod

=head1 NAME

Webservice::WhatCar - Get data from What Car? API

=head1 ABSTRACT

Simple API wrapper to get What Car? data

=head1 SYNOPSIS

  use Webservice::WhatCar;

  my $whatcar = Webservice::WhatCar->new
    (
     app_key       => $ENV{'WHATCAR_USERNAME'},
     developer_key => $ENV{'WHATCAR_PASSWORD'},
  );

=head2 $whatcar->get_manufacturers;

=head2 $whatcar->get_new_car_data("Tesla");


=head1 DESCRIPTION

Data is returned as a perl data structure based on the XML we are returned.

=head1 VERSION

Version 1.0

=head1 Constructor

=head2 new

Creates and returns a new Webservice::WhatCar object:

my $whatcar = Webservice::WhatCar->new
  (
   username => $ENV{'WHATCAR_USERNAME'},
   password => $ENV{'WHATCAR_PASSWORD'},
);

=head2 get_manufacturers

=head2 get_new_car_data


=head1 TESTS

To fully exercise the tests set the following environment variables:

WHATCAR_USERNAME=xxxxxxnnnn

WHATCAR_PASSWORD=aceg1357

=head1 AUTHOR

David Hodgkinson <daveh@hodgkinson.org>

=head1 COPYRIGHT

This software is copyright (c) 2011 by Willem Basson.

=head1 LICENSE

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

