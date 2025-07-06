# 5-Stage Pipelined MIPS-Lite CPU (Verilog)

This project implements a 5-stage pipelined MIPS-Lite CPU using Verilog.  
It supports 16 essential MIPS instructions, including arithmetic, logic, memory access, branching, and multiply/divide operations.

The CPU design follows the standard 5-stage pipeline model:  
**IF → ID → EX → MEM → WB**

---

## Supported Instructions

### Integer Arithmetic
- `add`, `sub`, `and`, `or`, `srl`, `slt`, `addiu`

### Memory Access
- `lw`, `sw`

### Branching
- `beq`, `j`

### Multiply/Divide
- `multu`: Unsigned 32-bit multiplication  
- `maddu`: Multiply and Add Unsigned (HI/LO = HI/LO + rs × rt)

### Other
- `mfhi`: Move from HI register  
- `mflo`: Move from LO register  
- `nop`: No operation

---

## System Design
### ALU
- The ALU used in this CPU is based on the design from the Midterm Project.
- It supports the following operations: `add`, `sub`, `and`, `or`, `srl`, `slt`, and `addiu`.


### Datapath
- Fully pipelined datapath with five stages:
  - **IF**: Instruction Fetch  
  - **ID**: Instruction Decode  
  - **EX**: Execute  
  - **MEM**: Memory Access  
  - **WB**: Write Back  
- Supports data hazard forwarding and basic stall control.

---


## Testbench

- A complete testbench is provided to validate the CPU's functionality.
- It **reads input programs from a file**, simulating a real instruction memory.
- Results can be observed through waveform or output log.

---

