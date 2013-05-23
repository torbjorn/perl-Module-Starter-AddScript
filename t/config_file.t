#!/usr/bin/perl

use strict;
use warnings;
use Test::Most tests => 5;

use AddScript;

{ ## M-S dir from ENV

    local $ENV{MODULE_STARTER_DIR} = "t/data/.module-starter";

    is( AddScript->_config_file, "t/data/.module-starter/config", "config file from ENV" );

}

{ ## M-S dir from HOME

    local %ENV;
    delete $ENV{MODULE_STARTER_DIR};
    $ENV{HOME} = "t/data";

    is( AddScript->_config_file, "t/data/.module-starter/config", "config file from default" );

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

{ ## M-S dir doesn't exist

    local %ENV;
    delete $ENV{MODULE_STARTER_DIR};
    $ENV{HOME} = "/";

    is( AddScript->_config_file, "/.module-starter/config", "non-existing M-S dir" );

    is( AddScript->_config_read, undef, "non-existing config" );


}

done_testing;
