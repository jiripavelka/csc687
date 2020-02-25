#!/usr/bin/perl
use strict;
use warnings;

my $seq = "CATTAATGAAAATTCTCAGCAAAAGTCATATATATTCTCGCCAAGGCGACACACCAGCTA";
$seq =~ s/GC/AA/;
printf ("1. Modified DNA sequence is: %s.\n\n", $seq);

my @arr = ([1,0,0,2], [1,0,0,0], [0,0,0,0], [2,0,0,4]);
my @brr;
for (my $i = 0; $i < 4; $i++) {
    next if ($i == 2); # skipping third row
    my @tmp;
    for (my $j = 0; $j < 4; $j++) {
        next if ($j == 1 || $j == 2); # skipping second and third columns
        push (@tmp, $arr[$i][$j]);
    }
    push (@brr, \@tmp);
}
my $txt = "";
foreach my $tmp (@brr) {
    $txt .= sprintf ("[%s]", join (",", @{$tmp})).",";
}
printf ("2. Resulting array is: (%s).\n\n", $txt);

my $seq1 = "CCCCEEEEEEECCCCCCCHHHHHHHHHHHCCCCCEEEEECCEEEEEECCHHHHHHHHHHHHHHCCCCEEEEEEC";
my $seq2 = "HHHCCCEEECCCCCCCCHHHHHHHHHHCCCCCCCCCCCCCCCEEECCCCHHHHHHCCCEEEEECCCCEEEEECC";
my @over;
for (my $i = 0; $i < length $seq1; $i++) {
    my $j = 0;
    while (substr($seq1, $i, $j + 1) eq substr($seq2, $i, $j + 1)) {
        $j++;
        last if ($i + $j == length $seq1);
    }
    next if $j == 0;
    push (@over, sprintf ("[%d %d]", $i + 1, $i + $j));
    $i += $j;
}
printf ("3. Overlapping sequences are: %s.\n\n", join (", ", @over));

my $sn = 0;
my @a;
my %coord;
open (IN, "test.pdb");
while (<IN>) {
    my $name = substr($_, 13, 2);
    if ($name eq "CB") {
        $sn = 0;
        next;
    }
    next if ($name ne "CA");
    push (@a, $sn * 1) if ($sn != 0);
    $sn = substr($_, 23, 5);
    $coord{$sn} = [substr($_, 30, 8), substr($_, 38, 8), substr($_, 46, 8)];
}
close (IN);
printf ("4.1 Residues which don't have CB atom: %s.\n\n", join (", ", @a));

my @d;
foreach (sort { $coord{$a} <=> $coord{$b} } keys %coord) {
    my $i = $_;
    my @r;
    foreach (sort { $coord{$a} <=> $coord{$b} } keys %coord) {
        my $j = $_;
        push(@r, "d1");
        push(@r, "d2");
        push(@r, "d3");
    }
    print join (" ", @r)."\n";
    last;
    push (@d, @r);
}
foreach my $row (@d) {
    print join (" ", $row)."\n";
}
