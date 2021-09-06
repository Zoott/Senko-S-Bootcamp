#!/bin/bash

if [[ $# -eq 0 ]]; 
then
	echo "To use this script please enter arguments (DATE) '(TIME)'"
else
	echo "$1 - Time of the incident and the dealer working at the Blackjack table:"
        cat $1_Dealer_schedule | awk -F'\t' '{print $1" - "$2}' | grep "$2"

	echo "$1 - Time of the incident and the dealer working at the Roulette table:"
        cat $1_Dealer_schedule | awk -F'\t' '{print $1" - "$3}' | grep "$2"

	echo "$1 - Time of the incident and the dealer working at the Texas hold'em table:"
        cat $1_Dealer_schedule | awk -F'\t' '{print $1" - "$4}' | grep "$2"
fi

#This is my version of the script to see which dealer is working on which table.
#Since I lack the knowledge to write a script that could print specific game table on demand,
#I have decided to make it display all three at the same time, marked with their names respectively.