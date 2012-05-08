#!/usr/bin/env perl

use Modern::Perl;
use Net::Netrc;
use Google::Voice;

my $machine = Net::Netrc->lookup('google.com');
my $google  = Google::Voice->new();

$google->login($machine->login,$machine->password);
$google->send_sms($ARGV[0], $ARGV[1]);
