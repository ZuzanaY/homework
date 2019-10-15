#!/bin/bash
# validate input
function checkIP()  {
    ip=$1
    IFS='/' read -ra array_range <<< "$1"
    if ! [[ "${array_range[1]}" == "" || ( "${array_range[1]}" -ge 0 && "${array_range[1]}" -le 32 && ${array_range[1]} =~ ^[0-9]{1,2} ) ]] ; then
        echo "IP range ${array_range[1]} is not valid!"
        exit 2
    fi
    IFS='.' read -ra array_ip <<< "${array_range[0]}"
    if ! [[ "${array_range[0]}" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$  && ${array_ip[0]} -ge 0 && ${array_ip[0]} -le 255 && ${array_ip[1]} -ge 0 && ${array_ip[1]} -le 255 && ${array_ip[2]} -ge 0 && ${array_ip[2]} -le 255 && ${array_ip[3]} -ge 0 && ${array_ip[3]} -le 255 ]]
    then
        echo "This doesn't look like a valid IP Address : ${array_range[0]}"
        exit 3
    fi
}


if [[ $# -ne 1 ]] ; then
    echo "Scan skipped. Enter the mandatory parameter IP address or IP range!"
    exit 1
fi

touch ./nmap_n.txt
mv ./nmap_n.txt ./nmap_o.txt
ip=$1

checkIP $ip

nmap $ip -oG ./nmap_n.txt 1> /dev/null 2> /dev/null
grep -Fxv -f nmap_o.txt nmap_n.txt | grep Host | grep -v Status > nmap_diff.txt
while read line; do
    IFS='(' read -ra array <<< "$line"
    host="${array[0]}"
    host="${host:6:15}"
    echo "host: ${host}"
    IFS=':' read -ra array2 <<< "$line"
    ports="${array2[2]}"
    IFS=',' read -ra array_ports <<< "$ports"
    for i in "${array_ports[@]}"
    do
        IFS='/' read -ra port_details <<< "$i"
        echo "    port number: ${port_details[0]}"
        echo "        state: ${port_details[1]}"
        echo "        protocol: ${port_details[2]}"
        echo "        service: ${port_details[4]}"
    done
done < nmap_diff.txt
