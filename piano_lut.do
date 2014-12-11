vlog -reportprogress 300 -work work piano_lut_cc.v
vsim -voptargs="+acc" lut_test
run 5000000