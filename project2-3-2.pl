#!/usr/bin/perl
use strict;
use warnings;

sub zeros {
    return " 0" x 20;
}

sub nextrow {
    return zeros if not my $l = <PSSM>;
    return zeros if $l !~ /^ +[0-9]+ [A-Z]/;
    my @v = split (/ +/, $l);
    my $row = "";
    foreach (1..20) {
        $row .= " " . (1 / (1 + exp -$v[$_+2]));
    }
    return $row;
}

my $spread = 7;
die if not open (SS, "../prj2/Protein_ID_list_test.txt");
while (<SS>) {
    my $pid = substr($_, 0, 8);
    my $pfn = "../prj2/Test_PSSM/$pid.PSSM";
    die if not open (PSSM, $pfn);
    <PSSM>; <PSSM>; <PSSM>;
    my @w;
    foreach (0..$spread) {
        push(@w, zeros);
    }
    foreach (1..$spread) {
        push(@w, nextrow);
    }
    my $wcl = `wc -l < $pfn`;
    open (OUT, ">", $pid . "_feature_file.txt");
    foreach (8..$wcl) {
        shift(@w);
        push(@w, nextrow);
        print OUT "C" . (join '', @w) . "\n";
    }
    close (OUT);
    close (PSSM);
}
close (SS);

