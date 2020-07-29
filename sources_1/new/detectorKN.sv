module detectorKN59(
    input clk,
    input reset,
    input dataIn,
    output logic det59
    );

    (* fsm_encoding = "sequential" *)typedef enum logic [4:0] {Sz,
                              S00, S01, S02, S03,
                              S10, S11, S12, S13,
                              S20, S21, S22, S23,
                              S30, S31, S32, S33,
                              S40, S41, S42, S43, Sbeg} statetype;
    statetype state, nextstate;
    always_ff @(posedge clk or negedge reset)
    if (~reset) state <= Sz;
    else       state <= nextstate;
    always_comb
        case (state)
            Sz: if (dataIn) nextstate = S00;
                else   nextstate = Sz;
                
            S00: if (dataIn) nextstate = S01;
                else   nextstate = S10;
            S01: if (dataIn) nextstate = S02;
                else   nextstate = S11;
            S02: if (dataIn) nextstate = S03;
                else   nextstate = S12;
            S03: if (dataIn) nextstate = Sbeg;
                else   nextstate = S13;

            S10: if (dataIn) nextstate = S11;
                else   nextstate = S20;
            S11: if (dataIn) nextstate = S12;
                else   nextstate = S21;
            S12: if (dataIn) nextstate = S13;
                else   nextstate = S22;
            S13: if (dataIn) nextstate = Sbeg;
                else   nextstate = S23;

            S20: if (dataIn) nextstate = S21;
                else   nextstate = S30;
            S21: if (dataIn) nextstate = S22;
                else   nextstate = S31;
            S22: if (dataIn) nextstate = S23;
                else   nextstate = S32;
            S23: if (dataIn) nextstate = Sbeg;
                else   nextstate = S33;

            S30: if (dataIn) nextstate = S31;
                else   nextstate = S40;
            S31: if (dataIn) nextstate = S32;
                else   nextstate = S41;
            S32: if (dataIn) nextstate = S33;
                else   nextstate = S42;
            S33: if (dataIn) nextstate = Sbeg;
                else   nextstate = S43;
                
            S40: if (dataIn) nextstate = S41;
                else   nextstate = Sz;
            S41: if (dataIn) nextstate = S42;
                else   nextstate = Sz;
            S42: if (dataIn) nextstate = S43;
                else   nextstate = Sz;
            S43: if (dataIn) nextstate = Sbeg;
                else   nextstate = Sz;
            
            Sbeg: if (dataIn) nextstate = Sbeg;
                else   nextstate = Sz;

            default: nextstate=Sz;
        endcase
        
        assign det59 = (state == Sbeg);
endmodule
