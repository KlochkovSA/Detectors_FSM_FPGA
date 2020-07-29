`timescale 1ns / 1ps
module StatTestKK55();

logic clk;
logic reset;
logic dataIn;
logic det55;

real det55Count;

integer counter;

real P55;

detectorKK55 DUT(.*);

integer seed = 165;
always #20 dataIn <= $dist_uniform(seed , 0 , 1);

always #10 clk = ~clk;  // ��������� ��������� �������� ���������

initial begin
counter=0;
det55Count<=0;
clk<=0;
dataIn<=0;
reset<=0;
end
always begin
counter=counter+1;
reset=0;
#20;
reset=1;
#20;// ������� 1
#20;// ������� 2
#20;// ������� 3
#20;// ������� 4
#20;// ������� 5
if(det55)
    begin : detection55_5
        det55Count<=det55Count+1;
    end  : detection55_5
    
P55=det55Count/counter;

$display("��������� - %D | ����������� ����������� - %f |",counter,P55);
end
endmodule