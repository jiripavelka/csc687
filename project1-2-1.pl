#!/usr/bin/perl
use strict;
use warnings;

my @a;
for (my $i = 0; $i < 155; $i ++) {
    for (my $j = 0; $j < 155; $j ++) {
        $a[$i][$j] = 0;
    }
}

open (IN, "contact_library.txt");
while (<IN>) {
    die if $_ !~ /^(\d*?)\d{0,6}\s+(\d*?)\d{0,6}$/;
    my $x = ! $1 ? 0 : $1;
    my $y = ! $2 ? 0 : $2;
    $a[$x][$y] ++;
    next if $x == $y;
    $a[$y][$x] ++;
}

open (OUT, ">", "chrX_1Mb_contact_map.txt");
foreach (@a) {
    foreach (@{$_}) {
        print OUT "$_ ";
    }
    print OUT "\n";
}
close (OUT);
