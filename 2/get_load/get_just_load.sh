# /bin/bash
statusCode() {
	#curl -s 'http://10.0.1.94:800/pc1/' #| jq '.cpu.percent'
	curl --max-time 0,5  --write-out "%{http_code}\n" --silent --output /dev/null	$ip'/'$id'/'
}



#ao adicionar alguma máquina, adiconar um if com o id
get_load(){
	if [[ $1 -eq 0 ]]; then
		id="pc1"
	elif [[ $1 -eq 1 ]]; then
		id="pc2"
	elif [[ $1 -eq 2 ]]; then
		id="pc3"
	elif [[ $1 -eq 3 ]]; then
		id="pc4"
	elif [[ $1 -eq 4 ]]; then
		id="pc5"
	fi
	status_code=`statusCode $ip $id`
	if [[ $status_code -ne 200 ]]; then
		percent=100
	else
		percent=`curl -s $ip'/'$id'/' | jq '.cpu.percent'`
	fi

echo $percent";"

}

rate=$1 
policySchedule=$2
gapFillChoice=$3 

ip=10.0.1.94:800
while [[ TRUE ]]; do
	for (( i = 0; i < 5; i++ )); do
		vec[$i]=`get_load $i`
	done
	sleep 1
	echo ${vec[@]} >> "get_load/usage/"$policySchedule"_"$gapFillChoice"_"$rate".txt"
done




