vlog -reportprogress 300 -work work adder.v

#vlib work
vsim -voptargs="+acc"  testFullAdder

add wave -position insertpoint  \
sim:/testFullAdder/a \
sim:/testFullAdder/b \
sim:/testFullAdder/carryin \
sim:/testFullAdder/carryout \
sim:/testFullAdder/sum \
sim:/testFullAdder/overflow\
run -all
