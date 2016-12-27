#!/usr/bin/perl
use File::ReadBackwards;
use POSIX "strftime";

my $items;
my $time = $ARGV[0];
my $logfile = "/opt/zimbra/log/mailbox.log";
my $search_string = "service/soap/";
my $goback = POSIX::strftime( "%F %H:%M:%S", localtime( time() - $time * 60 ) );

$readback = File::ReadBackwards->new( $logfile ) or
                        die "unable to open '$logfile' $!" ;

while ( defined( my $line = $readback->readline() ) ) {

    last if $line lt $goback;

    if ($line =~ /$search_string/) {
        print $line;
    }

}
