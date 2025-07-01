	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1100"
	.amdhsa_code_object_version 5
	.p2align	2                               ; -- Begin function __ockl_hsa_signal_load
	.type	__ockl_hsa_signal_load,@function
__ockl_hsa_signal_load:                 ; @__ockl_hsa_signal_load
.Lfunc_begin0:
	.cfi_sections .debug_frame
	.cfi_startproc
; %bb.0:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
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
	.section	.AMDGPU.csdata,"",@progbits
; Function info:
; codeLenInByte = 208
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
	v_dual_mov_b32 v8, v5 :: v_dual_mov_b32 v7, v4
	v_dual_mov_b32 v10, v3 :: v_dual_mov_b32 v9, v2
	s_mov_b32 s1, 0
	s_mov_b32 s2, 0
	s_mov_b32 s3, exec_lo
                                        ; implicit-def: $sgpr0
                                        ; implicit-def: $vgpr2_vgpr3
	v_cmpx_lt_i32_e32 3, v6
	s_xor_b32 s3, exec_lo, s3
	s_cbranch_execz .LBB0_8
; %bb.1:                                ; %NodeBlock12
	s_mov_b32 s0, exec_lo
                                        ; implicit-def: $sgpr4
                                        ; implicit-def: $vgpr2_vgpr3
	v_cmpx_lt_i32_e32 4, v6
	s_xor_b32 s0, exec_lo, s0
	s_cbranch_execz .LBB0_5
; %bb.2:                                ; %LeafBlock10
	s_mov_b32 s5, -1
	s_mov_b32 s2, exec_lo
                                        ; implicit-def: $sgpr4
                                        ; implicit-def: $vgpr2_vgpr3
	v_cmpx_eq_u32_e32 5, v6
	s_cbranch_execz .LBB0_4
; %bb.3:
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
	s_and_not1_saveexec_b32 s0, s0
	s_cbranch_execz .LBB0_7
; %bb.6:
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
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s0, s4, exec_lo
	s_and_b32 s2, s2, exec_lo
                                        ; implicit-def: $vgpr6
.LBB0_8:                                ; %Flow16
	s_and_not1_saveexec_b32 s3, s3
	s_cbranch_execz .LBB0_14
; %bb.9:                                ; %NodeBlock
	s_mov_b32 s4, exec_lo
                                        ; implicit-def: $sgpr1
                                        ; implicit-def: $vgpr2_vgpr3
	v_cmpx_lt_i32_e32 2, v6
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_11
; %bb.10:
	s_waitcnt_vscnt null, 0x0
	global_atomic_cmpswap_b64 v[2:3], v[0:1], v[7:10], off offset:8 glc
                                        ; implicit-def: $vgpr6
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e32 vcc_lo, v[2:3], v[9:10]
	s_and_b32 s1, vcc_lo, exec_lo
.LBB0_11:                               ; %Flow21
	s_or_saveexec_b32 s5, s4
	s_mov_b32 s4, 0
	s_mov_b32 s6, s2
	s_xor_b32 exec_lo, exec_lo, s5
; %bb.12:                               ; %LeafBlock
	v_cmp_gt_i32_e32 vcc_lo, 1, v6
	s_and_not1_b32 s6, s2, exec_lo
	s_mov_b32 s4, exec_lo
	s_and_not1_b32 s1, s1, exec_lo
                                        ; implicit-def: $vgpr2_vgpr3
	s_and_b32 s7, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s6, s6, s7
; %bb.13:                               ; %Flow22
	s_or_b32 exec_lo, exec_lo, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 s0, s0, exec_lo
	s_and_b32 s1, s1, exec_lo
	s_and_not1_b32 s2, s2, exec_lo
	s_and_b32 s5, s6, exec_lo
	s_or_b32 s0, s0, s1
	s_and_b32 s1, s4, exec_lo
	s_or_b32 s2, s2, s5
.LBB0_14:                               ; %Flow20
	s_or_b32 exec_lo, exec_lo, s3
	s_and_saveexec_b32 s3, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s2, exec_lo, s3
	s_cbranch_execz .LBB0_16
; %bb.15:
	global_atomic_cmpswap_b64 v[2:3], v[0:1], v[7:10], off offset:8 glc
	s_and_not1_b32 s0, s0, exec_lo
	s_and_not1_b32 s1, s1, exec_lo
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e32 vcc_lo, v[2:3], v[9:10]
	s_and_b32 s3, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s0, s0, s3
.LBB0_16:                               ; %Flow23
	s_or_b32 exec_lo, exec_lo, s2
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB0_18
; %bb.17:
	global_atomic_cmpswap_b64 v[2:3], v[0:1], v[7:10], off offset:8 glc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	s_and_not1_b32 s0, s0, exec_lo
	v_cmp_eq_u64_e32 vcc_lo, v[2:3], v[9:10]
	s_and_b32 s1, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s0, s0, s1
.LBB0_18:
	s_or_b32 exec_lo, exec_lo, s2
	s_and_saveexec_b32 s1, s0
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
	v_readfirstlane_b32 s0, v0
	s_waitcnt_vscnt null, 0x0
	global_store_b64 v[4:5], v[0:1], off
	s_and_b32 m0, s0, 0xff
	s_sendmsg sendmsg(MSG_INTERRUPT)
.LBB0_21:
	s_or_b32 exec_lo, exec_lo, s1
	v_dual_mov_b32 v0, v2 :: v_dual_mov_b32 v1, v3
	s_waitcnt lgkmcnt(0)
	s_setpc_b64 s[30:31]
.Lfunc_end1:
	.size	__ockl_hsa_signal_cas, .Lfunc_end1-__ockl_hsa_signal_cas
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata,"",@progbits
; Function info:
; codeLenInByte = 556
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
	global_load_b64 v[5:6], v[0:1], off
	s_mov_b32 s0, exec_lo
	s_waitcnt vmcnt(0)
	v_cmpx_ne_u64_e32 1, v[5:6]
	s_xor_b32 s0, exec_lo, s0
	s_cbranch_execnz .LBB2_3
; %bb.1:                                ; %Flow14
	s_and_not1_saveexec_b32 s0, s0
	s_cbranch_execnz .LBB2_4
.LBB2_2:                                ; %Flow15
	s_or_b32 exec_lo, exec_lo, s0
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
; %bb.5:                                ; %LeafBlock8
	s_mov_b32 s2, -1
	s_mov_b32 s4, exec_lo
	v_cmpx_eq_u32_e32 5, v4
	s_cbranch_execz .LBB2_7
; %bb.6:
	s_xor_b32 s2, exec_lo, -1
	s_waitcnt_vscnt null, 0x0
	global_store_b64 v[0:1], v[2:3], off offset:8
