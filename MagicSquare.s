;
; CS1022 Introduction to Computing II 2018/2019
; Magic Square
;

	AREA	RESET, CODE, READONLY
	ENTRY

	; initialize system stack pointer (SP)
	LDR	SP, =0x40010000
                                  ;if the array is a magic square, 0 in each register otherwise 1

	LDR	R0, =arr1         ;load arr1
	LDR	R4, =size1
	LDR	R1, [R4]
	BL isMagic
	MOV R2,R0                 ;R2 should be 0
	
	LDR	R0, =arr2         ;load arr2
	LDR	R4, =size2        
	LDR	R1, [R4]          
	BL isMagic
	MOV R3,R0                ;R3 should be 1 
	
	LDR R0, =arr3            ;load arr3
	LDR R4, =size3
	LDR R1, [R4]
	BL isMagic
	MOV R5,R0                ;R5 should be 0
	
	LDR R0, =arr4            ;load arr4
	LDR R4, =size4           
	LDR R1, [R4]
	BL isMagic
	MOV R6,R0                ;R6 should be 1
	
	LDR R0, =arr5            ;load arr5
	LDR R4, =size5
	LDR R1, [R4]
	BL isMagic
	MOV R7,R0                ;R7 should be 0
	
	LDR R0, =arr6            ;load arr6
	LDR R4, =size6
	LDR R1, [R4]
	BL isMagic
	MOV R8,R0                 ;R8 should be 1

        LDR R0, =arr7            ;load arr7
	LDR R4, =size7
	LDR R1, [R4]
	BL isMagic
	MOV R9,R0               ;R9 should be 0
	
	LDR R0, =arr8            ;load arr8
	LDR R4, =size8 
	LDR R1, [R4]
	BL isMagic
	MOV R10,R0               ;R10 should be 1
	
	LDR R0, =arr9            ;load arr9
	LDR R4, =size9
	LDR R1, [R4]
	BL isMagic
	MOV R11,R0               ;R11 should be 0
	
	LDR R0, =arr10            ;load arr10
	LDR R4, =size10
	LDR R1, [R4]
	BL isMagic              
	MOV R12,R0                ;R12 should be 0
	
	LDR R0, =arr11            ;load arr11
	LDR R4, =size11
	LDR R1, [R4]
	BL isMagic                  ;R0 should be 0
	
	

stop	B	stop


;
; write your subroutine here
;

isMagic
     
	 PUSH {R4-R12, LR}
                                       ;if a square is a magic square, 0 is in R0 otherwise 1.
                                       ;N is the size of array
                                       ;There are 4 lines, which are a horizontal line, a vertical line, and 2 diagonal lines.
                                       ;and they are called A,B,C,D e.g. C[i,j]
        LDR R4,=0                      ;R4 is used for index of array
        LDR R5,=0                      ;R5 is N-i-1
        LDR R6,=0                      ;i
        LDR R7,=0                      ;j
        LDR R8,=0                      ;R8 is R which is the sum of diagonal line, represented as A[i,i]
        LDR R9,=0                      ;R9 is S which is the sum of diagonal line, represented as B[i,N-i-1]
        LDR R10,=0                     ;R10 is T which is the sum of horizontal line, represented as C[i,j]
        LDR R11,=0                     ;R11 is U which is the sum of vertical line, represented as D[j,i]
        LDR R12,=0                     ;R12 is M which is the standard sum.
                                       ;R12 is used for comparing it with other lines' sum.

