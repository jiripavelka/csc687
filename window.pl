#!/usr/bin/perl
use strict;
use warnings;

# user variables
my $left = 7;
my $center = 1;
my $right = 7;
my $blank = "*";
my $sep = "  ";

# read standard input
my $seq = "";
while (<>) {
  $seq = $_;
}
chomp $seq;

# print windows
my $len = length $seq;
$seq = $blank x $left . $seq . $blank x $right;
for (my $i = 0; $i < $len; $i++) {
  print substr($seq, $i, $left).$sep.substr($seq, $i + $left, $center)
    .$sep.substr($seq, $i + $left + $center, $right)."\n";
}
