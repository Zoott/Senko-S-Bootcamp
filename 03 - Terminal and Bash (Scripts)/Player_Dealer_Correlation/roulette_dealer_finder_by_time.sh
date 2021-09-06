#!/bin/bash

echo "$1 - Time of the incident and the dealer working at the table:"
cat $1_Dealer_schedule | awk -F'\t' '{print $1" - "$3}' | grep "$2"


#As mentioned in the previous script, this script is pretty much the same. The first argument is for date and the second argument for time.
