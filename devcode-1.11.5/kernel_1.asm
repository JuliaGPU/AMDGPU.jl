	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1100"
	.p2align	2                               ; -- Begin function __ockl_hsa_signal_load
	.type	__ockl_hsa_signal_load,@function
__ockl_hsa_signal_load:                 ; @__ockl_hsa_signal_load
.Lfunc_begin0:
	.cfi_sections .debug_frame
	.cfi_startproc
; %bb.0:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_mov_b32 s0, 0
	s_mov_b32 s1, 0
	s_mov_b32 s2, exec_lo
                                        ; implicit-def: $vgpr3_vgpr4
	v_cmpx_lt_i32_e32 4, v2
	s_xor_b32 s2, exec_lo, s2
	s_cbranch_execz .LBB1_4
; %bb.1:                                ; %LeafBlock6
	s_mov_b32 s1, -1
	s_mov_b32 s3, exec_lo
                                        ; implicit-def: $vgpr3_vgpr4
	v_cmpx_eq_u32_e32 5, v2
	s_cbranch_execz .LBB1_3
; %bb.2:
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_load_b64 v[3:4], v[0:1], off offset:8 glc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	s_xor_b32 s1, exec_lo, -1
.LBB1_3:                                ; %Flow8
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s1, s1, exec_lo
                                        ; implicit-def: $vgpr2
.LBB1_4:                                ; %Flow
	s_and_not1_saveexec_b32 s2, s2
; %bb.5:                                ; %LeafBlock
	v_add_nc_u32_e32 v2, -1, v2
	s_and_not1_b32 s1, s1, exec_lo
	s_mov_b32 s0, exec_lo
                                        ; implicit-def: $vgpr3_vgpr4
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_lt_u32_e32 vcc_lo, 1, v2
	s_and_b32 s3, vcc_lo, exec_lo
	s_or_b32 s1, s1, s3
; %bb.6:                                ; %Flow9
	s_or_b32 exec_lo, exec_lo, s2
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB1_8
; %bb.7:
	global_load_b64 v[3:4], v[0:1], off offset:8 glc
	s_and_not1_b32 s0, s0, exec_lo
.LBB1_8:                                ; %Flow10
	s_or_b32 exec_lo, exec_lo, s2
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB1_10
; %bb.9:
	global_load_b64 v[3:4], v[0:1], off offset:8 glc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
.LBB1_10:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt vmcnt(0)
	v_dual_mov_b32 v0, v3 :: v_dual_mov_b32 v1, v4
	s_setpc_b64 s[30:31]
.Lfunc_end0:
	.size	__ockl_hsa_signal_load, .Lfunc_end0-__ockl_hsa_signal_load
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata
; Function info:
; codeLenInByte = 216
; NumSgprs: 34
; NumVgprs: 5
; ScratchSize: 0
; MemoryBound: 0
	.text
	.p2align	2                               ; -- Begin function __ockl_hsa_signal_cas
	.type	__ockl_hsa_signal_cas,@function
__ockl_hsa_signal_cas:                  ; @__ockl_hsa_signal_cas
.Lfunc_begin1:
	.cfi_startproc
; %bb.0:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	v_dual_mov_b32 v8, v5 :: v_dual_mov_b32 v7, v4
	v_dual_mov_b32 v10, v3 :: v_dual_mov_b32 v9, v2
	s_mov_b32 s0, 0
	s_mov_b32 s2, 0
	s_mov_b32 s3, exec_lo
                                        ; implicit-def: $sgpr1
                                        ; implicit-def: $vgpr2_vgpr3
	v_cmpx_lt_i32_e32 3, v6
	s_xor_b32 s3, exec_lo, s3
	s_cbranch_execz .LBB0_8
; %bb.1:                                ; %NodeBlock12
	s_mov_b32 s1, exec_lo
                                        ; implicit-def: $sgpr4
                                        ; implicit-def: $vgpr2_vgpr3
	v_cmpx_lt_i32_e32 4, v6
	s_xor_b32 s1, exec_lo, s1
	s_cbranch_execz .LBB0_5
; %bb.2:                                ; %LeafBlock10
	s_mov_b32 s5, -1
	s_mov_b32 s2, exec_lo
                                        ; implicit-def: $sgpr4
                                        ; implicit-def: $vgpr2_vgpr3
	v_cmpx_eq_u32_e32 5, v6
	s_cbranch_execz .LBB0_4
; %bb.3:
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_cmpswap_b64 v[2:3], v[0:1], v[7:10], off offset:8 glc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	s_xor_b32 s5, exec_lo, -1
	v_cmp_eq_u64_e32 vcc_lo, v[2:3], v[9:10]
	s_and_b32 s4, vcc_lo, exec_lo
.LBB0_4:                                ; %Flow18
	s_or_b32 exec_lo, exec_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s4, s4, exec_lo
	s_and_b32 s2, s5, exec_lo
.LBB0_5:                                ; %Flow17
	s_and_not1_saveexec_b32 s1, s1
	s_cbranch_execz .LBB0_7
; %bb.6:
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_cmpswap_b64 v[2:3], v[0:1], v[7:10], off offset:8 glc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	s_and_not1_b32 s4, s4, exec_lo
	v_cmp_eq_u64_e32 vcc_lo, v[2:3], v[9:10]
	s_and_b32 s5, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s4, s4, s5
.LBB0_7:                                ; %Flow19
	s_or_b32 exec_lo, exec_lo, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s1, s4, exec_lo
	s_and_b32 s2, s2, exec_lo
                                        ; implicit-def: $vgpr6
.LBB0_8:                                ; %Flow16
	s_and_not1_saveexec_b32 s3, s3
	s_cbranch_execz .LBB0_14
; %bb.9:                                ; %NodeBlock
	s_mov_b32 s4, exec_lo
                                        ; implicit-def: $sgpr0
                                        ; implicit-def: $vgpr2_vgpr3
	v_cmpx_lt_i32_e32 2, v6
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_11
; %bb.10:
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_cmpswap_b64 v[2:3], v[0:1], v[7:10], off offset:8 glc
                                        ; implicit-def: $vgpr6
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e32 vcc_lo, v[2:3], v[9:10]
	s_and_b32 s0, vcc_lo, exec_lo
.LBB0_11:                               ; %Flow21
	s_or_saveexec_b32 s5, s4
	s_mov_b32 s4, 0
	s_mov_b32 s6, s2
	s_xor_b32 exec_lo, exec_lo, s5
; %bb.12:                               ; %LeafBlock
	v_cmp_gt_i32_e32 vcc_lo, 1, v6
	s_and_not1_b32 s6, s2, exec_lo
	s_mov_b32 s4, exec_lo
	s_and_not1_b32 s0, s0, exec_lo
                                        ; implicit-def: $vgpr2_vgpr3
	s_and_b32 s7, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s6, s6, s7
