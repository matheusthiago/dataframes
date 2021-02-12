#script para a criação de tempos de requisições dada pela distribuição exponencial
cont=1
for(i in seq(1,21,5)){
	 set.seed(1)
	 #define o tamanho e qual é a taxa
	 a=(rexp(200, rate=100/(i)))
	 a=round(a, digits=3)
	 print("mean:")
	 print(round(mean(a),2))
	# a
	write.table(a, paste("exp",cont,".txt", sep=""), col.names = FALSE, row.names = FALSE)
	cont=cont+1
}



