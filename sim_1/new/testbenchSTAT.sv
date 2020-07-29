`timescale 1ns / 1ns


module testbenchSTAT();

logic clk;
logic reset;
logic datain;
logic det55,det59,begP;

real det55Count, det59Count,det472Count;
bit det55enable,det59enable,det472enable;

integer counter;

real P59, P472,P55;

top DUT(
.clk(clk),
.reset(reset),
.dataIn(datain),
.detect55(det55),
.detect59(det59),
.begP(begP)
);

integer seed = 165;
always #20 datain <= $dist_uniform(seed , 0 , 1);

always #10 clk = ~clk;  // Описываем генератор тактовых импульсов
integer h1;
initial begin
h1 = $fopen("AA2.txt");
end
initial begin
counter=0;
det55Count<=0;
det59Count<=0;
det472Count<=0;
clk<=0;
datain<=0;
reset<=0;
end
always begin
det472enable<=1;
det59enable<=1;
det55enable<=1;
counter=counter+1;
reset=0;
#20;
reset=1;
#20;// Позиция 1
#20;// Позиция 2
#20;// Позиция 3
#20;// Позиция 4
if(begP)
    if(det472enable)
    begin : detection472_4
        det472Count<=det472Count+1;
        det472enable<=0;
    end  : detection472_4
#20;// Позиция 5
if(det55)
    if(det55enable)
    begin : detection55_5
        det55Count<=det55Count+1;
        det55enable<=0;
    end  : detection55_5
if(det59)
    if(det59enable)
    begin : detection59_5
        det59Count<=det59Count+1;
        det59enable<=0;
    end  : detection59_5
if(begP)
    if(det472enable)
    begin : detection472_5
        det472Count<=det472Count+1;
        det472enable<=0;
    end  : detection472_5        
#20;// Позиция 6
if(det59)
    if(det59enable)
    begin : detection59_6
        det59Count<=det59Count+1;
        det59enable<=0;
    end  : detection59_6
if(begP)
    if(det472enable)
    begin : detection472_6
        det472Count<=det472Count+1;
        det472enable<=0;
    end  : detection472_6
#20;// Позиция 7
if(det59)
    if(det59enable)
    begin : detection59_7
        det59Count<=det59Count+1;
        det59enable<=0;
    end  : detection59_7
if(begP)
    if(det472enable)
    begin : detection472_7
        det472Count<=det472Count+1;
        det472enable<=0;
    end  : detection472_7   
#20;// Позиция 8
if(det59)
    if(det59enable)
    begin : detection59_8
        det59Count<=det59Count+1;
        det59enable<=0;
    end  : detection59_8
#20;// Позиция 9
if(det59)
    if(det59enable)
    begin : detection59_9
        det59Count<=det59Count+1;
        det59enable<=0;
    end  : detection59_9

P55=det55Count/counter;
P472=det472Count/counter;
P59=det59Count/counter;
$display("Серия испытаний № %D | P55 - %f | P472 - %f | P59 - %f |",counter,P55,P472,P59);


$fdisplay(h1,"%d;%,f;%,f;%,f",counter,P55,P472,P59);
end

endmodule

