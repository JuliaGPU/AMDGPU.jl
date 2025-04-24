	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1100"
	.amdhsa_code_object_version 5
	.globl	_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE ; -- Begin function _Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
	.p2align	8
	.type	_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE,@function
_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE: ; @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
.Lfunc_begin0:
	.file	1 "." "/home/pxlth/.julia/dev/AMDGPU/t.jl"
	.loc	1 3 0                           ; /home/pxlth/.julia/dev/AMDGPU/t.jl:3:0
	.cfi_sections .debug_frame
	.cfi_startproc
; %bb.0:                                ; %conversion
	s_mov_b64 s[34:35], s[2:3]
	s_mov_b64 s[10:11], s[4:5]
.Ltmp0:
	.file	2 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl"
	.loc	2 43 0 prologue_end             ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:43:0
	s_clause 0x1
	s_load_b32 s4, s[2:3], 0x78
	s_load_b64 s[2:3], s[2:3], 0x70
	s_mov_b32 s12, s13
	s_mov_b32 s32, 0
	v_mov_b32_e32 v3, 0
	v_mov_b32_e32 v5, 1
	s_waitcnt lgkmcnt(0)
	s_cmp_lt_u32 s15, s4
	s_cselect_b32 s4, 16, 22
	s_add_u32 s8, s34, 0x70
	s_addc_u32 s9, s35, 0
	s_cmp_lt_u32 s14, s3
	s_cselect_b32 s3, 14, 20
	s_cmp_lt_u32 s13, s2
	s_mov_b32 s13, s14
	s_cselect_b32 s2, 12, 18
	s_delay_alu instid0(SALU_CYCLE_1)
	v_dual_mov_b32 v40, v0 :: v_dual_mov_b32 v1, s2
	v_mov_b32_e32 v0, s3
	s_clause 0x1
	global_load_u16 v43, v0, s[8:9]
	global_load_u16 v42, v1, s[8:9]
	v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v0, s4
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, llvm.amdgcn.permlanex16.i32@gotpcrel32@lo+4
	s_addc_u32 s3, s3, llvm.amdgcn.permlanex16.i32@gotpcrel32@hi+12
	v_mov_b32_e32 v31, v40
	s_load_b64 s[2:3], s[2:3], 0x0
	v_mov_b32_dpp v1, v1 row_shl:1 row_mask:0xf bank_mask:0xf bound_ctrl:1
	global_load_u16 v0, v0, s[8:9]
	s_mov_b64 s[4:5], s[0:1]
	s_mov_b32 s14, s15
	v_or_b32_dpp v1, v1, v1 row_shl:2 row_mask:0xf bank_mask:0xf bound_ctrl:1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_dpp v1, v1, v1 row_shl:4 row_mask:0xf bank_mask:0xf bound_ctrl:1
	v_or_b32_dpp v1, v1, v1 row_shl:8 row_mask:0xf bank_mask:0xf bound_ctrl:1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mov_b32_dpp v41, v1 row_share:0 row_mask:0xf bank_mask:0xf bound_ctrl:1
	v_dual_mov_b32 v4, 0 :: v_dual_mov_b32 v1, v41
	s_waitcnt vmcnt(1)
	v_mul_lo_u32 v2, v43, v42
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_bfe_i32 v2, v2, 0, 24
	s_waitcnt vmcnt(0)
	v_mul_lo_u32 v0, v2, v0
	v_mov_b32_e32 v2, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v44, 31, v0
	s_waitcnt lgkmcnt(0)
	s_swappc_b64 s[30:31], s[2:3]
	v_and_b32_e32 v1, 0xffffffe0, v44
	v_or_b32_e32 v0, v0, v41
	s_delay_alu instid0(VALU_DEP_2)
	v_cmp_eq_u32_e32 vcc_lo, 32, v1
	s_cbranch_vccnz .LBB0_9
; %bb.1:
	.loc	2 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:0:0
	v_bfe_u32 v1, v40, 10, 10
	v_bfe_u32 v2, v40, 20, 10
	v_and_b32_e32 v3, 0x3ff, v40
	.loc	2 43 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:43:0
	s_mov_b32 s0, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u32_u24 v4, v2, v43, v1
	v_mad_u64_u32 v[1:2], null, v4, v42, v[3:4]
	v_mbcnt_lo_u32_b32 v2, -1, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v3, 5, v1
	v_or_b32_e32 v3, v3, v2
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 0, v3
	s_cbranch_execz .LBB0_3
; %bb.2:
	.loc	2 0 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:0:0
	v_mov_b32_e32 v3, 0
	.loc	2 43 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:43:0
	ds_store_b32 v3, v0
