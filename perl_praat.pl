use strict;
use warnings;
use Encode qw(decode encode);
use utf8;
binmode STDOUT, ":utf8";

my $str = 'vocales.wav';
my $frame_size = 0.060;
my $frame_step = 0.060;
my $path_sound = "vocales.wav";
my $path_textgrid_out = "vocales.MFCC";
my $code_run = "";
my $path_praat = "/usr/bin/praat";
my $trimDecimal = sub { return 0 + sprintf "%.3f", shift; };


get_textGrid_silences($path_sound, 100, 0, -25, 0.1, 0.1, "silent", "sounding");
get_mfcc($path_sound,12, $frame_size, $frame_step, 100.0, 100.0, 0.0);
get_formants($path_sound, "vocales.TextGrid", $frame_step, 2, 5500.0, $frame_size, 50);
#get_energy0($path_sound, "vocales.TextGrid");
get_energy($path_sound, $frame_size, $frame_step);

my ($validation, $data, $header) = read_csv("vocales.energy", "utf-8");

for (my $i = 0; $i < @$data; $i++){
  print $trimDecimal->($data->[$i][0]), "\t", $data->[$i][1], "\n";
}

sub get_energy{
  my ($path_sound, $frame_size, $frame_step) = @_;
  system("$path_praat --run energia.praat $path_sound $frame_size $frame_step");
}

sub get_energy0{
  my ($path_sound, $path_TextGrid) = @_;
  system("$path_praat --run energy.praat $path_sound $path_TextGrid");
}


sub get_mfcc{
  my ($path_sound,$num_coef, $frame_size, $frame_step, $f_filter, $distance,$maximu) = @_;
  system("$path_praat --run MFCC.praat $path_sound $num_coef $frame_size $frame_step $f_filter $distance $maximu");
}

sub get_textGrid_silences{
  my ($path_sound,$pitch,$frame_step,$silence_threshold,$minimun,$maximun,$silent_labl,$sounding) = @_;
  #print $path_praat." --run TextGrid.praat ".$path_sound $path_name;
  system("$path_praat --run TextGrid.praat $path_sound $pitch $frame_step $silence_threshold $minimun $maximun $silent_labl $sounding");
}

sub get_formants{
  my ($path_sound, $path_TextGrid, $frame_step, $num_formants, $forman_celling_Hz, $frame_size, $pre_empasis_Hz) = @_;
  system("$path_praat --run FORMATS.praat $path_sound $path_TextGrid $frame_step $num_formants $forman_celling_Hz $frame_size $pre_empasis_Hz");
}

sub read_csv{
  my ($file_name, $encoding) = @_;
  
  if (!(-e $file_name)){
    print STDERR "File $file_name could not be found in that path.\n";
    return 0;
  }
  
  $encoding = "utf-8" if (!defined $encoding || $encoding =~ /^\s*$/);
  
  #Reading data from file and building array.
  open(FH, '<', $file_name) or die $!;
  my $header_str = <FH>;
  chomp $header_str;
  my @dataset_arr = ();
  while (<FH>){
    chomp;
    push @dataset_arr, [split ",", Encode::decode($encoding, $_ , Encode::FB_CROAK)];
  }
  close(FH);
  
  my $header = [split ",", Encode::decode($encoding, $header_str , Encode::FB_CROAK)];
  
  return (1, \@dataset_arr, $header);
}