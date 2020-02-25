#!/usr/bin/perl
use strict;
use warnings;

# user variables
my $user_file = "human_chromosomes_length.txt";
my $user_chr = "chrX";

# get statistics and reference chromosome length
my @data;
my $count = 0;
my $sum = 0;
my $ref_len = 0;
open (IN, $user_file);
while (<IN>) {
    my $i = push (@data, [split("\t", $_)]);
    $ref_len = @{$data[$i-1]}[1] if (@{$data[$i-1]}[0] eq $user_chr);
    $count++;
    $sum += @{$data[$i-1]}[1];
}
close (IN);

# get minimum and save values lower than reference
my $min_chr = $user_chr;
my $min_len = $ref_len;
my @shorter;
foreach my $value(@data) {
    if (@{$value}[1] < $min_len) {
        $min_chr = @{$value}[0];
        $min_len = @{$value}[1];
    }
    push (@shorter, @{$value}[0]) if (@{$value}[1] < $ref_len);
}

printf ("1.1 Chromosome with the shortest length is %s.\n", $min_chr);
printf ("1.2 Average length of all chromosomes is %d.\n", $sum / $count);
printf ("1.3 Chromosomes shorter than %s are: %s.\n", $user_chr, join(", ", @shorter));
