#!/bin/bash

echo "$1 - Time of the incident and the dealer working at the table:" >> Dealers_working_during_losses 
cat $1_Dealer_schedule | awk -F'\t' '{print $1" - "$3}' | grep "$2" >> Dealers_working_during_losses


#After several Google searches, I have learned that the files that we need to analyse are tab-delimited which means \t can be used as a delimiter to separate out specific columns. 
#That enabled me to create a very simple script that is applicable to both Step 3 and Step 4.

#The first line will print out the date in the file name assigned by the first argument with additional text.
#The second line will print out te exact line where time in question matches (assigned by the second argument).
#Output of both lines will go to the file "Dealers_working_during_losses"

#For example if we run the script with the following arguments: 0310 "05:00:00 AM", the output will be:

#0310 - Time of the incident and the dealer working at the table:
#05:00:00 AM - Billy Jones
