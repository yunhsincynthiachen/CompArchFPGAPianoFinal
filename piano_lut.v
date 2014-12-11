// CompArch Final Project
// Piano LUT
// Detects switches being pressed on FPGA and enables the notes

module lut(sw, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
input[7:0] sw;
output En_C=0, En_D=0, En_E=0, En_F=0, En_G=0, En_A=0, En_B=0, En_C2=0;

always@(sw) begin
	if (sw[0]) begin En_C = 1;
	end
	if (sw[1]) begin En_D = 1;
	end
	if (sw[2]) begin En_E = 1;
	end
	if (sw[3]) begin En_F = 1;
	end
	if (sw[4]) begin En_G = 1;
	end
	if (sw[5]) begin En_A = 1;
	end
	if (sw[6]) begin En_B = 1;
	end
	if (sw[7]) begin En_C2 = 1;
	end
end
endmodule 