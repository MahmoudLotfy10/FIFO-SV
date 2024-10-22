import FIFO_scoreboard_pkg::*;
import FIFO_Transaction_pkg::*;
import FIFO_coverage_pkg::*;
import SHARED_PKG::*;
module monitor (FIFO_Interface.MONITOR FIFO_IF);

FIFO_Transaction  FIFO_Transaction_obj;
FIFO_scoreboard   FIFO_scoreboard_obj;
FIFO_coverage     FIFO_coverage_obj;
SHARED_class      SHARED_class_obj;
initial begin
    FIFO_Transaction_obj = new();
    FIFO_scoreboard_obj  = new();
    FIFO_coverage_obj    = new();
    SHARED_class_obj     = new();

   //EXTRA
    /*0 mean in score board the data_out only will be checked as required and all other flags will checked only
     by assertions
     1 mean data_out and all falgs will check in scoreboard and in assertions also (extra) */
    SHARED_class_obj.score_board_check=0;

    @(negedge FIFO_IF.clk);
    forever begin
      @(negedge FIFO_IF.clk);
      FIFO_Transaction_obj.data_in     = FIFO_IF.data_in;
      FIFO_Transaction_obj.rst_n       = FIFO_IF.rst_n;
      FIFO_Transaction_obj.rd_en       = FIFO_IF.rd_en;
      FIFO_Transaction_obj.wr_en       = FIFO_IF.wr_en;
      FIFO_Transaction_obj.data_out    = FIFO_IF.data_out;
      FIFO_Transaction_obj.wr_ack      = FIFO_IF.wr_ack;
      FIFO_Transaction_obj.overflow    = FIFO_IF.overflow;
      FIFO_Transaction_obj.underflow   = FIFO_IF.underflow;
      FIFO_Transaction_obj.full        = FIFO_IF.full;
      FIFO_Transaction_obj.empty       = FIFO_IF.empty;
      FIFO_Transaction_obj.almostfull  = FIFO_IF.almostfull;
      FIFO_Transaction_obj.almostempty = FIFO_IF.almostempty;

      fork
        //sample_data
         begin
            FIFO_coverage_obj.sample_data(FIFO_Transaction_obj);
         end
        //check_data
         begin
            FIFO_scoreboard_obj.check_data(FIFO_Transaction_obj);
         end
      join

        if(SHARED_class_obj.test_finished) begin
            $display("Correct_count = %0d ,,, Error_count = %0d",SHARED_class_obj.correct_count,SHARED_class_obj.error_count);
            $stop;
        end
    end
end

endmodule