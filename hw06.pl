#!/usr/bin/perl
use strict;
use warnings;

my @arr1 = (12,546,13,45,32,2);
my @arr2 = (1,78,2,46,6,45);

sub rg {
    my @a;
    my $i = 1;
    foreach (sort { $_[$b] <=> $_[$a] } keys @_) {
        @a[$_] = $i++;
    }
    return @a;
}

my @rg_arr1 = rg(@arr1);
my @rg_arr2 = rg(@arr2);
my $di_ssum = 0;
for (my $i = 0; $i < @arr1; $i++) {
    $di_ssum += ($rg_arr1[$i] - $rg_arr2[$i])**2;
}
my $rs = 1 - 6 * $di_ssum / (@arr1 * (@arr1**2 - 1));
printf ("1. Spearman's rank correlation coefficient is %.3f.\n\n", $rs);
