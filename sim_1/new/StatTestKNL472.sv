`timescale 1ns / 1ps
module StatTestKNL472();

logic clk;
logic reset;
logic dataIn;
logic begP;
logic endP;

real det472Count;
bit det472enable;

integer counter;

real P472;

detectorKNL472 DUT(.*);

integer seed = 165;
always #20 dataIn <= $dist_uniform(seed , 0 , 1);

always #10 clk = ~clk;  // Описываем генератор тактовых импульсов

initial begin
counter=0;
det472Count<=0;
clk<=0;
dataIn<=0;
reset<=0;
end
always begin
det472enable<=1;
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
if(begP)
    if(det472enable)
    begin : detection472_5
        det472Count<=det472Count+1;
        det472enable<=0;
    end  : detection472_5        
#20;// Позиция 6
if(begP)
    if(det472enable)
    begin : detection472_6
        det472Count<=det472Count+1;
        det472enable<=0;
    end  : detection472_6
#20;// Позиция 7
if(begP)
    if(det472enable)
    begin : detection472_7
        det472Count<=det472Count+1;
        det472enable<=0;
    end  : detection472_7
    
P472=det472Count/counter;
$display("Испытание - %D | Вероятность обнаружения - %f |",counter,P472);
end
endmodule