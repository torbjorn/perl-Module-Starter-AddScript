#!/usr/bin/perl

use strict;
use warnings;
use Test::Most tests => 2;

use Module::Starter::AddScript;

ok( Module::Starter::AddScript::_check_if_module_dir, "this module is a module dir" );
chdir "t";
ok( !Module::Starter::AddScript::_check_if_module_dir, "the t dir is not a module dir" );

done_testing;