.LBB2_7:                                ; %Flow11
	s_or_b32 exec_lo, exec_lo, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s2, s2, exec_lo
                                        ; implicit-def: $vgpr4
.LBB2_8:                                ; %Flow10
	s_and_not1_saveexec_b32 s3, s3
; %bb.9:                                ; %LeafBlock
	v_cmp_ne_u32_e32 vcc_lo, 3, v4
	s_and_not1_b32 s2, s2, exec_lo
	s_mov_b32 s1, exec_lo
	s_and_b32 s4, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s2, s2, s4
; %bb.10:                               ; %Flow12
	s_or_b32 exec_lo, exec_lo, s3
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB2_12
; %bb.11:
	s_and_not1_b32 s1, s1, exec_lo
	global_store_b64 v[0:1], v[2:3], off offset:8
.LBB2_12:                               ; %Flow13
	s_or_b32 exec_lo, exec_lo, s3
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB2_14
; %bb.13:
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
	s_waitcnt_vscnt null, 0x0
	global_store_b64 v[2:3], v[0:1], off
	s_and_b32 m0, s2, 0xff
	s_sendmsg sendmsg(MSG_INTERRUPT)
.LBB2_16:                               ; %Flow
	s_or_b32 exec_lo, exec_lo, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s0
	s_waitcnt lgkmcnt(0)
	s_setpc_b64 s[30:31]
.Lfunc_end2:
	.size	__ockl_hsa_signal_store, .Lfunc_end2-__ockl_hsa_signal_store
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata,"",@progbits
; Function info:
; codeLenInByte = 316
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
	s_clause 0x1
	s_load_b64 s[4:5], s[2:3], 0x48
	s_load_b64 s[10:11], s[2:3], 0x0
	v_mov_b32_e32 v3, 0
	s_load_b64 s[0:1], s[0:1], 0x4
	v_and_b32_e32 v11, 0x3ff, v0
	v_bfe_u32 v12, v0, 10, 10
	v_bfe_u32 v0, v0, 20, 10
	s_mov_b32 s9, 0
	s_mov_b32 s12, 0
.Ltmp0:
	.file	2 "." "promotion.jl"
	.loc	2 637 0 prologue_end            ; promotion.jl:637:0
	v_cmp_eq_u32_e64 s8, 0, v11
	s_mov_b32 s32, 0
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v1, s4 :: v_dual_mov_b32 v2, s5
	s_lshr_b32 s0, s0, 16
	v_mul_u32_u24_e32 v12, s1, v12
	s_mul_i32 s0, s0, s1
.Ltmp1:
	.file	3 "." "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl"
	.loc	3 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	ds_store_b64 v3, v[1:2]
.Ltmp2:
	.file	4 "." "pointer.jl"
	.loc	4 151 0                         ; pointer.jl:151:0
	s_clause 0x7
	flat_load_u8 v3, v[1:2] offset:20
	flat_load_u8 v4, v[1:2] offset:21
	flat_load_u8 v5, v[1:2] offset:22
	flat_load_u8 v6, v[1:2] offset:23
	flat_load_u8 v7, v[1:2] offset:16
	flat_load_u8 v8, v[1:2] offset:17
	flat_load_u8 v9, v[1:2] offset:18
	flat_load_u8 v10, v[1:2] offset:19
	v_mul_lo_u32 v13, s0, v11
	s_mov_b32 s0, -1
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v13, v12, v0
	s_waitcnt vmcnt(6) lgkmcnt(6)
	v_lshl_or_b32 v3, v4, 8, v3
	s_waitcnt vmcnt(4) lgkmcnt(4)
	v_lshl_or_b32 v4, v6, 8, v5
	s_waitcnt vmcnt(2) lgkmcnt(2)
	v_lshl_or_b32 v5, v8, 8, v7
	v_mul_lo_u32 v7, v0, 24
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v6, v10, 8, v9
	v_lshl_or_b32 v4, v4, 16, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshl_or_b32 v3, v6, 16, v5
	v_add_nc_u32_e32 v13, 8, v7
	ds_store_b64 v7, v[3:4] offset:24
	s_clause 0x7
	flat_load_u8 v0, v[1:2] offset:12
	flat_load_u8 v3, v[1:2] offset:13
	flat_load_u8 v4, v[1:2] offset:14
	flat_load_u8 v5, v[1:2] offset:15
	flat_load_u8 v6, v[1:2] offset:8
	flat_load_u8 v8, v[1:2] offset:9
	flat_load_u8 v9, v[1:2] offset:10
	flat_load_u8 v10, v[1:2] offset:11
	s_waitcnt vmcnt(6) lgkmcnt(6)
	v_lshl_or_b32 v0, v3, 8, v0
	s_waitcnt vmcnt(4) lgkmcnt(4)
	v_lshl_or_b32 v3, v5, 8, v4
	s_waitcnt vmcnt(2) lgkmcnt(2)
	v_lshl_or_b32 v5, v8, 8, v6
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v6, v10, 8, v9
	v_lshl_or_b32 v4, v3, 16, v0
	s_delay_alu instid0(VALU_DEP_2)
	v_lshl_or_b32 v3, v6, 16, v5
	ds_store_b64 v7, v[3:4] offset:16
	s_clause 0x7
	flat_load_u8 v0, v[1:2] offset:4
	flat_load_u8 v3, v[1:2] offset:5
	flat_load_u8 v4, v[1:2] offset:6
	flat_load_u8 v5, v[1:2] offset:7
	flat_load_u8 v6, v[1:2]
	flat_load_u8 v8, v[1:2] offset:1
	flat_load_u8 v9, v[1:2] offset:2
	flat_load_u8 v1, v[1:2] offset:3
	s_waitcnt vmcnt(6) lgkmcnt(6)
	v_lshl_or_b32 v0, v3, 8, v0
	s_waitcnt vmcnt(4) lgkmcnt(4)
	v_lshl_or_b32 v2, v5, 8, v4
	s_waitcnt vmcnt(2) lgkmcnt(2)
	v_lshl_or_b32 v3, v8, 8, v6
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v4, v1, 8, v9
	v_lshl_or_b32 v1, v2, 16, v0
	s_delay_alu instid0(VALU_DEP_2)
	v_lshl_or_b32 v0, v4, 16, v3
	ds_store_b64 v7, v[0:1] offset:8
.Ltmp3:
	.file	5 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl"
	.loc	5 30 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s14, s8
	s_cbranch_execz .LBB3_9
; %bb.1:                                ; %L25.preheader
.Ltmp4:
	.file	6 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl"
	.loc	6 27 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27:0
	ds_load_b64 v[11:12], v13
	s_mov_b32 s15, 0
	s_getpc_b64 s[12:13]
	s_add_u32 s12, s12, __ockl_hsa_signal_cas@rel32@lo+4
	s_addc_u32 s13, s13, __ockl_hsa_signal_cas@rel32@hi+12
                                        ; implicit-def: $sgpr16
                                        ; implicit-def: $sgpr18
                                        ; implicit-def: $sgpr17
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB3_4
.Ltmp5:
	.p2align	6
