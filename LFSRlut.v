// CompArch Final Project
// Piano LUT
// Detects switches being pressed on FPGA and enables the notes

module LFSR_lut(sw_0,sw_1,sw_2,sw_3,sw_4,sw_5,sw_6,sw_7,LFSR1_EN,LFSR2_EN,LFSR3_EN,LFSR4_EN,LFSR5_EN,LFSR6_EN,LFSR7_EN,LFSR8_EN);
input sw_0, sw_1, sw_2, sw_3, sw_3, sw_4, sw_5, sw_6, sw_7;

output reg LFSR1_EN = 'b0;
output reg LFSR2_EN = 'b0;
output reg LFSR3_EN = 'b0;
output reg LFSR4_EN = 'b0;
output reg LFSR5_EN = 'b0;
output reg LFSR6_EN = 'b0;
output reg LFSR7_EN = 'b0;
output reg LFSR8_EN = 'b0;

always@(sw_0, sw_1, sw_2, sw_3, sw_3, sw_4, sw_5, sw_6, sw_7) begin
	LFSR8_EN = sw_7;
	LFSR7_EN = sw_6;
	LFSR6_EN = sw_5;
	LFSR5_EN = sw_4;
	LFSR4_EN = sw_3;
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