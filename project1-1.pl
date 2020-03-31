#!/usr/bin/perl
#use strict;
#use warnings;

my %h;
open (IN, "sra_1_chrX.sam");
while (<IN>) {
    next if (substr($_, 0, 3) ne "SRR");
    my @a = split("\t", $_);
    $h{substr($a[0], 0, -2)} = $a[3];
}
close (IN);

open (IN, "sra_2_chrX.sam");
open (OUT, ">", "contact_library.txt");
while (<IN>) {
    my @a = split("\t", $_);
    next if !exists($h{substr($a[0], 0, -2)});
    print OUT $h{substr($a[0], 0, -2)}." ".$a[3]."\n";
}
close (IN);
close (OUT);
