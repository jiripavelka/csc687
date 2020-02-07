#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw[min max];

my %pop = (
    "China" => 1415,
    "India" => 1354,
    "USA" => 326,
    "Indonesia" => 266,
);

foreach (keys %pop) {
    print "$_ => " . $pop{$_} . "\n";
}
print "\n";

my @a;
foreach (sort { $pop{$b} <=> $pop{$a} } keys %pop) {
    #print "$_ => " . $pop{$_} . "\n";
    push @a, "$_ " . $pop{$_};
}
foreach(@a) {
    print "`$_`\n";
}
print "\n";

my $string = 'A private research university with more than 17,000 students from around the world, the University of Miami is a vibrant and diverse academic community focused on teaching and learning, the discovery of new knowledge, and service to the South Florida region and beyond. The University comprises 11 schools and colleges serving undergraduate and graduate students in more than 180 majors and programs. UM ranks No. 46 on U.S. News & World Report’s 2018 Best Colleges list and ranked No. 44 in the 2018 Wall Street Journal/Times Higher Education College Rankings. Established in 1925 during the region\'s famous real estate boom, UM is a major research university engaged in $324 million in research and sponsored program expenditures annually. While the majority of this work is housed at the Miller School of Medicine, investigators conduct hundreds of studies in other areas, including marine science, engineering, education, and psychology.';
my @words = split / /, $string;
my %wordMap;
foreach(@words) {
    if ($wordMap{$_}) {
        $wordMap{$_}++;
    } else {
        $wordMap{$_} = 1;
    }
    #print "`$_`\n";
}
my @sortedWords;
foreach (sort { $wordMap{$b} <=> $wordMap{$a} } keys %wordMap) {
    #print "$_ => " . $wordMap{$_} . "\n";
    push @sortedWords, "$_ " . $wordMap{$_};
}
foreach(@sortedWords) {
    print "`$_`\n";
}
print "\n";

my $seq1 = "CATTAATGAAAATTCTCAGCAAAAGTCATATATATTCTCGCCAAGGCGACACACCAGCTA";
my $pat = "GC";
my $wc = () = $seq1 =~ /$pat/gi;
if ($wc == 0) {
    print "The pattern `$pat` does NOT occur in the text.\n";
} else {
    print "The pattern `$pat` occurs in the text $wc times.\n";
}
print "\n";

$seq1 = "CCCCEEEEEEECCCCCCCHHHHHHHHHHHCCCCCEEEEECCEEEEEECCHHHHHHHHHHHHHHCCCCEEEEEEC";
my $seq2 = "HHHCCCEEECCCCCCCCHHHHHHHHHHCCCCCCCCCCCCCCCEEECCCCHHHHHHCCCEEEEECCCCEEEEECC";
my $count = 0;
for(my $i = 0; $i < (- 1 + length $seq1); $i++) {
    if (substr($seq1, $i, 2) eq substr ($seq2, $i, 2)) {
        $count++;
    }
}
print "There are $count character pairs in the two DNA sequences.\n"
