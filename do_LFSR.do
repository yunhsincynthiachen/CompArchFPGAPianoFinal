vlog -reportprogress 300 -work work LFSR_ind_modelsim.v
vsim -voptargs="+acc" test_lut_LFSR

add wave -position insertpoint  \
sim:/test_lut_LFSR/clk \
sim:/test_lut_LFSR/sw \
sim:/test_lut_LFSR/LFSR_1 \
sim:/test_lut_LFSR/LFSR_2 \
sim:/test_lut_LFSR/LFSR_3 \
sim:/test_lut_LFSR/LFSR_4 \
sim:/test_lut_LFSR/LFSR_5 \
sim:/test_lut_LFSR/LFSR_6 \
sim:/test_lut_LFSR/LFSR_7 \
sim:/test_lut_LFSR/LFSR_8 
run 10000000

wave zoom full