import FIFO_Transaction_pkg::*;
import SHARED_PKG::*;
module FIFO_TB(FIFO_Interface.TEST FIFO_IF);

FIFO_Transaction  FIFO_Transaction_obj;
SHARED_class      SHARED_class_obj;

initial begin
    FIFO_Transaction_obj = new();
    SHARED_class_obj     = new();
    SHARED_class_obj.test_finished=0;

    RST();
  
    repeat(1000) begin
       assert (FIFO_Transaction_obj.randomize());
       take_inputs(FIFO_Transaction_obj.data_in,FIFO_Transaction_obj.rst_n,FIFO_Transaction_obj.wr_en,FIFO_Transaction_obj.rd_en);
    end

   repeat(2) @(negedge FIFO_IF.clk);
    SHARED_class_obj.test_finished=1;

end
    task take_inputs(
       input [FIFO_IF.FIFO_WIDTH-1:0]data_in,
       input rst_n, wr_en, rd_en
    );
        
        FIFO_IF.data_in = data_in;
        FIFO_IF.rst_n   = rst_n;
        FIFO_IF.wr_en   = wr_en;
        FIFO_IF.rd_en   = rd_en;
        @(negedge FIFO_IF.clk);
  
    endtask

    task RST();
    FIFO_IF.rst_n=0;
    assert (FIFO_Transaction_obj.randomize() with {FIFO_Transaction_obj.rst_n==0;});
    take_inputs(FIFO_Transaction_obj.data_in,FIFO_Transaction_obj.rst_n,FIFO_Transaction_obj.wr_en,FIFO_Transaction_obj.rd_en);
    @(negedge FIFO_IF.clk);
    FIFO_IF.rst_n=1; 
    @(negedge FIFO_IF.clk);
    endtask


endmodule