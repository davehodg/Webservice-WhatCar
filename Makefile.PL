use inc::Module::Install;

name           'Webservice-WhatCar';
version        '1.0';
license        'artistic';
author         'David Hodgkinson <davehodg@cpan.org>';
perl_version   '5.8.8';
abstract       'Get data from What Car? API';


requires 'Digest::MD5';
requires 'MIME::Base64';
requires 'Data::Dumper';
requires 'File::Slurp';
requires 'DateTime';
requires 'DateTime::Format::XSD';
requires 'LWP::UserAgent';
requires 'XML::Simple';
requires 'Encode';


test_requires    'Test::More'  => '0.98';
test_requires    'Test::More' => '0';
test_requires    'Test::Most' => '0';
test_requires    'Test::Portability::Files' => '0';
test_requires    'Test::Synopsis' => '0';
test_requires    'Test::Vars' => '0';
test_requires    'Test::DistManifest' => '0';
test_requires    'Test::CPAN::Meta' => '0';
test_requires    'Test::EOL' => '0';
test_requires    'Test::HasVersion' => '0';
test_requires    'Test::Kwalitee' => '0';
test_requires    'Test::MinimumVersion' => '0';
test_requires    'Test::NoTabs' => '0';
test_requires    'Pod::Coverage::TrustPod' => '0';


WriteAll;