FOR1                                   ;for(i=0; i<N; i++){   
        CMP R6,R1                      ;if i=N, go to IF3
        BEQ IF3                              
        MOV R4, R1                     ;
        MUL R4, R6, R4                 ;prepare for loading A[i,i]
        ADD R4, R4, R6                 ;
        LDR R4, [R0,R4,LSL #2]         ;load A[i,i]
        CMP R4,#0                      ;if(A[i,i]<=0){
        BLS NOTMAGIC                   ;isMagic=false;} go to NOTMAGIC
        ADD R8,R8,R4                   ;R=R+A[i,i]
        MOV R4, R1                     
        SUB R5, R4, R6                 ;N-i
        SUB R5, R5, #1                 ;it should be N-i-1 to load B[i,N-i-1]
        MUL R4, R6, R4                 ;prepare for loading B[i,N-i-1]
        ADD R4, R4, R5                 ; 
        LDR R4, [R0,R4,LSL#2]          ;load B[i,N-i-1]
        CMP R4,#0                      ;if(B[i,N-i-1]<=0){
        BLS NOTMAGIC                   ;isMagic=false;} go to NOTMAGIC
        ADD R9, R9, R4                 ;S=S+B[i,N-i-1]
        LDR R10,=0                     ;T=0 initialise T
        LDR R11,=0                     ;U=0 initialise U
	    LDR R7, =0                     ;initialise k to use for FOR2 
        
FOR2                                   ;for(j=0; j<N; j++){
        CMP R7,R1                     
        BEQ IF1                        ;if j=N, go to IF1
        MOV R4, R1                     ;
        MUL R4, R6, R4                 ;prepare for loading C[i,j]
        ADD R4, R4, R7                 ;
        LDR R4, [R0,R4,LSL#2]          ;load C[i,j]
        CMP R4,#0                      ;if(C[i,j]<=0){
        BLS NOTMAGIC                   ;isMagic=false;} go to NOTMAGIC
        ADD R10, R10, R4               ;T=T+C[i,j]
        MOV R4, R1                     ; 
        MUL R4, R7, R4                 ;prepare for loading D[j,i]
        ADD R4, R4, R6                 ;
        LDR R4, [R0,R4,LSL#2]          ;load D[j,i]
        CMP R4,#0                      ;if(A[j,i]<=0){
        BLS NOTMAGIC                   ;isMagic=false;} go to NOTMAGIC
        ADD R11, R11, R4               ;U=U+D[j,i]
        ADD R7, R7, #1                 ;j=j+1
        B FOR2                         ;back to FOR2
		                       ;}
IF1      
        CMP R6, #0                    
        BNE IF2                        ;if(i==0)
        MOV R12,R10                    ;M=T
IF2 
        CMP R10, R12                   ;if(M!=T || M!=U)
        BNE NOTMAGIC                   ;isMagic=false 
        CMP R11, R12                   ;
        BNE NOTMAGIC                   ;go to NOTMAGIC to say a square is not a magic square 
        ADD R6, R6, #1                 ;i=i+1
        B FOR1                         ;} go back to FOR1  
IF3
        CMP R8,R12                     ;if(M!=R || M!=S)     
        BNE NOTMAGIC                   ;isMagic=false, go to NOTMAGIC
        CMP R9,R10                     ;else         
        BEQ MAGIC                      ;isMagic=true, go to MAGIC to say a square is a magic square                        
		                                
NOTMAGIC
        MOV R0,#1                      ;isMagic = false, R0=1
        B END                          ;go to END
		
MAGIC
        MOV R0,#0                      ;isMagic = true, R0=0

END
	
	POP {R4-R12, PC}
	BX LR
	

	
size1 DCD 3     ; a 3x3 array
arr1  DCD 8,1,6 ; the array
      DCD 3,5,7 ;to check that the code works if the size of array is odd
      DCD 4,9,2 ;R2 should be 0

size2 DCD 3         ;a 3×3 array
arr2  DCD 3,-2,5    ; the array
      DCD 4,2,0     ;to check that the code works if the sum of the numbers in any horizontal,
      DCD -1,6,1    ;vertical, or main diagonal line is the same number
                    ;but it contains negative number and 0, so result should be false.
                    ;R3 should be 1
	
		
