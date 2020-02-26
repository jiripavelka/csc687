#!/usr/bin/perl
use strict;
use warnings;

my $user_file = "1AD5.pdb";
my $user_rsn = 200;
my $user_radius = 20;

sub edist {
  my ($x1, $y1, $z1, $x2, $y2, $z2) = @_;
  return sqrt(($x1 - $x2)**2 + ($y1 - $y2)**2 + ($z1 - $z2)**2);
}

my @a;
my $ref = "unknown";
die "File not found.\n" if !open (IN, $user_file);
while (<IN>) {
  next if substr($_, 0, 4) ne "ATOM";
  next if substr($_, 21, 1) ne "A";
  next if substr($_, 13, 2) ne "CA";
  if (substr($_, 23, 3) eq $user_rsn) {
    $ref = $_;
    next;
  }
  push (@a, $_);
}
close (IN);
die "Reference atom not found.\n" if $ref eq "unknown";

my @b;
my ($x, $y, $z) = (substr($ref, 30, 8), substr($ref, 38, 8), substr($ref, 46, 8));
foreach (@a) {
  my $d = edist($x, $y, $z, substr($_, 30, 8), substr($_, 38, 8), substr($_, 46, 8));
  next if $d > $user_radius;
  push @b, substr($_, 17, 3);
}

printf ("There is %d atoms in %d radius around residue with sequence number of %d:\n", scalar @b, $user_radius, $user_rsn);
print join (" ", @b)."\n";
