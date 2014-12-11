// CompArch Final Project
// Piano LUT
// Detects switches being pressed on FPGA and enables the notes

module lut(sw, A, B, C, D, E, F, G, A2);
input[7:0] sw;
output A=0, B=0, C=0, D=0, E=0, F=0, G=0, A2=0;

always@(sw) begin
case(sw[7:0])
	8'b00000001 : A = 1;
	8'b00000010 : B = 1;
	8'b00000100 : C = 1;
	8'b00001000 : D = 1;
	8'b00010000 : E = 1;
	8'b00100000 : F = 1;
	8'b01000000 : G = 1;	8'b10000000 : A2 = 1;
endcase
end
endmodule 