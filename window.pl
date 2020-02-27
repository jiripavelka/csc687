#!/usr/bin/perl
use strict;
use warnings;

my $user_file = "1AD5.fas";
my $user_left = 7;
my $user_center = 1;
my $user_right = 7;
my $user_blank = "_";

die "File not found.\n" if !open (IN, $user_file);
my $seq = "";
while (<IN>) {
  $seq = $_;
}
close (IN);

my $len = length $seq;
$seq = $user_blank x $user_left . $seq . $user_blank x $user_right;
for (my $i = 0; $i < $len; $i++) {
  print substr($seq, $i, $user_left + $user_center + $user_right)."\n";
}
