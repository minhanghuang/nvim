require('persistent-breakpoints').setup{
	save_dir = ".cache/dap/persistent-breakpoints/" .. '/nvim_checkpoints',
	-- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
	perf_record = false,
} 