; %bb.13:                               ; %Flow22
	s_or_b32 exec_lo, exec_lo, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 s1, s1, exec_lo
	s_and_b32 s0, s0, exec_lo
	s_and_not1_b32 s2, s2, exec_lo
	s_and_b32 s5, s6, exec_lo
	s_or_b32 s1, s1, s0
	s_and_b32 s0, s4, exec_lo
	s_or_b32 s2, s2, s5
.LBB0_14:                               ; %Flow20
	s_or_b32 exec_lo, exec_lo, s3
	s_and_saveexec_b32 s3, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s2, exec_lo, s3
	s_cbranch_execz .LBB0_16
; %bb.15:
	global_atomic_cmpswap_b64 v[2:3], v[0:1], v[7:10], off offset:8 glc
	s_and_not1_b32 s1, s1, exec_lo
	s_and_not1_b32 s0, s0, exec_lo
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e32 vcc_lo, v[2:3], v[9:10]
	s_and_b32 s3, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s1, s1, s3
.LBB0_16:                               ; %Flow23
	s_or_b32 exec_lo, exec_lo, s2
	s_and_saveexec_b32 s2, s0
	s_cbranch_execz .LBB0_18
; %bb.17:
	global_atomic_cmpswap_b64 v[2:3], v[0:1], v[7:10], off offset:8 glc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	s_and_not1_b32 s0, s1, exec_lo
	v_cmp_eq_u64_e32 vcc_lo, v[2:3], v[9:10]
	s_and_b32 s1, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s1, s0, s1
.LBB0_18:
	s_or_b32 exec_lo, exec_lo, s2
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB0_21
; %bb.19:
	global_load_b64 v[4:5], v[0:1], off offset:16
	s_waitcnt vmcnt(0)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[4:5]
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB0_21
; %bb.20:
	global_load_b32 v0, v[0:1], off offset:24
	v_mov_b32_e32 v1, 0
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s1, v0
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_store_b64 v[4:5], v[0:1], off
	s_and_b32 m0, s1, 0xff
	s_sendmsg sendmsg(MSG_INTERRUPT)
.LBB0_21:
	s_or_b32 exec_lo, exec_lo, s0
	v_dual_mov_b32 v0, v2 :: v_dual_mov_b32 v1, v3
	s_waitcnt lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_setpc_b64 s[30:31]
.Lfunc_end1:
	.size	__ockl_hsa_signal_cas, .Lfunc_end1-__ockl_hsa_signal_cas
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata
; Function info:
; codeLenInByte = 580
; NumSgprs: 34
; NumVgprs: 11
; ScratchSize: 0
; MemoryBound: 0
	.text
	.p2align	2                               ; -- Begin function __ockl_hsa_signal_store
	.type	__ockl_hsa_signal_store,@function
__ockl_hsa_signal_store:                ; @__ockl_hsa_signal_store
.Lfunc_begin2:
	.cfi_startproc
; %bb.0:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_load_b64 v[5:6], v[0:1], off
	s_mov_b32 s0, exec_lo
	s_waitcnt vmcnt(0)
	v_cmpx_ne_u64_e32 1, v[5:6]
	s_xor_b32 s0, exec_lo, s0
	s_cbranch_execnz .LBB2_3
; %bb.1:                                ; %Flow12
	s_and_not1_saveexec_b32 s0, s0
	s_cbranch_execnz .LBB2_4
.LBB2_2:                                ; %Flow13
	s_or_b32 exec_lo, exec_lo, s0
	s_waitcnt_vscnt null, 0x0
	s_setpc_b64 s[30:31]
.LBB2_3:
	global_load_b64 v[0:1], v[0:1], off offset:8
                                        ; implicit-def: $vgpr4
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_store_b64 v[0:1], v[2:3], off
                                        ; implicit-def: $vgpr0_vgpr1
                                        ; implicit-def: $vgpr2_vgpr3
	s_and_not1_saveexec_b32 s0, s0
	s_cbranch_execz .LBB2_2
.LBB2_4:                                ; %NodeBlock
	s_mov_b32 s1, 0
	s_mov_b32 s2, 0
	s_mov_b32 s3, exec_lo
	v_cmpx_lt_i32_e32 4, v4
	s_xor_b32 s3, exec_lo, s3
	s_cbranch_execz .LBB2_8
; %bb.5:                                ; %LeafBlock6
	s_mov_b32 s2, -1
	s_mov_b32 s4, exec_lo
	v_cmpx_eq_u32_e32 5, v4
	s_cbranch_execz .LBB2_7
; %bb.6:
	s_xor_b32 s2, exec_lo, -1
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_store_b64 v[0:1], v[2:3], off offset:8
.LBB2_7:                                ; %Flow9
	s_or_b32 exec_lo, exec_lo, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s2, s2, exec_lo
                                        ; implicit-def: $vgpr4
.LBB2_8:                                ; %Flow8
	s_and_not1_saveexec_b32 s3, s3
; %bb.9:                                ; %LeafBlock
	v_cmp_ne_u32_e32 vcc_lo, 3, v4
	s_and_not1_b32 s2, s2, exec_lo
	s_mov_b32 s1, exec_lo
	s_and_b32 s4, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s2, s2, s4
; %bb.10:                               ; %Flow10
	s_or_b32 exec_lo, exec_lo, s3
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB2_12
; %bb.11:
	s_and_not1_b32 s1, s1, exec_lo
	global_store_b64 v[0:1], v[2:3], off offset:8
.LBB2_12:                               ; %Flow11
	s_or_b32 exec_lo, exec_lo, s3
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB2_14
; %bb.13:
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_store_b64 v[0:1], v[2:3], off offset:8
.LBB2_14:
	s_or_b32 exec_lo, exec_lo, s2
	global_load_b64 v[2:3], v[0:1], off offset:16
	s_mov_b32 s1, exec_lo
	s_waitcnt vmcnt(0)
	v_cmpx_ne_u64_e32 0, v[2:3]
	s_cbranch_execz .LBB2_16
; %bb.15:
	global_load_b32 v0, v[0:1], off offset:24
	v_mov_b32_e32 v1, 0
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s2, v0
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_store_b64 v[2:3], v[0:1], off
	s_and_b32 m0, s2, 0xff
	s_sendmsg sendmsg(MSG_INTERRUPT)
.LBB2_16:                               ; %Flow
	s_or_b32 exec_lo, exec_lo, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s0
	s_waitcnt lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_setpc_b64 s[30:31]