.LBB3_2:                                ; %Flow7
                                        ;   in Loop: Header=BB3_4 Depth=1
	.loc	6 40 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40:0
	s_or_b32 exec_lo, exec_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 s2, s18, exec_lo
	s_and_b32 s1, s1, exec_lo
	s_and_not1_b32 s17, s17, exec_lo
	s_or_b32 s18, s2, s1
.LBB3_3:                                ; %Flow6
                                        ;   in Loop: Header=BB3_4 Depth=1
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_or_b32 exec_lo, exec_lo, s0
	s_xor_b32 s0, s17, -1
	.loc	6 38 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38:0
	s_and_b32 s1, exec_lo, s18
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s15, s1, s15
	s_and_not1_b32 s1, s16, exec_lo
	s_and_b32 s0, s0, exec_lo
	s_or_b32 s16, s1, s0
	s_and_not1_b32 exec_lo, exec_lo, s15
	s_cbranch_execz .LBB3_7
.LBB3_4:                                ; %L25
                                        ; =>This Inner Loop Header: Depth=1
.Ltmp6:
	.loc	6 27 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27:0
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v0, v11 :: v_dual_mov_b32 v1, v12
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v3, 0
	v_dual_mov_b32 v4, 1 :: v_dual_mov_b32 v5, 0
	v_mov_b32_e32 v6, 4
	s_swappc_b64 s[30:31], s[12:13]
	s_or_b32 s17, s17, exec_lo
	s_or_b32 s18, s18, exec_lo
.Ltmp7:
	.loc	6 38 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38:0
	s_mov_b32 s0, exec_lo
.Ltmp8:
	.loc	2 637 0                         ; promotion.jl:637:0
	v_cmpx_ne_u64_e32 0, v[0:1]
.Ltmp9:
	.loc	6 38 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38:0
	s_cbranch_execz .LBB3_3
; %bb.5:                                ; %L29
                                        ;   in Loop: Header=BB3_4 Depth=1
	.loc	6 40 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40:0
	v_add_co_u32 v0, vcc_lo, v0, -7
	v_add_co_ci_u32_e32 v1, vcc_lo, -1, v1, vcc_lo
	s_mov_b32 s1, -1
	s_mov_b32 s2, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u64_e32 -2, v[0:1]
	s_cbranch_execz .LBB3_2
; %bb.6:                                ; %L39
                                        ;   in Loop: Header=BB3_4 Depth=1
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_xor_b32 s1, exec_lo, -1
.Ltmp10:
	.loc	6 108 0 is_stmt 1               ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108:0
	s_sleep 5
	s_branch .LBB3_2
.Ltmp11:
.LBB3_7:                                ; %loop.exit.guard
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_set_inst_prefetch_distance 0x2
	s_or_b32 exec_lo, exec_lo, s15
	s_mov_b32 s1, -1
	s_mov_b32 s2, 0
	s_and_saveexec_b32 s0, s16
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s0, exec_lo, s0
	s_cbranch_execnz .LBB3_36
.LBB3_8:                                ; %Flow10
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s12, s2, exec_lo
	s_or_not1_b32 s0, s1, exec_lo
.LBB3_9:                                ; %Flow9
	.loc	5 30 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_or_b32 exec_lo, exec_lo, s14
	s_mov_b32 s5, 0
                                        ; implicit-def: $vgpr11_vgpr12
	s_and_saveexec_b32 s13, s0
	s_cbranch_execz .LBB3_29
; %bb.10:                               ; %L43
.Ltmp12:
	.file	7 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl"
	.loc	7 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	s_waitcnt lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
.Ltmp13:
	.loc	7 28 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28:0
	s_barrier
.Ltmp14:
	.loc	7 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	buffer_gl0_inv
.Ltmp15:
	.loc	3 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	ds_load_b64 v[3:4], v13 offset:8
.Ltmp16:
	.loc	3 39 0 is_stmt 0                ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_dual_mov_b32 v0, 0x6c6c6548 :: v_dual_mov_b32 v5, 0
	v_mov_b32_e32 v1, 0x6f57206f
	v_mov_b32_e32 v2, 0x21646c72
	s_mov_b32 s0, 0
	s_mov_b32 s1, -1
	s_mov_b32 s2, s12
                                        ; implicit-def: $vgpr11_vgpr12
	s_waitcnt lgkmcnt(0)
	s_clause 0x1
	global_store_b96 v[3:4], v[0:2], off
	global_store_b8 v[3:4], v5, off offset:12
.Ltmp17:
	.loc	5 30 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_and_saveexec_b32 s14, s8
	s_cbranch_execz .LBB3_28
; %bb.11:                               ; %L73.preheader
.Ltmp18:
	.loc	6 27 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27:0
	ds_load_b64 v[11:12], v13
	s_mov_b32 s15, 0
	s_getpc_b64 s[8:9]
	s_add_u32 s8, s8, __ockl_hsa_signal_cas@rel32@lo+4
	s_addc_u32 s9, s9, __ockl_hsa_signal_cas@rel32@hi+12
                                        ; implicit-def: $sgpr16
                                        ; implicit-def: $sgpr18
                                        ; implicit-def: $sgpr17
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB3_14
.Ltmp19:
	.p2align	6
.LBB3_12:                               ; %Flow5
                                        ;   in Loop: Header=BB3_14 Depth=1
	.loc	6 40 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40:0
	s_or_b32 exec_lo, exec_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 s2, s18, exec_lo
	s_and_b32 s1, s1, exec_lo
	s_and_not1_b32 s17, s17, exec_lo
	s_or_b32 s18, s2, s1
.LBB3_13:                               ; %Flow4
                                        ;   in Loop: Header=BB3_14 Depth=1
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_or_b32 exec_lo, exec_lo, s0
	s_xor_b32 s0, s17, -1
	.loc	6 38 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38:0
	s_and_b32 s1, exec_lo, s18
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s15, s1, s15
	s_and_not1_b32 s1, s16, exec_lo
	s_and_b32 s0, s0, exec_lo
	s_or_b32 s16, s1, s0
	s_and_not1_b32 exec_lo, exec_lo, s15
	s_cbranch_execz .LBB3_17
.LBB3_14:                               ; %L73
                                        ; =>This Inner Loop Header: Depth=1
.Ltmp20:
	.loc	6 27 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27:0
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v0, v11 :: v_dual_mov_b32 v1, v12
	v_dual_mov_b32 v2, 1 :: v_dual_mov_b32 v3, 0
	v_dual_mov_b32 v4, 2 :: v_dual_mov_b32 v5, 0
	v_mov_b32_e32 v6, 4
	s_swappc_b64 s[30:31], s[8:9]
	s_or_b32 s17, s17, exec_lo
	s_or_b32 s18, s18, exec_lo
