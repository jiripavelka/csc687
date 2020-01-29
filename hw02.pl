#!/usr/bin/perl
use List::Util qw[min max];

my @a;
for ($i = 1; $i <= 11; $i = $i + 2) {
    push @a, $i;
}
my @b;
for ($i = 10; $i >= 0; $i = $i - 2) {
    push @b, $i;
}
my @c;
$max = 0;
$sum = 0;
for($i = 0; $i <= $#a; $i++) {
    $p = $a[$i] * $b[$i];
    if ($p > $max) {
        $max = $p;
    }
    $sum += $p;
    push @c, $p;
}
print "Largest = $max, Sum = $sum\n";

my @d;
for ($i = 1; $i <= 100; $i++) {
    push @d, $i;
}
$sum = 0;
foreach(@d) {
    $sum += $_;
}
print "Sum 1..100 is $sum\n";

$s = "Zheng Wang 28; Mary Young 34; Bob Clinton 38; Cali Liu 31; Winston Churchill 2; ";
@n = split /; /, $s;
$max = 0;
foreach(@n) {
    @p = split / /, $_;
    if ($p[2] > $max) {
        $max = $p[2];
    }
}
print "Oldest person is $max years old.\n";

$s = "A private research university with more than 17,000 students from around the world, the University of Miami is a vibrant and diverse academic community focused on teaching and learning, the discovery of new knowledge, and service to the South Florida region and beyond. The University comprises 11 schools and colleges serving undergraduate and graduate students in more than 180 majors and programs. UM ranks No. 46 on U.S. News & World Report’s 2018 Best Colleges list and ranked No. 44 in the 2018 Wall Street Journal/Times Higher Education College Rankings. Established in 1925 during the region's famous real estate boom, UM is a major research university engaged in \$324 million in research and sponsored program expenditures annually. While the majority of this work is housed at the Miller School of Medicine, investigators conduct hundreds of studies in other areas, including marine science, engineering, education, and psychology. ";

my $w = "university";
my $wc = () = $s =~ /$w/gi;
my $twc = () = $s =~ / /gi;
print "The word '$w' occurs $wc times in $twc words.\n";