.Lfunc_end2:
	.size	__ockl_hsa_signal_store, .Lfunc_end2-__ockl_hsa_signal_store
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata
; Function info:
; codeLenInByte = 340
; NumSgprs: 34
; NumVgprs: 7
; ScratchSize: 0
; MemoryBound: 0
	.text
	.globl	_Z6kernel                       ; -- Begin function _Z6kernel
	.p2align	8
	.type	_Z6kernel,@function
_Z6kernel:                              ; @_Z6kernel
.Lfunc_begin3:
	.file	1 "." "/home/pxlth/.julia/dev/AMDGPU/t.jl"
	.loc	1 3 0                           ; /home/pxlth/.julia/dev/AMDGPU/t.jl:3:0
	.cfi_startproc
; %bb.0:                                ; %conversion
	.file	2 "." "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl"
	.loc	2 39 0 prologue_end             ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	s_clause 0x1
	s_load_b64 s[2:3], s[0:1], 0x48
	s_load_b64 s[10:11], s[0:1], 0x0
	v_mov_b32_e32 v3, 0
.Ltmp0:
	.file	3 "." "promotion.jl"
	.loc	3 639 0                         ; promotion.jl:639:0
	v_cmp_eq_u32_e64 s8, 0, v0
	s_mov_b32 s9, 0
	s_mov_b32 s0, -1
	s_mov_b32 s12, 0
	s_mov_b32 s32, 0
.Ltmp1:
	.loc	2 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v1, s2 :: v_dual_mov_b32 v2, s3
.Ltmp2:
	.loc	2 39 0 is_stmt 0                ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	ds_store_b64 v3, v[1:2]
.Ltmp3:
	.file	4 "." "pointer.jl"
	.loc	4 153 0 is_stmt 1               ; pointer.jl:153:0
	s_clause 0xf
	flat_load_u8 v3, v[1:2] offset:4
	flat_load_u8 v4, v[1:2] offset:5
	flat_load_u8 v5, v[1:2] offset:6
	flat_load_u8 v6, v[1:2] offset:7
	flat_load_u8 v7, v[1:2]
	flat_load_u8 v8, v[1:2] offset:1
	flat_load_u8 v9, v[1:2] offset:2
	flat_load_u8 v10, v[1:2] offset:3
	flat_load_u8 v13, v[1:2] offset:13
	flat_load_u8 v14, v[1:2] offset:14
	flat_load_u8 v15, v[1:2] offset:15
	flat_load_u8 v16, v[1:2] offset:8
	flat_load_u8 v17, v[1:2] offset:9
	flat_load_u8 v18, v[1:2] offset:10
	flat_load_u8 v20, v[1:2] offset:12
	flat_load_u8 v19, v[1:2] offset:11
	s_waitcnt vmcnt(14) lgkmcnt(14)
	v_lshl_or_b32 v1, v4, 8, v3
	s_waitcnt vmcnt(12) lgkmcnt(12)
	v_lshl_or_b32 v2, v6, 8, v5
	s_waitcnt vmcnt(10) lgkmcnt(10)
	v_lshl_or_b32 v3, v8, 8, v7
	s_waitcnt vmcnt(8) lgkmcnt(8)
	v_lshl_or_b32 v4, v10, 8, v9
	v_lshl_or_b32 v11, v2, 16, v1
	s_delay_alu instid0(VALU_DEP_2)
	v_lshl_or_b32 v12, v4, 16, v3
.Ltmp4:
	.file	5 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl"
	.loc	5 30 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s14, s8
	s_cbranch_execz .LBB3_10
; %bb.1:                                ; %L26.preheader
	.loc	5 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:0:0
	s_mov_b32 s15, 0
	s_getpc_b64 s[12:13]
	s_add_u32 s12, s12, __ockl_hsa_signal_cas@rel32@lo+4
	s_addc_u32 s13, s13, __ockl_hsa_signal_cas@rel32@hi+12
                                        ; implicit-def: $sgpr16
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB3_3
	.p2align	6
.LBB3_2:                                ; %Flow18
                                        ;   in Loop: Header=BB3_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s3
	s_xor_b32 s0, s0, -1
	s_and_b32 s1, exec_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s15, s1, s15
	s_and_not1_b32 s1, s16, exec_lo
	s_and_b32 s0, s0, exec_lo
	s_or_b32 s16, s1, s0
	s_and_not1_b32 exec_lo, exec_lo, s15
	s_cbranch_execz .LBB3_9
.LBB3_3:                                ; %L26
                                        ; =>This Inner Loop Header: Depth=1
.Ltmp5:
	.file	6 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl"
	.loc	6 27 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27:0
	v_dual_mov_b32 v0, v12 :: v_dual_mov_b32 v1, v11
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v3, 0
	v_dual_mov_b32 v4, 1 :: v_dual_mov_b32 v5, 0
	v_mov_b32_e32 v6, 4
	s_swappc_b64 s[30:31], s[12:13]
	s_mov_b32 s1, 0
	s_mov_b32 s2, exec_lo
                                        ; implicit-def: $sgpr0
	v_cmpx_lt_i64_e32 4, v[0:1]
	s_xor_b32 s2, exec_lo, s2
.Ltmp6:
; %bb.4:                                ; %LeafBlock3
                                        ;   in Loop: Header=BB3_3 Depth=1
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	v_cmp_lt_i64_e32 vcc_lo, 6, v[0:1]
	s_mov_b32 s0, -1
                                        ; implicit-def: $vgpr0_vgpr1
	s_and_b32 s1, vcc_lo, exec_lo
; %bb.5:                                ; %Flow16
                                        ;   in Loop: Header=BB3_3 Depth=1
	s_and_not1_saveexec_b32 s2, s2
; %bb.6:                                ; %LeafBlock
                                        ;   in Loop: Header=BB3_3 Depth=1
	v_cmp_ne_u64_e32 vcc_lo, 0, v[0:1]
	s_and_not1_b32 s1, s1, exec_lo
	s_and_not1_b32 s0, s0, exec_lo
	s_and_b32 s3, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s1, s1, s3
; %bb.7:                                ; %Flow17
                                        ;   in Loop: Header=BB3_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s2
	s_mov_b32 s2, -1
	s_and_saveexec_b32 s3, s1
	s_cbranch_execz .LBB3_2
; %bb.8:                                ; %L42
                                        ;   in Loop: Header=BB3_3 Depth=1
	s_and_not1_b32 s0, s0, exec_lo
	s_xor_b32 s2, exec_lo, -1
.Ltmp7:
	.loc	6 108 0 is_stmt 1               ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108:0
	s_sleep 5
	s_branch .LBB3_2
.Ltmp8:
.LBB3_9:                                ; %loop.exit.guard
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_set_inst_prefetch_distance 0x2
	s_or_b32 exec_lo, exec_lo, s15
	s_delay_alu instid0(SALU_CYCLE_1)
	s_mov_b32 s12, exec_lo
	s_or_not1_b32 s0, s16, exec_lo
