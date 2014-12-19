vlog -reportprogress 300 -work work playsong.v notes.v
vsim -voptargs="+acc" test_playsong

add wave -position insertpoint  \
sim:/test_playsong/clk \
sim:/test_playsong/c \
sim:/test_playsong/d \
sim:/test_playsong/e \
sim:/test_playsong/f \
sim:/test_playsong/g \
sim:/test_playsong/a \
sim:/test_playsong/b \
sim:/test_playsong/c2 
run 90000000

wave zoom full