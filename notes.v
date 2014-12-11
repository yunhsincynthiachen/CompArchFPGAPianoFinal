module musicC(clk, speaker, counter, EN_C);
//261.6 HZ
input clk;
input EN_C;
output speaker;

output reg [16:0] counter = 17'b0;

always @(posedge clk)
	if(EN_C) begin
		if(counter==95566) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[16];
endmodule

module musicD(clk, speaker, counter, EN_D);
//293.7 HZ
input clk;
input EN_D;
output speaker;

output reg [16:0] counter = 17'b0;

always @(posedge clk)
	if(EN_D) begin
		if(counter==85121) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[16];
endmodule

module musicE(clk, speaker, counter, EN_E);
//329.6 HZ
input clk;
input EN_E;
output speaker;

output reg [16:0] counter = 17'b0;

always @(posedge clk)
	if(EN_E) begin
		if(counter==75850) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[16];
endmodule

module musicF(clk, speaker, counter, EN_F);
//349.2 HZ
input clk;
input EN_F;
output speaker;

output reg [16:0] counter = 17'b0;

always @(posedge clk)
	if(EN_F) begin
		if(counter==71592) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[16];
endmodule
module musicG(clk, speaker, counter, EN_F);
//392 HZ
input clk;
input EN_F;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
	if(EN_F) begin
    		if(counter==63776) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[15];
endmodule

module musicA(clk, speaker, counter, EN_A);
//440 HZ
input clk;
input EN_A;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
	if(EN_A) begin
		if(counter==56818) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[15];
endmodule
module musicB(clk, speaker, counter, EN_B);
//493.9 HZ
input clk;
input EN_B;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
	if(EN_B) begin
		if(counter==50618) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[15];
endmodule

module musicC2(clk, speaker, counter, EN_C2);
//523.3 HZ
input clk;
input EN_C2;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
	if(EN_C2) begin
		if(counter==47774) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[15];
endmodule

module testmusic;
reg clk;
reg EN_C;
wire speaker;
wire [15:0] counter;

musicC playnote(clk, speaker, counter, EN_C);

initial clk = 0;
always #20 clk=!clk;

initial begin
EN_C = 0;
$display("%b, %b, %b", clk, speaker, counter, EN_C);
end 
endmodule