.LBB3_10:                               ; %Flow20
	s_or_b32 exec_lo, exec_lo, s14
	.loc	5 30 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s13, s0
	s_cbranch_execz .LBB3_36
.Ltmp9:
; %bb.11:                               ; %L46
	.loc	5 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:0:0
	s_waitcnt vmcnt(1) lgkmcnt(1)
	v_lshl_or_b32 v0, v13, 8, v20
	v_lshl_or_b32 v1, v15, 8, v14
	v_lshl_or_b32 v2, v17, 8, v16
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v3, v19, 8, v18
	s_mov_b32 s1, 0
	v_mov_b32_e32 v5, 0
	v_lshl_or_b32 v4, v1, 16, v0
.Ltmp10:
	.loc	2 39 0 is_stmt 1                ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_mov_b32_e32 v0, 0x6c6c6548
	v_lshl_or_b32 v3, v3, 16, v2
	v_mov_b32_e32 v2, 0x21646c72
	v_mov_b32_e32 v1, 0x6f57206f
	s_mov_b32 s2, -1
	s_mov_b32 s0, 0
.Ltmp11:
	.file	7 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl"
	.loc	7 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
.Ltmp12:
	.loc	7 28 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28:0
	s_barrier
.Ltmp13:
	.loc	7 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
.Ltmp14:
	.loc	2 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	s_clause 0x1
	global_store_b96 v[3:4], v[0:2], off
	global_store_b8 v[3:4], v5, off offset:12
.Ltmp15:
	.loc	5 30 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s14, s8
	s_cbranch_execz .LBB3_32
; %bb.12:                               ; %L76.preheader
	.loc	5 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:0:0
	s_mov_b32 s16, 0
	s_getpc_b64 s[8:9]
	s_add_u32 s8, s8, __ockl_hsa_signal_cas@rel32@lo+4
	s_addc_u32 s9, s9, __ockl_hsa_signal_cas@rel32@hi+12
                                        ; implicit-def: $sgpr15
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB3_14
	.p2align	6
.LBB3_13:                               ; %Flow15
                                        ;   in Loop: Header=BB3_14 Depth=1
	s_or_b32 exec_lo, exec_lo, s3
	s_xor_b32 s0, s0, -1
	s_and_b32 s1, exec_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s16, s1, s16
	s_and_not1_b32 s1, s15, exec_lo
	s_and_b32 s0, s0, exec_lo
	s_or_b32 s15, s1, s0
	s_and_not1_b32 exec_lo, exec_lo, s16
	s_cbranch_execz .LBB3_20
.LBB3_14:                               ; %L76
                                        ; =>This Inner Loop Header: Depth=1
.Ltmp16:
	.loc	6 27 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27:0
	v_dual_mov_b32 v0, v12 :: v_dual_mov_b32 v1, v11
	v_dual_mov_b32 v2, 1 :: v_dual_mov_b32 v3, 0
	v_dual_mov_b32 v4, 2 :: v_dual_mov_b32 v5, 0
	v_mov_b32_e32 v6, 4
	s_swappc_b64 s[30:31], s[8:9]
	s_mov_b32 s1, 0
	s_mov_b32 s2, exec_lo
                                        ; implicit-def: $sgpr0
	v_cmpx_lt_i64_e32 4, v[0:1]
	s_xor_b32 s2, exec_lo, s2
.Ltmp17:
; %bb.15:                               ; %LeafBlock7
                                        ;   in Loop: Header=BB3_14 Depth=1
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	v_cmp_lt_i64_e32 vcc_lo, 6, v[0:1]
	s_mov_b32 s0, -1
                                        ; implicit-def: $vgpr0_vgpr1
	s_and_b32 s1, vcc_lo, exec_lo
; %bb.16:                               ; %Flow13
                                        ;   in Loop: Header=BB3_14 Depth=1
	s_and_not1_saveexec_b32 s2, s2
; %bb.17:                               ; %LeafBlock5
                                        ;   in Loop: Header=BB3_14 Depth=1
	v_cmp_ne_u64_e32 vcc_lo, 1, v[0:1]
	s_and_not1_b32 s1, s1, exec_lo
	s_and_not1_b32 s0, s0, exec_lo
	s_and_b32 s3, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s1, s1, s3
; %bb.18:                               ; %Flow14
                                        ;   in Loop: Header=BB3_14 Depth=1
	s_or_b32 exec_lo, exec_lo, s2
	s_mov_b32 s2, -1
	s_and_saveexec_b32 s3, s1
	s_cbranch_execz .LBB3_13
; %bb.19:                               ; %L92
                                        ;   in Loop: Header=BB3_14 Depth=1
	s_and_not1_b32 s0, s0, exec_lo
	s_xor_b32 s2, exec_lo, -1
.Ltmp18:
	.loc	6 108 0 is_stmt 1               ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108:0
	s_sleep 5
	s_branch .LBB3_13
.Ltmp19:
.LBB3_20:                               ; %loop.exit.guard11
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_set_inst_prefetch_distance 0x2
	s_or_b32 exec_lo, exec_lo, s16
	s_mov_b32 s1, -1
	s_mov_b32 s2, 0
	s_mov_b32 s0, 0
	s_and_saveexec_b32 s3, s15
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s6, exec_lo, s3
	s_cbranch_execz .LBB3_31
; %bb.21:                               ; %L95
.Ltmp20:
	.loc	6 12 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12:0
	v_dual_mov_b32 v0, v12 :: v_dual_mov_b32 v1, v11
	v_mov_b32_e32 v2, 2
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, __ockl_hsa_signal_load@rel32@lo+4
	s_addc_u32 s5, s5, __ockl_hsa_signal_load@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1)
	s_swappc_b64 s[30:31], s[4:5]
	s_mov_b32 s0, -1
	s_mov_b32 s7, 0
	s_mov_b32 s9, 0
.Ltmp21:
	.loc	6 62 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62:0
	s_mov_b32 s8, exec_lo
.Ltmp22:
	.loc	3 639 0                         ; promotion.jl:639:0
	v_cmpx_ne_u64_e32 4, v[0:1]
	s_cbranch_execz .LBB3_28
.Ltmp23:
; %bb.22:                               ; %L100.preheader
	.loc	3 0 0 is_stmt 0                 ; promotion.jl:0:0
	s_mov_b32 s15, 0
                                        ; implicit-def: $sgpr9
                                        ; implicit-def: $sgpr17
                                        ; implicit-def: $sgpr16
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB3_24
	.p2align	6
