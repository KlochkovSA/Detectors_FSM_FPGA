`timescale 1ns / 1ns
module testbench();
parameter Tclk = 10;
logic clk;
logic reset;
logic datain;
logic det55,det59,begP,endP;

top DUT(
.clk(clk),
.reset(reset),
.dataIn(datain),
.detect55(det55),
.detect59(det59),
.begP(begP),
.endP(endP)
);

always #(Tclk/2) clk = ~clk;  // ��������� ��������� �������� ���������
initial begin
clk=0;
repeat(2) @ (negedge clk) reset=0;
reset<=1;
datain=0;
#Tclk datain = 1;
//  ? 1 �������
#Tclk datain = 1;
//  ? 2 �������
#Tclk datain = 1;
//  ? 3 �������
#Tclk datain = 1;
//  ? 4 �������
#Tclk assert ((begP === 1)|(DUT.det472.state==="Sbeg"))
      else $error("������� 5 ���� ������������ 4/7-2 �� �������");
//  ? 5 �������
#Tclk begin
      assert ((det59 === 1)|(DUT.det59.state==="Sbeg")) else $error("������� 5, ���� ������������ 5/9 �� �������");
      assert ((det55 === 1)|(DUT.det55.stateMR==="Sbeg")) else $error("������� 5, ���� ������������ 5/5 �� �������");
      end

datain = 0;
#Tclk begin
      assert ((det55 === 0)|(DUT.det55.stateMR==="Sz"))
        else $error("������� � �������� det5/5 �� ������");
      assert ((det59 === 0)|(DUT.det59.state==="Sz"))
        else $error("������� � �������� det5/9 �� ������");
      end
      
#Tclk assert ((endP === 1)|(DUT.det472.state==="SendP"))
        else $error("����� ������������ ������������ 4/7-2 �� ����������");
#(Tclk) assert ((endP === 0)|(DUT.det472.state==="Sz"))
        else $error("������� � �������� det4/7-2 �� ������");
$stop;
end

endmodule