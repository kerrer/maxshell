#!/usr/bin/perl 
 
use strict;
use warnings;

use threads;
use threads::shared;
use Thread::Queue;

use Getopt::Long qw(GetOptions);
 
my $filename;
my $numthread = 5;

GetOptions(
	'f|filename=s'        => \$filename,
	'n=i'        => \$numthread,
) or die "Usage: $0 -f filename [-n NUM OF THREADS ]]\n";

if ( !$filename) {
     die "Usage: $0 -f filename [-n NUM OF THREADS ]]\n";
}


# (2) we got two command line args, so assume they are the
# first name and last name
my $file=$ARGV[0];
my $threads=$ARGV[1];

print "Hello, $filename $numthread\n";


-e $filename && -T $filename or die "$filename is not valid file";

my $DataQueue = Thread::Queue->new();

for my $i (1..$numthread) {
    my $th_name = "thr".$i;
    threads->create(sub {
		my $id = shift @_;
        while (my $boxname = $DataQueue->dequeue()) {
            print("Tread-$id is adding box : $boxname \n");
            system("vagrant box add $boxname --provider virtualbox ");
            sleep(3);
        }
    },$i);
    
}

open my $info, $filename or die "Could not open $filename: $!";
while( my $line = <$info>)  {    
    my  @temp = split(/\(/,$line);  
    #print $temp[0];
    print "\n";
    $DataQueue->enqueue($temp[0]);
}
close $info;
$DataQueue->end();
 
    
foreach my $thr (threads->list()) {
       $thr->join();
}

exit;



 
