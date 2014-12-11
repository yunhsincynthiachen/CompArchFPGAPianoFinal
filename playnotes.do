vlog -reportprogress 300 -work work notes.v
vsim -voptargs="+acc" testmusic

add wave -position insertpoint  \
sim:/testmusic/clk \
sim:/testmusic/speaker \
sim:/testmusic/counter
run 50000000

wave zoom full