size3 DCD 4         ;a 4×4 array
arr3  DCD 1,2,15,16 ;the array
      DCD 13,14,3,4 ;to check that the code works if the size is even
      DCD 12,7,10,5 ;R5 should be 0
      DCD 8,11,6,9		  

size4 DCD 4         ;a 4×4 array 
arr4  DCD 1,2,3,4   ;the array
      DCD 2,3,4,1   ;to check that the code works if each sum of all row and column is same but that of main diagonal line is different
      DCD 3,4,1,2   ;R6 should be 1
      DCD 4,1,2,3	
		   
size5 DCD 7                     ;a 7×7 array 
arr5  DCD 30,39,48,1,10,19,28   ;the array
      DCD 38,47,7,9,18,27,29    ;to check that the code works if the size is odd
      DCD 46,6,8,17,26,35,37    ;R7 should be 0
      DCD 5,14,16,25,34,36,45
      DCD 13,15,24,33,42,44,4
      DCD 21,23,32,41,43,3,12	
      DCD 22,31,40,49,2,11,20	

size6 DCD 7                     ;a 7×7 array 
arr6  DCD 30,39,48,1,10,19,28   ;the array
      DCD 38,47,7,9,18,27,29    ;to check that the code works if the size is odd and result should be false i.e. R8 is 1
      DCD 46,6,8,17,26,35,37
      DCD 5,14,16,25,34,36,45
      DCD 13,15,24,33,42,44,2
      DCD 21,23,32,41,43,3,12	
      DCD 22,31,40,49,2,11,20	

size7 DCD 10                              ;a 10×10 array
arr7  DCD 68,65,96,93,4,1,32,29,60,57     ; the array
      DCD 66,67,94,95,2,3,30,31,58,59     ;to check that the code works if the size of array is large
      DCD 92,89,20,17,28,25,56,53,64,61   ;R9 should be 0
      DCD 90,91,18,19,26,27,54,55,62,63
      DCD 16,13,24,21,49,52,80,77,88,85
      DCD 14,15,22,23,50,51,78,79,86,87
      DCD 37,40,45,48,76,73,81,84,9,12
      DCD 38,39,46,47,74,75,82,83,10,11
      DCD 41,44,69,72,97,100,5,8,33,36
      DCD 43,42,71,70,99,98,7,6,35,34
		  
size8 DCD 10                              ;a 10×10 array
arr8  DCD 68,65,96,93,4,1,32,29,60,57     ; the array
      DCD 66,67,94,95,2,3,30,31,58,59     ;to check that the code says false if the size of array is large 
      DCD 92,89,20,17,28,25,56,53,64,61   ;R10 should be 1
      DCD 90,91,18,19,26,27,54,55,62,63
      DCD 16,13,24,22,49,52,80,77,88,85
      DCD 14,15,22,23,50,51,78,79,86,87
      DCD 37,40,45,48,76,73,81,84,9,12
      DCD 38,39,46,47,74,75,82,83,10,11
      DCD 41,44,69,72,97,100,5,8,33,36
      DCD 43,42,71,70,99,98,7,6,35,34	

size9 DCD 1 ;a 1×1 array
arr9  DCD 1 ;the array     
	    ;it's not a two-dimentional array but just would like to check if it works when the size of array is 1
            ;R11 should be 0

size10 DCD 6                 ;a 6×6 array
arr10  DCD 32,29,4,1,24,21   ;the array
       DCD 30,31,2,3,22,23   ;R12 should be 0
       DCD 12,9,17,20,28,25
       DCD 10,11,18,19,26,27
       DCD 13,16,36,33,5,8
       DCD 14,15,34,35,6,7
		   
		   
size11 DCD 5              ;a 5×5 array
arr11  DCD 11,24,7,20,3   ;the array
       DCD 4,12,25,8,16   ;R0 should be 0
       DCD 17,5,13,21,9
       DCD 10,18,1,14,22
       DCD 23,6,19,2,15	   
		   
		   

	END
