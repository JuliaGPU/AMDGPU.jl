	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1030"
	.globl	_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE ; -- Begin function _Z1f14ROCDeviceArrayI5Int32Li1ELi1EE
	.p2align	8
	.type	_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE,@function
_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE:   ; @_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE
.Lfunc_begin0:
	.file	1 "/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl"
	.loc	1 363 0                         ; /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:363:0
	.cfi_sections .debug_frame
	.cfi_startproc
; %bb.0:                                ; %conversion
	s_load_dwordx2 s[0:1], s[4:5], 0x38
	s_mov_b32 s33, 0
.Ltmp0:
	.file	2 "./int.jl"
	.loc	2 488 0 prologue_end            ; int.jl:488:0
	s_waitcnt lgkmcnt(0)
	v_cmp_gt_i64_e64 s0, s[0:1], 1
.Ltmp1:
	.file	3 "./abstractarray.jl"
	.loc	3 709 0                         ; abstractarray.jl:709:0
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB0_2
.Ltmp2:
; %bb.1:                                ; %L18
	.loc	3 0 0 is_stmt 0                 ; abstractarray.jl:0:0
	s_load_dwordx2 s[0:1], s[4:5], 0x40
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 1
.Ltmp3:
	.file	4 "/home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl"
	.loc	4 40 0 is_stmt 1                ; /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl:40:0
	s_waitcnt lgkmcnt(0)
	global_store_dword v0, v1, s[0:1] offset:4
.Ltmp4:
	.loc	1 365 0                         ; /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:365:0
	s_endpgm
.LBB0_2:                                ; %L10
	.loc	1 0 0 is_stmt 0                 ; /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:0:0
	s_load_dwordx2 s[0:1], s[4:5], 0x0
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 1
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s0
	v_mov_b32_e32 v1, s1
.Ltmp5:
	.file	5 "./pointer.jl"
	.loc	5 126 0 is_stmt 1               ; pointer.jl:126:0
	flat_store_byte v[0:1], v2 offset:3
	flat_store_byte v[0:1], v2 offset:2
	flat_store_byte v[0:1], v2 offset:1
	flat_store_byte v[0:1], v3
.Ltmp6:
	.file	6 "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl"
	.loc	6 52 0                          ; /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52:0
	s_endpgm
