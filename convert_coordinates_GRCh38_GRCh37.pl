#!/usr/bin/perl -w

use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use HTTP::Tiny;
use JSON;
use Data::Dumper;

my $registry = 'Bio::EnsEMBL::Registry';

$registry->load_registry_from_db(
  -host => 'ensembldb.ensembl.org',
  -user => 'anonymous'
);

my $http = HTTP::Tiny->new();
my $server = 'http://grch37.rest.ensembl.org';
my $ext = '/map/human/GRCh38/';
my $slice_adaptor = $registry->get_adaptor( 'homo_sapiens', 'Core', 'Slice' );


my @chromosomes = @{ $slice_adaptor->fetch_all('chromosome', 'GRCh38') };

printf("Number of Chromosomes: %d\n",$#chromosomes);
open my $fh, ">", "data_out.json";
foreach my $chromsome (@chromosomes) {
	my $coord_sys  = $chromsome->coord_system()->name();
	my $seq_region = $chromsome->seq_region_name();
	my $start      = $chromsome->start();
	my $end        = $chromsome->end();
	my $strand     = $chromsome->strand();
	printf("Sequence: $coord_sys $seq_region $start-$end ($strand)\n");
	my $new_ext = $ext.$seq_region.':'.$start.'..'.$end.':'.$strand.'/GRCh37?';
	my $response = $http->get($server.$new_ext, {
	  headers => { 'Content-type' => 'application/json' }
	});
	 
	die "Failed!\n" unless $response->{success};

	if(length $response->{content}) {
	  my $hash = decode_json($response->{content});
	  local $Data::Dumper::Terse = 1;
	  local $Data::Dumper::Indent = 1;
	  print $fh encode_json($hash);
	}
}
close $fh;