.Ltmp21:
	.loc	6 38 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38:0
	s_mov_b32 s0, exec_lo
.Ltmp22:
	.loc	2 637 0                         ; promotion.jl:637:0
	v_cmpx_ne_u64_e32 1, v[0:1]
.Ltmp23:
	.loc	6 38 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38:0
	s_cbranch_execz .LBB3_13
; %bb.15:                               ; %L77
                                        ;   in Loop: Header=BB3_14 Depth=1
	.loc	6 40 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40:0
	v_add_co_u32 v0, vcc_lo, v0, -7
	v_add_co_ci_u32_e32 v1, vcc_lo, -1, v1, vcc_lo
	s_mov_b32 s1, -1
	s_mov_b32 s2, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u64_e32 -2, v[0:1]
	s_cbranch_execz .LBB3_12
; %bb.16:                               ; %L87
                                        ;   in Loop: Header=BB3_14 Depth=1
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_xor_b32 s1, exec_lo, -1
.Ltmp24:
	.loc	6 108 0 is_stmt 1               ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108:0
	s_sleep 5
	s_branch .LBB3_12
.Ltmp25:
.LBB3_17:                               ; %loop.exit.guard2
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_set_inst_prefetch_distance 0x2
	s_or_b32 exec_lo, exec_lo, s15
	s_mov_b32 s6, s12
	s_and_saveexec_b32 s0, s16
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s0, exec_lo, s0
	s_cbranch_execnz .LBB3_37
.LBB3_18:                               ; %Flow13
	s_or_saveexec_b32 s7, s0
	s_mov_b32 s0, 0
	s_xor_b32 exec_lo, exec_lo, s7
	s_cbranch_execz .LBB3_27
; %bb.19:                               ; %L91.preheader
.Ltmp26:
	.loc	6 12 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12:0
	v_dual_mov_b32 v0, v11 :: v_dual_mov_b32 v1, v12
	v_mov_b32_e32 v2, 2
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, __ockl_hsa_signal_load@rel32@lo+4
	s_addc_u32 s5, s5, __ockl_hsa_signal_load@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1)
	s_swappc_b64 s[30:31], s[4:5]
	s_mov_b32 s0, -1
	s_mov_b32 s1, s6
.Ltmp27:
	.loc	6 62 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62:0
	s_mov_b32 s8, exec_lo
.Ltmp28:
	.loc	2 637 0                         ; promotion.jl:637:0
	v_cmpx_ne_u64_e32 4, v[0:1]
	s_cbranch_execz .LBB3_26
.Ltmp29:
; %bb.20:                               ; %L95.preheader
	.loc	2 0 0 is_stmt 0                 ; promotion.jl:0:0
	s_mov_b32 s15, 0
                                        ; implicit-def: $sgpr9
                                        ; implicit-def: $sgpr17
                                        ; implicit-def: $sgpr16
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB3_22
	.p2align	6
.LBB3_21:                               ; %Flow
                                        ;   in Loop: Header=BB3_22 Depth=1
	.loc	6 64 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64:0
	s_or_b32 exec_lo, exec_lo, s18
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_and_b32 s0, exec_lo, s17
	s_or_b32 s15, s0, s15
	s_and_not1_b32 s0, s9, exec_lo
	s_and_b32 s1, s16, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s9, s0, s1
	s_and_not1_b32 exec_lo, exec_lo, s15
	s_cbranch_execz .LBB3_24
.LBB3_22:                               ; %L95
                                        ; =>This Inner Loop Header: Depth=1
	v_add_co_u32 v0, vcc_lo, v0, -7
	v_add_co_ci_u32_e32 v1, vcc_lo, -1, v1, vcc_lo
	s_or_b32 s16, s16, exec_lo
	s_or_b32 s17, s17, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_gt_u64_e32 vcc_lo, -2, v[0:1]
                                        ; implicit-def: $vgpr0_vgpr1
	s_and_saveexec_b32 s18, vcc_lo
	s_cbranch_execz .LBB3_21
; %bb.23:                               ; %L105
                                        ;   in Loop: Header=BB3_22 Depth=1
.Ltmp30:
	.loc	6 12 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12:0
	v_dual_mov_b32 v0, v11 :: v_dual_mov_b32 v1, v12
	v_mov_b32_e32 v2, 2
.Ltmp31:
	.loc	6 108 0                         ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108:0
	s_sleep 5
.Ltmp32:
	.loc	6 12 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12:0
	s_swappc_b64 s[30:31], s[4:5]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
.Ltmp33:
	.loc	2 637 0                         ; promotion.jl:637:0
	v_cmp_eq_u64_e32 vcc_lo, 4, v[0:1]
	s_and_not1_b32 s0, s17, exec_lo
	s_and_not1_b32 s16, s16, exec_lo
	s_and_b32 s1, vcc_lo, exec_lo
	s_or_b32 s17, s0, s1
	s_branch .LBB3_21
.Ltmp34:
.LBB3_24:                               ; %loop.exit.guard3
	.loc	2 0 0 is_stmt 0                 ; promotion.jl:0:0
	s_set_inst_prefetch_distance 0x2
	s_or_b32 exec_lo, exec_lo, s15
	s_mov_b32 s1, -1
	s_mov_b32 s2, s6
	s_and_saveexec_b32 s0, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s0, exec_lo, s0
	s_cbranch_execnz .LBB3_38
.LBB3_25:                               ; %Flow16
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 s3, s6, exec_lo
	s_and_b32 s2, s2, exec_lo
	s_or_not1_b32 s0, s1, exec_lo
	s_or_b32 s1, s3, s2
.LBB3_26:                               ; %Flow15
	.loc	6 62 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62:0
	s_or_b32 exec_lo, exec_lo, s8
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 s2, s6, exec_lo
	s_and_b32 s1, s1, exec_lo
	s_and_b32 s0, s0, exec_lo
	s_or_b32 s6, s2, s1
.Ltmp35:
.LBB3_27:                               ; %Flow14
	.loc	6 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:0:0
	s_or_b32 exec_lo, exec_lo, s7
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 s2, s12, exec_lo
	s_and_b32 s3, s6, exec_lo
	s_xor_b32 s1, exec_lo, -1
	s_and_b32 s0, s0, exec_lo
	s_or_b32 s2, s2, s3
.LBB3_28:                               ; %Flow12
	.loc	5 30 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_or_b32 exec_lo, exec_lo, s14
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s5, s1, exec_lo
	s_and_not1_b32 s1, s12, exec_lo
	s_and_b32 s2, s2, exec_lo
	s_and_b32 s9, s0, exec_lo
	s_or_b32 s12, s1, s2
