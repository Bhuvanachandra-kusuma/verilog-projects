# Verilog Projects

A growing collection of digital design projects implemented in Verilog HDL.  
Each project is self-contained with source, testbench, and simulation instructions.

## Projects

| # | Project | Description | Status |
|---|---------|-------------|--------|
| 01 | [4-bit ALU](./01_alu) | Arithmetic Logic Unit with flags | ✅ Complete |

## Tools Used

- **Simulator:** [Icarus Verilog](http://iverilog.icarus.com/) (`iverilog` + `vvp`)
- **Waveform Viewer:** [GTKWave](http://gtkwave.sourceforge.net/)
- **Language:** Verilog HDL (IEEE 1364-2001)

## Getting Started

Install dependencies (Ubuntu/Debian):
```bash
sudo apt install iverilog gtkwave
```

Then go into any project folder and run:
```bash
make sim     # compile and simulate
make wave    # open waveform in GTKWave
make clean   # remove build artifacts
```

---

*Projects are added progressively. Each one builds on the last.*
