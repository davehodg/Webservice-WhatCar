#!perl

use lib qw/lib/;

BEGIN {
    unless ($ENV{'WHATCAR_USERNAME'} && $ENV{'WHATCAR_PASSWORD'}) {
      require Test::More;
      Test::More::plan(skip_all =>
                       'Set the following environment variables or these tests are skipped: '
                       . "\n"
              . q/ $ENV{'WHATCAR_USERNAME'} && $ENV{'WHATCAR_PASSWORD'}/
                      );
    }
  }

use strict;
use warnings;

use Test::More;
use Data::Dumper;
use lib 'lib';

use Webservice::WhatCar;


use_ok('Webservice::WhatCar');

my $whatcar = Webservice::WhatCar->new
  (
   app_key       => $ENV{'WHATCAR_USERNAME'},
   developer_key => $ENV{'WHATCAR_PASSWORD'},
);

isa_ok($whatcar, 'Webservice::WhatCar', 'Create a new instance');


can_ok( $whatcar, qw ( new get_manufacturers get_new_car_data _get_data _access_authentication) );
ok($whatcar->get_manufacturers, "Get Manufacturers");


# should probably delve into the data structure...
ok($whatcar->get_new_car_data("Tesla"), "Get Tesla");

done_testing;
