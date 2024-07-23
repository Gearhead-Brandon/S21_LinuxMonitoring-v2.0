#!/bin/bash

echo "Creates an access_$(($i)).log file with $number_of_records entries"
#> "access_$(($i+1)).log"
touch "access_$(($i)).log"