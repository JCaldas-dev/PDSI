No ficheiro em /sim/simargs.txt pode editar os dois valores.
Primeiro argumento muda a quantidade de bits utilizados.
Valores acima de 62 bits nao funcionam corretamente.
Segundo argumento muda o valor pretendido fazer a raiz quadrada.

iverilog -c files.txt -o sim
vpp sim

/src/verilog/rtl/dff16.v nao e utilzado.