.LBB3_23:                               ; %Flow
                                        ;   in Loop: Header=BB3_24 Depth=1
	s_or_b32 exec_lo, exec_lo, s18
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_and_b32 s0, exec_lo, s17
	s_or_b32 s15, s0, s15
	s_and_not1_b32 s0, s9, exec_lo
	s_and_b32 s1, s16, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s9, s0, s1
	.loc	6 64 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64:0
	s_and_not1_b32 exec_lo, exec_lo, s15
	s_cbranch_execz .LBB3_26
.LBB3_24:                               ; %L100
                                        ; =>This Inner Loop Header: Depth=1
	v_add_co_u32 v0, vcc_lo, v0, -5
	v_add_co_ci_u32_e32 v1, vcc_lo, -1, v1, vcc_lo
	s_or_b32 s16, s16, exec_lo
	s_or_b32 s17, s17, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_lt_u64_e32 vcc_lo, 1, v[0:1]
                                        ; implicit-def: $vgpr0_vgpr1
	s_and_saveexec_b32 s18, vcc_lo
	s_cbranch_execz .LBB3_23
; %bb.25:                               ; %L112
                                        ;   in Loop: Header=BB3_24 Depth=1
.Ltmp24:
	.loc	6 12 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12:0
	v_dual_mov_b32 v0, v12 :: v_dual_mov_b32 v1, v11
	v_mov_b32_e32 v2, 2
.Ltmp25:
	.loc	6 108 0                         ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108:0
	s_sleep 5
.Ltmp26:
	.loc	6 12 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12:0
	s_swappc_b64 s[30:31], s[4:5]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
.Ltmp27:
	.loc	3 639 0                         ; promotion.jl:639:0
	v_cmp_eq_u64_e32 vcc_lo, 4, v[0:1]
	s_and_not1_b32 s0, s17, exec_lo
	s_and_not1_b32 s16, s16, exec_lo
	s_and_b32 s1, vcc_lo, exec_lo
	s_or_b32 s17, s0, s1
.Ltmp28:
	.loc	6 62 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62:0
	s_branch .LBB3_23
.LBB3_26:                               ; %loop.exit.guard12
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_set_inst_prefetch_distance 0x2
	s_or_b32 exec_lo, exec_lo, s15
	s_mov_b32 s0, -1
	s_mov_b32 s2, 0
	s_and_saveexec_b32 s1, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s1, exec_lo, s1
	s_cbranch_execnz .LBB3_42
.LBB3_27:                               ; %Flow25
	s_or_b32 exec_lo, exec_lo, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s9, s2, exec_lo
	s_or_not1_b32 s0, s0, exec_lo
.LBB3_28:                               ; %Flow24
	s_or_b32 exec_lo, exec_lo, s8
	.loc	6 62 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62:0
	s_and_saveexec_b32 s5, s0
	s_cbranch_execz .LBB3_30
.Ltmp29:
; %bb.29:                               ; %L115
	.loc	6 19 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19:0
	v_dual_mov_b32 v0, v12 :: v_dual_mov_b32 v1, v11
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v3, 0
	v_mov_b32_e32 v4, 3
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, __ockl_hsa_signal_store@rel32@lo+4
	s_addc_u32 s1, s1, __ockl_hsa_signal_store@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1)
	s_swappc_b64 s[30:31], s[0:1]
	s_mov_b32 s7, exec_lo
.Ltmp30:
.LBB3_30:                               ; %Flow26
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_or_b32 exec_lo, exec_lo, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s0, s9, exec_lo
	s_xor_b32 s1, exec_lo, -1
	s_and_b32 s2, s7, exec_lo
.LBB3_31:                               ; %Flow23
	s_or_b32 exec_lo, exec_lo, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s0, s0, exec_lo
	s_and_b32 s1, s1, exec_lo
	s_or_not1_b32 s2, s2, exec_lo
.LBB3_32:                               ; %Flow22
	s_or_b32 exec_lo, exec_lo, s14
	.loc	5 30 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB3_34
; %bb.33:                               ; %L117
.Ltmp31:
	.loc	7 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
.Ltmp32:
	.loc	7 28 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28:0
	s_barrier
.Ltmp33:
	.loc	7 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
.Ltmp34:
.LBB3_34:                               ; %Flow27
	.loc	7 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:0:0
	s_or_b32 exec_lo, exec_lo, s3
	.loc	5 30 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s2, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s1, exec_lo, s2
	s_cbranch_execnz .LBB3_41
.Ltmp35:
.LBB3_35:                               ; %Flow28
	.loc	5 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:0:0
	s_or_b32 exec_lo, exec_lo, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s9, s0, exec_lo
	s_and_not1_b32 s12, s12, exec_lo
.LBB3_36:                               ; %Flow21
	s_or_b32 exec_lo, exec_lo, s13
.Ltmp36:
	.loc	5 30 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s0, s12
	s_cbranch_execnz .LBB3_40
.LBB3_37:                               ; %Flow29
	.loc	5 0 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:0:0
	s_or_b32 exec_lo, exec_lo, s0
	.loc	5 30 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s0, s9
; %bb.38:                               ; %UnifiedUnreachableBlock
	; divergent unreachable
; %bb.39:                               ; %UnifiedReturnBlock
	.loc	5 0 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:0:0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
.LBB3_40:                               ; %L37
.Ltmp37:
	.loc	2 39 0 is_stmt 1                ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_dual_mov_b32 v0, s10 :: v_dual_mov_b32 v3, 1
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s11
.Ltmp38:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x3
	flat_store_b8 v[0:1], v2 offset:3
	flat_store_b8 v[0:1], v2 offset:2
	flat_store_b8 v[0:1], v2 offset:1
	flat_store_b8 v[0:1], v3
.Ltmp39:
	.file	8 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl"
	.loc	8 6 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6:0
	s_endpgm
	s_or_b32 s9, s9, exec_lo
	s_branch .LBB3_37
.Ltmp40:
.LBB3_41:                               ; %L87
	.loc	2 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_dual_mov_b32 v0, s10 :: v_dual_mov_b32 v3, 1
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s11
.Ltmp41:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x3
	flat_store_b8 v[0:1], v2 offset:3
	flat_store_b8 v[0:1], v2 offset:2
	flat_store_b8 v[0:1], v2 offset:1
	flat_store_b8 v[0:1], v3
.Ltmp42:
	.loc	8 6 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6:0
	s_endpgm
	s_or_b32 s0, s0, exec_lo
	s_branch .LBB3_35
.Ltmp43:
.LBB3_42:                               ; %L107
	.loc	2 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_dual_mov_b32 v0, s10 :: v_dual_mov_b32 v3, 1
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s11
.Ltmp44:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x3
	flat_store_b8 v[0:1], v2 offset:3
	flat_store_b8 v[0:1], v2 offset:2
	flat_store_b8 v[0:1], v2 offset:1
	flat_store_b8 v[0:1], v3
