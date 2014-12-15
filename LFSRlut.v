// CompArch Final Project
// Piano LUT
// Detects switches being pressed on FPGA and enables the notes

module LFSR_lut(sw_0, sw_1, sw_2, LFSR1_EN, LFSR2_EN, LFSR3_EN);
input sw_0, sw_1, sw_2;

output reg LFSR1_EN = 'b0;
output reg LFSR2_EN = 'b0;
output reg LFSR3_EN = 'b0;

always@(sw_0,sw_1,sw_2) begin
	LFSR3_EN = sw_2;
	LFSR2_EN = sw_1;
	LFSR1_EN = sw_0;
end
endmodule 

module test_LFSRlut;
reg sw_0,sw_1,sw_2;
wire LFSR1_EN, LFSR2_EN, LFSR3_EN;


LFSR_lut LUT(sw_0,sw_1,sw_2,LFSR1_EN,LFSR2_EN,LFSR3_EN);
initial begin
sw_0 = 0;
sw_1 = 1;
sw_2 = 0;
#1000
$display("%b %b %b", LFSR1_EN,LFSR2_EN,LFSR3_EN);
end
endmodule 