# Verilog Projects

A progressive collection of digital design projects implemented in Verilog HDL —
starting from foundational building blocks and working up to a simple CPU.

Each project includes a synthesizable module, a testbench with full test coverage,
simulation waveforms, and step-by-step instructions to run locally.

---

## Projects

| # | Project | Description | Status |
|---|---------|-------------|--------|
| 01 | [4-bit ALU](./01_alu) | Arithmetic Logic Unit — ADD, SUB, AND, OR, XOR, NOT, SHL, SHR with flags | ✅ Complete |
| 02 | Register File | 8x4-bit register file with read/write ports | 🔜 Coming soon |
| 03 | UART | Serial transmitter/receiver with configurable baud rate | 🔜 Coming soon |
| 04 | Simple CPU | 8-bit fetch-decode-execute pipeline | 🔜 Coming soon |

---

## Tools

| Tool | Purpose |
|------|---------|
| [Icarus Verilog](http://iverilog.icarus.com/) | Simulation (`iverilog` + `vvp`) |
| [GTKWave](http://gtkwave.sourceforge.net/) | Waveform viewer |
| Verilog HDL (IEEE 1364-2001) | Hardware description language |

---

## Getting Started

**Install dependencies:**
```bash
# Ubuntu / WSL
sudo apt install iverilog gtkwave

# macOS
brew install icarus-verilog gtkwave
```

**Run any project:**
```bash
cd 01_alu
make sim     # compile and simulate — prints PASS/FAIL for each test
make wave    # open waveform in GTKWave
make clean   # remove build artifacts
```

---

## Repo Structure

```
verilog-projects/
├── 01_alu/
│   ├── src/        # Verilog source modules
│   ├── tb/         # Testbenches
│   ├── sim/        # Generated simulation outputs
│   ├── docs/       # Waveform screenshots and simulation logs
│   ├── Makefile
│   └── README.md
└── README.md       # This file
```

---

## About

This repo documents my journey learning digital design from the ground up.
Projects are added progressively — each one builds on the concepts of the last.

**Topics:** `verilog` `hdl` `digital-design` `fpga` `alu` `uart` `cpu`
