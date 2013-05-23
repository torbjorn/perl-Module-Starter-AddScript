#!/usr/bin/perl

use strict;
use warnings;
use Test::Most tests => 2;

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

}

done_testing;