.Ltmp36:
.LBB3_29:                               ; %Flow11
	.loc	5 30 0 is_stmt 0                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_or_b32 exec_lo, exec_lo, s13
	s_and_saveexec_b32 s0, s12
; %bb.30:                               ; %UnifiedUnreachableBlock
	; divergent unreachable
; %bb.31:                               ; %Flow17
	.loc	5 0 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:0:0
	s_delay_alu instid0(SALU_CYCLE_1)
	.loc	5 30 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_or_b32 exec_lo, exec_lo, s0
	s_and_saveexec_b32 s6, s9
	s_cbranch_execz .LBB3_33
.Ltmp37:
; %bb.32:                               ; %L108
	.loc	6 19 0 is_stmt 1                ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19:0
	v_dual_mov_b32 v0, v11 :: v_dual_mov_b32 v1, v12
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v3, 0
	v_mov_b32_e32 v4, 3
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, __ockl_hsa_signal_store@rel32@lo+4
	s_addc_u32 s1, s1, __ockl_hsa_signal_store@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1)
	s_swappc_b64 s[30:31], s[0:1]
	s_or_b32 s5, s5, exec_lo
.Ltmp38:
.LBB3_33:                               ; %Flow18
	.loc	5 30 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30:0
	s_or_b32 exec_lo, exec_lo, s6
	s_and_saveexec_b32 s0, s5
	s_cbranch_execz .LBB3_35
.Ltmp39:
; %bb.34:                               ; %L110
	.loc	7 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	s_waitcnt lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
.Ltmp40:
	.loc	7 28 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28:0
	s_barrier
.Ltmp41:
	.loc	7 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	buffer_gl0_inv
.Ltmp42:
.LBB3_35:                               ; %UnifiedReturnBlock
	.loc	7 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:0:0
	s_endpgm
.LBB3_36:                               ; %L34
.Ltmp43:
	.loc	3 39 0 is_stmt 1                ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_dual_mov_b32 v0, s10 :: v_dual_mov_b32 v3, 1
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s11
.Ltmp44:
	.loc	4 178 0                         ; pointer.jl:178:0
	s_clause 0x3
	flat_store_b8 v[0:1], v2 offset:3
	flat_store_b8 v[0:1], v2 offset:2
	flat_store_b8 v[0:1], v2 offset:1
	flat_store_b8 v[0:1], v3
.Ltmp45:
	.file	8 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl"
	.loc	8 6 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6:0
	s_endpgm
	s_mov_b32 s2, exec_lo
	s_xor_b32 s1, exec_lo, -1
	s_branch .LBB3_8
.Ltmp46:
.LBB3_37:                               ; %L82
	.loc	3 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_dual_mov_b32 v0, s10 :: v_dual_mov_b32 v3, 1
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s11
.Ltmp47:
	.loc	4 178 0                         ; pointer.jl:178:0
	s_clause 0x3
	flat_store_b8 v[0:1], v2 offset:3
	flat_store_b8 v[0:1], v2 offset:2
	flat_store_b8 v[0:1], v2 offset:1
	flat_store_b8 v[0:1], v3
.Ltmp48:
	.loc	8 6 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6:0
	s_endpgm
	s_or_b32 s6, s12, exec_lo
	s_branch .LBB3_18
.Ltmp49:
.LBB3_38:                               ; %L100
	.loc	3 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_dual_mov_b32 v0, s10 :: v_dual_mov_b32 v3, 1
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s11
.Ltmp50:
	.loc	4 178 0                         ; pointer.jl:178:0
	s_clause 0x3
	flat_store_b8 v[0:1], v2 offset:3
	flat_store_b8 v[0:1], v2 offset:2
	flat_store_b8 v[0:1], v2 offset:1
	flat_store_b8 v[0:1], v3
.Ltmp51:
	.loc	8 6 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6:0
	s_endpgm
	s_xor_b32 s1, exec_lo, -1
	s_or_b32 s2, s6, exec_lo
	s_branch .LBB3_25
.Ltmp52:
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z6kernel
		.amdhsa_group_segment_fixed_size 24584
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 88
		.amdhsa_user_sgpr_count 15
		.amdhsa_user_sgpr_dispatch_ptr 1
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 2
		.amdhsa_next_free_vgpr 14
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
	.file	10 "." "none"
	.file	11 "." "operators.jl"
	.file	12 "." "int.jl"
	.file	13 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl"
	.file	14 "." "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl"
                                        ; -- End function
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1860
; NumSgprs: 35
; NumVgprs: 14
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 24584 bytes/workgroup (compile time only)
; SGPRBlocks: 4
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 35
; NumVGPRsForWavesPerEU: 14
; Occupancy: 16
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 15
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 2
	.text
	.p2alignl 7, 3214868480
	.fill 96, 4, 3214868480
	.type	__unnamed_1,@object             ; @0
	.section	.rodata.str1.1,"aMS",@progbits,1
