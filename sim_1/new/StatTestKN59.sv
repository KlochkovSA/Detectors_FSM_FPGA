`timescale 1ns / 1ps
module StatTestKN59();

logic clk;
logic reset;
logic dataIn;
logic det59;

real det59Count;
bit det59enable;

integer counter;

real P59;

detectorKN59 DUT(.*);

integer seed = 165;
always #20 dataIn <= $dist_uniform(seed , 0 , 1);

always #10 clk = ~clk;  // Описываем генератор тактовых импульсов

initial begin
counter=0;
det59Count<=0;
clk<=0;
dataIn<=0;
reset<=0;
end
always begin
det59enable<=1;
counter=counter+1;
reset=0;
#20;
reset=1;
#20;// Позиция 1
#20;// Позиция 2
#20;// Позиция 3
#20;// Позиция 4
#20;// Позиция 5
if(det59)
    if(det59enable)
    begin : detection59_5
        det59Count<=det59Count+1;
        det59enable<=0;
    end  : detection59_5
#20;// Позиция 6
if(det59)
    if(det59enable)
    begin : detection59_6
        det59Count<=det59Count+1;
        det59enable<=0;
    end  : detection59_6
#20;// Позиция 7
if(det59)
    if(det59enable)
    begin : detection59_7
        det59Count<=det59Count+1;
        det59enable<=0;
    end  : detection59_7
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


P59=det59Count/counter;
$display("Событие - %D | P59 - %f |",counter,P59);
end
endmodule
