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

always #(Tclk/2) clk = ~clk;  // Описываем генератор тактовых импульсов
initial begin
clk=0;
repeat(2) @ (negedge clk) reset=0;
reset<=1;
datain=0;
#Tclk datain = 1;
//  ? 1 позиция
#Tclk datain = 1;
//  ? 2 позиция
#Tclk datain = 1;
//  ? 3 позиция
#Tclk datain = 1;
//  ? 4 позиция
#Tclk assert ((begP === 1)|(DUT.det472.state==="Sbeg"))
      else $error("Позиция 5 тест обнаружителя 4/7-2 не пройден");
//  ? 5 позиция
#Tclk begin
      assert ((det59 === 1)|(DUT.det59.state==="Sbeg")) else $error("Позиция 5, тест обнаружителя 5/9 не пройден");
      assert ((det55 === 1)|(DUT.det55.stateMR==="Sbeg")) else $error("Позиция 5, тест обнаружителя 5/5 не пройден");
      end

datain = 0;
#Tclk begin
      assert ((det55 === 0)|(DUT.det55.stateMR==="Sz"))
        else $error("Возврат в исходное det5/5 не сделан");
      assert ((det59 === 0)|(DUT.det59.state==="Sz"))
        else $error("Возврат в исходное det5/9 не сделан");
      end
      
#Tclk assert ((endP === 1)|(DUT.det472.state==="SendP"))
        else $error("Сброс обнаружителя обнаружителя 4/7-2 не произведен");
#(Tclk) assert ((endP === 0)|(DUT.det472.state==="Sz"))
        else $error("Возврат в исходное det4/7-2 не сделан");
$stop;
end

endmodule