module lut_to_notes(clk, sw, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
input clk;
input[7:0] sw;
output speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8;

wire[16:0] counter1;
wire[15:0] counter2;
wire En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2;

lut LUT(sw, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);

musicC cnote(clk, speaker1, counter1, En_C);
musicD dnote(clk, speaker2, counter1, En_D);
musicE enote(clk, speaker3, counter1, En_E);
musicF fnote(clk, speaker4, counter1, En_F);
musicG gnote(clk, speaker5, counter2, En_G);
musicA anote(clk, speaker6, counter2, En_A);
musicB bnote(clk, speaker7, counter2, En_B);
musicC2 c2note(clk, speaker8, counter2, En_C2);

endmodule 

module test_lut_notes;
reg clk;
reg[7:0] sw;
wire speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8;

lut_to_notes allnotes(clk, sw, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);

initial clk = 0;
always #20 clk=!clk;

initial begin
sw = 8'b10010001;
#4000000
$display("%b %b %b", clk, sw, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
sw = 8'b00010010;
#4000000
$display("%b %b %b", clk, sw, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
end
endmodule 