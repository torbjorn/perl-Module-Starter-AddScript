use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'AddScript',
    license             => 'perl',
    dist_author         => 'Torbjørn Lindahl <torbjorn.lindahl@gmail.com>',
    dist_version_from   => 'lib/AddScript.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'AddScript-*' ],
);

$builder->create_build_script();
