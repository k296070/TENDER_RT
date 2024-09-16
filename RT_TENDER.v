// RT_group_generator.v

module RT_TENDER
#(parameter DATA_WIDTH = 16)(
  input clk,
  input rstn
);

//////////////////////////////////////////////////////////////////////////////////
// Hardware Counters
//////////////////////////////////////////////////////////////////////////////////
wire [31:0] CORE_CYCLE;

hardware_counter m_core_cycle(
  .clk(clk),
  .rstn(rstn),
  .cond(1'b1),

  .counter(CORE_CYCLE)
);


wire [15:0] Chidx_vpu,Chidx_maxtree,Chidx_idxgen;
wire [15:0] Tmax_vpu,Tmax_maxtree;
wire [1023:0] Tensors;
wire valid_VPU, valid_maxtree, valid_idxgen;
genvar i;

VPU_memory VPU_memory(
  .clk(clk),
  .rstn(rstn),

  .Chnaddr(Chidx_vpu),
  .Tmax(Tmax_vpu),
  .Tensors(Tensors),
  .valid(valid_VPU)
);

//////////////////////////////////////////////////////////////////////////////////
// Comperator
//////////////////////////////////////////////////////////////////////////////////
wire [15:0] max_val;
Maxtree64 Maxtree64(
  .clk(clk),
  .rstn(rstn),
  .Tensor(Tensors),
  .valid_in(valid_VPU),
  .Tmax_in(Tmax_vpu),
  .Chidx_in(Chidx_vpu),

  .Chidx_out(Chidx_maxtree),
  .Tmax_out(Tmax_maxtree),
  .valid_out(valid_maxtree),
  .max_val(max_val)
);

//////////////////////////////////////////////////////////////////////////////////
// Layer7 Index Generation
//////////////////////////////////////////////////////////////////////////////////
wire [7:0] grp_idx;
grp_idx_generator idx_generator(
  .clk(clk),
  .rstn(rstn),
  .Tmax(Tmax_maxtree),
  .in(max_val),
  .valid_in(valid_maxtree),
  .Chidx_in(Chidx_maxtree),
  
  .Chidx_out(Chidx_idxgen),
  .valid_out(valid_idxgen),
  .grp_idx(grp_idx)
);
//////////////////////////////////////////////////////////////////////////////////
// Layer8 Meta Data Access
//////////////////////////////////////////////////////////////////////////////////
wire [7:0] counter,buffer_addr;
index_buffer_table index_buffer_table(
  .clk(clk),
  .rstn(rstn),
  .grp_idx(grp_idx),
  .valid(valid_idxgen),

  .buffer_addr(buffer_addr),
  .counter(counter)
);
index_buffer index_buffer(
  .clk(clk),
  .rstn(rstn),
  .valid(valid_idxgen),

  .Chidx(Chidx_idxgen),//
  .buffer_addr(buffer_addr),
  .counter(counter)
);
endmodule