.LBB0_3:
	s_or_b32 exec_lo, exec_lo, s0
	v_cmp_eq_u32_e32 vcc_lo, 0, v2
	v_cmp_lt_u32_e64 s0, 31, v1
	s_waitcnt lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_barrier
	buffer_gl0_inv
	s_and_b32 s1, vcc_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB0_8
; %bb.4:
	.loc	2 0 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:0:0
	s_mov_b32 s2, exec_lo
	s_mov_b32 s1, 0
.LBB0_5:                                ; %ComputeLoop
                                        ; =>This Inner Loop Header: Depth=1
	.loc	2 43 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:43:0
	s_ctz_i32_b32 s3, s2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_readlane_b32 s4, v0, s3
	s_lshl_b32 s3, 1, s3
	s_and_not1_b32 s2, s2, s3
	s_delay_alu instid0(VALU_DEP_1)
	s_or_b32 s1, s1, s4
	s_cmp_lg_u32 s2, 0
	s_cbranch_scc1 .LBB0_5
; %bb.6:                                ; %ComputeEnd
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	s_mov_b32 s2, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_eq_u32_e32 0, v0
	s_xor_b32 s2, exec_lo, s2
	s_cbranch_execz .LBB0_8
; %bb.7:
	.loc	2 0 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:0:0
	v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s1
	.loc	2 43 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:43:0
	ds_or_b32 v0, v1
.LBB0_8:                                ; %Flow3
	s_or_b32 exec_lo, exec_lo, s0
	v_mov_b32_e32 v0, 0
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	ds_load_b32 v0, v0
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
.Ltmp1:
.LBB0_9:                                ; %__ockl_wgred_or_i32.exit
	.loc	2 0 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:0:0
	s_load_b64 s[0:1], s[34:35], 0x58
.Ltmp2:
	.file	3 "." "int.jl"
	.loc	3 519 0 is_stmt 1               ; int.jl:519:0
	s_waitcnt lgkmcnt(0)
	s_cmp_lg_u64 s[0:1], 0
.Ltmp3:
	.file	4 "." "abstractarray.jl"
	.loc	4 699 0                         ; abstractarray.jl:699:0
	s_cbranch_scc0 .LBB0_12
.Ltmp4:
; %bb.10:                               ; %L17
	.loc	4 0 0 is_stmt 0                 ; abstractarray.jl:0:0
	s_load_b64 s[2:3], s[34:35], 0x60
	v_mov_b32_e32 v2, 0
.Ltmp5:
	.file	5 "." "boot.jl"
	.loc	5 876 0 is_stmt 1               ; boot.jl:876:0
	v_ashrrev_i32_e32 v1, 31, v0
.Ltmp6:
	.file	6 "." "/home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl"
	.loc	6 39 0                          ; /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39:0
	s_waitcnt lgkmcnt(0)
	global_store_b64 v2, v[0:1], s[2:3]
.Ltmp7:
	.loc	4 699 0                         ; abstractarray.jl:699:0
	s_cbranch_execz .LBB0_13
; %bb.11:                               ; %UnifiedReturnBlock
	.loc	4 0 0 is_stmt 0                 ; abstractarray.jl:0:0
	s_endpgm
.LBB0_12:
.LBB0_13:                               ; %L14
	s_load_b64 s[0:1], s[34:35], 0x0
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v3, 1
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
.Ltmp8:
	.file	7 "." "pointer.jl"
	.loc	7 180 0 is_stmt 1               ; pointer.jl:180:0
	s_clause 0x3
	flat_store_b8 v[0:1], v2 offset:3
	flat_store_b8 v[0:1], v2 offset:2
	flat_store_b8 v[0:1], v2 offset:1
	flat_store_b8 v[0:1], v3
.Ltmp9:
	.file	8 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl"
	.loc	8 52 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52:0
	s_endpgm
	; divergent unreachable
	s_endpgm