.Ltmp7:
	.section	.rodata,#alloc
	.p2align	6
	.amdhsa_kernel _Z1f14ROCDeviceArrayI5Int32Li1ELi1EE
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 80
		.amdhsa_user_sgpr_count 6
		.amdhsa_user_sgpr_private_segment_buffer 1
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_flat_scratch_init 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_system_sgpr_private_segment_wavefront_offset 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 4
		.amdhsa_next_free_sgpr 34
		.amdhsa_reserve_flat_scratch 0
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end0:
	.size	_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE, .Lfunc_end0-_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE
	.cfi_endproc
	.file	7 "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl"
	.file	8 "/home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl"
	.file	9 "/home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl"
	.file	10 "/home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl"
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 128
; NumSgprs: 36
; NumVgprs: 4
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 4
; VGPRBlocks: 0
; NumSGPRsForWavesPerEU: 36
; NumVGPRsForWavesPerEU: 4
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 6
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.p2alignl 6, 3214868480
	.fill 48, 4, 3214868480
	.section	.debug_abbrev
	.byte	1                               ; Abbreviation Code
	.byte	17                              ; DW_TAG_compile_unit
	.byte	1                               ; DW_CHILDREN_yes
	.byte	37                              ; DW_AT_producer
	.byte	14                              ; DW_FORM_strp
	.byte	19                              ; DW_AT_language
	.byte	5                               ; DW_FORM_data2
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	16                              ; DW_AT_stmt_list
	.byte	23                              ; DW_FORM_sec_offset
	.byte	27                              ; DW_AT_comp_dir
	.byte	14                              ; DW_FORM_strp
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	2                               ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	32                              ; DW_AT_inline
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	3                               ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	1                               ; DW_CHILDREN_yes
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	4                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	85                              ; DW_AT_ranges
	.byte	23                              ; DW_FORM_sec_offset
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	5                               ; DW_FORM_data2
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	5                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	85                              ; DW_AT_ranges
	.byte	23                              ; DW_FORM_sec_offset
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	6                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	5                               ; DW_FORM_data2
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	7                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	0                               ; DW_CHILDREN_no
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	5                               ; DW_FORM_data2
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	8                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	9                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	0                               ; DW_CHILDREN_no
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	0                               ; EOM(3)
	.section	.debug_info
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 ; Length of Unit
.Ldebug_info_start0:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0x183 DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string1                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string2                  ; DW_AT_comp_dir
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string3                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x30:0x6 DW_TAG_subprogram
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x36:0x6 DW_TAG_subprogram
	.long	.Linfo_string5                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x3c:0x6 DW_TAG_subprogram
	.long	.Linfo_string6                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x42:0x6 DW_TAG_subprogram
	.long	.Linfo_string7                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x48:0x6 DW_TAG_subprogram
	.long	.Linfo_string7                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x4e:0x6 DW_TAG_subprogram
	.long	.Linfo_string8                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x54:0x6 DW_TAG_subprogram
	.long	.Linfo_string9                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x5a:0x6 DW_TAG_subprogram
	.long	.Linfo_string9                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x60:0x6 DW_TAG_subprogram
	.long	.Linfo_string10                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x66:0x6 DW_TAG_subprogram
	.long	.Linfo_string11                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x6c:0x6 DW_TAG_subprogram
	.long	.Linfo_string12                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	3                               ; Abbrev [3] 0x72:0x11b DW_TAG_subprogram
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.long	.Linfo_string13                 ; DW_AT_name
	.byte	4                               ; Abbrev [4] 0x83:0x109 DW_TAG_inlined_subroutine
	.long	60                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges0                 ; DW_AT_ranges
	.byte	1                               ; DW_AT_call_file
	.short	364                             ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x8f:0xad DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges1                 ; DW_AT_ranges
	.byte	7                               ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x9a:0x3e DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.short	709                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0xae:0x29 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.short	694                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0xc2:0x14 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.short	768                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0xd8:0x63 DW_TAG_inlined_subroutine
	.long	102                             ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp7-.Ltmp5                   ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.short	709                             ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0xec:0x4e DW_TAG_inlined_subroutine
	.long	96                              ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp7-.Ltmp5                   ; DW_AT_high_pc
	.byte	8                               ; DW_AT_call_file
	.byte	8                               ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0xff:0x27 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp6-.Ltmp5                   ; DW_AT_high_pc
	.byte	9                               ; DW_AT_call_file
	.byte	56                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x112:0x13 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp6-.Ltmp5                   ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	126                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0x126:0x13 DW_TAG_inlined_subroutine
	.long	108                             ; DW_AT_abstract_origin
	.quad	.Ltmp6                          ; DW_AT_low_pc
	.long	.Ltmp7-.Ltmp6                   ; DW_AT_high_pc
	.byte	9                               ; DW_AT_call_file
	.byte	58                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	8                               ; Abbrev [8] 0x13c:0x4f DW_TAG_inlined_subroutine
	.long	84                              ; DW_AT_abstract_origin
	.quad	.Ltmp3                          ; DW_AT_low_pc
	.long	.Ltmp4-.Ltmp3                   ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	90                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x14f:0x3b DW_TAG_inlined_subroutine
	.long	78                              ; DW_AT_abstract_origin
	.quad	.Ltmp3                          ; DW_AT_low_pc
	.long	.Ltmp4-.Ltmp3                   ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x162:0x27 DW_TAG_inlined_subroutine
	.long	72                              ; DW_AT_abstract_origin
	.quad	.Ltmp3                          ; DW_AT_low_pc
	.long	.Ltmp4-.Ltmp3                   ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	46                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x175:0x13 DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.quad	.Ltmp3                          ; DW_AT_low_pc
	.long	.Ltmp4-.Ltmp3                   ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	46                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_ranges
.Ldebug_ranges0:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges1:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	0
	.quad	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"julia"                         ; string offset=0
.Linfo_string1:
	.asciz	"/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl" ; string offset=6
.Linfo_string2:
	.asciz	"."                             ; string offset=51
.Linfo_string3:
	.asciz	"<=;"                           ; string offset=53
.Linfo_string4:
	.asciz	"checkindex;"                   ; string offset=57
.Linfo_string5:
	.asciz	"checkbounds;"                  ; string offset=69
.Linfo_string6:
	.asciz	"#setindex!;"                   ; string offset=82
.Linfo_string7:
	.asciz	"macro expansion;"              ; string offset=94
.Linfo_string8:
	.asciz	"pointerset;"                   ; string offset=111
.Linfo_string9:
	.asciz	"unsafe_store!;"                ; string offset=123
.Linfo_string10:
	.asciz	"signal_exception;"             ; string offset=138
.Linfo_string11:
	.asciz	"#throw_boundserror;"           ; string offset=156
.Linfo_string12:
	.asciz	"endpgm;"                       ; string offset=176
.Linfo_string13:
	.asciz	"f"                             ; string offset=184
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.section	".note.GNU-stack"
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .name:           state
        .offset:         0
        .size:           56
        .value_kind:     by_value
      - .offset:         56
        .size:           24
        .value_kind:     by_value
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 80
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z1f14ROCDeviceArrayI5Int32Li1ELi1EE
    .private_segment_fixed_size: 0
    .sgpr_count:     36
    .sgpr_spill_count: 0
    .symbol:         _Z1f14ROCDeviceArrayI5Int32Li1ELi1EE.kd
    .vgpr_count:     4
    .vgpr_spill_count: 0
    .wavefront_size: 32
amdhsa.target:   amdgcn-amd-amdhsa--gfx1030
amdhsa.version:
  - 1
  - 1
...

	.end_amdgpu_metadata
	.section	.debug_line
.Lline_table_start0:
