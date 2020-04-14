#!/usr/bin/perl
use strict;
use warnings;

my %tr = (
    "H" => "H",
    "G" => "H",
    "I" => "H",
    "E" => "E",
    "B" => "E",
    "T" => "C",
    "S" => "C",
    "C" => "C",
    " " => "C",
);

sub getstr {
    open (DF, "$_[0]");
    my $str = "";
    while (<DF>) {
        $str .= $tr{substr($_, 16, 1)} if $str;
        $str = " " if (substr($_, 0, 12) eq "  #  RESIDUE");
    }
    close (DF);
    return $str;
}

open (IN, "Protein_ID_list_training.txt");
open (OUT, ">", "Training_SS.txt");
while (<IN>) {
    chomp($_);
    my $df = "dssp/$_.dssp";
    `../prj2/dssp-2.0.4-linux-amd64 -i ../prj2/Training_pdbs/$_.pdb -o $df` if not (-f $df);
    print OUT "$_" . (getstr $df) . "\n";
}
close (OUT);
close (IN);

