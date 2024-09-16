all: RT_TENDER

MODULES = modules/utils/hardware_counter.v										\
					modules/utils/VPU_memory.v										\
					modules/utils/Maxtree64.v										\
					modules/grp_idx_generator.v										\
					modules/index_buffer_table.v										\
					modules/index_buffer.v										

SOURCES = ./RT_TENDER_tb.v ./RT_TENDER.v 

RT_TENDER: $(MODULES) $(SOURCES)
	iverilog -I modules/ -s RT_TENDER_tb -o $@ $^

clean:
	rm -f RT_TENDER *.vcd
