#!/usr/bin/perl
use strict;
use warnings;

sub train {
    my $outfile = "RF_model_$_[0]_$_[1]";
    return if (-f $outfile);
    dolog ("Train $_[0] $_[1]");
    `Rscript RF_train.R Training_features.txt $_[0] $_[1] $outfile`;
    dolog ("Done");
}

sub dolog {
    die if not open (LOG, ">>", "perl.log");
    print LOG localtime () . " " . $_[0] . "\n";
    close (LOG);
}

train (100, 17);
train (100, 24);
train (200, 17);
train (200, 24);

