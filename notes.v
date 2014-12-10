module musicC(clk, speaker, counter);
input clk;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
    if(counter==47773) begin
	counter <= 0;
    end
    else begin
	counter <= counter+1;
    end
assign speaker = counter[15];
endmodule

module musicD(clk, speaker, counter);
input clk;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
    if(counter==42567) begin
	counter <= 0;
    end
    else begin
	counter <= counter+1;
    end
assign speaker = counter[15];
endmodule

module musicE(clk, speaker, counter);
input clk;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
    if(counter==37919) begin
	counter <= 0;
    end
    else begin
	counter <= counter+1;
    end
assign speaker = counter[15];
endmodule

module musicF(clk, speaker, counter);
input clk;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
    if(counter==35791) begin
	counter <= 0;
    end
    else begin
	counter <= counter+1;
    end
assign speaker = counter[15];
endmodule

module musicG(clk, speaker, counter);
input clk;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
    if(counter==63775) begin
	counter <= 0;
    end
    else begin
	counter <= counter+1;
    end
assign speaker = counter[15];
endmodule

module musicA2(clk, speaker, counter);
input clk;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
    if(counter==28409) begin
	counter <= 0;
    end
    else begin
	counter <= counter+1;
    end
assign speaker = counter[15];
endmodule

module musicB(clk, speaker, counter);
input clk;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
    if(counter==50618) begin
	counter <= 0;
    end
    else begin
	counter <= counter+1;
    end
assign speaker = counter[15];
endmodule

module testmusic;
reg clk;
wire speaker;
wire [15:0] counter;

musicG playnote(clk, speaker, counter);

initial clk = 0;
always #20 clk=!clk;

initial begin
$display("%b, %b, %b", clk, speaker, counter);
end 
endmodule
