#!/usr/bin/perl
use strict;
use warnings;

my $TF = "Training_features.txt";

sub train {
    my $outfile = "RF_model_$_[0]_$_[1]_$_[2]";
    return if (-f $outfile);
    die if not (-f $TF);
    dolog ("Train on $_[2] with $_[0] / $_[1]");
    `Rscript RF_train.R $TF $_[0] $_[1] $outfile`;
    dolog ("Done");
}

sub predict {
    my $mfile = "RF_model_$_[1]_$_[2]_$_[3]";
    die $mfile if not (-f $mfile);
    my $ffile = "$_[0]_feature_file.txt";
    die if not (-f $ffile);
    my $pfile = "$_[0]_predictions_$_[1]_$_[2]_$_[3].txt";
    return if (-f $pfile);
    dolog ("Predict $_[0] on $_[3] with $_[1] / $_[2]");
    `Rscript RF_predict.R $mfile $ffile $pfile`;
    dolog ("Done");
}

sub dolog {
    die if not open (LOG, ">>", "perl.log");
    print LOG localtime () . " " . $_[0] . "\n";
    close (LOG);
}

train (100, 17, 0);
train (100, 24, 0);
train (200, 17, 0);
train (200, 24, 0);

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
    train (100, 17, $i);
    #train (100, 24, $i);
    #train (200, 17, $i);
    #train (200, 24, $i);
    `rm "$TF"`;
}

=pod
die if not open (IN, "../prj2/Protein_ID_list_test.txt");
while (<IN>) {
    my $pid = substr($_, 0, 8);
    predict ($pid, 100, 17, 0);
    foreach (2..$n) {
        predict ($pid, 100, 17, $_);
    }
}

