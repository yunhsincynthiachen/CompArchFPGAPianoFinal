vlog -reportprogress 300 -work work inputConditioner_cc.v
vsim -voptargs="+acc" testConditioner

add wave -position insertpoint  \
sim:/testConditioner/clk \
sim:/testConditioner/pin \
sim:/testConditioner/conditioned 
run 2000

wave zoom full