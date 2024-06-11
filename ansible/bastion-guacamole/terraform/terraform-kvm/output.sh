#!/bin/bash 
terraform output -json information > /tmp/a
COUNT=`jq '.[] | length' /tmp/a`
for I in $(seq 0 $(( ${COUNT} - 1)) )
do
	MACHINE=`jq -c -r '.[0]."'${I}'".vm_name' /tmp/a | awk -F'[\"]' '{ print $2 }'`
	IP=`jq -c -r '.[0]."'${I}'".vm_address|.[0]' /tmp/a | awk -F'[\"]' '{ print $2 }'`
	echo "${IP}    ${MACHINE}"
done

