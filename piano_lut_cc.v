// CompArch Final Project
// Piano LUT
// Detects switches being pressed on FPGA and enables the notes

module lut(sw, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
input[7:0] sw;

output reg En_C = 'b0;
output reg En_D = 'b0;
output reg En_E = 'b0;
output reg En_F = 'b0;
output reg En_G = 'b0;
output reg En_A = 'b0;
output reg En_B = 'b0;
output reg En_C2 = 'b0;

always@(sw) begin
	En_C2 = sw[7];
	En_B = sw[6];
	En_A = sw[5];
	En_G = sw[4];
	En_F = sw[3];
	En_E = sw[2];
	En_D = sw[1];
	En_C = sw[0];
end
endmodule 

module lut_test;
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


endmodule 