module detectorKK55(
    input clk,
    input reset,
    input dataIn,
    output logic det55
    );
    (* fsm_encoding = "sequential" *)typedef enum logic [2:0] {Sz, S00, S01, S02, S03, Sbeg} statetype;
    statetype stateMR, nextstate;
    //***Обновление регистра состояния
    always_ff @(posedge clk or negedge reset)
    if (~reset) stateMR <= Sz;
    else       stateMR <= nextstate;
    //***
    // ---Логика описывающая вычисление следующего состояния
    always_comb
        case (stateMR)
            Sz: if (dataIn) nextstate = S00;
                else   nextstate = Sz;
            S00: if (dataIn) nextstate = S01;
                else   nextstate = Sz;
            S01: if (dataIn) nextstate = S02;
                else   nextstate = Sz;
            S02: if (dataIn) nextstate = S03;
                else   nextstate = Sz;
            S03: if (dataIn) nextstate = Sbeg;
                else   nextstate = Sz;
            Sbeg: if (dataIn) nextstate = Sbeg;
                else   nextstate = Sz;
          
            default: nextstate = Sz;
        endcase
        // ---
        // Выходная логика
        assign det55 = (stateMR == Sbeg);
endmodule