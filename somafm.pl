#!/usr/bin/env perl

use Modern::Perl;
use Mojo::UserAgent;
use Mojo::DOM;
use IPC::System::Simple qw(run);
use File::Temp;
use File::Slurp qw(read_file);
use Try::Tiny;

my $somafm_url         = q{http://somafm.com};
my $backtitle          = q{SomaFM: Listener Supported, Commercial Free Internet Radio};
my $title              = q{Select a station to listen to};
my $radiolist_title    = q{Select a station to listen to};
my $dialog_geom        = q{20 60};
my $dialog_list_height = q{24};
my @stations           = get_stations();

while (1) {
  play(get_station_selection());
}

sub play {
  my ($station) = @_;

  my $url         = sprintf qq{$somafm_url/startstream=%s.pls}, $station;
  my $mplayer_cmd = sprintf q{mplayer -quiet -vo none -ao sdl %s 2>&1}, $url;

  run(qq{$mplayer_cmd | dialog --progressbox $dialog_geom});

  return;
}

sub get_station_selection {
  my $temp   = File::Temp->new();
  my $dialog = build_station_selection_dialog($temp->filename);

  try {
    run($dialog);
  } catch {
    exit;
  };

  return read_file($temp->filename);
}

sub build_station_selection_dialog {
  my ($temp_file) = @_;

  my $cmd  = qq{dialog --backtitle "$backtitle" };
     $cmd .= qq{--title "$title" --clear --radiolist };
     $cmd .= qq{"$radiolist_title" $dialog_geom $dialog_list_height };

  map {$cmd .= qq{"$_->[1]" "$_->[0]" off }} @stations;

  return qq{$cmd 2> $temp_file};
}

sub get_stations {
  my $agent    = Mojo::UserAgent->new();
  my $dom      = Mojo::DOM->new($agent->get($somafm_url)->res->body);
  my @stations = ();

  $dom->find('li.cbshort')->each(
    sub {
      my $node = shift;
      (my $station_name = $node->at('a:first-child')->attrs('href')) =~ s/\///g;
      my $station_title = $node->at('h3')->text();

      push @stations, [$station_title, $station_name];
    }
  );

  return @stations;
}