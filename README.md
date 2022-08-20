# Hardware-Implementation-of-AES
High Speed and Low Power Implementation in Verilog

## advanced encryption system algorithm
A 5 minutes video for AES Rijndael Cipher algorithm explained as a Flash animation here
https://www.youtube.com/watch?v=gP4PqVGudtg&t=23s

## simulation results 
  first we used the input data and key in the video and this is the RTL output which is the same as the output in the video :
  
  ![image](https://user-images.githubusercontent.com/103184935/185762896-4f97a917-f77c-4a32-8933-dbcf82770c16.png)            ![image](https://user-images.githubusercontent.com/103184935/185762989-db2751ac-cb7d-45c1-915a-23dee7dcf411.png)

## virtex-7 FPGA implementation results
  ### 1- clock and Timing 
       clock_frequency = __200MHZ(4ns)__ 
       the design is clean from setup and hold time violation 
      **SETUP :** 
      ![image](https://user-images.githubusercontent.com/103184935/185763525-33dd105d-d774-46b7-95bf-0a04513a6a9b.png)
      **HOLD :**
      ![image](https://user-images.githubusercontent.com/103184935/185763537-acea832a-12ba-4ca5-88eb-ba936ca8ca8d.png)

 
 ### 2-hardware resources and utillization 
     the AES block is implemented on much less than 1% of the total resources of the virtex-7 FPGA.
     ![image](https://user-images.githubusercontent.com/103184935/185763663-7fdb900d-d6a4-49ca-8ab4-22b864c7b92d.png
     note that this block will be used as a macros so we couldn't take the IOB pins into cosideration.
     
     ![image](https://user-images.githubusercontent.com/103184935/185763704-e1a3f648-1e30-40d4-b0b9-0235ef3e0336.png)

 
 ### 3-Power dissipation
     we used clock gating technique for each block to reduce the power dissipation in the system 
     also we used resouece shariong dor the SBOX block (4 times in all the design) which redused the area and the power
     **POWER DISSIPATION @ 200MHZ :**
     ![image](https://user-images.githubusercontent.com/103184935/185763565-5fb6654a-c068-42e2-a3ee-379db77d74f0.png)
     
     **POWER DISSIPATION @ 100MHZ :**
       ![image](https://user-images.githubusercontent.com/103184935/185763632-2116ba8f-1258-41da-acfa-aa3e226b5d26.png)

     note that this block will be used as a macros so we couldn't take the power dissipation from the pins into cosideration.
      

 ### 4-throughput 
    the design takes 100 clock cycles from the start to the end , when the clock period is 5ns it takes 500ns as shown:
    ![image](https://user-images.githubusercontent.com/103184935/185763842-720ff116-400f-4639-a6a1-cd948ac1d817.png)
    so the output is got with 2MHZ frequency (after 500ns). 
    
 


