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

printf ("1.1 Chromosome with the shortest length is %s.\n\n", $min_chr);
printf ("1.2 Average length of all chromosomes is %d.\n\n", $sum / $count);
printf ("1.3 Chromosomes shorter than %s are: %s.\n\n", $user_chr, join(", ", @shorter));

my %amino=();
$amino{"ALA"} = 'A'; $amino{"CYS"} = 'C'; $amino{"ASP"} = 'D'; $amino{"GLU"} = 'E';
$amino{"PHE"} = 'F'; $amino{"GLY"} = 'G'; $amino{"HIS"} = 'H'; $amino{"ILE"} = 'I';
$amino{"LYS"} = 'K'; $amino{"LEU"} = 'L'; $amino{"MET"} = 'M'; $amino{"ASN"} = 'N';
$amino{"PRO"} = 'P'; $amino{"GLN"} = 'Q'; $amino{"ARG"} = 'R'; $amino{"SER"} = 'S';
$amino{"THR"} = 'T'; $amino{"VAL"} = 'V'; $amino{"TRP"} = 'W'; $amino{"TYR"} = 'Y';

my $prot = "";
my @ca20to30;
my %c_in;
open (IN, "test.pdb");
while (<IN>) {
    next if (substr($_, 13, 2) ne "CA");
    $prot .= $amino{substr($_, 17, 3)};
    my $seq = substr($_, 22, 4);
    my @xyz = (substr($_, 30, 8), substr($_, 38, 8), substr($_, 46, 8));
    $c_in{$seq} = \@xyz;
    next if ($seq < 20 || $seq > 30);
    push (@ca20to30, $_);
}
my @c_out;
foreach (sort { $c_in{$a} <=> $c_in{$b} } keys %c_in) {
    push @c_out, "$_ " . join(" ", @{$c_in{$_}});
}
close (IN);
printf ("2.1 There are %d residues.\n\n", length $prot);
printf ("2.2 Protein sequence is:\n%s\n\n", $prot);
printf ("2.3 CA in range 20-30:\n%s\n", join("", @ca20to30));
printf ("2.4 Sorted list of CA coordinates:\n%s\n", join("\n", @c_out));
