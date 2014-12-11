vlog -reportprogress 300 -work work inputConditioner.v
vsim -voptargs="+acc" testConditioner

add wave -position insertpoint  \
sim:/testConditioner/clk \
sim:/testConditioner/pin \
sim:/testConditioner/conditioned \
sim:/testConditioner/rising \
sim:/testConditioner/falling 
run 2000

wave zoom full