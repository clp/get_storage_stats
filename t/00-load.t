#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Parse::StorageArrayLog' );
}

diag( "Testing Parse::StorageArrayLog $Parse::StorageArrayLog::VERSION, Perl $], $^X" );
