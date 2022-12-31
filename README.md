팀 프로젝트 용

state 3 : pe1 : a11*b33

state 4 : pe1 : a12*b33 
          pe2 : a11*b32

          pe4 : a11*b33 + a21*b23

state 5 : pe1 : a13*b33 
          pe2 : a12*b32
          pe3 : a11*b31

          pe4 : a12*b33 + a22*b23
          pe5 : a11*b32 + a21*b22

          pe7 : a11*b33 + a21*b23 + a31*b13 >> acc1

state 6 : pe1 : a14*b33 
          pe2 : a13*b32
          pe3 : a12*b31

          pe4 : a13*b33 + a23*b23
          pe5 : a12*b32 + a22*b22
          pe6 : a11*b31 + a21*b21

          pe7 : a12*b33 + a22*b23 + a32*b13  >> acc2 
          pe8 : a11*b32 + a21*b22 + a31*b12

state 7 : pe1 : a21*b33 
          pe2 : a14*b32
          pe3 : a13*b31

          pe4 : a14*b33 + a24*b23
          pe5 : a13*b32 + a23*b22
          pe6 : a12*b31 + a22*b21

          pe7 : a13*b33 + a23*b23 + a33*b13  
          pe8 : a12*b32 + a22*b22 + a32*b12  >> acc1
          pe9 : a11*b31 + a21*b21 + a31*b11

state 8 : pe1 : a22*b33 
          pe2 : a21*b32
          pe3 : a14*b31

          pe4 : a21*b33 + a31*b23
          pe5 : a14*b32 + a24*b22
          pe6 : a13*b31 + a23*b21

          pe7 : a14*b33 + a24*b23 + a34*b13 
          pe8 : a13*b32 + a23*b22 + a33*b12  >> acc2
          pe9 : a12*b31 + a22*b21 + a32*b11

state 9 : pe1 : a23*b33 
          pe2 : a22*b32
          pe3 : a21*b31

          pe4 : a22*b33 + a32*b23
          pe5 : a21*b32 + a31*b22
          pe6 : a14*b31 + a24*b21

          pe7 : a21*b33 + a31*b23 + a41*b13  >> acc3
          pe8 : a14*b32 + a24*b22 + a34*b12  
          pe9 : a13*b31 + a23*b21 + a33*b11  >> acc1

state 10 : pe1 : a24*b33 
          pe2 : a23*b32
          pe3 : a22*b31

          pe4 : a23*b33 + a33*b23
          pe5 : a22*b32 + a32*b22
          pe6 : a21*b31 + a31*b21

          pe7 : a22*b33 + a32*b23 + a42*b13  >> acc4
          pe8 : a21*b32 + a31*b22 + a41*b12
          pe9 : a14*b31 + a24*b21 + a34*b11  >> acc2

state 11 : pe1 :  
          pe2 : a24*b32
          pe3 : a23*b31

          pe4 : a24*b33 + a34*b23
          pe5 : a23*b32 + a33*b22
          pe6 : a22*b31 + a32*b21

          pe7 : a23*b33 + a33*b23 + a43*b13  
          pe8 : a22*b32 + a32*b22 + a42*b12  >> acc3
          pe9 : a21*b31 + a31*b21 + a41*b11  

state 12 : pe1 :  
          pe2 : 
          pe3 : a24*b31

          pe4 : 
          pe5 : a24*b32 + a34*b22
          pe6 : a23*b31 + a33*b21

          pe7 : a24*b33 + a34*b23 + a44*b13
          pe8 : a23*b32 + a33*b22 + a43*b12  >> acc4
          pe9 : a22*b31 + a32*b21 + a42*b11

state 13 : pe1 :  
          pe2 : 
          pe3 : 

          pe4 : 
          pe5 : 
          pe6 : a24*b31 + a34*b21

          pe7 : 
          pe8 : a24*b32 + a34*b22 + a44*b12  
          pe9 : a23*b31 + a33*b21 + a43*b11  >> acc3

state 14 : pe1 :  
          pe2 : 
          pe3 : 

          pe4 : 
          pe5 : 
          pe6 : 

          pe7 : 
          pe8 : 
          pe9 : a24*b31 + a34*b21 + a44*b11  >> acc4

state 15 : done : 1
