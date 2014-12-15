vlog -reportprogress 300 -work work LFSR.v LFSRlut.v LFSR_to_LUT.v inputConditioner_cc.v
vsim -voptargs="+acc" test_lut_LFSR

add wave -position insertpoint  \
sim:/test_lut_LFSR/clk \
sim:/test_lut_LFSR/LFSR_1 \
sim:/test_lut_LFSR/LFSR_2 \
sim:/test_lut_LFSR/LFSR_3 \
sim:/test_lut_LFSR/conditioned1 \
sim:/test_lut_LFSR/conditioned2 \
sim:/test_lut_LFSR/conditioned3
run 2000

wave zoom full