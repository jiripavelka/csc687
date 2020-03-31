#!/usr/bin/perl
use strict;
use warnings;

sub v2d {
    return 1 if $_ == 0;
    return (1 / $_)**(1/3);
}

my %s;
my @a;
my $i = 0;
open (IN, "chrX_1Mb_contact_map.txt");
while (<IN>) {
    if ($_ =~ /^[0 ]+$/) {
        $s{$i++} = 1;
        next;
    }
    push (@a, $_);
    $i ++;
}
close (IN);

open (OUT, ">", "chrX_1Mb_distance_map.txt");
foreach (@a) {
    $i = 0;
    foreach (split (" ", $_)) {
        next if exists ($s{$i ++});
        print OUT (v2d $_)." ";
    }
    print OUT "\n";
}
close (OUT);
