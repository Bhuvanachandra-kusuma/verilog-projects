# ============================================================
# Makefile for 4-bit ALU
# Requires: iverilog, vvp, gtkwave
# ============================================================

TOP      = alu_tb
SRC      = src/alu.v
TB       = tb/alu_tb.v
OUT      = sim/$(TOP)
VCD      = sim/alu_wave.vcd

.PHONY: sim wave clean

sim: $(SRC) $(TB)
	@mkdir -p sim
	iverilog -o $(OUT) $(TB) $(SRC)
	vvp $(OUT)

wave: $(VCD)
	gtkwave $(VCD) &

$(VCD): sim

clean:
	rm -rf sim/
