#!/usr/bin/perl

use strict;
use warnings;
use Test::Most tests => 2;

use AddScript;

ok( AddScript::_check_if_module_dir, "this module is a module dir" );
chdir "t";
ok( !AddScript::_check_if_module_dir, "the t dir is not a module dir" );

done_testing;
