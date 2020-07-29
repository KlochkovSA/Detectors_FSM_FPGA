`timescale 1ns / 1ps

module top(
    input clk,
    (* dont_touch = "yes" *)input wire reset,
    input dataIn,
    output detect55,
    output detect59,
    output begP,
    output endP
    );
    (* fsm_encoding = "sequential" *)
    (* keep_hierarchy = "yes" *) detectorKK55 det55(clk,reset,dataIn,detect55);
    (* keep_hierarchy = "yes" *) detectorKN59 det59(clk,reset,dataIn,detect59);
    (* keep_hierarchy = "yes" *) detectorKNL472 det472(clk,reset,dataIn,begP,endP);
endmodule