__unnamed_1:
	.asciz	"Hello World!"
	.size	__unnamed_1, 13

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
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 ; Length of Unit
.Ldebug_info_start0:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0x639 DW_TAG_compile_unit
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
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x48:0x6 DW_TAG_subprogram
	.long	.Linfo_string5                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x4e:0x6 DW_TAG_subprogram
	.long	.Linfo_string5                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x54:0x6 DW_TAG_subprogram
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x5a:0x6 DW_TAG_subprogram
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x60:0x6 DW_TAG_subprogram
	.long	.Linfo_string6                  ; DW_AT_name
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
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x9c:0x6 DW_TAG_subprogram
	.long	.Linfo_string15                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xa2:0x6 DW_TAG_subprogram
	.long	.Linfo_string16                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xa8:0x6 DW_TAG_subprogram
	.long	.Linfo_string17                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xae:0x6 DW_TAG_subprogram
	.long	.Linfo_string18                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xb4:0x6 DW_TAG_subprogram
	.long	.Linfo_string18                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xba:0x6 DW_TAG_subprogram
	.long	.Linfo_string19                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xc0:0x6 DW_TAG_subprogram
	.long	.Linfo_string20                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xc6:0x6 DW_TAG_subprogram
	.long	.Linfo_string21                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xcc:0x6 DW_TAG_subprogram
	.long	.Linfo_string22                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xd2:0x6 DW_TAG_subprogram
	.long	.Linfo_string23                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xd8:0x6 DW_TAG_subprogram
	.long	.Linfo_string24                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xde:0x6 DW_TAG_subprogram
	.long	.Linfo_string7                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xe4:0x6 DW_TAG_subprogram
	.long	.Linfo_string25                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	3                               ; Abbrev [3] 0xea:0x559 DW_TAG_subprogram
	.quad	.Lfunc_begin3                   ; DW_AT_low_pc
	.long	.Lfunc_end3-.Lfunc_begin3       ; DW_AT_high_pc
	.long	.Linfo_string26                 ; DW_AT_name
	.byte	4                               ; Abbrev [4] 0xfb:0x547 DW_TAG_inlined_subroutine
	.long	84                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp52-.Ltmp0                  ; DW_AT_high_pc
	.byte	1                               ; DW_AT_call_file
	.byte	3                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x10e:0x1a2 DW_TAG_inlined_subroutine
	.long	78                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges0                 ; DW_AT_ranges
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x119:0x196 DW_TAG_inlined_subroutine
	.long	72                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges1                 ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	53                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x124:0x18a DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges2                 ; DW_AT_ranges
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x12f:0x17e DW_TAG_inlined_subroutine
	.long	60                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges3                 ; DW_AT_ranges
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x13a:0x52 DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	30                              ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x14d:0x3e DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.short	321                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x161:0x29 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	12                              ; DW_AT_call_file
	.short	524                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x175:0x14 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	2                               ; DW_AT_call_file
	.short	487                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x18c:0xe6 DW_TAG_inlined_subroutine
	.long	126                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges4                 ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	62                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x197:0xda DW_TAG_inlined_subroutine
	.long	126                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges5                 ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	36                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x1a2:0xb DW_TAG_inlined_subroutine
	.long	120                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges6                 ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	37                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x1ad:0x13 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp8                          ; DW_AT_low_pc
	.long	.Ltmp9-.Ltmp8                   ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	38                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x1c0:0x13 DW_TAG_inlined_subroutine
	.long	132                             ; DW_AT_abstract_origin
	.quad	.Ltmp10                         ; DW_AT_low_pc
	.long	.Ltmp11-.Ltmp10                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	46                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x1d3:0x9d DW_TAG_inlined_subroutine
	.long	216                             ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp46-.Ltmp43                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	41                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x1e6:0x4f DW_TAG_inlined_subroutine
	.long	210                             ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp44-.Ltmp43                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x1f9:0x3b DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp44-.Ltmp43                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	11                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x20c:0x27 DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp44-.Ltmp43                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x21f:0x13 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp43                         ; DW_AT_low_pc
	.long	.Ltmp44-.Ltmp43                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x235:0x27 DW_TAG_inlined_subroutine
	.long	222                             ; DW_AT_abstract_origin
	.quad	.Ltmp44                         ; DW_AT_low_pc
	.long	.Ltmp45-.Ltmp44                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x248:0x13 DW_TAG_inlined_subroutine
	.long	222                             ; DW_AT_abstract_origin
	.quad	.Ltmp44                         ; DW_AT_low_pc
	.long	.Ltmp45-.Ltmp44                 ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	178                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0x25c:0x13 DW_TAG_inlined_subroutine
	.long	228                             ; DW_AT_abstract_origin
	.quad	.Ltmp45                         ; DW_AT_low_pc
	.long	.Ltmp46-.Ltmp45                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x272:0x3a DW_TAG_inlined_subroutine
	.long	144                             ; DW_AT_abstract_origin
	.quad	.Ltmp12                         ; DW_AT_low_pc
	.long	.Ltmp15-.Ltmp12                 ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	47                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x285:0x13 DW_TAG_inlined_subroutine
	.long	138                             ; DW_AT_abstract_origin
	.quad	.Ltmp12                         ; DW_AT_low_pc
	.long	.Ltmp13-.Ltmp12                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	27                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x298:0x13 DW_TAG_inlined_subroutine
	.long	138                             ; DW_AT_abstract_origin
	.quad	.Ltmp14                         ; DW_AT_low_pc
	.long	.Ltmp15-.Ltmp14                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	29                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x2b0:0x8b DW_TAG_inlined_subroutine
	.long	108                             ; DW_AT_abstract_origin
	.quad	.Ltmp1                          ; DW_AT_low_pc
	.long	.Ltmp2-.Ltmp1                   ; DW_AT_high_pc
	.byte	9                               ; DW_AT_call_file
	.byte	69                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x2c3:0x77 DW_TAG_inlined_subroutine
	.long	102                             ; DW_AT_abstract_origin
	.quad	.Ltmp1                          ; DW_AT_low_pc
	.long	.Ltmp2-.Ltmp1                   ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	74                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x2d6:0x63 DW_TAG_inlined_subroutine
	.long	102                             ; DW_AT_abstract_origin
	.quad	.Ltmp1                          ; DW_AT_low_pc
	.long	.Ltmp2-.Ltmp1                   ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x2e9:0x4f DW_TAG_inlined_subroutine
	.long	102                             ; DW_AT_abstract_origin
	.quad	.Ltmp1                          ; DW_AT_low_pc
	.long	.Ltmp2-.Ltmp1                   ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x2fc:0x3b DW_TAG_inlined_subroutine
	.long	96                              ; DW_AT_abstract_origin
	.quad	.Ltmp1                          ; DW_AT_low_pc
	.long	.Ltmp2-.Ltmp1                   ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	88                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x30f:0x27 DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.quad	.Ltmp1                          ; DW_AT_low_pc
	.long	.Ltmp2-.Ltmp1                   ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x322:0x13 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp1                          ; DW_AT_low_pc
	.long	.Ltmp2-.Ltmp1                   ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x33b:0x27 DW_TAG_inlined_subroutine
	.long	114                             ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x34e:0x13 DW_TAG_inlined_subroutine
	.long	114                             ; DW_AT_abstract_origin
	.quad	.Ltmp2                          ; DW_AT_low_pc
	.long	.Ltmp3-.Ltmp2                   ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	151                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x362:0x4f DW_TAG_inlined_subroutine
	.long	162                             ; DW_AT_abstract_origin
	.quad	.Ltmp15                         ; DW_AT_low_pc
	.long	.Ltmp16-.Ltmp15                 ; DW_AT_high_pc
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x375:0x3b DW_TAG_inlined_subroutine
	.long	156                             ; DW_AT_abstract_origin
	.quad	.Ltmp15                         ; DW_AT_low_pc
	.long	.Ltmp16-.Ltmp15                 ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	147                             ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x388:0x27 DW_TAG_inlined_subroutine
	.long	150                             ; DW_AT_abstract_origin
	.quad	.Ltmp15                         ; DW_AT_low_pc
	.long	.Ltmp16-.Ltmp15                 ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	114                             ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x39b:0x13 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp15                         ; DW_AT_low_pc
	.long	.Ltmp16-.Ltmp15                 ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	114                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x3b1:0x3b DW_TAG_inlined_subroutine
	.long	168                             ; DW_AT_abstract_origin
	.quad	.Ltmp16                         ; DW_AT_low_pc
	.long	.Ltmp17-.Ltmp16                 ; DW_AT_high_pc
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x3c4:0x27 DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.quad	.Ltmp16                         ; DW_AT_low_pc
	.long	.Ltmp17-.Ltmp16                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x3d7:0x13 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp16                         ; DW_AT_low_pc
	.long	.Ltmp17-.Ltmp16                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x3ec:0x255 DW_TAG_inlined_subroutine
	.long	180                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges7                 ; DW_AT_ranges
	.byte	9                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x3f7:0x249 DW_TAG_inlined_subroutine
	.long	174                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges8                 ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	97                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x402:0x23d DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges9                 ; DW_AT_ranges
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x40d:0x231 DW_TAG_inlined_subroutine
	.long	60                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges10                ; DW_AT_ranges
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x418:0xe6 DW_TAG_inlined_subroutine
	.long	126                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges11                ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x423:0xda DW_TAG_inlined_subroutine
	.long	126                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges12                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	36                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x42e:0xb DW_TAG_inlined_subroutine
	.long	120                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges13                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	37                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x439:0x13 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp22                         ; DW_AT_low_pc
	.long	.Ltmp23-.Ltmp22                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	38                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x44c:0x13 DW_TAG_inlined_subroutine
	.long	132                             ; DW_AT_abstract_origin
	.quad	.Ltmp24                         ; DW_AT_low_pc
	.long	.Ltmp25-.Ltmp24                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	46                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x45f:0x9d DW_TAG_inlined_subroutine
	.long	216                             ; DW_AT_abstract_origin
	.quad	.Ltmp46                         ; DW_AT_low_pc
	.long	.Ltmp49-.Ltmp46                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	41                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x472:0x4f DW_TAG_inlined_subroutine
	.long	210                             ; DW_AT_abstract_origin
	.quad	.Ltmp46                         ; DW_AT_low_pc
	.long	.Ltmp47-.Ltmp46                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x485:0x3b DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp46                         ; DW_AT_low_pc
	.long	.Ltmp47-.Ltmp46                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	11                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x498:0x27 DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.quad	.Ltmp46                         ; DW_AT_low_pc
	.long	.Ltmp47-.Ltmp46                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x4ab:0x13 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp46                         ; DW_AT_low_pc
	.long	.Ltmp47-.Ltmp46                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x4c1:0x27 DW_TAG_inlined_subroutine
	.long	222                             ; DW_AT_abstract_origin
	.quad	.Ltmp47                         ; DW_AT_low_pc
	.long	.Ltmp48-.Ltmp47                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x4d4:0x13 DW_TAG_inlined_subroutine
	.long	222                             ; DW_AT_abstract_origin
	.quad	.Ltmp47                         ; DW_AT_low_pc
	.long	.Ltmp48-.Ltmp47                 ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	178                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0x4e8:0x13 DW_TAG_inlined_subroutine
	.long	228                             ; DW_AT_abstract_origin
	.quad	.Ltmp48                         ; DW_AT_low_pc
	.long	.Ltmp49-.Ltmp48                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x4fe:0xde DW_TAG_inlined_subroutine
	.long	192                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges14                ; DW_AT_ranges
	.byte	5                               ; DW_AT_call_file
	.byte	116                             ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x509:0xd2 DW_TAG_inlined_subroutine
	.long	192                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges15                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	60                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x514:0xb DW_TAG_inlined_subroutine
	.long	186                             ; DW_AT_abstract_origin
	.long	.Ldebug_ranges16                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	61                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x51f:0xb DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.long	.Ldebug_ranges17                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.byte	62                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x52a:0x13 DW_TAG_inlined_subroutine
	.long	132                             ; DW_AT_abstract_origin
	.quad	.Ltmp31                         ; DW_AT_low_pc
	.long	.Ltmp32-.Ltmp31                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	70                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x53d:0x9d DW_TAG_inlined_subroutine
	.long	216                             ; DW_AT_abstract_origin
	.quad	.Ltmp49                         ; DW_AT_low_pc
	.long	.Ltmp52-.Ltmp49                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	65                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x550:0x4f DW_TAG_inlined_subroutine
	.long	210                             ; DW_AT_abstract_origin
	.quad	.Ltmp49                         ; DW_AT_low_pc
	.long	.Ltmp50-.Ltmp49                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x563:0x3b DW_TAG_inlined_subroutine
	.long	204                             ; DW_AT_abstract_origin
	.quad	.Ltmp49                         ; DW_AT_low_pc
	.long	.Ltmp50-.Ltmp49                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	11                              ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x576:0x27 DW_TAG_inlined_subroutine
	.long	66                              ; DW_AT_abstract_origin
	.quad	.Ltmp49                         ; DW_AT_low_pc
	.long	.Ltmp50-.Ltmp49                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x589:0x13 DW_TAG_inlined_subroutine
	.long	90                              ; DW_AT_abstract_origin
	.quad	.Ltmp49                         ; DW_AT_low_pc
	.long	.Ltmp50-.Ltmp49                 ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x59f:0x27 DW_TAG_inlined_subroutine
	.long	222                             ; DW_AT_abstract_origin
	.quad	.Ltmp50                         ; DW_AT_low_pc
	.long	.Ltmp51-.Ltmp50                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	113                             ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x5b2:0x13 DW_TAG_inlined_subroutine
	.long	222                             ; DW_AT_abstract_origin
	.quad	.Ltmp50                         ; DW_AT_low_pc
	.long	.Ltmp51-.Ltmp50                 ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	178                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0x5c6:0x13 DW_TAG_inlined_subroutine
	.long	228                             ; DW_AT_abstract_origin
	.quad	.Ltmp51                         ; DW_AT_low_pc
	.long	.Ltmp52-.Ltmp51                 ; DW_AT_high_pc
	.byte	13                              ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x5dc:0x27 DW_TAG_inlined_subroutine
	.long	198                             ; DW_AT_abstract_origin
	.quad	.Ltmp37                         ; DW_AT_low_pc
	.long	.Ltmp38-.Ltmp37                 ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	128                             ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x5ef:0x13 DW_TAG_inlined_subroutine
	.long	198                             ; DW_AT_abstract_origin
	.quad	.Ltmp37                         ; DW_AT_low_pc
	.long	.Ltmp38-.Ltmp37                 ; DW_AT_high_pc
	.byte	6                               ; DW_AT_call_file
	.byte	19                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	4                               ; Abbrev [4] 0x603:0x3a DW_TAG_inlined_subroutine
	.long	144                             ; DW_AT_abstract_origin
	.quad	.Ltmp39                         ; DW_AT_low_pc
	.long	.Ltmp42-.Ltmp39                 ; DW_AT_high_pc
	.byte	5                               ; DW_AT_call_file
	.byte	47                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x616:0x13 DW_TAG_inlined_subroutine
	.long	138                             ; DW_AT_abstract_origin
	.quad	.Ltmp39                         ; DW_AT_low_pc
	.long	.Ltmp40-.Ltmp39                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.byte	27                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x629:0x13 DW_TAG_inlined_subroutine
	.long	138                             ; DW_AT_abstract_origin
	.quad	.Ltmp41                         ; DW_AT_low_pc
	.long	.Ltmp42-.Ltmp41                 ; DW_AT_high_pc
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
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp3-.Lfunc_begin3
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp38-.Lfunc_begin3
	.quad	.Ltmp39-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges1:
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp3-.Lfunc_begin3
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp38-.Lfunc_begin3
	.quad	.Ltmp39-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges2:
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp3-.Lfunc_begin3
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp38-.Lfunc_begin3
	.quad	.Ltmp39-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges3:
	.quad	.Ltmp0-.Lfunc_begin3
	.quad	.Ltmp1-.Lfunc_begin3
	.quad	.Ltmp3-.Lfunc_begin3
	.quad	.Ltmp15-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp38-.Lfunc_begin3
	.quad	.Ltmp39-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges4:
	.quad	.Ltmp4-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges5:
	.quad	.Ltmp4-.Lfunc_begin3
	.quad	.Ltmp11-.Lfunc_begin3
	.quad	.Ltmp43-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges6:
	.quad	.Ltmp4-.Lfunc_begin3
	.quad	.Ltmp5-.Lfunc_begin3
	.quad	.Ltmp6-.Lfunc_begin3
	.quad	.Ltmp7-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges7:
	.quad	.Ltmp17-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp38-.Lfunc_begin3
	.quad	.Ltmp39-.Lfunc_begin3
	.quad	.Ltmp42-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	.Ltmp52-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges8:
	.quad	.Ltmp17-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp38-.Lfunc_begin3
	.quad	.Ltmp39-.Lfunc_begin3
	.quad	.Ltmp42-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	.Ltmp52-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges9:
	.quad	.Ltmp17-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp38-.Lfunc_begin3
	.quad	.Ltmp39-.Lfunc_begin3
	.quad	.Ltmp42-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	.Ltmp52-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges10:
	.quad	.Ltmp17-.Lfunc_begin3
	.quad	.Ltmp36-.Lfunc_begin3
	.quad	.Ltmp37-.Lfunc_begin3
	.quad	.Ltmp38-.Lfunc_begin3
	.quad	.Ltmp39-.Lfunc_begin3
	.quad	.Ltmp42-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	.Ltmp52-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges11:
	.quad	.Ltmp18-.Lfunc_begin3
	.quad	.Ltmp25-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	.Ltmp49-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges12:
	.quad	.Ltmp18-.Lfunc_begin3
	.quad	.Ltmp25-.Lfunc_begin3
	.quad	.Ltmp46-.Lfunc_begin3
	.quad	.Ltmp49-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges13:
	.quad	.Ltmp18-.Lfunc_begin3
	.quad	.Ltmp19-.Lfunc_begin3
	.quad	.Ltmp20-.Lfunc_begin3
	.quad	.Ltmp21-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges14:
	.quad	.Ltmp26-.Lfunc_begin3
	.quad	.Ltmp35-.Lfunc_begin3
	.quad	.Ltmp49-.Lfunc_begin3
	.quad	.Ltmp52-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges15:
	.quad	.Ltmp26-.Lfunc_begin3
	.quad	.Ltmp35-.Lfunc_begin3
	.quad	.Ltmp49-.Lfunc_begin3
	.quad	.Ltmp52-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges16:
	.quad	.Ltmp26-.Lfunc_begin3
	.quad	.Ltmp27-.Lfunc_begin3
	.quad	.Ltmp30-.Lfunc_begin3
	.quad	.Ltmp31-.Lfunc_begin3
	.quad	.Ltmp32-.Lfunc_begin3
	.quad	.Ltmp33-.Lfunc_begin3
	.quad	0
	.quad	0
