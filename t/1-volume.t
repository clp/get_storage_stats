#!/usr/bin/env perl

use Test::More tests => 1;

my $project_dir = "/home/clpoda/p/Parse-StorageArrayLog/";
my $program_under_test = "perl -I lib " . $project_dir . "bin/get_host_stats";
my $infile = 'data/1-volume.txt' ;
my $test_output_filename = "1-volume.out";
my $outdir = "tmp/";

my $test_out = `$program_under_test $infile` or die "Cannot run $program_under_test: [$!]";

open my $outfile, ">", "$outdir/$test_output_filename"  or die "Cannot open [$outdir/$outfile]."; 
print { $outfile } $test_out;

# Compare two files on disk: reference o/p to program under test o/p.
my $ref_out = "refout/$test_output_filename";
my $diff_out = `diff -s  "$outdir/$test_output_filename" $ref_out`;
like( $diff_out, qr{Files.*are.identical.*}, "Compare reference o/p to program o/p for 4 volumes.");
