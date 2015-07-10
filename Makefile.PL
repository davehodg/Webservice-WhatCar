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


requires    'Test::More'  => '0.98';
requires    'Test::Most' => '0';
requires    'Test::Portability::Files' => '0';
requires    'Test::Synopsis' => '0';
requires    'Test::Vars' => '0';
requires    'Test::DistManifest' => '0';
requires    'Test::CPAN::Meta' => '0';
requires    'Test::EOL' => '0';
requires    'Test::HasVersion' => '0';
requires    'Test::Kwalitee' => '0';
requires    'Test::MinimumVersion' => '0';
requires    'Test::NoTabs' => '0';
requires    'Pod::Coverage::TrustPod' => '0';
requires    'Test::Pod';
requires    'Test::Perl::Critic';


WriteAll;

