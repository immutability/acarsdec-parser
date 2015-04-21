#!/bin/bash

process_message() {
	read line1
	read line2
	read line3
	read line4
	read line5

	aircraftreg=$(echo "$line1" | grep -oP "reg: \.*\K[\-\w]+")
	flightid=$(echo "$line1" | grep -oP "id: \K\w+")
	mode=$(echo "$line2" | grep -oP "Mode: \K\w+")
	label=$(echo "$line2" | grep -oP "label: \K\w+")
	blockid=$(echo "$line3" | grep -oP "id: \K\w+")
	ack=$(echo "$line3" | grep -oP "Ack: \K[^\s]+")
	msgno=$(echo "$line4" | grep -oP "no: \K\w+")
	msg=""

	while read line
	do
		if [ ${#line} -eq 0 ]
		then
			break
		fi
		msg="$msg$line"$'\n'
	done

	echo "$1"
	echo "  $aircraftreg $flightid $msgno"

#mysql -h <host> -P <port> -u <user> -p<password> <database> << EOF
#insert into messages (reg,flight,mode,label,blockid,ack,msgno,message,msgstamp,msgfreq) 
#values('$aircraftreg','$flightid','$mode','$label','$blockid','$ack','$msgno','$msg','$1','$2');
#EOF
}

while read line
do
	if [[ $line == [#* ]]
	then
		msgstamp=$(echo "$line" | grep -oP "\) \K.*(?= \-\-)")
		msgfreq=$(echo "$line" | grep -oP "\(F:\K[0-9\.]+(?= )")
		process_message "$msgstamp" "$msgfreq"
		echo " "
	fi
done < "${1:-/dev/stdin}"


