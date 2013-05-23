#!/usr/bin/perl

use strict;
use warnings;
use Test::Most tests => 3;

use AddScript;

{
    local %ENV;

    $ENV{MODULE_STARTER_DIR} = "t/data/.module-starter";

    is( AddScript->_config_file, "t/data/.module-starter/config", "M-S dir in ENV" );

}

{
    local %ENV;

    $ENV{HOME} = "t/data";

    is( AddScript->_config_file, "t/data/.module-starter/config", "M-S dir default" );

    my $expected_config =
      {
       author       => 'Firstname Lastname',
       email        => 'first.last@some.domain',
       builder      => [qw/ExtUtils::MakeMaker Module::Build/],
       template_dir => '/home/username/.module-starter',
       modules      => [],
       plugins      => [],
      };

    cmp_deeply( {AddScript->_config_read}, $expected_config, "config content" );

}

done_testing;
