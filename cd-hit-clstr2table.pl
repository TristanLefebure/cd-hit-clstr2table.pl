#!/usr/bin/perl

use strict;
use warnings;

my $help = << "HELP";
Usage: $0 <CD-HIT cluster output> <output>
Prints a table with the cluster number (Cluster_0), the sequence name
(TRINITY_DN34773_c0_g1_i1) and the selected sequence name
CD-HIT needs to be run with the -d 0 option.
HELP

if($#ARGV < 1) {
  print $help;
  exit;
}

open IN, $ARGV[0];
open OUT, ">$ARGV[1]";

my %clu;
my $cluster;
my $seq;
my $refseq;

while(<IN>) {
  if(/^>(\w+) (\d+)/) {
    $cluster = $1 . '_' . $2;
  }
  elsif(/ >(\w+)\./) {
    $seq = $1;
    push @{ $clu{$cluster}{seq} }, $seq;
    if(/\*$/) {
      $clu{$cluster}{ref} = $seq;
    }
  }
}

#printing

foreach my $c (sort keys %clu) {
  my @g = @{ $clu{$c}{seq} };
  my $r = $clu{$c}{ref};
  foreach my $s (@g) {
    print OUT "$c\t$s\t$r\n";
  }
}





# >Cluster 0
# 0       2554nt, >TRINITY_DN34773_c0_g1_i1... at +/99.41%
# 1       1838nt, >TRINITY_DN34773_c0_g1_i2... at +/96.79%
# 2       16522nt, >TRINITY_DN34773_c0_g1_i8... at +/98.47%
# 3       16534nt, >TRINITY_DN34773_c0_g1_i11... at +/98.38%
# 4       19368nt, >TRINITY_DN34773_c0_g1_i13... *
# 5       2288nt, >TRINITY_DN34773_c0_g1_i14... at +/96.46%
# >Cluster 1
# 0       3918nt, >TRINITY_DN36616_c6_g2_i1... at +/98.34%
# 1       18106nt, >TRINITY_DN36616_c6_g2_i3... at +/99.08%
# 2       3919nt, >TRINITY_DN36616_c6_g2_i6... at +/98.32%
