vlog -reportprogress 300 -work work lut_to_notes.v piano_lut_cc.v notes.v
vsim -voptargs="+acc" test_lut_notes

add wave -position insertpoint  \
sim:/test_lut_notes/clk \
sim:/test_lut_notes/sw \
sim:/test_lut_notes/speaker8 \
sim:/test_lut_notes/speaker7 \
sim:/test_lut_notes/speaker6 \
sim:/test_lut_notes/speaker5 \
sim:/test_lut_notes/speaker4 \
sim:/test_lut_notes/speaker3 \
sim:/test_lut_notes/speaker2 \
sim:/test_lut_notes/speaker1 
run 10000000

wave zoom full