.Ldebug_ranges17:
	.quad	.Ltmp28-.Lfunc_begin3
	.quad	.Ltmp29-.Lfunc_begin3
	.quad	.Ltmp33-.Lfunc_begin3
	.quad	.Ltmp34-.Lfunc_begin3
	.quad	0
	.quad	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"julia"                         ; string offset=0
.Linfo_string1:
	.asciz	"."                             ; string offset=6
.Linfo_string2:
	.asciz	"==;"                           ; string offset=8
.Linfo_string3:
	.asciz	"!=;"                           ; string offset=12
.Linfo_string4:
	.asciz	"macro expansion;"              ; string offset=16
.Linfo_string5:
	.asciz	"hostcall_device_lock!;"        ; string offset=33
.Linfo_string6:
	.asciz	"pointerset;"                   ; string offset=56
.Linfo_string7:
	.asciz	"unsafe_store!;"                ; string offset=68
.Linfo_string8:
	.asciz	"output_context;"               ; string offset=83
.Linfo_string9:
	.asciz	"unsafe_load;"                  ; string offset=99
.Linfo_string10:
	.asciz	"device_signal_cas!;"           ; string offset=112
.Linfo_string11:
	.asciz	"hostcall_device_signal_wait_cas!;" ; string offset=132
.Linfo_string12:
	.asciz	"device_sleep;"                 ; string offset=166
