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
		free=-123456789
	else
		percent=`curl -s $ip'/'$id'/' | jq '.cpu.percent'`
		free=`echo $var | awk '{print (100-(int('$percent')))*0.01}'`
	fi

echo $free

#	curl -s 'http://10.0.1.98:800/system/percent' | jq '.cpu.name,.cpu.percent'
}

run (){
	vec=()
	while [[ TRUE ]]; do

		for (( i = 0; i < 5; i++ )); do
			vec[$i]=`get_load $i`
		done

		echo ${vec[@]}
		#alterar o pc2 para vec[2] nos experimentos 
		machine=`curl -s 'http://localhost:5000/abc?pc1='${vec[0]}'&pc2='${vec[1]}'&pc3='${vec[2]}'&pc4='${vec[3]}'&pc5='${vec[4]}'&algorithm='$algorithm | jq '.betterMachine'`
		#retirando aspas
		echo $machine | sed 's/\"//g' 
		sleep 1
	done
}

get_machine(){
	vec=()
	for (( i = 0; i <=4; i++ )); do
		vec[$i]=`get_load $i`
	done
	#echo ${vec[@]}
	#alterar o pc2 para vec[2] nos experimentos 
	machine=`curl -s 'http://localhost:5000/abc?pc1='${vec[0]}'&pc2='${vec[1]}'&pc3='${vec[2]}'&pc4='${vec[3]}'&pc5='${vec[4]}'&algorithm='$algorithm | jq '.betterMachine'`
	#retirando aspas
	echo $machine | sed 's/\"//g' 
}
ip=10.0.1.94:800
algorithm=$1
#run $ip $algorithm
get_machine $ip $algorithm