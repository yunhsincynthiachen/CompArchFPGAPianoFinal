// CompArch Final Project
// Piano LUT
// Detects switches being pressed on FPGA and enables the notes

module lut(sw_0, sw_1, sw_2, sw_3, sw_4, sw_5, sw_6, sw_7, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
input sw_0, sw_1, sw_2, sw_3, sw_4, sw_5, sw_6, sw_7;

output reg En_C = 'b0;
output reg En_D = 'b0;
output reg En_E = 'b0;
output reg En_F = 'b0;
output reg En_G = 'b0;
output reg En_A = 'b0;
output reg En_B = 'b0;
output reg En_C2 = 'b0;

always@(sw_0,sw_1,sw_2,sw_3,sw_4,sw_5,sw_6,sw_7) begin
	En_C2 = sw_7;
	En_B = sw_6;
	En_A = sw_5;
	En_G = sw_4;
	En_F = sw_3;
	En_E = sw_2;
	En_D = sw_1;
	En_C = sw_0;
end
endmodule 

/*module lut_test;
reg[7:0] sw;
wire En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2;


lut LUT(sw, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
initial begin
sw = 8'b00010000;
#1000
$display("%b %b %b %b %b %b %b %b", En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
sw = 8'b11000000;
#1000
$display("%b %b %b %b %b %b %b %b", En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
sw = 8'b11111111;
#1000
$display("%b %b %b %b %b %b %b %b", En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
end


endmodule */