.Ltmp45:
	.loc	8 6 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6:0
	s_endpgm
	s_mov_b32 s2, exec_lo
	s_xor_b32 s0, exec_lo, -1
	s_branch .LBB3_27
.Ltmp46:
	.section	.rodata,#alloc
	.p2align	6, 0x0
	.amdhsa_kernel _Z6kernel
		.amdhsa_group_segment_fixed_size 8
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 88
		.amdhsa_user_sgpr_count 15
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 21
		.amdhsa_next_free_sgpr 33
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
.Lfunc_end3:
	.size	_Z6kernel, .Lfunc_end3-_Z6kernel
	.cfi_endproc
	.file	9 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl"
	.file	10 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl"
	.file	11 "." "none"
	.file	12 "." "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl"
	.file	13 "." "operators.jl"
	.file	14 "." "int.jl"
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 1552
; NumSgprs: 35
; NumVgprs: 21
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 8 bytes/workgroup (compile time only)
; SGPRBlocks: 4
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 35
; NumVGPRsForWavesPerEU: 21
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 15
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.p2alignl 7, 3214868480
	.fill 96, 4, 3214868480
	.type	__unnamed_1,@object             ; @0
	.section	.rodata.str1.1,"aMS",@progbits,1
__unnamed_1:
	.asciz	"Hello World!"
	.size	__unnamed_1, 13

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
	.byte	0                               ; DW_CHILDREN_no
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
	.byte	5                               ; DW_FORM_data2
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
	.byte	5                               ; DW_FORM_data2
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
	.byte	1                               ; Abbrev [1] 0xb:0x5c5 DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string0                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string1                  ; DW_AT_comp_dir
	.quad	.Lfunc_begin3                   ; DW_AT_low_pc
	.long	.Lfunc_end3-.Lfunc_begin3       ; DW_AT_high_pc
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x30:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x36:0x6 DW_TAG_subprogram
	.long	.Linfo_string3                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x3c:0x6 DW_TAG_subprogram
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x42:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x48:0x6 DW_TAG_subprogram
	.long	.Linfo_string5                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x4e:0x6 DW_TAG_subprogram
	.long	.Linfo_string5                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x54:0x6 DW_TAG_subprogram
	.long	.Linfo_string6                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x5a:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x60:0x6 DW_TAG_subprogram
	.long	.Linfo_string7                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x66:0x6 DW_TAG_subprogram
	.long	.Linfo_string7                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x6c:0x6 DW_TAG_subprogram
	.long	.Linfo_string8                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x72:0x6 DW_TAG_subprogram
	.long	.Linfo_string9                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x78:0x6 DW_TAG_subprogram
	.long	.Linfo_string10                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x7e:0x6 DW_TAG_subprogram
	.long	.Linfo_string11                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x84:0x6 DW_TAG_subprogram
	.long	.Linfo_string12                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x8a:0x6 DW_TAG_subprogram
	.long	.Linfo_string13                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x90:0x6 DW_TAG_subprogram
	.long	.Linfo_string14                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x96:0x6 DW_TAG_subprogram
	.long	.Linfo_string15                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x9c:0x6 DW_TAG_subprogram
	.long	.Linfo_string16                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xa2:0x6 DW_TAG_subprogram
	.long	.Linfo_string17                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xa8:0x6 DW_TAG_subprogram
	.long	.Linfo_string17                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xae:0x6 DW_TAG_subprogram
	.long	.Linfo_string18                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xb4:0x6 DW_TAG_subprogram
	.long	.Linfo_string19                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xba:0x6 DW_TAG_subprogram
	.long	.Linfo_string20                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xc0:0x6 DW_TAG_subprogram
	.long	.Linfo_string21                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xc6:0x6 DW_TAG_subprogram
	.long	.Linfo_string22                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xcc:0x6 DW_TAG_subprogram
	.long	.Linfo_string9                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xd2:0x6 DW_TAG_subprogram
	.long	.Linfo_string23                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	3                               ; Abbrev [3] 0xd8:0x4f7 DW_TAG_subprogram
	.quad	.Lfunc_begin3                   ; DW_AT_low_pc
	.long	.Lfunc_end3-.Lfunc_begin3       ; DW_AT_high_pc
	.long	.Linfo_string24                 ; DW_AT_name
	.byte	4                               ; Abbrev [4] 0xe9:0x4e5 DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.quad	.Lfunc_begin3                   ; DW_AT_low_pc
	.long	.Ltmp46-.Lfunc_begin3           ; DW_AT_high_pc
	.byte	1                               ; DW_AT_call_file
	.byte	3                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0xfc:0xa6 DW_TAG_inlined_subroutine
	.long	60                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges0                 ; DW_AT_ranges
	.byte	9                               ; DW_AT_call_file
	.byte	69                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x107:0x23 DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges1                 ; DW_AT_ranges
	.byte	10                              ; DW_AT_call_file
	.byte	71                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x112:0x17 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges2                 ; DW_AT_ranges
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x11d:0xb DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges3                 ; DW_AT_ranges
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x12a:0x77 DW_TAG_inlined_subroutine
	.long	114                             ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	74                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x13d:0x63 DW_TAG_inlined_subroutine
	.long	114                             ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	12                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x150:0x4f DW_TAG_inlined_subroutine
	.long	114                             ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	12                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x163:0x3b DW_TAG_inlined_subroutine
	.long	108                             ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	12                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x176:0x27 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x189:0x13 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x1a2:0x197 DW_TAG_inlined_subroutine
	.long	102                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges4                 ; DW_AT_ranges
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x1ad:0x18b DW_TAG_inlined_subroutine
	.long	96                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges5                 ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	53                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x1b8:0x17f DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges6                 ; DW_AT_ranges
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x1c3:0x173 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges7                 ; DW_AT_ranges
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x1ce:0x52 DW_TAG_inlined_subroutine
	.long	84                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	30                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x1e1:0x3e DW_TAG_inlined_subroutine
	.long	78                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.short	277                             ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x1f5:0x29 DW_TAG_inlined_subroutine
	.long	72                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.short	518                             ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x209:0x14 DW_TAG_inlined_subroutine
	.long	72                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.short	483                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x220:0xdb DW_TAG_inlined_subroutine
	.long	132                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges8                 ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	62                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x22b:0xcf DW_TAG_inlined_subroutine
	.long	132                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges9                 ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	36                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x236:0x13 DW_TAG_inlined_subroutine
	.long	126                             ; DW_AT_abstract_origin
	.quad	.Ltmp5                          ; DW_AT_low_pc
	.long	.Ltmp6-.Ltmp5                   ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	37                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x249:0x13 DW_TAG_inlined_subroutine
	.long	138                             ; DW_AT_abstract_origin
	.quad	.Ltmp7                          ; DW_AT_low_pc
	.long	.Ltmp8-.Ltmp7                   ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	46                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x25c:0x9d DW_TAG_inlined_subroutine
	.long	198                             ; DW_AT_abstract_origin
	.quad	.Ltmp37                         ; DW_AT_low_pc
	.long	.Ltmp40-.Ltmp37                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	41                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x26f:0x4f DW_TAG_inlined_subroutine
	.long	192                             ; DW_AT_abstract_origin
	.quad	.Ltmp37                         ; DW_AT_low_pc
	.long	.Ltmp38-.Ltmp37                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x282:0x3b DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.quad	.Ltmp37                         ; DW_AT_low_pc
	.long	.Ltmp38-.Ltmp37                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	11                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x295:0x27 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.quad	.Ltmp37                         ; DW_AT_low_pc
	.long	.Ltmp38-.Ltmp37                 ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x2a8:0x13 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp37                         ; DW_AT_low_pc
	.long	.Ltmp38-.Ltmp37                 ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x2be:0x27 DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp38                         ; DW_AT_low_pc
	.long	.Ltmp39-.Ltmp38                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x2d1:0x13 DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp38                         ; DW_AT_low_pc
	.long	.Ltmp39-.Ltmp38                 ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x2e5:0x13 DW_TAG_inlined_subroutine
	.long	210                             ; DW_AT_abstract_origin
	.quad	.Ltmp39                         ; DW_AT_low_pc
	.long	.Ltmp40-.Ltmp39                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x2fb:0x3a DW_TAG_inlined_subroutine
	.long	156                             ; DW_AT_abstract_origin
	.quad	.Ltmp11                         ; DW_AT_low_pc
	.long	.Ltmp14-.Ltmp11                 ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	47                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x30e:0x13 DW_TAG_inlined_subroutine
	.long	150                             ; DW_AT_abstract_origin
	.quad	.Ltmp11                         ; DW_AT_low_pc
	.long	.Ltmp12-.Ltmp11                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	27                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x321:0x13 DW_TAG_inlined_subroutine
	.long	150                             ; DW_AT_abstract_origin
	.quad	.Ltmp13                         ; DW_AT_low_pc
	.long	.Ltmp14-.Ltmp13                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	29                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x339:0x27 DW_TAG_inlined_subroutine
	.long	120                             ; DW_AT_abstract_origin
	.quad	.Ltmp3                          ; DW_AT_low_pc
	.long	.Ltmp4-.Ltmp3                   ; DW_AT_high_pc
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x34c:0x13 DW_TAG_inlined_subroutine
	.long	120                             ; DW_AT_abstract_origin
	.quad	.Ltmp3                          ; DW_AT_low_pc
	.long	.Ltmp4-.Ltmp3                   ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	153                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x360:0x23 DW_TAG_inlined_subroutine
	.long	144                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges10                ; DW_AT_ranges
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x36b:0x17 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges11                ; DW_AT_ranges
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x376:0xb DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges12                ; DW_AT_ranges
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x383:0x24a DW_TAG_inlined_subroutine
	.long	168                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges13                ; DW_AT_ranges
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x38e:0x23e DW_TAG_inlined_subroutine
	.long	162                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges14                ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	97                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x399:0x232 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges15                ; DW_AT_ranges
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x3a4:0x226 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges16                ; DW_AT_ranges
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x3af:0xdb DW_TAG_inlined_subroutine
	.long	132                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges17                ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x3ba:0xcf DW_TAG_inlined_subroutine
	.long	132                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges18                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	36                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x3c5:0x13 DW_TAG_inlined_subroutine
	.long	126                             ; DW_AT_abstract_origin
	.quad	.Ltmp16                         ; DW_AT_low_pc
	.long	.Ltmp17-.Ltmp16                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	37                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x3d8:0x13 DW_TAG_inlined_subroutine
	.long	138                             ; DW_AT_abstract_origin
	.quad	.Ltmp18                         ; DW_AT_low_pc
	.long	.Ltmp19-.Ltmp18                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	46                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x3eb:0x9d DW_TAG_inlined_subroutine
	.long	198                             ; DW_AT_abstract_origin
	.quad	.Ltmp40                         ; DW_AT_low_pc
	.long	.Ltmp43-.Ltmp40                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	41                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x3fe:0x4f DW_TAG_inlined_subroutine
	.long	192                             ; DW_AT_abstract_origin
	.quad	.Ltmp40                         ; DW_AT_low_pc
	.long	.Ltmp41-.Ltmp40                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x411:0x3b DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.quad	.Ltmp40                         ; DW_AT_low_pc
	.long	.Ltmp41-.Ltmp40                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	11                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x424:0x27 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.quad	.Ltmp40                         ; DW_AT_low_pc
	.long	.Ltmp41-.Ltmp40                 ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x437:0x13 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp40                         ; DW_AT_low_pc
	.long	.Ltmp41-.Ltmp40                 ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x44d:0x27 DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp41                         ; DW_AT_low_pc
	.long	.Ltmp42-.Ltmp41                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x460:0x13 DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp41                         ; DW_AT_low_pc
	.long	.Ltmp42-.Ltmp41                 ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x474:0x13 DW_TAG_inlined_subroutine
	.long	210                             ; DW_AT_abstract_origin
	.quad	.Ltmp42                         ; DW_AT_low_pc
	.long	.Ltmp43-.Ltmp42                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x48a:0xde DW_TAG_inlined_subroutine
	.long	180                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges19                ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	116                             ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x495:0xd2 DW_TAG_inlined_subroutine
	.long	180                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges20                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	60                              ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x4a0:0xb DW_TAG_inlined_subroutine
	.long	174                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges21                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	61                              ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x4ab:0xb DW_TAG_inlined_subroutine
	.long	72                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges22                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	62                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x4b6:0x13 DW_TAG_inlined_subroutine
	.long	138                             ; DW_AT_abstract_origin
	.quad	.Ltmp25                         ; DW_AT_low_pc
	.long	.Ltmp26-.Ltmp25                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x4c9:0x9d DW_TAG_inlined_subroutine
	.long	198                             ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp46-.Ltmp43                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	65                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x4dc:0x4f DW_TAG_inlined_subroutine
	.long	192                             ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp44-.Ltmp43                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x4ef:0x3b DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp44-.Ltmp43                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	11                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x502:0x27 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp44-.Ltmp43                 ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x515:0x13 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp44-.Ltmp43                 ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x52b:0x27 DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp44                         ; DW_AT_low_pc
	.long	.Ltmp45-.Ltmp44                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x53e:0x13 DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp44                         ; DW_AT_low_pc
	.long	.Ltmp45-.Ltmp44                 ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x552:0x13 DW_TAG_inlined_subroutine
	.long	210                             ; DW_AT_abstract_origin
	.quad	.Ltmp45                         ; DW_AT_low_pc
	.long	.Ltmp46-.Ltmp45                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x568:0x27 DW_TAG_inlined_subroutine
	.long	186                             ; DW_AT_abstract_origin
	.quad	.Ltmp29                         ; DW_AT_low_pc
	.long	.Ltmp30-.Ltmp29                 ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	128                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x57b:0x13 DW_TAG_inlined_subroutine
	.long	186                             ; DW_AT_abstract_origin
	.quad	.Ltmp29                         ; DW_AT_low_pc
	.long	.Ltmp30-.Ltmp29                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	19                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x58f:0x3a DW_TAG_inlined_subroutine
	.long	156                             ; DW_AT_abstract_origin
	.quad	.Ltmp31                         ; DW_AT_low_pc
	.long	.Ltmp34-.Ltmp31                 ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	47                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x5a2:0x13 DW_TAG_inlined_subroutine
	.long	150                             ; DW_AT_abstract_origin
	.quad	.Ltmp31                         ; DW_AT_low_pc
	.long	.Ltmp32-.Ltmp31                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	27                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x5b5:0x13 DW_TAG_inlined_subroutine
	.long	150                             ; DW_AT_abstract_origin
	.quad	.Ltmp33                         ; DW_AT_low_pc
	.long	.Ltmp34-.Ltmp33                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	29                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_ranges
