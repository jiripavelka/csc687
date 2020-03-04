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

print ("2.1 Output:\n\n");
my %h;
for (my $i = 100; $i <= 800; $i += 100) {
    $h{$i} = [];
}

my @algo;
open (IN, "CS_courses.txt");
while (<IN>) {
    next if (index($_, ">CSC") < 0);
    $_ =~ /(CSC[^<#]+)/;
    push (@{$h{substr($1, 3, 1)."00"}}, $1);
    push (@algo, $1) if ($_ =~ /(CSC[\d\[\]]+) [^<]+<.+algorithm/i);
}
close (IN);

foreach (sort keys %h) {
    printf ("=== CSC%s ===\n", $_);
    print join ("\n", @{$h{$_}});
    print "\n\n";
}

printf ("2.2 Courses containing 'algorithm' in their introduction "
    . "paragraph:\n%s\n\n", join (", ", @algo));
