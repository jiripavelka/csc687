#!/usr/bin/perl
use strict;
use warnings;

die "Missing file name argument.\n" if scalar @ARGV == 0;
die "File not found.\n" if !open (IN, $ARGV[0]);

my %amino = (
  ALA => 'A', CYS => 'C', ASP => 'D', GLU => 'E', PHE => 'F', GLY => 'G',
  HIS => 'H', ILE => 'I', LYS => 'K', LEU => 'L', MET => 'M', ASN => 'N',
  PRO => 'P', GLN => 'Q', ARG => 'R', SER => 'S', THR => 'T', VAL => 'V',
  TRP => 'W', TYR => 'Y'
);

my @a;
print ">".substr($ARGV[0], 0, -4)."\n";
while (<IN>) {
  next if substr($_, 0, 4) ne "ATOM";
  next if substr($_, 21, 1) ne "A";
  next if substr($_, 13, 2) ne "CA";
  print $amino{substr($_, 17, 3)};
}
close (IN);
print "\n";