.Linfo_string13:
	.asciz	"fence;"                        ; string offset=180
.Linfo_string14:
	.asciz	"sync_workgroup;"               ; string offset=187
.Linfo_string15:
	.asciz	"add_ptr;"                      ; string offset=203
.Linfo_string16:
	.asciz	"+;"                            ; string offset=212
.Linfo_string17:
	.asciz	"memcpy!;"                      ; string offset=215
.Linfo_string18:
	.asciz	"hostcall_device_trigger_and_return!;" ; string offset=224
.Linfo_string19:
	.asciz	"device_signal_load;"           ; string offset=261
.Linfo_string20:
	.asciz	"hostcall_device_signal_wait;"  ; string offset=281
.Linfo_string21:
	.asciz	"device_signal_store!;"         ; string offset=310
.Linfo_string22:
	.asciz	"kernel_state;"                 ; string offset=332
.Linfo_string23:
	.asciz	"exception_flag;"               ; string offset=346
.Linfo_string24:
	.asciz	"signal_exception;"             ; string offset=362
.Linfo_string25:
	.asciz	"endpgm;"                       ; string offset=380
.Linfo_string26:
	.asciz	"kernel"                        ; string offset=388
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.ident	"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"
	.section	".note.GNU-stack","",@progbits
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .name:           state
        .offset:         0
        .size:           88
        .value_kind:     by_value
    .group_segment_fixed_size: 24584
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
    .uses_dynamic_stack: false
    .vgpr_count:     14
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
