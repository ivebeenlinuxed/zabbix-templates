#!/usr/bin/perl
use File::ReadBackwards;
use POSIX "strftime";

my $items;
my $time = $ARGV[0];
my $logfile = "/var/log/mail.log";
my $search_string = "NOQUEUE\: reject\:";
my $goback = POSIX::strftime( "%b %d %H:%M:%S", localtime( time() - $time * 60 ) );

$readback = File::ReadBackwards->new( $logfile ) or
                        die "unable to open '$logfile' $!" ;

while ( defined( my $line = $readback->readline() ) ) {

    last if $line lt $goback;

    if ($line =~ /$search_string/) {
        print $line;
    }

}
