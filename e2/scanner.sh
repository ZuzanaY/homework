#!/bin/bash
# validate input
#    ./scanner.sh 172.31.18.0/24 
#    ./scanner.sh 172.31.18.31
if [[ $# -ne 1 ]] ; then
    echo "Scan skipped. Enter the mandatory parameter IP address or IP range!"
    exit 1
fi
echo "scanning: ${1}"
# processing 
touch ./nmap_n.txt
mv ./nmap_n.txt ./nmap_o.txt
ip=$1
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
# statistic 
lines_count=$(wc -l < "nmap_diff.txt")
echo "Scannind finished. ${lines_count} different ip address found."
