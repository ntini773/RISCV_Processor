# **RISC-V Pipelined Processor**

### This RISC-V 5-stage pipelined processor demonstrated remarkable efficiency by successfully executing various algorithmic implementations, including:

* Bubble Sort
* Dijkstra's Algorithm
* Binary Search
* Counting Odd Numbers in an Array
* Array Sum Calculation
* Fibonacci Sequence Generation

These algorithms showcased the processor's ability to handle complex computational tasks through its streamlined pipeline architecture.

### **1. Instruction Fetch (IF)**

* Fetches the instruction from memory using the program counter (PC).
* Updates the PC to point to the next instruction.

### **2. Instruction Decode (ID)**

* Decodes the fetched instruction.
* Reads values from the register file if required.
* Determines the type of operation.

### **3. Execute & Address Generation (EX)**

* Performs arithmetic and logical operations using the ALU.
* Calculates memory addresses for load/store instructions.
* Determines branch targets if applicable.

### **4. Memory Access (MEM)**

* Reads from or writes to memory for load/store instructions.
* Passes execution results for other instruction types.

### **5. Write Back (WB)**

* Writes the computed result back to the destination register.
* Updates the register file for subsequent instruction execution.

---

## **Installation**

### **1. Install Icarus Verilog & GTKWave**

#### **Ubuntu/Debian:**

```bash
sudo apt update
sudo apt install iverilog gtkwave
```

#### **Arch Linux:**

```bash
sudo pacman -S iverilog gtkwave
```

#### **macOS (Homebrew):**

```bash
brew install icarus-verilog gtkwave
```

#### **Windows:**

