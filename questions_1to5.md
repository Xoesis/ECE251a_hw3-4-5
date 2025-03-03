# Answer to Question 1 - 5

## Question 1
addi $t0, $s2, –5 
add $s0, $s1, $t0 

## Question 2
int f; 
int A[5]; 
A[1] = (int)&A[0]; 
f = (int)&A[0] + A[1]; // 2*(int)&A[0] 

## Question 3
| All in decimal  | Instruction | Type | Opcode | rs | rt | rd | Immed. | Funct |
|:---------------:|:-----------:|:----:|:------:|:--:|:--:|:--:|:------:|:-----:|
|addi $t0, $s6, 4 |addi         |I type|8       |22  |8   |N/A |4       |N/A    |
|add $t1, $s6, $0 |add          |R type|0       |0   |22  |9   |N/A     |32     |
| sw $t1, 0($t0)  |sw           |I type|43      |8   |9   |N/A |0       |N/A    |
| lw $t0, 0($t0)  |lw           |I type|35      |8   |8   |N/A |0       |N/A    |
|add $s0, $t1, $t0|add          |R type|0       |8   |9   |16  |N/A     |32     |

## Question 4
load word, I type instruction 
101011 00001 00010 00000000000001000 

## Question 5
### Part a
jal can access from 0x20000000 to 0x2FFFFFFC 

### Part b
0x20000000 – 0x00020000 and 0x20000000 + 0x0001fffc 
beq can access from 0x1FFE0000 to 0x2001FFFC2 