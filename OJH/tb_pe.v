    `timescale 1ns/1ns

    module tb_pe;

        reg CLK; 
        reg RST;

        reg [7:0] PE_IN;
        reg [7:0] PE_FILTER;
        reg MODE_I;
        
        wire [7:0] PE_OUT;
        wire SINGLE_COUNT_9;
    

        integer count1, count2, count3, count4;

        pe u_pe(.clk(CLK), .rst(RST), .mode_i(MODE_I), .pe_in(PE_IN), .pe_filter(PE_FILTER), .pe_out(PE_OUT), .single_count_9(SINGLE_COUNT_9));

        initial
        begin
            forever
            begin
                #10 CLK = !CLK;
            end
        end

        // initial setting
        initial 
        begin
            CLK = 0;
            RST = 1;
            MODE_I = 0;
        end

        initial 
        begin
            #20 RST = 0;


            for (count1 = 0; count1 < 9; count1 = count1 + 1) begin
                #20 PE_IN = 10;
                    PE_FILTER = 10;
                #10 MODE_I = 1;
            end
            for (count2 = 0; count2 < 9; count2 = count2 + 1) begin
                #20 PE_IN = 5;
                    PE_FILTER = 5;
            end
            for (count3 = 0; count3 < 9; count3 = count3 + 1) begin
                #20 PE_IN = 2;
                    PE_FILTER = 2;
            end
            for (count4 = 0; count4 < 9; count4 = count4 + 1) begin
                #20 PE_IN = 20;
                    PE_FILTER = 20;
            end

            #20 RST = 1;

        end


    endmodule 