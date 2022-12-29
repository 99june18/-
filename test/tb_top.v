`timescale 1ns/1ns
`define DELTA 2

/* the module 'top.v' can be verificated by using this python code

// this python code rotates filter
====================================================
import numpy as np
m=np.array([[        ,       ,       ,       ],
            [        ,       ,       ,       ],
            [        ,       ,       ,       ]
            [        ,       ,       ,       ]])  
filter11=
filter12=
filter13=
filter21=
filter22=
filter23=
filter31=
filter32=
filter33=

f=np.array([[filter33,filter32,filter31],[filter23,filter22,filter21],[filter13,filter12,filter11]])
result=[]

mx,my=np.shape(m)
fx,fy=np.shape(f)

for i in range(mx-fx+1): 
    for j in range(my-fy+1): 
        result.append((m[i:i+fy,j:j+fy]*f).sum())

result=(np.array(result).reshape(2,2)) % 256
print(result)

#reference to https://lsh-story.tistory.com/48 
========================================================
*/

module tb_top;

	reg clk; 
	reg reset;
	reg run;
	reg [7:0]
        a11,a12,a13,a14,
        a21,a22,a23,a24,
        a31,a32,a33,a34,
        a41,a42,a43,a44;
    reg [7:0]
        b11,b12,b13,
        b21,b22,b23,
        b31,b32,b33;

  wire [7:0] display_result;
  wire [2:0] display_current_state;
	
	//clock
	initial
	begin
	    forever
		begin
		    #10 clk = !clk;
		end
	end

    // initial setting
	initial 
	begin
		clk = 0;
        reset = 0;
        run = 0;
        
        a11 =     3       ; a12 =      1       ; a13 =    6       ; a14 =     5     ;
        a21 =      7      ; a22 =     5        ; a23 =      2     ; a24 =     7     ;
        a31 =      7      ; a32 =       10      ; a33 =     8      ; a34 =    9      ;
        a41 =       1     ; a42 =      3       ; a43 =      2     ; a44 =     10     ;

        b11 =      3      ; b12 =       1      ; b13 =      4     ; 
        b21 =      0      ; b22 =      5       ; b23 =      1     ; 
        b31 =        0    ; b32 =       1      ; b33 =      5     ; 
        //result 110 101 110 121
        
        /*
        a11 =  72          ; a12 =     58       ; a13 =    36       ; a14 =     24     ;
        a21 =     254       ; a22 =     210        ; a23 =   159        ; a24 =     73     ;
        a31 =      89      ; a32 =     72        ; a33 =    205       ; a34 =    101      ;
        a41 =     220       ; a42 =     9        ; a43 =     87      ; a44 =     172     ;

        b11 =    201        ; b12 =      170       ; b13 =     24      ; 
        b21 =     59       ; b22 =       109      ; b23 =    187       ; 
        b31 =    80        ; b32 =       141      ; b33 =     210      ; 
        // result 248 3 137 121
        */
        /*
        a11 =  58          ; a12 =     72        ; a13 =    36       ; a14 =     24     ;
        a21 =     254       ; a22 =     210        ; a23 =   159        ; a24 =     73     ;
        a31 =      89      ; a32 =     72        ; a33 =    205       ; a34 =    101      ;
        a41 =     220       ; a42 =     9        ; a43 =     87      ; a44 =     172     ;

        b11 =    201        ; b12 =      170       ; b13 =     24      ; 
        b21 =     59       ; b22 =       109      ; b23 =    187       ; 
        b31 =    80        ; b32 =       141      ; b33 =     210      ; 

        // result 50 127 137 121 
       */
        


        /*
        a11 =    1        ; a12 =       2      ; a13 =   3       ; a14 =   0       ;
        a21 =      0      ; a22 =       1      ; a23 =      2     ; a24 =    3      ;
        a31 =      3      ; a32 =    0         ; a33 =      1     ; a34 =       2   ;
        a41 =     2       ; a42 =       3      ; a43 =     0      ; a44 =      1    ;

        b11 =     2       ; b12 =       0      ; b13 =    1       ; 
        b21 =      0      ; b22 =       1      ; b23 =      2     ; 
        b31 =      1      ; b32 =     0        ; b33 =    2       ; 

        // result 11 12 10 11
        */


        /*
        a11 =            ; a12 =             ; a13 =           ; a14 =          ;
        a21 =            ; a22 =             ; a23 =           ; a24 =          ;
        a31 =            ; a32 =             ; a33 =           ; a34 =          ;
        a41 =            ; a42 =             ; a43 =           ; a44 =          ;

        b11 =            ; b12 =             ; b13 =           ; 
        b21 =            ; b22 =             ; b23 =           ; 
        b31 =            ; b32 =             ; b33 =           ; 
        // result
        */

	end

    integer i;

    initial 
	begin
		@(posedge clk); 
        #(`DELTA) // propagation delay
        reset = 1; // external siganl (external means top input)
        
        @(posedge clk); 
        #(`DELTA) 
        reset = 0;

        @(posedge clk); 
        #(`DELTA) 
        run = 1;

        @(posedge clk); 
        #(`DELTA) 
        //run = 0;

        @(posedge clk); 
        for (i = 0; i < 112; i = i+1) begin
        // 112cycle
        @(posedge clk);
        end

        $display("single_c11 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("single_c12 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("single_c21 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("single_c22 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic3_c11 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic3_c12 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic3_c21 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic3_c22 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic2_c11 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic2_c12 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic2_c21 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic2_c22 : %d", display_result);
        $display("current state : %d", display_current_state);
        
	end

top u_top(
    .clk  ( clk  ),
    .reset  ( reset  ),
    .run ( run ),
    .a11  ( a11  ),
    .a12  ( a12  ),
    .a13  ( a13  ),
    .a14  ( a14  ),
    .a21  ( a21  ),
    .a22  ( a22  ),
    .a23  ( a23  ),
    .a24  ( a24  ),
    .a31  ( a31  ),
    .a32  ( a32  ),
    .a33  ( a33  ),
    .a34  ( a34  ),
    .a41  ( a41  ),
    .a42  ( a42  ),
    .a43  ( a43  ),
    .a44  ( a44  ),
    .b11  ( b11  ),
    .b12  ( b12  ),
    .b13  ( b13  ),
    .b21  ( b21  ),
    .b22  ( b22  ),
    .b23  ( b23  ),
    .b31  ( b31  ),
    .b32  ( b32  ),
    .b33  ( b33  ),
    .display_result ( display_result ),
    .display_current_state ( display_current_state )
);

endmodule