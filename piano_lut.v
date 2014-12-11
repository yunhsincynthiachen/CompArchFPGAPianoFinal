// CompArch Final Project
// Piano LUT
// Detects switches being pressed on FPGA and enables the notes

module lut(sw, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
input[7:0] sw;
output En_C=0, En_D=0, En_E=0, En_F=0, En_G=0, En_A=0, En_B=0, En_C2=0;

always@(sw) begin
case(sw[7:0])
	8'b000 : En_C = 1;
	8'b001 : En_D = 1;
	8'b010 : En_E = 1;
	8'b011 : En_F = 1;
	8'b100 : En_G = 1;
	8'b101 : En_A = 1;
	8'b110 : En_B = 1;
	8'b111 : En_C2 = 1;
endcase
end
endmodule 