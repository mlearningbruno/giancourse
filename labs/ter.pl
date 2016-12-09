#!/usr/bin/env perl
# wrapper around tercom java code, allows for command line call
#
# CREATION Bruno Pouliquen 8/12/2016
#
if ($#ARGV < 1) {
    die "usage: perl $0 \"string1\" \"string2\"\n or \nperl $0 File1 File2";
}
my $tercomJar = '/home/smt/tercom-0.7.25/tercom.7.25.jar';
if (! -f $tercomJar) {die "Error: this tool has to use tercom jar";}
open (F1, ">:utf8", "/tmp/f1$$.txt") || die "Err $!: /tmp/f1$$.txt:$!";
open (F2, ">:utf8", "/tmp/f2$$.txt") || die "Err $!: /tmp/f2$$.txt:$!";
if (-f $ARGV[0] && -f $ARGV[1]) {
    open (I1, "<:utf8", $ARGV[0]) || die "Err read $!: $ARGV[0]";
    open (I2, "<:utf8", $ARGV[1]) || die "Err read $!: $ARGV[1]";
    my $i=0; while (<I1>) {chomp; print F1 "$_ (".$i++.")\n";}
    $i=0; while (<I2>) {chomp; print F2 "$_ (".$i++.")\n";}
    close I1;
    close I2;
} else {
    if (-f $ARGV[0]) {die "File $ARGV[1] does not exist";}
    if (-f $ARGV[1]) {die "File $ARGV[0] does not exist";}
    print F1 $ARGV[0]," (0)\n";
    print F2 $ARGV[1]," (0)\n";
}
my $out=`java -jar $tercomJar -r /tmp/f1$$.txt -h /tmp/f2$$.txt`;
close F1;
close F2;
if (! defined $ARGV[2]) {
    my ($ter) = $out=~ /Total TER: ([0-9]\.[0-9]+)/;
    print $ter,"\n";
} else {
    print $out;
}
unlink "/tmp/f1$$.txt","/tmp/f2$$.txt";
