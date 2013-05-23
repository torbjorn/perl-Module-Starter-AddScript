use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Module::Starter::AddScript',
    license             => 'perl',
    dist_author         => 'Torbjørn Lindahl <torbjorn.lindahl@gmail.com>',
    dist_version_from   => 'lib/Module::Starter::AddScript.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Module::Starter::AddScript-*' ],
);

$builder->create_build_script();