.Ldebug_ranges0:
	.quad	.Lfunc_begin3-.Lfunc_begin3
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp3-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges1:
	.quad	.Lfunc_begin3-.Lfunc_begin3
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp2-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges2:
	.quad	.Lfunc_begin3-.Lfunc_begin3
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp2-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges3:
	.quad	.Lfunc_begin3-.Lfunc_begin3
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp2-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges4:
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp4-.Lfunc_begin3
	.quad	.Ltmp9-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp14-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges5:
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp4-.Lfunc_begin3
	.quad	.Ltmp9-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp14-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges6:
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp4-.Lfunc_begin3
	.quad	.Ltmp9-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp14-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges7:
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp4-.Lfunc_begin3
	.quad	.Ltmp9-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp14-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges8:
	.quad	.Ltmp5-.Lfunc_begin3
	.quad	.Ltmp8-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges9:
	.quad	.Ltmp5-.Lfunc_begin3
	.quad	.Ltmp8-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges10:
	.quad	.Ltmp10-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp14-.Lfunc_begin3
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges11:
	.quad	.Ltmp10-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp14-.Lfunc_begin3
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges12:
	.quad	.Ltmp10-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp14-.Lfunc_begin3
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges13:
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	.Ltmp35-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges14:
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	.Ltmp35-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges15:
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	.Ltmp35-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges16:
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	.Ltmp35-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges17:
	.quad	.Ltmp16-.Lfunc_begin3
	.quad	.Ltmp19-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges18:
	.quad	.Ltmp16-.Lfunc_begin3
	.quad	.Ltmp19-.Lfunc_begin3
	.quad	.Ltmp40-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges19:
	.quad	.Ltmp20-.Lfunc_begin3
	.quad	.Ltmp29-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges20:
	.quad	.Ltmp20-.Lfunc_begin3
	.quad	.Ltmp29-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges21:
	.quad	.Ltmp20-.Lfunc_begin3
	.quad	.Ltmp21-.Lfunc_begin3
	.quad	.Ltmp24-.Lfunc_begin3
	.quad	.Ltmp25-.Lfunc_begin3
	.quad	.Ltmp26-.Lfunc_begin3
	.quad	.Ltmp27-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges22:
	.quad	.Ltmp22-.Lfunc_begin3
	.quad	.Ltmp23-.Lfunc_begin3
	.quad	.Ltmp27-.Lfunc_begin3
	.quad	.Ltmp28-.Lfunc_begin3
	.quad	0
	.quad	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"julia"                         ; string offset=0
