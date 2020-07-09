# EMBL-EBI TASK

## Exercise

Using the latest human data from Ensembl release and the Perl API to convert coordinates on chromosome (e.g chromosome 10 from 25000 to 30000 ) to the same region in GRCh37. Enable the script to be as generic as possible to be run as a command-line program.

## Specific Coordinate Conversion

I have created a python script ```specific_cooordinate_conversion.py``` which uses Ensembl REST API Endpoint to convert a specific coordinate from GRCh38 to GRCh37 assembly.


### Input Format 

Input for the python script is ```sequence_region_name:start..end:strand(optional)```.

Here, arguments - "Sequence Region Name, Start Position and End Position" are mandatory whereas "Strand" is optional.

For example,
```X:1000000..1000100:1``` or ```X:1000000..1000100```



### Run the python script ```specific_cooordinate_conversion.py```

Input the arguments as necessary
```
python3 specific_cooordinate_conversion.py X:1000000..1000100
```

### Output format

Output will be of JSON format containing mapping of the the chromosome region in GRCh38 to that of the coordinates in GRCh37

```json
{'mappings': 
  [
  {'original': {'end': 1000100, 'assembly': 'GRCh38', 'strand': 1, 'coord_system': 'chromosome', 'start': 1000000, 'seq_region_name': 'X'}, 
  'mapped': {'end': 960835, 'assembly': 'GRCh37', 'strand': 1, 'coord_system': 'chromosome', 'seq_region_name': 'X', 'start': 960735}
  }, 
  {'original': {'assembly': 'GRCh38', 'end': 1000100, 'start': 1000000, 'seq_region_name': 'X', 'strand': 1, 'coord_system': 'chromosome'}, 
  'mapped': {'coord_system': 'chromosome', 'strand': 1, 'seq_region_name': 'HG480_HG481_PATCH', 'start': 960735, 'end': 960835, 'assembly': 'GRCh37'}
  }
  ]
}
```

## Coordinate Conversion for all regions

I have created a perl script ```convert_coordinates_GR38_GR37.pl``` which uses Ensembl REST API Endpoint to convert all the chromosome sequence regions from GRCh38 to that of the coordinates in GRCh37 assembly.

This script will convert all the coordinates of the chromosome and hence, there is no specific input.

### Run the perl script ```convert_coordinates_GR38_GR37.pl```

```
perl convert_coordinates_GR38_GR37.pl
```

### Output

Output will be a JSON format file ```data_out.json``` containing all the mappings of the the chromosome regions in GRCh38 to that of the coordinates in GRCh37
