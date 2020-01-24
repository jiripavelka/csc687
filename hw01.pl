#!/usr/bin/perl
use List::Util qw[min max];

my $a = 10;
my $b = 8;
my $c = 8;
my $d = 11;

print "(1)\n";
print "Max of $a, $b, $c, $d is ";
print max($a, $b, $c, $d)."\n";

print "(2)\n";
my $e = 11;
my $f = 22;
print "\$e = $e\n";
print "\$f = $f\n";
print "Swapping...\n";
my $g = $e;
$e = $f;
$f = $g;
print "\$e = $e\n";
print "\$f = $f\n";

print "(3)\n";
print "\$a =? \$b : ".($a == $b ? "Yes" : "No")."\n";
print "\$a =? \$c : ".($a == $c ? "Yes" : "No")."\n";
print "\$b =? \$c : ".($b == $c ? "Yes" : "No")."\n";

print "(4)\n";
my $g = "aabba";
my $h = "aabbab";
my $i = "abbab";

print "different(\$g, \$h, \$i) : ".($g ne $h && $g ne $i ? "Yes" : "No")."\n";
