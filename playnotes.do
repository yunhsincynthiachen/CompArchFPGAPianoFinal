vlog -reportprogress 300 -work work notes.v
vsim -voptargs="+acc" testmusic

add wave -position insertpoint  \
sim:/testmusic/clk \
sim:/testmusic/speaker 
run 1000

wave zoom full