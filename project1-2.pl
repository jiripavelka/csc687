#!/usr/bin/perl
#use strict;
#use warnings;

my @a;
for (my $i = 0; $i < 155; $i ++) {
    for (my $j = 0; $j < 155; $j ++) {
        $a[$i][$j] = 0;
    }
}

open (IN, "contact_library.txt");
while (<IN>) {
    $_ =~ /(\d+)\d{6}\s+(\d+)\d{6}/;
    $a[$1][$2]++;
    $a[$2][$1]++;
}

open (OUT, ">", "chrX_1Mb_contact_map.txt");
foreach (@a) {
    foreach (@{$_}) {
        print OUT "$_ ";
    }
    print OUT "\n";
}
close (OUT);
