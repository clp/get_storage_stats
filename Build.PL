use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Parse::StorageArrayLog',
    license             => 'artistic',
    dist_author         => 'C. Poda <clp301 -at- poda -dot- net>',
    dist_version_from   => 'lib/Parse/StorageArrayLog.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Parse-StorageArrayLog-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
