module DIGITAL_CLOCK(
output reg [7:0] anode,
output reg [6:0] cathode,
input clock, clear
);
// registers
reg [26:0] counterClockCount; // div factor - 1
reg [13:0] refreshRateCount; // div factor - 10,000

reg counterClockBit;
reg refreshRateBit;
reg [3:0] display [0:5]; // six displays that can count upto four bits. 6 X 4 array
reg [3:0] count;
// Assigning values
initial
begin
{counterClockCount, refreshRateCount, counterClockBit, refreshRateBit} = 4'd0;
count = 4'd0;
end

//////// CLOCKS /////////
always@(posedge clock)
begin
if (clear)
begin
counterClockCount = counterClockCount + 1'd1;
begin
if( counterClockCount == 27'd2500000) // for a 10 Mhz clock, div

factor - 5M/2 = 2.5M to produce a 1 sec clock

begin
counterClockCount = 27'd0;
counterClockBit = ~counterClockBit;
end
end
end
else if (!clear)
begin
counterClockCount = 27'd0;
counterClockBit = 1'd0;
end
end

always@(posedge clock)
begin
if (clear)
begin
refreshRateCount = refreshRateCount + 1'd1;
if( refreshRateCount == 14'd5000 )// for a 10Mhz clock, div factor - 10K/2 = 5K

to produce a 1ms clock
begin
refreshRateCount = 14'd0;
refreshRateBit = ~refreshRateBit;
end
end
else if (!clear)
begin
refreshRateCount = 14'd0;
refreshRateBit = 1'd0;
end
end
//////// DIGITAL CLOCK LOGIC ////////
always@(posedge counterClockBit)
begin
if( !clear || (display [5] == 2 && display [4] == 3 && display [3] == 5 && display [2]
== 9 && display[1] == 5 && display [0] == 9))
begin
display [0] = 4'd0;
display [1] = 4'd0;
display [2] = 4'd0;
display [3] = 4'd0;
display [4] = 4'd0;
display [5] = 4'd0;
end
else if( display [5] != 2 && display [4] != 3 && display [3] == 5 && display [2] == 9
&& display[1] == 5 && display [0] == 9)
begin
display[4] = display [4] + 4'd1;
display [3] = 4'd0;
if ( display [4] == 4'd10 )
begin
display [5] = display [5] + 4'd1;
display [4] = 4'd0;
end
end
else if( display [5] != 2 && display [4] != 3 && display [3] != 5 && display [2] != 9
&& display[1] == 5 && display [0] == 9 )
begin
display [2] = display [2] + 4'd1;

display [1] = 4'd0;
if ( display [2] == 4'd10 )
begin
display [3] = display [3] + 1; // it have a overflow warning but ignore

as the condition will not let that happen
display [2] = 4'd0;
end
end
else if( display [5] != 2 && display [4] != 3 && display [3] != 5 && display [2] != 9
&& display[1] != 5)
begin
display [0] = display [0] + 4'd1;
if ( display [0] == 4'd10 )
begin
display [1] = display [1] + 4'd1;
display [0] = 4'd0;
end
end
end
//////// VALUES ////////
reg [7:0] an0; // seconds
reg [7:0] an1;
reg [7:0] an2; // minutes
reg [7:0] an3;
reg [7:0] an4;
reg [7:0] an5; // hours
reg [6:0] cat0; // seconds
reg [6:0] cat1;
reg [6:0] cat2; // minutes
reg [6:0] cat3;
reg [6:0] cat4;
reg [6:0] cat5; // hours
// separations
reg [7:0] sepAn1 = 8'b11111011;
reg [7:0] sepAn2 = 8'b11011111;
reg [6:0] sepCat1 = 7'b1111110;
reg [6:0] sepCat2 = 7'b1111110;
always@(posedge counterClockBit)
begin
an0 = 8'b11111110;
case(display [0])

4'b0000 : cat0 = 7'b0000001;
4'b0001 : cat0 = 7'b1001111;
4'b0010 : cat0 = 7'b0010010;
4'b0011 : cat0 = 7'b0000110;
4'b0100 : cat0 = 7'b1001100;
4'b0101 : cat0 = 7'b0100100;
4'b0110 : cat0 = 7'b0100000;
4'b0111 : cat0 = 7'b0001101;
4'b1000 : cat0 = 7'b0000000;
4'b1001 : cat0 = 7'b0000100;
default : cat0 = 7'd1;
endcase
end
always@(posedge counterClockBit)
begin
an1 = 8'b11111101;
case(display [1])
4'b0000 : cat1 = 7'b0000001;
4'b0001 : cat1 = 7'b1001111;
4'b0010 : cat1 = 7'b0010010;
4'b0011 : cat1 = 7'b0000110;
4'b0100 : cat1 = 7'b1001100;
4'b0101 : cat1 = 7'b0100100;
4'b0110 : cat1 = 7'b0100000;
4'b0111 : cat1 = 7'b0001101;
4'b1000 : cat1 = 7'b0000000;
4'b1001 : cat1 = 7'b0000100;
default : cat1 = 7'd1;
endcase
end
always@(posedge counterClockBit)
begin
an2 = 8'b11110111;
case(display [2])
4'b0000 : cat2 = 7'b0000001;
4'b0001 : cat2 = 7'b1001111;
4'b0010 : cat2 = 7'b0010010;
4'b0011 : cat2 = 7'b0000110;
4'b0100 : cat2 = 7'b1001100;
4'b0101 : cat2 = 7'b0100100;
4'b0110 : cat2 = 7'b0100000;
4'b0111 : cat2 = 7'b0001101;
4'b1000 : cat2 = 7'b0000000;
4'b1001 : cat2 = 7'b0000100;
default : cat2 = 7'd1;
endcase
end
always@(posedge counterClockBit)
begin
an3 = 8'b11101111;
case(display [3])

4'b0000 : cat3 = 7'b0000001;
4'b0001 : cat3 = 7'b1001111;
4'b0010 : cat3 = 7'b0010010;
4'b0011 : cat3 = 7'b0000110;
4'b0100 : cat3 = 7'b1001100;
4'b0101 : cat3 = 7'b0100100;
4'b0110 : cat3 = 7'b0100000;
4'b0111 : cat3 = 7'b0001101;
4'b1000 : cat3 = 7'b0000000;
4'b1001 : cat3 = 7'b0000100;
default : cat3 = 7'd1;
endcase
end
always@(posedge counterClockBit)
begin
an4 = 8'b10111111;
case(display [4])
4'b0000 : cat4 = 7'b0000001;
4'b0001 : cat4 = 7'b1001111;
4'b0010 : cat4 = 7'b0010010;
4'b0011 : cat4 = 7'b0000110;
4'b0100 : cat4 = 7'b1001100;
4'b0101 : cat4 = 7'b0100100;
4'b0110 : cat4 = 7'b0100000;
4'b0111 : cat4 = 7'b0001101;
4'b1000 : cat4 = 7'b0000000;
4'b1001 : cat4 = 7'b0000100;
default : cat4 = 7'd1;
endcase
end
always@(posedge counterClockBit)
begin
an5 = 8'b01111111;
case(display [5])
4'b0000 : cat5 = 7'b0000001;
4'b0001 : cat5 = 7'b1001111;
4'b0010 : cat5 = 7'b0010010;
4'b0011 : cat5 = 7'b0000110;
4'b0100 : cat5 = 7'b1001100;
4'b0101 : cat5 = 7'b0100100;
4'b0110 : cat5 = 7'b0100000;
4'b0111 : cat5 = 7'b0001101;
4'b1000 : cat5 = 7'b0000000;
4'b1001 : cat5 = 7'b0000100;
default : cat5 = 7'd1;
endcase
end

//////// DISPLAY ////////

always@(posedge refreshRateBit)
begin
case(count)
4'd0 : begin

anode = an0;
cathode = cat0;
end
4'd1 : begin

anode = an1;
cathode = cat1;
end
4'd2 : begin

anode = sepAn1;
cathode = sepCat1;
end
4'd3 : begin

anode = an2;
cathode = cat2;
end
4'd4 : begin

anode = an3;
cathode = cat3;
end
4'd5 : begin

anode = sepAn2;
cathode = sepCat2;
end
4'd6 : begin

anode = an4;
cathode = cat4;
end
4'd7 : begin

anode = an5;
cathode = cat5;
end

endcase
count = count + 1;
if ( count == 4'd8 )
count = 4'd0;

end
endmodule