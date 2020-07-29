module detectorKNL472(
    input clk,
    input reset,
    input dataIn,
    output logic begP,
    output logic endP
    );
   (* fsm_encoding = "sequential" *)typedef enum logic [4:0]
                             {S00, S01, S02,
                              S10, S11, S12,
                              S20, S21, S22,
                              S30, S31, S32, Sz, Sbeg, SL, Send} statetype;
    statetype state, nextstate;
    always_ff @(posedge clk or negedge reset)
    if (~reset) state <= Sz;
    else       state <= nextstate;
    always_comb
        case (state)
            Sz:  if (dataIn) nextstate = S00;
                else   nextstate = Sz;
            S00: if (dataIn) nextstate = S01;
                else   nextstate = S10;
            S01: if (dataIn) nextstate = S02;
                else   nextstate = S11;
            S02: if (dataIn) nextstate = Sbeg;
                else   nextstate = S12;

            S10: if (dataIn) nextstate = S11;
                else   nextstate = S20;
            S11: if (dataIn) nextstate = S12;
                else   nextstate = S21;
            S12: if (dataIn) nextstate = Sbeg;
                else   nextstate = S22;

            S20: if (dataIn) nextstate = S21;
                else   nextstate = S30;
            S21: if (dataIn) nextstate = S22;
                else   nextstate = S31;
            S22: if (dataIn) nextstate = Sbeg;
                else   nextstate = S32;

            S30: if (dataIn) nextstate = S31;
                else   nextstate = Sz;
            S31: if (dataIn) nextstate = S32;
                else   nextstate = Sz;
            S32: if (dataIn) nextstate = Sbeg;
                else   nextstate = Sz;

            Sbeg: if (dataIn) nextstate = Sbeg;
                    else   nextstate = SL;
            SL: if(dataIn) nextstate = Sbeg;
                    else   nextstate = Send;
            Send: if (dataIn) nextstate = S00;
                else   nextstate = Sz;

            default: nextstate = Sz;
        endcase
        // output logic
        
        assign begP =  (state == Sbeg)|(state == SL);
        assign endP =  (state == Send);
    
endmodule