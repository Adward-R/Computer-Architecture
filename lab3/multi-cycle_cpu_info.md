# Multi-cycle CPU Info

====

##Memory
- IP Core Module- Dual Port Block Memory- Port A: Read Only, Width: 32, Depth: 512- Port B: Read and Write, Read After Write- Rising Edge Triggered
##Observation Info
- ###Input	- East Button: Step execute	- South Button: Reset
	- Four Switches: Select Register to Show Its Content- ###Output	- 0-7 Character of First Line: Instruction Code (when first load an instruction)	- 9-10 of First Line : Read Address	- 12-13 of First Line : Write Address	- 0/2/4 of Second Line : state/type/code	- 6-7 of Second Line : PC	- 8-15 of Second Line: Selected Register's Content (kinda ugly...)##Program for Verification
```<0>  lw r1, $20(r0); 0x8c01_0014 State:0,1,3,5,9 Type:3 Code:1  (LD) <1>  lw r2, $21(r0); 0x8c02_0015 State:0,1,3,5,9 Type:3 Code:1  (LD)<2>  add r3, r1, r2; 0x0022_1820 State:0,1,2,8 Type:1 Code:3  (AD)<3>  sub r4, r1, r2; 0x0022_2022 State:0,1,2,8 Type:1 Code:4  (SU)<4>  and r5, r3, r4; 0x0064_2824 State:0,1,2,8 Type:1 Code:5  (AN)<5>  nor r6, r4, r5; 0x0085_3027 State:0,1,2,8 Type:1 Code: 6  (NO)<6>  sw r6, $22(r0); 0x ac06_0016 State:0,1,4,7 Type:3 Code: 2  (ST)<7>  J 0; 0x0800_0000 State:0,1 Type:2 Code:7  (JP)```
and:
```DataMem(20) = 0xbeef_0000 ; DataMem(21) =0x0000_beef ;```