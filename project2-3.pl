#!/usr/bin/perl
use strict;
use warnings;

sub train {
    `Rscript RF_train.R Training_features.txt 100 17 RF_model_100_17`;
}

sub dolog {
    die if not open (LOG, ">>", "perl.log");
    print LOG localtime () . " " . $_[0] . "\n";
    close (LOG);
}


dolog "Start";
train;
dolog "Done";

