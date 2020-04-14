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
open (SS, "Training_SS.txt");
open (OUT, ">", "Training_features.txt");
while (<SS>) {
    my $pid = substr($_, 0, 8);
    die if not open (PSSM, "../prj2/Training_PSSM/$pid.PSSM");
    <PSSM>; <PSSM>; <PSSM>;
    my @w;
    foreach (0..$spread) {
        push(@w, zeros);
    }
    foreach (1..$spread) {
        push(@w, nextrow);
    }
    foreach (split '', substr($_, 9, -1)) {
        shift(@w);
        push(@w, nextrow);
        print OUT $_ . (join '', @w) . "\n";
    }
    close (PSSM);
}
close (OUT);
close (SS);