1. Download **Icarus Verilog** from [here](https://bleyer.org/icarus/).
2. Download **GTKWave** from [here](https://sourceforge.net/projects/gtkwave/).
3. Install both and add them to the system path.

---

### **2. Clone the Repository**

Run the following command to clone the RISC-V processor repository:

```bash
git clone --branch main https://github.com/ntini773/RISCV_Processor.git
cd RISCV_Processor/Pipelined_Processor/src
```

---

### File Structure (/src)

```
src/
│
├── Arithmetic and Logic Components/
│   ├── ADDv.v
│   ├── Adder.v
│   ├── add_gen.v
│   ├── ALU.v
│   ├── alu_control.v
│   ├── full_adder.v
│   ├── AND.v
│   ├── MUX2.v
│   ├── NEG.v
│   ├── NOT.v
│   ├── OR.v
│   ├── SLT.v
│   └── SUB.v
│
├── Pipeline Stage Components/
│   ├── control.v
│   ├── data_memory.v
│   ├── EX.v
│   ├── EX_MEM.v
│   ├── FwdUnit.v
│   ├── HazardDetection.v
│   ├── ID.v
│   ├── ID_EX.v
│   ├── IF.v
│   ├── IF_ID.v
│   ├── imm_gen.v
│   ├── instruction_memory.v
│   ├── MEM.v
│   ├── MEM_WB.v
│   ├── program_counter.v
│   ├── t_hazard.v
│   ├── WB.v
│   └── HazardDetectionUnit.tb.vcd
│
├── Register and File Management/
│   ├── regfile.v
│   └── refile.v.out
│
├── Python Utility Scripts/
│   └── initialise.py
│
├── Input and Configuration Files/
│   ├── initial_data.txt
│   ├── initial_reg.txt
│   ├── initial_register.txt
│   ├── input_data_memory.txt
│   ├── input_registers.txt
│   ├── instructions.txt
│   ├── memory.txt
│   ├── register_values.txt
│   └── pipeline_data_hazard.pdf
│
├── Core and Simulation Files/
│   ├── main.v
│   ├── main.v.out
│   ├── main.vcd
│   ├── processor.out
│   ├── risc.out
│   └── risc_pipeline.out
│
├── Hex Dump Files/
│   ├── memory_dump.hex
│   └── reg_dump.hex
│
└── Test Cases/
    ├── test_case.v
    ├── test_case2.v
    ├── test_case3.v
    ├── test_case4.v
    └── test_case5.v
```

## **Usage**

### **1. Prepare the Assembly Program**

* Use an assembly load supporting `add`, `sub`, `and`, `or`, `ld`, `sd`, `beq` ,`blt` commands.
* Do note that `instruction memory` is byte addressed(8bits) and `data memory` is double word addressed(8byte/64bit) ,so kindly align rhe assemby program accordingly
* Convert assembly instructions to machine code using [RV Codec](https://luplab.gitlab.io/rvcodecjs/).
* Save the converted instructions in `instructions.txt`.

### **2. Initialize Data and Registers**

- Run the following command which creates `input_registers.txt` ,`input_data_memory.txt`.Edit the values for your register and data memory:
  ```bash
  python3 intialise.py
  ```

### **3. Compile the Verilog Files:**

```bash
iverilog -o risc_pipeline.out main.v
```

### **4. Run the Simulation:**

```bash
vvp risc_pipeline.out
```

### **5. To View Waveform in GTKWave:**

```bash
gtkwave main.vcd
```

### **6. Check the Output Files**

- `reg_dump.hex` → Stores the final register contents.
- `memory_dump.hex` → Stores the final memory contents.
- Convert `memory_dump.hex , reg_dump.hex` to decimal format using:

  ```bash
  python3 hex_to_dec.py
  ```
- You can see the memory output in decimal format in `memory.txt`.
- You can see the register output in decimal format in `register.txt`.

  ### **7. All Commands**


  ```bash
  python3 intialise.py 
  iverilog -o risc_pipeline.out main.v && vvp risc_pipeline.out
  python3 hex_to_dec.py

  ```
- You can see the memory output in decimal format in `memory.txt`.
- You can see the register output in decimal format in `register_values.txt`

---

## **Example Assembly Code**

```assembly
// Assembly Code
// x2 contains the base address of the array
// x1 contains the value of n
// x6 contains the value 1
// x7 has value 2

// Start
0    add x26 x0 x0      // i=0 
4    sub x31 x1 x6      // x31 contains n-2 SAY(P)
8    Loop1:  beq x26 x31 Exit
12   add x27 x0 x0      // j=0
16   sub x30 x1 x26     // n-i
20   sub x30 x30 x6     // n-i-1
24   Loop2:  beq x27 x30 Temp
28   add x20 x2 x27     // address of arr[j]
32   add x22 x27 x6     // calculated j+1
36   add x21 x2 x22     // address of arr[j+1]
40   ld  x18 0(x20)     // x18= arr[j]
44   ld x19 0(x21)      // x19=arr[j+1]
48   blt x19 x18 Swap   // swap arr[j] & arr[j+1]
52   intermediate: add x27 x27 x6   // j=j+1
56   beq x0 x0 Loop2    // go back to beginning
60   Temp: add x26 x26 x6   // i=i+1
64   beq x0 x0 Loop1
68   Swap:  sd x18 0(x21)
72   sd x19 0(x20)
76   beq x0 x0 intermediate
80   Exit:
```

### **Corresponding Machine Code**

```plaintext
//instructions.txt(already written)

00000000000000000000110100110011
01000000011000001000111110110011
00000101111111010000010001100011
00000000000000000000110110110011
01000001101000001000111100110011
01000000011011110000111100110011
00000011111011011000001001100011
00000001101100010000101000110011
00000000011011011000101100110011
00000001011000010000101010110011
00000000000010100011100100000011
00000000000010101011100110000011
00000001001010011100101001100011
00000000011011011000110110110011
11111110000000000000000011100011
00000000011011010000110100110011
11111100000000000000010011100011
00000001001010101011000000100011
00000001001110100011000000100011
11111110000000000000010011100011 
```

---

### Run the following command

```bash
python3 intialise.py 
```

Update the input_registers.txt and input_data_memory.txt as prompted and preload according to the code as given below:

### input_registers.txt used (base address of array in x2 and length of array in x1 , x6=1,x7=2)

```
x0: x
x1: 5
x2: 0
x3: 9
x4: 6
x5: x
x6: 1
x7: 2
x8: x

```

### input_data_memory.txt used for Sorting(Eg:base address of array is 0(x2=0) and n=5)

```
memory0: 5
memory1: 3
memory2: 4
memory3: 2
memory4: 1
memory5: x

```

### intial_data.txt used for Sorting

```
0000000000000000000000000000000000000000000000000000000000000101
0000000000000000000000000000000000000000000000000000000000000011
0000000000000000000000000000000000000000000000000000000000000100
0000000000000000000000000000000000000000000000000000000000000010
0000000000000000000000000000000000000000000000000000000000000001
0000000000000000000000000000000000000000000000000000000000000000

```

### **Run the Processor**

Execute the following commands in the terminal within the project folder:

```bash
iverilog -o risc.out main.v
vvp risc.out
python3 hex_to_dec.py
```

### **Final Output visible for this in memory.txt**

```
memory[0]: 1
memory[1]: 2
memory[2]: 3
memory[3]: 4
memory[4]: 5
memory[5]: 0
memory[6]: 0
```

### To simulate waveforms:

Run this on terminal within project folder:

```bash
gtkwave main.vcd
```

##### You are to good to go!

---

## **Repository Link**

🔗 [GitHub Repository](https://github.com/ntini773/RISCV_Processor.git)
