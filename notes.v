module music(clk, speaker, counter);
input clk;
output speaker;

output reg [15:0] counter = 15'b0;

always @(posedge clk)
    if(counter==56817) begin
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

music playnoteA(clk, speaker, counter);

initial clk = 0;
always #10 clk=!clk;

initial begin
#10
#10
$display("%b, %b, %b", clk, speaker, counter);
end 
endmodule
