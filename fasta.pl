#!/usr/bin/perl
use strict;
use warnings;

my %amino = (
  ALA => 'A', CYS => 'C', ASP => 'D', GLU => 'E', PHE => 'F', GLY => 'G',
  HIS => 'H', ILE => 'I', LYS => 'K', LEU => 'L', MET => 'M', ASN => 'N',
  PRO => 'P', GLN => 'Q', ARG => 'R', SER => 'S', THR => 'T', VAL => 'V',
  TRP => 'W', TYR => 'Y');

my $user_file = "1AD5.pdb";
my $base_name = substr($user_file, 0, -4);

my @a;
die "File not found.\n" if !open (IN, $user_file);
die "Cannot open file.\n" if !open(OUT, '>', "$base_name.fas");
print OUT ">$base_name\n";
while (<IN>) {
  next if substr($_, 0, 4) ne "ATOM";
  next if substr($_, 21, 1) ne "A";
  next if substr($_, 13, 2) ne "CA";
  print OUT $amino{substr($_, 17, 3)};
}
close (IN);
close (OUT);