.Ltmp10:
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
		.amdhsa_group_segment_fixed_size 256
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 368
		.amdhsa_user_sgpr_count 13
		.amdhsa_user_sgpr_dispatch_ptr 1
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 1
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 1
		.amdhsa_enable_private_segment 1
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 1
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 2
		.amdhsa_next_free_vgpr 45
		.amdhsa_next_free_sgpr 36
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
		.amdhsa_shared_vgpr_count 0
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
	.size	_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE, .Lfunc_end0-_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
	.cfi_endproc
	.file	9 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl"
	.file	10 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl"
	.file	11 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl"
	.file	12 "." "/home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl"
	.file	13 "." "number.jl"
	.file	14 "." "none"
                                        ; -- End function
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 728
; NumSgprs: 38
; NumVgprs: 45
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 256 bytes/workgroup (compile time only)
; SGPRBlocks: 4
; VGPRBlocks: 5
; NumSGPRsForWavesPerEU: 38
; NumVGPRsForWavesPerEU: 45
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 1
; COMPUTE_PGM_RSRC2:USER_SGPR: 13
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 1
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 2
	.text
	.p2alignl 7, 3214868480
	.fill 96, 4, 3214868480
	.section	.debug_abbrev,"",@progbits
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
	.byte	5                               ; Abbreviation Code
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
	.byte	6                               ; Abbreviation Code
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
	.byte	7                               ; Abbreviation Code
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
	.byte	8                               ; Abbreviation Code
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
	.byte	9                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	16                              ; DW_FORM_ref_addr
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
	.byte	10                              ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	16                              ; DW_FORM_ref_addr
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
	.byte	11                              ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	0                               ; DW_CHILDREN_no
	.byte	49                              ; DW_AT_abstract_origin
	.byte	16                              ; DW_FORM_ref_addr
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
	.byte	12                              ; Abbreviation Code
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
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	0                               ; EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 ; Length of Unit
.Ldebug_info_start0:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0x1d9 DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string0                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string1                  ; DW_AT_comp_dir
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x30:0x6 DW_TAG_subprogram
	.long	.Linfo_string3                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x36:0x6 DW_TAG_subprogram
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x3c:0x6 DW_TAG_subprogram
	.long	.Linfo_string5                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x42:0x6 DW_TAG_subprogram
	.long	.Linfo_string6                  ; DW_AT_name
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
	.long	.Linfo_string10                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x60:0x6 DW_TAG_subprogram
	.long	.Linfo_string11                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x66:0x6 DW_TAG_subprogram
	.long	.Linfo_string11                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x6c:0x6 DW_TAG_subprogram
	.long	.Linfo_string12                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	3                               ; Abbrev [3] 0x72:0x171 DW_TAG_subprogram
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.long	.Linfo_string16                 ; DW_AT_name
	.byte	4                               ; Abbrev [4] 0x83:0x13 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	1                               ; DW_AT_call_file
	.byte	4                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x96:0x14c DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp10-.Ltmp2                  ; DW_AT_high_pc
	.byte	1                               ; DW_AT_call_file
	.byte	4                               ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0xa9:0xad DW_TAG_inlined_subroutine
	.long	60                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges0                 ; DW_AT_ranges
	.byte	9                               ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0xb4:0x3e DW_TAG_inlined_subroutine
	.long	60                              ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.short	699                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0xc8:0x29 DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.short	689                             ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0xdc:0x14 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.short	754                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0xf2:0x63 DW_TAG_inlined_subroutine
	.long	.debug_info+563                 ; DW_AT_abstract_origin
	.quad	.Ltmp8                          ; DW_AT_low_pc
	.long	.Ltmp10-.Ltmp8                  ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.short	699                             ; DW_AT_call_line
	.byte	10                              ; Abbrev [10] 0x106:0x4e DW_TAG_inlined_subroutine
	.long	.debug_info+520                 ; DW_AT_abstract_origin
	.quad	.Ltmp8                          ; DW_AT_low_pc
	.long	.Ltmp10-.Ltmp8                  ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	8                               ; DW_AT_call_line
	.byte	10                              ; Abbrev [10] 0x119:0x27 DW_TAG_inlined_subroutine
	.long	.debug_info+514                 ; DW_AT_abstract_origin
	.quad	.Ltmp8                          ; DW_AT_low_pc
	.long	.Ltmp9-.Ltmp8                   ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	11                              ; Abbrev [11] 0x12c:0x13 DW_TAG_inlined_subroutine
	.long	.debug_info+514                 ; DW_AT_abstract_origin
	.quad	.Ltmp8                          ; DW_AT_low_pc
	.long	.Ltmp9-.Ltmp8                   ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	11                              ; Abbrev [11] 0x140:0x13 DW_TAG_inlined_subroutine
	.long	.debug_info+526                 ; DW_AT_abstract_origin
	.quad	.Ltmp9                          ; DW_AT_low_pc
	.long	.Ltmp10-.Ltmp9                  ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x156:0x8b DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp7-.Ltmp5                   ; DW_AT_high_pc
	.byte	9                               ; DW_AT_call_file
	.byte	90                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x169:0x3c DW_TAG_inlined_subroutine
	.long	84                              ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp6-.Ltmp5                   ; DW_AT_high_pc
	.byte	12                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x17c:0x28 DW_TAG_inlined_subroutine
	.long	78                              ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp6-.Ltmp5                   ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	7                               ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x18f:0x14 DW_TAG_inlined_subroutine
	.long	72                              ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp6-.Ltmp5                   ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.short	957                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x1a5:0x3b DW_TAG_inlined_subroutine
	.long	108                             ; DW_AT_abstract_origin
	.quad	.Ltmp6                          ; DW_AT_low_pc
	.long	.Ltmp7-.Ltmp6                   ; DW_AT_high_pc
	.byte	12                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x1b8:0x27 DW_TAG_inlined_subroutine
	.long	102                             ; DW_AT_abstract_origin
	.quad	.Ltmp6                          ; DW_AT_low_pc
	.long	.Ltmp7-.Ltmp6                   ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x1cb:0x13 DW_TAG_inlined_subroutine
	.long	96                              ; DW_AT_abstract_origin
	.quad	.Ltmp6                          ; DW_AT_low_pc
	.long	.Ltmp7-.Ltmp6                   ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end0:
.Lcu_begin1:
	.long	.Ldebug_info_end1-.Ldebug_info_start1 ; Length of Unit
.Ldebug_info_start1:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	12                              ; Abbrev [12] 0xb:0x26 DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string0                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string1                  ; DW_AT_comp_dir
	.byte	2                               ; Abbrev [2] 0x1e:0x6 DW_TAG_subprogram
	.long	.Linfo_string10                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x24:0x6 DW_TAG_subprogram
	.long	.Linfo_string13                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string15                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end1:
.Lcu_begin2:
	.long	.Ldebug_info_end2-.Ldebug_info_start2 ; Length of Unit
.Ldebug_info_start2:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	12                              ; Abbrev [12] 0xb:0x1a DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string0                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string1                  ; DW_AT_comp_dir
	.byte	2                               ; Abbrev [2] 0x1e:0x6 DW_TAG_subprogram
	.long	.Linfo_string14                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end2:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	.Ltmp10-.Lfunc_begin0
	.quad	0
	.quad	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"julia"                         ; string offset=0
.Linfo_string1:
	.asciz	"."                             ; string offset=6
.Linfo_string2:
	.asciz	"sync_workgroup_or;"            ; string offset=8
.Linfo_string3:
	.asciz	"<;"                            ; string offset=27
.Linfo_string4:
	.asciz	"checkindex;"                   ; string offset=30
.Linfo_string5:
	.asciz	"checkbounds;"                  ; string offset=42
.Linfo_string6:
	.asciz	"#setindex!;"                   ; string offset=55
.Linfo_string7:
	.asciz	"toInt64;"                      ; string offset=67
.Linfo_string8:
	.asciz	"Int64;"                        ; string offset=76
.Linfo_string9:
	.asciz	"convert;"                      ; string offset=83
.Linfo_string10:
	.asciz	"unsafe_store!;"                ; string offset=92
.Linfo_string11:
	.asciz	"macro expansion;"              ; string offset=107
.Linfo_string12:
	.asciz	"pointerset;"                   ; string offset=124
.Linfo_string13:
	.asciz	"signal_exception"              ; string offset=136
.Linfo_string14:
	.asciz	"#throw_boundserror"            ; string offset=153
.Linfo_string15:
	.asciz	"endpgm;"                       ; string offset=172
.Linfo_string16:
	.asciz	"ker!"                          ; string offset=180
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.3.0 24455 f24aa3b4a91f6ee2fcd15629ba0b49fa545d8d6b)"
	.section	".note.GNU-stack","",@progbits
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .name:           state
        .offset:         0
        .size:           88
        .value_kind:     by_value
      - .name:           'x::ROCDeviceArray'
        .offset:         88
        .size:           24
        .value_kind:     by_value
      - .offset:         112
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         116
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         120
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         124
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         126
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         128
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         130
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         132
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         134
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         152
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         160
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         168
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         176
        .size:           2
        .value_kind:     hidden_grid_dims
      - .offset:         192
        .size:           8
        .value_kind:     hidden_hostcall_buffer
      - .offset:         200
        .size:           8
        .value_kind:     hidden_multigrid_sync_arg
      - .offset:         208
        .size:           8
        .value_kind:     hidden_heap_v1
      - .offset:         216
        .size:           8
        .value_kind:     hidden_default_queue
      - .offset:         224
        .size:           8
        .value_kind:     hidden_completion_action
      - .offset:         312
        .size:           8
        .value_kind:     hidden_queue_ptr
    .group_segment_fixed_size: 256
    .kernarg_segment_align: 8
    .kernarg_segment_size: 368
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
    .private_segment_fixed_size: 0
    .sgpr_count:     38
    .sgpr_spill_count: 0
    .symbol:         _Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE.kd
    .uses_dynamic_stack: true
    .vgpr_count:     45
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1100
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
	.section	.debug_line,"",@progbits
.Lline_table_start0:
