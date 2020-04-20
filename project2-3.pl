#!/usr/bin/perl
use strict;
use warnings;

my $TF = "Training_features.txt";

sub tap {
    my $ext = "$_[0]_$_[1]_$_[2]";
    my $mf = "models/RF_model_$ext";
    train ($_[0], $_[1], $mf);
    return if not (-f $_[2]);
    my $pf = "predictions/" . substr ($_[2], 0, 8) . "_$ext";
    predict ($mf, $_[2], $pf);
    my $ac = `cut -d" " -f1 < "$_[2]" | diff "$pf" - | grep ">" | wc -l` / `wc -l < "$_[2]"`;
    print "$ext prediction accuracy = " . (100 - int ($ac * 1000) / 10) . " %\n";
}

sub train {
    return if (-f $_[2]);
    die if not (-f $TF);
    dolog ("Train $_[2]");
    `Rscript RF_train.R $TF $_[0] $_[1] $_[2]`;
    dolog ("Done");
}

sub predict {
    return if (-f $_[2]);
    dolog ("Predict $_[2]");
    `Rscript RF_predict.R $_[0] $_[1] $_[2]`;
    dolog ("Done");
}

sub dolog {
    die if not open (LOG, ">>", "p.log");
    print LOG localtime () . " " . $_[0] . "\n";
    close (LOG);
}

tap (100, 17, "full");
tap (100, 24, "full");
tap (200, 17, "full");
tap (200, 24, "full");

my $n = 5;
my $l = int (`wc -l < "$TF"` / $n) + 1;
`split --numeric-suffixes=1 -l $l $TF` if not (-f "x01");
$TF = "tmp_training_features.txt";
die if (-f $TF);
foreach my $i (1..$n) {
    foreach (1..$n) {
        next if $_ == $i;
        `cat "x0$_" >> "$TF"`;
    }
    tap (100, 17, "x0$i");
    tap (100, 24, "x0$i");
    tap (200, 17, "x0$i");
    tap (200, 24, "x0$i");
    `rm "$TF"`;
}