.Linfo_string1:
	.asciz	"."                             ; string offset=6
.Linfo_string2:
	.asciz	"macro expansion;"              ; string offset=8
.Linfo_string3:
	.asciz	"kernel_state;"                 ; string offset=25
.Linfo_string4:
	.asciz	"output_context;"               ; string offset=39
.Linfo_string5:
	.asciz	"==;"                           ; string offset=55
.Linfo_string6:
	.asciz	"!=;"                           ; string offset=59
.Linfo_string7:
	.asciz	"hostcall_device_lock!;"        ; string offset=63
.Linfo_string8:
	.asciz	"pointerset;"                   ; string offset=86
.Linfo_string9:
	.asciz	"unsafe_store!;"                ; string offset=98
.Linfo_string10:
	.asciz	"unsafe_load;"                  ; string offset=113
.Linfo_string11:
	.asciz	"device_signal_cas!;"           ; string offset=126
.Linfo_string12:
	.asciz	"hostcall_device_signal_wait_cas!;" ; string offset=146
.Linfo_string13:
	.asciz	"device_sleep;"                 ; string offset=180
.Linfo_string14:
	.asciz	"memcpy!;"                      ; string offset=194
.Linfo_string15:
	.asciz	"fence;"                        ; string offset=203
.Linfo_string16:
	.asciz	"sync_workgroup;"               ; string offset=210
.Linfo_string17:
	.asciz	"hostcall_device_trigger_and_return!;" ; string offset=226
.Linfo_string18:
	.asciz	"device_signal_load;"           ; string offset=263
.Linfo_string19:
	.asciz	"hostcall_device_signal_wait;"  ; string offset=283
.Linfo_string20:
	.asciz	"device_signal_store!;"         ; string offset=312
.Linfo_string21:
	.asciz	"exception_flag;"               ; string offset=334
.Linfo_string22:
	.asciz	"signal_exception;"             ; string offset=350
.Linfo_string23:
	.asciz	"endpgm;"                       ; string offset=368
.Linfo_string24:
	.asciz	"kernel"                        ; string offset=376
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.section	".note.GNU-stack"
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .name:           state
        .offset:         0
        .size:           88
        .value_kind:     by_value
    .group_segment_fixed_size: 8
    .kernarg_segment_align: 8
    .kernarg_segment_size: 88
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z6kernel
    .private_segment_fixed_size: 0
    .sgpr_count:     35
    .sgpr_spill_count: 0
    .symbol:         _Z6kernel.kd
    .vgpr_count:     21
    .vgpr_spill_count: 0
    .wavefront_size: 32
amdhsa.target:   amdgcn-amd-amdhsa--gfx1100
amdhsa.version:
  - 1
  - 1
...

	.end_amdgpu_metadata
	.section	.debug_line
.Lline_table_start0:
