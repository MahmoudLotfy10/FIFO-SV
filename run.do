vlib work
vlog -f sourcefile.txt +cover -covercells +define+SIM
vsim -voptargs=+acc work.top -cover +define+SIM

add wave -position insertpoint sim:/top/DUT/FIFO_IF/*
add wave -position insertpoint sim:/top/DUT/*

add wave /top/DUT/max_fifo_addr_p /top/DUT/wr_ptr1_p /top/DUT/wr_ptr2_p 
add wave /top/DUT/rd_ptr1_p /top/DUT/rd_ptr2_p /top/DUT/counter1_p 
add wave /top/DUT/counter2_p /top/DUT/counter3_p /top/DUT/counter4_p /top/DUT/counter5_p 
add wave /top/DUT/wr_ack1_p /top/DUT/wr_ack2_p /top/DUT/wr_ack3_p /top/DUT/overflow1_p 
add wave /top/DUT/overflow2_p /top/DUT/overflow3_p /top/DUT/underflow1_p /top/DUT/underflow2_p 
add wave /top/DUT/underflow3_p /top/DUT/full1_p /top/DUT/full2_p /top/DUT/almostfull1_p 
add wave /top/DUT/almostfull2_p /top/DUT/full_almostfull1_p /top/DUT/full_almostfull2_p 
add wave /top/DUT/empty1_p /top/DUT/empty2_p /top/DUT/almostempty1_p /top/DUT/almostempty2_p 
add wave /top/DUT/empty_almostempty1_p /top/DUT/empty_almostempty2_p

coverage save top.ucdb -onexit 
run -all

#vcover report top.ucdb -details -annotate -all -output code_coverage3_rpt.txt
