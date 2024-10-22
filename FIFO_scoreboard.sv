package FIFO_scoreboard_pkg;

import FIFO_Transaction_pkg::*;
import SHARED_PKG::*;

class FIFO_scoreboard ;

parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;

bit [FIFO_WIDTH-1:0] data_out_ref;
bit wr_ack_ref, overflow_ref,underflow_ref; 
bit full_ref, empty_ref, almostfull_ref, almostempty_ref ;

SHARED_class shared_obj;

int queue_check[$];

function void check_data(input FIFO_Transaction  FIFO_Transaction_chech_data);
    
    Reference_model(FIFO_Transaction_chech_data);

if (FIFO_Transaction_chech_data.rd_en && !FIFO_Transaction_chech_data.empty) begin

    if(FIFO_Transaction_chech_data.data_out == data_out_ref) begin
        shared_obj.correct_count = shared_obj.correct_count+1;
        $display("************************************************");
        $display("Succeeded,, data_out the expected is %h and the actual is %h",data_out_ref,FIFO_Transaction_chech_data.data_out);
        $display("************************************************");

    end
    else begin
        shared_obj.error_count = shared_obj.error_count+1;
        $display("************************************************");
        $display("there is error in data_out the expected is %h and the actual is %h",data_out_ref,FIFO_Transaction_chech_data.data_out);
        $display("************************************************");
    end

end

if(shared_obj.score_board_check) begin

    if(FIFO_Transaction_chech_data.wr_ack == wr_ack_ref) begin
        shared_obj.correct_count = shared_obj.correct_count+1;
        $display("************************************************");
        $display("Succeeded,, wr_ack the expected is %b and the actual is %b",wr_ack_ref,FIFO_Transaction_chech_data.wr_ack);
        $display("************************************************");
    end
    else begin
        shared_obj.error_count = shared_obj.error_count+1;
        $display("************************************************");
        $display("there is error in wr_ack the expected is %b and the actual is %b",wr_ack_ref,FIFO_Transaction_chech_data.wr_ack);
        $display("************************************************");
    end

    if(FIFO_Transaction_chech_data.overflow == overflow_ref) begin
        shared_obj.correct_count = shared_obj.correct_count+1;
        $display("************************************************");
        $display("Succeeded,, overflow the expected is %b and the actual is %b",overflow_ref,FIFO_Transaction_chech_data.overflow);
        $display("************************************************");
    end
    else begin
        shared_obj.error_count = shared_obj.error_count+1;
        $display("************************************************");
        $display("there is error in overflow the expected is %b and the actual is %b",overflow_ref,FIFO_Transaction_chech_data.overflow);
        $display("************************************************");
    end

    if(FIFO_Transaction_chech_data.underflow == underflow_ref) begin
        shared_obj.correct_count = shared_obj.correct_count+1;
        $display("************************************************");
        $display("Succeeded,, underflow the expected is %b and the actual is %b",underflow_ref,FIFO_Transaction_chech_data.underflow);
        $display("************************************************");
    end
    else begin
        shared_obj.error_count = shared_obj.error_count+1;
        $display("************************************************");
        $display("there is error in underflow the expected is %b and the actual is %b",underflow_ref,FIFO_Transaction_chech_data.underflow);
        $display("************************************************");
    end

   if(FIFO_Transaction_chech_data.almostempty == almostempty_ref) begin
        shared_obj.correct_count = shared_obj.correct_count+1;
        $display("************************************************");
        $display("Succeeded,, almostempty the expected is %b and the actual is %b",almostempty_ref,FIFO_Transaction_chech_data.almostempty);
        $display("************************************************");
    end
    else begin
        shared_obj.error_count = shared_obj.error_count+1;
        $display("************************************************");
        $display("there is error in almostempty the expected is %b and the actual is %b",almostempty_ref,FIFO_Transaction_chech_data.almostempty);
        $display("************************************************");
    end

    if(FIFO_Transaction_chech_data.empty == empty_ref) begin
        shared_obj.correct_count = shared_obj.correct_count+1;
        $display("************************************************");
        $display("Succeeded,, empty the expected is %b and the actual is %b",empty_ref,FIFO_Transaction_chech_data.empty);
        $display("************************************************");
    end
    else begin
        shared_obj.error_count = shared_obj.error_count+1;
        $display("************************************************");
        $display("there is error in empty the expected is %b and the actual is %b",empty_ref,FIFO_Transaction_chech_data.empty);
        $display("************************************************");
    end

    if(FIFO_Transaction_chech_data.almostfull == almostfull_ref) begin
        shared_obj.correct_count = shared_obj.correct_count+1;
        $display("************************************************");
        $display("Succeeded,, almostfull the expected is %b and the actual is %b",almostfull_ref,FIFO_Transaction_chech_data.almostfull);
        $display("************************************************");
    end
    else begin
        shared_obj.error_count = shared_obj.error_count+1;
        $display("************************************************");
        $display("there is error in almostfull the expected is %b and the actual is %b",almostfull_ref,FIFO_Transaction_chech_data.almostfull);
        $display("************************************************");
    end

     if(FIFO_Transaction_chech_data.full == full_ref) begin
        shared_obj.correct_count = shared_obj.correct_count+1;
        $display("************************************************");
        $display("Succeeded,, full the expected is %b and the actual is %b",full_ref,FIFO_Transaction_chech_data.full);
        $display("************************************************");
    end
    else begin
        shared_obj.error_count = shared_obj.error_count+1;
        $display("************************************************");
        $display("there is error in full the expected is %b and the actual is %b",full_ref,FIFO_Transaction_chech_data.full);
        $display("************************************************");
    end
end
    
endfunction
    
function void Reference_model(input FIFO_Transaction  FIFO_Transaction_Reference_model);

	if (!FIFO_Transaction_Reference_model.rst_n) begin
		wr_ack_ref <= 0; 
		overflow_ref <= 0; 
	end
	else if (FIFO_Transaction_Reference_model.wr_en && !full_ref) begin
		queue_check.push_front(FIFO_Transaction_Reference_model.data_in);
		wr_ack_ref <= 1;
        overflow_ref <= 0;
	end
	else begin 
		wr_ack_ref <= 0; 
		if (full_ref & FIFO_Transaction_Reference_model.wr_en)
			overflow_ref <= 1;
		else
			overflow_ref <= 0;
	end

    if (!FIFO_Transaction_Reference_model.rst_n) begin
		underflow_ref<=0; 
        queue_check.delete();
	end
	else if (FIFO_Transaction_Reference_model.rd_en && !empty_ref) begin
		data_out_ref <= queue_check.pop_back();
        underflow_ref<=0; 
	end
	else begin 
		if (empty_ref && FIFO_Transaction_Reference_model.rd_en) begin
			underflow_ref <=1;
		end
		else begin
			underflow_ref <=0;
		end
	end

 
    full_ref        <= (queue_check.size() == FIFO_Transaction_Reference_model.FIFO_DEPTH)? 1 : 0;
    empty_ref       <= (queue_check.size() == 0)? 1 : 0;
    almostfull_ref  <= (queue_check.size() == FIFO_Transaction_Reference_model.FIFO_DEPTH-1)? 1 : 0; 
    almostempty_ref <= (queue_check.size() == 1)? 1 : 0;
   
   
endfunction

function new();
    full_ref        = 0;
    empty_ref       = 1;
    almostfull_ref  = 0; 
    almostempty_ref = 0;
    wr_ack_ref      = 0;
    underflow_ref   = 0;
    overflow_ref    = 0;
endfunction
endclass
    
endpackage