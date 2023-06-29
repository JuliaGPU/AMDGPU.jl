	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1030"
	.p2align	2                               ; -- Begin function __ockl_hsa_signal_add
	.type	__ockl_hsa_signal_add,@function
__ockl_hsa_signal_add:                  ; @__ockl_hsa_signal_add
.Lfunc_begin0:
	.cfi_sections .debug_frame
	.cfi_startproc
; %bb.0:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	v_cmp_lt_i32_e32 vcc_lo, 3, v4
	s_mov_b32 s4, 0
	s_mov_b32 s5, 0
	s_and_saveexec_b32 s6, vcc_lo
	s_xor_b32 s6, exec_lo, s6
	s_cbranch_execz .LBB0_8
; %bb.1:                                ; %NodeBlock12
	v_cmp_lt_i32_e32 vcc_lo, 4, v4
	s_mov_b32 s7, 0
	s_and_saveexec_b32 s5, vcc_lo
	s_xor_b32 s5, exec_lo, s5
	s_cbranch_execz .LBB0_5
; %bb.2:                                ; %LeafBlock10
	v_cmp_eq_u32_e32 vcc_lo, 5, v4
	s_mov_b32 s7, -1
	s_and_saveexec_b32 s8, vcc_lo
	s_cbranch_execz .LBB0_4
; %bb.3:
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_add_x2 v[0:1], v[2:3], off offset:8
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	buffer_gl1_inv
	s_xor_b32 s7, exec_lo, -1
.LBB0_4:                                ; %Flow17
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s7, s7, exec_lo
.LBB0_5:                                ; %Flow16
	s_or_saveexec_b32 s5, s5
	s_xor_b32 exec_lo, exec_lo, s5
	s_cbranch_execz .LBB0_7
; %bb.6:
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_add_x2 v[0:1], v[2:3], off offset:8
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	buffer_gl1_inv
.LBB0_7:                                ; %Flow18
	s_or_b32 exec_lo, exec_lo, s5
	s_and_b32 s5, s7, exec_lo
                                        ; implicit-def: $vgpr4
.LBB0_8:                                ; %Flow
	s_or_saveexec_b32 s6, s6
	s_xor_b32 exec_lo, exec_lo, s6
	s_cbranch_execz .LBB0_14
; %bb.9:                                ; %NodeBlock
	v_cmp_lt_i32_e32 vcc_lo, 2, v4
	s_and_saveexec_b32 s4, vcc_lo
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_11
; %bb.10:
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_add_x2 v[0:1], v[2:3], off offset:8
                                        ; implicit-def: $vgpr4
.LBB0_11:                               ; %Flow20
	s_or_saveexec_b32 s7, s4
	s_mov_b32 s4, 0
	s_mov_b32 s8, s5
	s_xor_b32 exec_lo, exec_lo, s7
; %bb.12:                               ; %LeafBlock
	v_cmp_gt_i32_e32 vcc_lo, 1, v4
	s_andn2_b32 s8, s5, exec_lo
	s_mov_b32 s4, exec_lo
	s_and_b32 s9, vcc_lo, exec_lo
	s_or_b32 s8, s8, s9
; %bb.13:                               ; %Flow21
	s_or_b32 exec_lo, exec_lo, s7
	s_andn2_b32 s5, s5, exec_lo
	s_and_b32 s7, s8, exec_lo
	s_and_b32 s4, s4, exec_lo
	s_or_b32 s5, s5, s7
.LBB0_14:                               ; %Flow19
	s_or_b32 exec_lo, exec_lo, s6
	s_and_saveexec_b32 s6, s5
	s_xor_b32 s5, exec_lo, s6
	s_cbranch_execz .LBB0_16
; %bb.15:
	global_atomic_add_x2 v[0:1], v[2:3], off offset:8
	s_andn2_b32 s4, s4, exec_lo
.LBB0_16:                               ; %Flow22
	s_or_b32 exec_lo, exec_lo, s5
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB0_18
; %bb.17:
	global_atomic_add_x2 v[0:1], v[2:3], off offset:8
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
	buffer_gl1_inv
.LBB0_18:
	s_or_b32 exec_lo, exec_lo, s5
	global_load_dwordx2 v[2:3], v[0:1], off offset:16
	s_waitcnt vmcnt(0)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB0_20
; %bb.19:
	global_load_dword v0, v[0:1], off offset:24
	v_mov_b32_e32 v1, 0
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s5, v0
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_store_dwordx2 v[2:3], v[0:1], off
	s_and_b32 m0, s5, 0xff
	s_sendmsg sendmsg(MSG_INTERRUPT)
.LBB0_20:                               ; %UnifiedReturnBlock
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_setpc_b64 s[30:31]
.Lfunc_end0:
	.size	__ockl_hsa_signal_add, .Lfunc_end0-__ockl_hsa_signal_add
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata
; Function info:
; codeLenInByte = 468
; NumSgprs: 34
; NumVgprs: 5
; ScratchSize: 0
; MemoryBound: 0
	.text
	.p2align	2                               ; -- Begin function __ockl_hostcall_internal
	.type	__ockl_hostcall_internal,@function
__ockl_hostcall_internal:               ; @__ockl_hostcall_internal
.Lfunc_begin1:
	.cfi_startproc
; %bb.0:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_mov_b32 s13, s33
	s_mov_b32 s33, s32
	s_add_i32 s32, s32, 0x1400
	s_mov_b64 s[10:11], s[30:31]
	buffer_store_dword v1, off, s[0:3], s33 offset:4
	buffer_store_dword v0, off, s[0:3], s33
	buffer_store_dword v2, off, s[0:3], s33 offset:8
	buffer_store_dword v4, off, s[0:3], s33 offset:20
	buffer_store_dword v3, off, s[0:3], s33 offset:16
	buffer_store_dword v6, off, s[0:3], s33 offset:28
	buffer_store_dword v5, off, s[0:3], s33 offset:24
	buffer_store_dword v8, off, s[0:3], s33 offset:36
	buffer_store_dword v7, off, s[0:3], s33 offset:32
	buffer_store_dword v10, off, s[0:3], s33 offset:44
	buffer_store_dword v9, off, s[0:3], s33 offset:40
	buffer_store_dword v12, off, s[0:3], s33 offset:52
	buffer_store_dword v11, off, s[0:3], s33 offset:48
	buffer_store_dword v14, off, s[0:3], s33 offset:60
	buffer_store_dword v13, off, s[0:3], s33 offset:56
	buffer_store_dword v16, off, s[0:3], s33 offset:68
	buffer_store_dword v15, off, s[0:3], s33 offset:64
	buffer_store_dword v18, off, s[0:3], s33 offset:76
	buffer_store_dword v17, off, s[0:3], s33 offset:72
	s_mov_b32 s4, 0
	s_mov_b32 s5, -1
	v_mbcnt_lo_u32_b32 v0, s5, s4
	v_mbcnt_hi_u32_b32 v0, s5, v0
	buffer_store_dword v0, off, s[0:3], s33 offset:80
	buffer_load_dword v0, off, s[0:3], s33 offset:80
	s_waitcnt vmcnt(0)
	;;#ASMSTART
	; ockl readfirstlane hoisting hack v0
	;;#ASMEND
	buffer_store_dword v0, off, s[0:3], s33 offset:80
	buffer_load_dword v0, off, s[0:3], s33 offset:80
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s4, v0
	v_mov_b32_e32 v0, s4
	buffer_store_dword v0, off, s[0:3], s33 offset:84
	buffer_load_dword v0, off, s[0:3], s33
	buffer_load_dword v1, off, s[0:3], s33 offset:4
	s_waitcnt vmcnt(0)
	buffer_store_dword v1, off, s[0:3], s33 offset:92
	buffer_store_dword v0, off, s[0:3], s33 offset:88
	buffer_load_dword v0, off, s[0:3], s33 offset:80
	buffer_load_dword v1, off, s[0:3], s33 offset:84
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e64 s6, v0, v1
	s_mov_b64 s[4:5], 0
	v_mov_b32_e32 v7, s5
	v_mov_b32_e32 v6, s4
	s_mov_b32 s4, exec_lo
	s_and_b32 s5, s4, s6
	s_mov_b32 exec_lo, s5
	s_cbranch_execz .LBB1_6
; %bb.1:
	buffer_load_dword v0, off, s[0:3], s33 offset:88
	buffer_load_dword v1, off, s[0:3], s33 offset:92
	s_mov_b64 s[6:7], 24
	s_waitcnt vmcnt(1)
	v_add_co_u32 v2, s5, v0, s6
	s_waitcnt vmcnt(0)
	v_add_co_ci_u32_e64 v3, s5, v1, s7, s5
	global_load_dwordx2 v[8:9], v[0:1], off offset:24 glc dlc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	s_mov_b64 s[6:7], 40
	v_add_co_u32 v4, s5, v0, s6
	v_add_co_ci_u32_e64 v5, s5, v1, s7, s5
	global_load_dwordx2 v[6:7], v[0:1], off
	global_load_dwordx2 v[10:11], v[0:1], off offset:40
	s_waitcnt vmcnt(0)
	v_and_b32_e64 v11, v11, v9
	v_and_b32_e64 v10, v10, v8
	s_mov_b32 s5, 32
	v_lshrrev_b64 v[11:12], s5, v[10:11]
	s_mov_b32 s6, 24
	v_mul_lo_u32 v12, v11, s6
	v_mad_u64_u32 v[10:11], s6, v10, s6, 0
	v_add_nc_u32_e64 v11, v11, v12
	v_lshlrev_b64 v[11:12], s5, v[11:12]
	s_mov_b32 s5, 0
	v_mov_b32_e32 v13, 0
	v_or_b32_e64 v12, v13, v12
	v_or_b32_e64 v10, v10, v11
	v_add_co_u32 v6, s5, v6, v10
	v_add_co_ci_u32_e64 v7, s5, v7, v12, s5
	global_load_dwordx2 v[6:7], v[6:7], off glc dlc
	s_waitcnt vmcnt(0)
	global_atomic_cmpswap_x2 v[6:7], v[0:1], v[6:9], off offset:24 glc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	v_cmp_eq_u64_e64 s6, v[6:7], v[8:9]
	v_cmp_ne_u64_e64 s7, v[6:7], v[8:9]
	s_mov_b32 s5, exec_lo
	s_and_b32 s7, s5, s7
	s_mov_b32 exec_lo, s7
; %bb.2:                                ; %.preheader6
	s_mov_b32 s7, 0
                                        ; implicit-def: $sgpr8
	s_branch .LBB1_4
.LBB1_3:                                ; %Flow7
	s_or_b32 exec_lo, exec_lo, s5
                                        ; implicit-def: $sgpr5
	s_branch .LBB1_7
.LBB1_4:                                ; =>This Inner Loop Header: Depth=1
                                        ; implicit-def: $sgpr9
	s_sleep 1
	global_load_dwordx2 v[10:11], v[0:1], off
	global_load_dwordx2 v[12:13], v[4:5], off
	v_mov_b32_e32 v9, v7
	v_mov_b32_e32 v8, v6
	s_waitcnt vmcnt(0)
	v_and_b32_e64 v7, v13, v9
	v_and_b32_e64 v6, v12, v8
	s_mov_b32 s9, 32
	v_lshrrev_b64 v[12:13], s9, v[6:7]
	s_mov_b32 s12, 24
	v_mul_lo_u32 v12, v12, s12
	v_mad_u64_u32 v[6:7], s12, v6, s12, 0
	v_add_nc_u32_e64 v7, v7, v12
	v_lshlrev_b64 v[12:13], s9, v[7:8]
	s_mov_b32 s9, 0
	v_mov_b32_e32 v7, 0
	v_or_b32_e64 v7, v7, v13
	v_or_b32_e64 v6, v6, v12
	v_add_co_u32 v6, s9, v10, v6
	v_add_co_ci_u32_e64 v7, s9, v11, v7, s9
	global_load_dwordx2 v[6:7], v[6:7], off glc dlc
	s_waitcnt vmcnt(0)
	global_atomic_cmpswap_x2 v[6:7], v[2:3], v[6:9], off glc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	v_cmp_eq_u64_e64 s9, v[6:7], v[8:9]
	s_or_b32 s7, s9, s7
	s_andn2_b32 s8, s8, exec_lo
	s_and_b32 s9, s9, exec_lo
	s_or_b32 s8, s8, s9
	s_andn2_b32 exec_lo, exec_lo, s7
	s_cbranch_execnz .LBB1_4
; %bb.5:                                ; %.loopexit7
	s_or_b32 exec_lo, exec_lo, s7
	s_andn2_b32 s6, s6, exec_lo
	s_and_b32 s7, s8, exec_lo
	s_or_b32 s6, s6, s7
	s_branch .LBB1_3
.LBB1_6:                                ; %Flow8
	s_or_b32 exec_lo, exec_lo, s4
	s_branch .LBB1_8
.LBB1_7:
	s_branch .LBB1_6
.LBB1_8:                                ; %.exit3
	s_mov_b32 s8, 32
	v_lshrrev_b64 v[0:1], s8, v[6:7]
	v_readfirstlane_b32 s4, v6
	v_readfirstlane_b32 s6, v0
	s_lshl_b64 s[6:7], s[6:7], s8
	s_mov_b32 s5, 0
	s_or_b64 s[6:7], s[6:7], s[4:5]
	v_mov_b32_e32 v0, s7
	buffer_store_dword v0, off, s[0:3], s33 offset:100
	v_mov_b32_e32 v0, s6
	buffer_store_dword v0, off, s[0:3], s33 offset:96
	buffer_load_dword v0, off, s[0:3], s33 offset:88
	buffer_load_dword v1, off, s[0:3], s33 offset:92
	buffer_load_dword v2, off, s[0:3], s33 offset:96
	buffer_load_dword v3, off, s[0:3], s33 offset:100
	s_waitcnt vmcnt(2)
	global_load_dwordx2 v[4:5], v[0:1], off
	global_load_dwordx2 v[0:1], v[0:1], off offset:40
	s_waitcnt vmcnt(0)
	v_and_b32_e64 v1, v3, v1
	v_and_b32_e64 v0, v2, v0
	v_lshrrev_b64 v[1:2], s8, v[0:1]
	s_mov_b32 s4, 24
	v_mul_lo_u32 v2, v1, s4
	v_mad_u64_u32 v[0:1], s4, v0, s4, 0
	v_add_nc_u32_e64 v1, v1, v2
	v_lshlrev_b64 v[1:2], s8, v[1:2]
	v_mov_b32_e32 v3, s5
	v_or_b32_e64 v2, v3, v2
	v_or_b32_e64 v0, v0, v1
	v_add_co_u32 v0, s4, v4, v0
	v_add_co_ci_u32_e64 v1, s4, v5, v2, s4
	buffer_store_dword v1, off, s[0:3], s33 offset:108
	buffer_store_dword v0, off, s[0:3], s33 offset:104
	buffer_load_dword v0, off, s[0:3], s33 offset:88
	buffer_load_dword v1, off, s[0:3], s33 offset:92
	buffer_load_dword v2, off, s[0:3], s33 offset:96
	buffer_load_dword v3, off, s[0:3], s33 offset:100
	s_waitcnt vmcnt(2)
	global_load_dwordx2 v[4:5], v[0:1], off offset:8
	global_load_dwordx2 v[0:1], v[0:1], off offset:40
	s_waitcnt vmcnt(0)
	v_and_b32_e64 v1, v3, v1
	v_and_b32_e64 v0, v2, v0
	s_mov_b32 s4, 12
	v_lshlrev_b64 v[0:1], s4, v[0:1]
	v_add_co_u32 v0, s4, v4, v0
	v_add_co_ci_u32_e64 v1, s4, v5, v1, s4
	buffer_store_dword v1, off, s[0:3], s33 offset:116
	buffer_store_dword v0, off, s[0:3], s33 offset:112
	buffer_load_dword v0, off, s[0:3], s33 offset:112
	buffer_load_dword v1, off, s[0:3], s33 offset:116
	buffer_load_dword v2, off, s[0:3], s33 offset:16
	buffer_load_dword v3, off, s[0:3], s33 offset:20
	buffer_load_dword v4, off, s[0:3], s33 offset:24
	buffer_load_dword v5, off, s[0:3], s33 offset:28
	buffer_load_dword v6, off, s[0:3], s33 offset:32
	buffer_load_dword v7, off, s[0:3], s33 offset:36
	buffer_load_dword v8, off, s[0:3], s33 offset:40
	buffer_load_dword v9, off, s[0:3], s33 offset:44
	buffer_load_dword v10, off, s[0:3], s33 offset:48
	buffer_load_dword v11, off, s[0:3], s33 offset:52
	buffer_load_dword v12, off, s[0:3], s33 offset:56
	buffer_load_dword v13, off, s[0:3], s33 offset:60
	buffer_load_dword v14, off, s[0:3], s33 offset:64
	buffer_load_dword v15, off, s[0:3], s33 offset:68
	buffer_load_dword v16, off, s[0:3], s33 offset:72
	buffer_load_dword v17, off, s[0:3], s33 offset:76
	buffer_load_dword v18, off, s[0:3], s33 offset:80
	buffer_load_dword v19, off, s[0:3], s33 offset:84
	s_mov_b64 s[4:5], exec
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e64 s7, v18, v19
	s_mov_b32 s6, exec_lo
	s_and_b32 s7, s6, s7
	s_mov_b32 exec_lo, s7
	s_cbranch_execz .LBB1_10
; %bb.9:
	buffer_load_dword v19, off, s[0:3], s33 offset:104
	buffer_load_dword v20, off, s[0:3], s33 offset:108
	buffer_load_dword v21, off, s[0:3], s33 offset:8
	s_waitcnt vmcnt(0)
	global_store_dword v[19:20], v21, off offset:16
	v_mov_b32_e32 v22, s5
	v_mov_b32_e32 v21, s4
	global_store_dwordx2 v[19:20], v[21:22], off offset:8
	v_mov_b32_e32 v21, 1
	global_store_dword v[19:20], v21, off offset:20
.LBB1_10:                               ; %.exit4
	s_or_b32 exec_lo, exec_lo, s6
	s_mov_b32 s4, 0
	v_mov_b32_e32 v19, 0
	s_mov_b32 s4, 6
	v_lshlrev_b64 v[18:19], s4, v[18:19]
	v_add_co_u32 v0, s4, v0, v18
	v_add_co_ci_u32_e64 v1, s4, v1, v19, s4
	global_store_dwordx2 v[0:1], v[2:3], off
	global_store_dwordx2 v[0:1], v[4:5], off offset:8
	global_store_dwordx2 v[0:1], v[6:7], off offset:16
	global_store_dwordx2 v[0:1], v[8:9], off offset:24
	global_store_dwordx2 v[0:1], v[10:11], off offset:32
	global_store_dwordx2 v[0:1], v[12:13], off offset:40
	global_store_dwordx2 v[0:1], v[14:15], off offset:48
	global_store_dwordx2 v[0:1], v[16:17], off offset:56
	buffer_load_dword v0, off, s[0:3], s33 offset:80
	buffer_load_dword v1, off, s[0:3], s33 offset:84
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e64 s4, v0, v1
	s_mov_b32 s12, exec_lo
	s_and_b32 s4, s12, s4
	s_mov_b32 exec_lo, s4
	s_cbranch_execz .LBB1_15
; %bb.11:
	buffer_load_dword v4, off, s[0:3], s33 offset:88
	buffer_load_dword v5, off, s[0:3], s33 offset:92
	buffer_load_dword v0, off, s[0:3], s33 offset:96
	buffer_load_dword v1, off, s[0:3], s33 offset:100
	s_mov_b64 s[4:5], 32
	s_waitcnt vmcnt(3)
	v_add_co_u32 v6, s4, v4, s4
	s_waitcnt vmcnt(2)
	v_add_co_ci_u32_e64 v7, s4, v5, s5, s4
	global_load_dwordx2 v[10:11], v[4:5], off offset:32 glc dlc
	global_load_dwordx2 v[2:3], v[4:5], off
	global_load_dwordx2 v[8:9], v[4:5], off offset:40
	s_waitcnt vmcnt(0)
	v_and_b32_e64 v9, v9, v1
	v_and_b32_e64 v8, v8, v0
	s_mov_b32 s4, 32
	v_lshrrev_b64 v[12:13], s4, v[8:9]
	s_mov_b32 s5, 24
	v_mul_lo_u32 v12, v12, s5
	v_mad_u64_u32 v[8:9], s5, v8, s5, 0
	v_add_nc_u32_e64 v9, v9, v12
	v_lshlrev_b64 v[12:13], s4, v[9:10]
	s_mov_b32 s4, 0
	v_mov_b32_e32 v9, 0
	v_or_b32_e64 v9, v9, v13
	v_or_b32_e64 v8, v8, v12
	v_add_co_u32 v8, s4, v2, v8
	v_add_co_ci_u32_e64 v9, s4, v3, v9, s4
	global_store_dwordx2 v[8:9], v[10:11], off
	v_mov_b32_e32 v2, v10
	v_mov_b32_e32 v3, v11
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_cmpswap_x2 v[2:3], v[4:5], v[0:3], off offset:32 glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e64 s4, v[2:3], v[10:11]
	v_cmp_ne_u64_e64 s5, v[2:3], v[10:11]
	s_mov_b32 s4, exec_lo
	s_and_b32 s5, s4, s5
	s_mov_b32 exec_lo, s5
	s_cbranch_execz .LBB1_14
; %bb.12:                               ; %.preheader5
	s_mov_b32 s5, 0
.LBB1_13:                               ; =>This Inner Loop Header: Depth=1
                                        ; implicit-def: $sgpr6
	s_sleep 1
	global_store_dwordx2 v[8:9], v[2:3], off
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_cmpswap_x2 v[10:11], v[6:7], v[0:3], off glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e64 s6, v[10:11], v[2:3]
	s_or_b32 s5, s6, s5
	v_mov_b32_e32 v2, v10
	v_mov_b32_e32 v3, v11
	s_andn2_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB1_13
.LBB1_14:                               ; %Flow4
	s_or_b32 exec_lo, exec_lo, s4
	s_branch .LBB1_16
.LBB1_15:                               ; %Flow5
	s_or_b32 exec_lo, exec_lo, s12
	s_branch .LBB1_17
.LBB1_16:
	global_load_dwordx2 v[0:1], v[4:5], off offset:16
	s_mov_b32 s4, 32
	s_waitcnt vmcnt(0)
	v_lshrrev_b64 v[1:2], s4, v[0:1]
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, __ockl_hsa_signal_add@rel32@lo+4
	s_addc_u32 s5, s5, __ockl_hsa_signal_add@rel32@hi+12
	v_mov_b32_e32 v2, 1
	v_mov_b32_e32 v3, 0
	v_mov_b32_e32 v4, 3
	s_swappc_b64 s[30:31], s[4:5]
	s_branch .LBB1_15
.LBB1_17:                               ; %.exit2
	buffer_load_dword v3, off, s[0:3], s33 offset:104
	buffer_load_dword v4, off, s[0:3], s33 offset:108
	buffer_load_dword v0, off, s[0:3], s33 offset:112
	buffer_load_dword v1, off, s[0:3], s33 offset:116
	buffer_load_dword v2, off, s[0:3], s33 offset:80
	buffer_load_dword v5, off, s[0:3], s33 offset:84
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e64 s4, v2, v5
	s_mov_b64 s[6:7], 20
	v_add_co_u32 v3, s5, v3, s6
	v_add_co_ci_u32_e64 v4, s5, v4, s7, s5
.LBB1_18:                               ; =>This Inner Loop Header: Depth=1
	s_mov_b32 s5, 1
	v_mov_b32_e32 v5, 1
	s_mov_b32 s5, exec_lo
	s_and_b32 s6, s5, s4
	s_mov_b32 exec_lo, s6
	s_cbranch_execz .LBB1_20
; %bb.19:                               ;   in Loop: Header=BB1_18 Depth=1
	global_load_dword v5, v[3:4], off glc dlc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	s_mov_b32 s6, 1
	v_and_b32_e64 v5, v5, s6
.LBB1_20:                               ;   in Loop: Header=BB1_18 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_readfirstlane_b32 s6, v5
	s_mov_b32 s5, -1
	s_mov_b32 s7, 0
	s_cmp_eq_u32 s6, s7
	s_cselect_b32 s6, -1, 0
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB1_22
; %bb.21:                               ;   in Loop: Header=BB1_18 Depth=1
	s_sleep 1
	s_mov_b32 s5, 0
.LBB1_22:                               ; %Flow2
                                        ;   in Loop: Header=BB1_18 Depth=1
	v_cndmask_b32_e64 v5, 0, 1, s5
	s_mov_b32 s5, 1
	v_cmp_ne_u32_e64 s5, v5, s5
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB1_18
; %bb.23:                               ; %.exit1
	s_mov_b32 s4, 0
	v_mov_b32_e32 v3, 0
	s_mov_b32 s4, 6
	v_lshlrev_b64 v[2:3], s4, v[2:3]
	v_add_co_u32 v0, s4, v0, v2
	v_add_co_ci_u32_e64 v1, s4, v1, v3, s4
	global_load_dwordx2 v[2:3], v[0:1], off
	global_load_dwordx2 v[0:1], v[0:1], off offset:8
	s_waitcnt vmcnt(0)
	buffer_store_dword v1, off, s[0:3], s33 offset:140
	buffer_store_dword v0, off, s[0:3], s33 offset:136
	buffer_store_dword v3, off, s[0:3], s33 offset:132
	buffer_store_dword v2, off, s[0:3], s33 offset:128
	buffer_load_dword v0, off, s[0:3], s33 offset:80
	buffer_load_dword v1, off, s[0:3], s33 offset:84
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e64 s5, v0, v1
	s_mov_b32 s4, exec_lo
	s_and_b32 s5, s4, s5
	s_mov_b32 exec_lo, s5
	s_cbranch_execz .LBB1_27
; %bb.24:
	buffer_load_dword v8, off, s[0:3], s33 offset:88
	buffer_load_dword v9, off, s[0:3], s33 offset:92
	buffer_load_dword v0, off, s[0:3], s33 offset:96
	buffer_load_dword v1, off, s[0:3], s33 offset:100
	s_waitcnt vmcnt(2)
	global_load_dwordx2 v[2:3], v[8:9], off offset:40
	s_mov_b64 s[6:7], 1
	s_waitcnt vmcnt(0)
	v_add_co_u32 v4, s5, v2, s6
	v_add_co_ci_u32_e64 v5, s5, v3, s7, s5
	v_add_co_u32 v0, s5, v4, v0
	v_add_co_ci_u32_e64 v1, s5, v5, v1, s5
	s_mov_b64 s[6:7], 0
	v_cmp_eq_u64_e64 s5, v[0:1], s[6:7]
	v_cndmask_b32_e64 v1, v1, v5, s5
	v_cndmask_b32_e64 v0, v0, v4, s5
	s_mov_b64 s[6:7], 24
	v_add_co_u32 v4, s5, v8, s6
	v_add_co_ci_u32_e64 v5, s5, v9, s7, s5
	global_load_dwordx2 v[10:11], v[8:9], off offset:24 glc dlc
	global_load_dwordx2 v[6:7], v[8:9], off
	v_and_b32_e64 v3, v1, v3
	v_and_b32_e64 v2, v0, v2
	s_mov_b32 s5, 32
	v_lshrrev_b64 v[12:13], s5, v[2:3]
	s_mov_b32 s6, 24
	v_mul_lo_u32 v12, v12, s6
	v_mad_u64_u32 v[2:3], s6, v2, s6, 0
	v_add_nc_u32_e64 v3, v3, v12
	v_lshlrev_b64 v[12:13], s5, v[3:4]
	s_mov_b32 s5, 0
	v_mov_b32_e32 v3, 0
	v_or_b32_e64 v3, v3, v13
	v_or_b32_e64 v2, v2, v12
	s_waitcnt vmcnt(0)
	v_add_co_u32 v6, s5, v6, v2
	v_add_co_ci_u32_e64 v7, s5, v7, v3, s5
	global_store_dwordx2 v[6:7], v[10:11], off
	v_mov_b32_e32 v2, v10
	v_mov_b32_e32 v3, v11
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_cmpswap_x2 v[2:3], v[8:9], v[0:3], off offset:24 glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e64 s5, v[2:3], v[10:11]
	v_cmp_ne_u64_e64 s5, v[2:3], v[10:11]
	s_mov_b32 s6, exec_lo
	s_and_b32 s5, s6, s5
	s_mov_b32 exec_lo, s5
	s_cbranch_execz .LBB1_27
; %bb.25:                               ; %.preheader
	s_mov_b32 s5, 0
.LBB1_26:                               ; =>This Inner Loop Header: Depth=1
                                        ; implicit-def: $sgpr6
	s_sleep 1
	global_store_dwordx2 v[6:7], v[2:3], off
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_cmpswap_x2 v[8:9], v[4:5], v[0:3], off glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e64 s6, v[8:9], v[2:3]
	s_or_b32 s5, s6, s5
	v_mov_b32_e32 v2, v8
	v_mov_b32_e32 v3, v9
	s_andn2_b32 exec_lo, exec_lo, s5
	s_cbranch_execnz .LBB1_26
.LBB1_27:                               ; %.exit
	s_or_b32 exec_lo, exec_lo, s4
	buffer_load_dword v0, off, s[0:3], s33 offset:128
	buffer_load_dword v1, off, s[0:3], s33 offset:132
	buffer_load_dword v2, off, s[0:3], s33 offset:136
	buffer_load_dword v3, off, s[0:3], s33 offset:140
	s_add_i32 s32, s32, 0xffffec00
	s_mov_b32 s33, s13
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	s_setpc_b64 s[10:11]
.Lfunc_end1:
	.size	__ockl_hostcall_internal, .Lfunc_end1-__ockl_hostcall_internal
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata
; Function info:
; codeLenInByte = 3020
; NumSgprs: 36
; NumVgprs: 23
; ScratchSize: 160
; MemoryBound: 0
	.text
	.p2align	2                               ; -- Begin function __ockl_dm_alloc
	.type	__ockl_dm_alloc,@function
__ockl_dm_alloc:                        ; @__ockl_dm_alloc
.Lfunc_begin2:
	.cfi_startproc
; %bb.0:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	v_cmp_ne_u64_e32 vcc_lo, 0, v[0:1]
	s_mov_b64 s[16:17], s[30:31]
	s_mov_b32 s34, s13
	s_mov_b32 s35, s12
	s_and_saveexec_b32 s64, vcc_lo
	s_cbranch_execz .LBB2_419
; %bb.1:
	s_mov_b32 s37, 0
	s_movk_i32 s36, 0xc01
	s_mov_b64 s[20:21], s[10:11]
	v_cmp_gt_u64_e32 vcc_lo, s[36:37], v[0:1]
	s_mov_b64 s[18:19], s[8:9]
	s_mov_b64 s[22:23], s[6:7]
	s_mov_b64 s[24:25], s[4:5]
	s_and_saveexec_b32 s4, vcc_lo
	s_xor_b32 s65, exec_lo, s4
	s_cbranch_execz .LBB2_415
; %bb.2:
	v_max_u32_e32 v0, 16, v0
	s_load_dwordx2 s[38:39], s[18:19], 0x60
	v_mov_b32_e32 v25, 0
	s_movk_i32 s66, 0x800
	s_movk_i32 s67, 0x1000
	v_ffbh_u32_e32 v1, v0
	s_movk_i32 s68, 0x2000
	v_mov_b32_e32 v28, v25
	s_movk_i32 s69, 0x1800
	s_movk_i32 s48, 0xbf
	v_min_u32_e32 v1, 32, v1
	s_mov_b32 s49, s37
	v_mov_b32_e32 v29, v25
	v_mov_b32_e32 v30, v25
	v_mov_b32_e32 v41, 1
	v_sub_nc_u32_e32 v2, 31, v1
	v_mul_i32_i24_e32 v1, -2, v1
	v_mov_b32_e32 v40, 0x100
	v_mov_b32_e32 v42, 1
	s_ff1_i32_b32 s85, 0
	v_lshlrev_b32_e64 v2, v2, 1
	s_waitcnt lgkmcnt(0)
	s_add_u32 s40, s38, 0x1a800
	s_addc_u32 s41, s39, 0
	s_add_u32 s42, s38, 0x1a808
	s_addc_u32 s43, s39, 0
	v_lshrrev_b32_e32 v3, 1, v2
	v_cmp_gt_u32_e32 vcc_lo, v0, v2
	s_add_u32 s4, s38, s66
	s_addc_u32 s5, s39, 0
	s_getpc_b64 s[44:45]
	s_add_u32 s44, s44, __unnamed_1@rel32@lo+12
	s_addc_u32 s45, s45, __unnamed_1@rel32@hi+20
	v_or_b32_e32 v2, v3, v2
	v_cndmask_b32_e64 v4, 0, 1, vcc_lo
	s_getpc_b64 s[46:47]
	s_add_u32 s46, s46, __unnamed_1@rel32@lo+4
	s_addc_u32 s47, s47, __unnamed_1@rel32@hi+12
	s_add_u32 s6, s38, s67
	s_addc_u32 s7, s39, 0
	v_cmp_gt_u32_e32 vcc_lo, v0, v2
	v_or_b32_e32 v1, v1, v4
	s_mov_b32 s70, 0x10100
	s_mov_b32 s71, 0xff00ff01
	s_movk_i32 s72, 0x100
	s_movk_i32 s73, 0x2800
	v_add_co_ci_u32_e32 v27, vcc_lo, 54, v1, vcc_lo
	s_movk_i32 s74, 0xff00
	s_movk_i32 s75, 0xff
	s_mov_b32 s96, 0x4f7ffffe
	v_lshlrev_b64 v[0:1], 7, v[27:28]
	v_lshlrev_b64 v[2:3], 5, v[27:28]
	v_lshrrev_b64 v[4:5], v27, s[48:49]
	v_cmp_ne_u32_e64 s26, 2, v27
	s_movk_i32 s36, 0x752f
	s_movk_i32 s76, 0x300
	v_add_co_u32 v36, vcc_lo, s4, v0
	v_add_co_ci_u32_e32 v37, vcc_lo, s5, v1, vcc_lo
	v_add_co_u32 v38, vcc_lo, s38, v0
	v_add_co_ci_u32_e32 v39, vcc_lo, s39, v1, vcc_lo
	v_add_co_u32 v48, vcc_lo, v2, s44
	v_add_co_ci_u32_e32 v49, vcc_lo, s45, v3, vcc_lo
	v_add_co_u32 v50, vcc_lo, v2, s46
	v_add_co_ci_u32_e32 v51, vcc_lo, s47, v3, vcc_lo
	v_add_co_u32 v52, vcc_lo, s6, v0
	s_add_u32 s4, s38, s68
	v_add_co_ci_u32_e32 v53, vcc_lo, s7, v1, vcc_lo
	s_addc_u32 s5, s39, 0
	v_add_co_u32 v54, vcc_lo, s4, v0
	s_add_u32 s4, s38, s69
	v_add_co_ci_u32_e32 v55, vcc_lo, s5, v1, vcc_lo
	s_addc_u32 s5, s39, 0
	v_add_co_u32 v64, vcc_lo, s4, v0
	s_getpc_b64 s[50:51]
	s_add_u32 s50, s50, __unnamed_1@rel32@lo+24
	s_addc_u32 s51, s51, __unnamed_1@rel32@hi+32
	v_add_co_ci_u32_e32 v65, vcc_lo, s5, v1, vcc_lo
	v_add_co_u32 v66, vcc_lo, v2, s50
	s_getpc_b64 s[52:53]
	s_add_u32 s52, s52, __unnamed_1@rel32@lo+20
	s_addc_u32 s53, s53, __unnamed_1@rel32@hi+28
	v_add_co_ci_u32_e32 v67, vcc_lo, s51, v3, vcc_lo
	v_and_b32_e32 v0, 1, v4
	v_add_co_u32 v68, vcc_lo, v2, s52
	s_getpc_b64 s[54:55]
	s_add_u32 s54, s54, __unnamed_1@rel32@lo+28
	s_addc_u32 s55, s55, __unnamed_1@rel32@hi+36
	v_add_co_ci_u32_e32 v69, vcc_lo, s53, v3, vcc_lo
	v_add_co_u32 v70, vcc_lo, v2, s54
	v_cmp_eq_u32_e64 s15, 1, v0
	v_add_co_ci_u32_e32 v71, vcc_lo, s55, v3, vcc_lo
	s_getpc_b64 s[56:57]
	s_add_u32 s56, s56, __unnamed_1@rel32@lo+8
	s_addc_u32 s57, s57, __unnamed_1@rel32@hi+16
	s_movk_i32 s77, 0x2ff
	s_movk_i32 s58, 0x7530
	s_movk_i32 s78, 0x659
	s_movk_i32 s79, 0x326
	s_movk_i32 s80, 0x18c
	s_movk_i32 s81, 0xc0
	s_movk_i32 s82, 0x59
	s_movk_i32 s60, 0x4e1f
	s_mov_b32 s83, 0x200000
	s_mov_b32 s84, 0x1ffffffc
	s_movk_i32 s62, 0x4e20
	s_add_i32 s85, s85, 32
	s_branch .LBB2_5
.LBB2_3:                                ; %Flow391
                                        ;   in Loop: Header=BB2_5 Depth=1
	s_or_b32 exec_lo, exec_lo, s87
	v_mov_b32_e32 v0, v41
.LBB2_4:                                ; %.loopexit87
                                        ;   in Loop: Header=BB2_5 Depth=1
	s_or_b32 exec_lo, exec_lo, s86
	v_mov_b32_e32 v1, v0
	;;#ASMSTART
	; ockl ballot hoisting hack v1
	;;#ASMEND
	v_cmp_ne_u32_e32 vcc_lo, 0, v1
	v_mov_b32_e32 v41, v0
                                        ; implicit-def: $vgpr0_vgpr1
	v_cmp_ne_u32_e64 s4, vcc_lo, 0
	s_and_b32 s4, s4, exec_lo
	s_cbranch_scc0 .LBB2_415
.LBB2_5:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_11 Depth 2
                                        ;       Child Loop BB2_228 Depth 3
                                        ;         Child Loop BB2_233 Depth 4
                                        ;         Child Loop BB2_258 Depth 4
                                        ;           Child Loop BB2_277 Depth 5
                                        ;           Child Loop BB2_282 Depth 5
                                        ;           Child Loop BB2_300 Depth 5
                                        ;           Child Loop BB2_302 Depth 5
                                        ;           Child Loop BB2_304 Depth 5
                                        ;           Child Loop BB2_306 Depth 5
                                        ;           Child Loop BB2_308 Depth 5
                                        ;           Child Loop BB2_310 Depth 5
                                        ;           Child Loop BB2_312 Depth 5
                                        ;           Child Loop BB2_333 Depth 5
                                        ;           Child Loop BB2_336 Depth 5
                                        ;           Child Loop BB2_341 Depth 5
                                        ;           Child Loop BB2_353 Depth 5
                                        ;         Child Loop BB2_383 Depth 4
                                        ;         Child Loop BB2_385 Depth 4
                                        ;         Child Loop BB2_387 Depth 4
                                        ;         Child Loop BB2_389 Depth 4
                                        ;         Child Loop BB2_391 Depth 4
                                        ;         Child Loop BB2_393 Depth 4
                                        ;         Child Loop BB2_395 Depth 4
                                        ;       Child Loop BB2_20 Depth 3
                                        ;         Child Loop BB2_24 Depth 4
                                        ;         Child Loop BB2_53 Depth 4
                                        ;           Child Loop BB2_58 Depth 5
                                        ;           Child Loop BB2_83 Depth 5
                                        ;             Child Loop BB2_102 Depth 6
                                        ;             Child Loop BB2_107 Depth 6
                                        ;             Child Loop BB2_125 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_129 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_133 Depth 6
                                        ;             Child Loop BB2_135 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_158 Depth 6
                                        ;             Child Loop BB2_161 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_178 Depth 6
                                        ;           Child Loop BB2_208 Depth 5
                                        ;           Child Loop BB2_210 Depth 5
                                        ;           Child Loop BB2_212 Depth 5
                                        ;           Child Loop BB2_214 Depth 5
                                        ;           Child Loop BB2_216 Depth 5
                                        ;           Child Loop BB2_218 Depth 5
                                        ;           Child Loop BB2_220 Depth 5
                                        ;       Child Loop BB2_404 Depth 3
	;;#ASMSTART
	; O0 v41
	;;#ASMEND
	v_cmp_ne_u32_e32 vcc_lo, 0, v41
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s86, vcc_lo
	s_cbranch_execz .LBB2_4
; %bb.6:                                ;   in Loop: Header=BB2_5 Depth=1
	v_readfirstlane_b32 s4, v27
	v_cmp_eq_u32_e32 vcc_lo, s4, v27
	s_and_saveexec_b32 s87, vcc_lo
	s_cbranch_execz .LBB2_3
; %bb.7:                                ; %.preheader86.preheader
                                        ;   in Loop: Header=BB2_5 Depth=1
	v_mov_b32_e32 v0, 1
	s_branch .LBB2_11
.LBB2_8:                                ; %Flow
                                        ;   in Loop: Header=BB2_11 Depth=2
	s_or_b32 exec_lo, exec_lo, s4
	v_mov_b32_e32 v0, v43
	v_mov_b32_e32 v1, v41
.LBB2_9:                                ; %Flow126
                                        ;   in Loop: Header=BB2_11 Depth=2
	v_mov_b32_e32 v41, v1
.LBB2_10:                               ; %Flow389
                                        ;   in Loop: Header=BB2_11 Depth=2
	s_or_b32 exec_lo, exec_lo, s88
	v_mov_b32_e32 v1, v0
	;;#ASMSTART
	; ockl ballot hoisting hack v1
	;;#ASMEND
	v_cmp_ne_u32_e32 vcc_lo, 0, v1
	v_cmp_ne_u32_e64 s4, vcc_lo, 0
	s_and_b32 s4, s4, exec_lo
	s_cbranch_scc0 .LBB2_3
.LBB2_11:                               ; %.preheader86
                                        ;   Parent Loop BB2_5 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_228 Depth 3
                                        ;         Child Loop BB2_233 Depth 4
                                        ;         Child Loop BB2_258 Depth 4
                                        ;           Child Loop BB2_277 Depth 5
                                        ;           Child Loop BB2_282 Depth 5
                                        ;           Child Loop BB2_300 Depth 5
                                        ;           Child Loop BB2_302 Depth 5
                                        ;           Child Loop BB2_304 Depth 5
                                        ;           Child Loop BB2_306 Depth 5
                                        ;           Child Loop BB2_308 Depth 5
                                        ;           Child Loop BB2_310 Depth 5
                                        ;           Child Loop BB2_312 Depth 5
                                        ;           Child Loop BB2_333 Depth 5
                                        ;           Child Loop BB2_336 Depth 5
                                        ;           Child Loop BB2_341 Depth 5
                                        ;           Child Loop BB2_353 Depth 5
                                        ;         Child Loop BB2_383 Depth 4
                                        ;         Child Loop BB2_385 Depth 4
                                        ;         Child Loop BB2_387 Depth 4
                                        ;         Child Loop BB2_389 Depth 4
                                        ;         Child Loop BB2_391 Depth 4
                                        ;         Child Loop BB2_393 Depth 4
                                        ;         Child Loop BB2_395 Depth 4
                                        ;       Child Loop BB2_20 Depth 3
                                        ;         Child Loop BB2_24 Depth 4
                                        ;         Child Loop BB2_53 Depth 4
                                        ;           Child Loop BB2_58 Depth 5
                                        ;           Child Loop BB2_83 Depth 5
                                        ;             Child Loop BB2_102 Depth 6
                                        ;             Child Loop BB2_107 Depth 6
                                        ;             Child Loop BB2_125 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_129 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_133 Depth 6
                                        ;             Child Loop BB2_135 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_158 Depth 6
                                        ;             Child Loop BB2_161 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_178 Depth 6
                                        ;           Child Loop BB2_208 Depth 5
                                        ;           Child Loop BB2_210 Depth 5
                                        ;           Child Loop BB2_212 Depth 5
                                        ;           Child Loop BB2_214 Depth 5
                                        ;           Child Loop BB2_216 Depth 5
                                        ;           Child Loop BB2_218 Depth 5
                                        ;           Child Loop BB2_220 Depth 5
                                        ;       Child Loop BB2_404 Depth 3
	v_mov_b32_e32 v43, v0
	;;#ASMSTART
	; O0 v43
	;;#ASMEND
	v_cmp_ne_u32_e32 vcc_lo, 0, v43
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s88, vcc_lo
	s_cbranch_execz .LBB2_10
; %bb.12:                               ;   in Loop: Header=BB2_11 Depth=2
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	v_mbcnt_hi_u32_b32 v0, exec_hi, v0
	;;#ASMSTART
	; O0 v0
	;;#ASMEND
	v_cmp_eq_u32_e32 vcc_lo, 0, v0
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_14
; %bb.13:                               ;   in Loop: Header=BB2_11 Depth=2
	global_load_dword v0, v[36:37], off glc dlc
.LBB2_14:                               ;   in Loop: Header=BB2_11 Depth=2
	s_or_b32 exec_lo, exec_lo, s4
	v_mbcnt_lo_u32_b32 v1, exec_lo, 0
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s90, v0
	s_bcnt1_i32_b64 s89, exec
	v_mbcnt_hi_u32_b32 v44, exec_hi, v1
	s_cmp_lt_u32 s90, s70
	s_cbranch_scc1 .LBB2_223
; %bb.15:                               ; %.preheader84.preheader
                                        ;   in Loop: Header=BB2_11 Depth=2
	v_mov_b32_e32 v24, v27
	v_mov_b32_e32 v45, v44
	s_mov_b32 s91, 0
                                        ; implicit-def: $vgpr80_vgpr81
	s_branch .LBB2_20
.LBB2_16:                               ;   in Loop: Header=BB2_20 Depth=3
	v_mov_b32_e32 v24, v32
.LBB2_17:                               ; %Flow247
                                        ;   in Loop: Header=BB2_20 Depth=3
	v_mov_b32_e32 v0, v80
	v_mov_b32_e32 v1, v81
	s_and_b32 s5, s4, exec_lo
.LBB2_18:                               ; %Flow249
                                        ;   in Loop: Header=BB2_20 Depth=3
	s_or_b32 exec_lo, exec_lo, s92
	v_mov_b32_e32 v81, v1
	v_mov_b32_e32 v80, v0
.LBB2_19:                               ; %.loopexit62
                                        ;   in Loop: Header=BB2_20 Depth=3
	s_xor_b32 s4, s5, -1
	s_and_b32 s4, exec_lo, s4
	s_or_b32 s91, s4, s91
	s_andn2_b32 exec_lo, exec_lo, s91
	s_cbranch_execz .LBB2_224
.LBB2_20:                               ; %.preheader84
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_24 Depth 4
                                        ;         Child Loop BB2_53 Depth 4
                                        ;           Child Loop BB2_58 Depth 5
                                        ;           Child Loop BB2_83 Depth 5
                                        ;             Child Loop BB2_102 Depth 6
                                        ;             Child Loop BB2_107 Depth 6
                                        ;             Child Loop BB2_125 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_129 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_133 Depth 6
                                        ;             Child Loop BB2_135 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_158 Depth 6
                                        ;             Child Loop BB2_161 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_178 Depth 6
                                        ;           Child Loop BB2_208 Depth 5
                                        ;           Child Loop BB2_210 Depth 5
                                        ;           Child Loop BB2_212 Depth 5
                                        ;           Child Loop BB2_214 Depth 5
                                        ;           Child Loop BB2_216 Depth 5
                                        ;           Child Loop BB2_218 Depth 5
                                        ;           Child Loop BB2_220 Depth 5
	v_lshlrev_b64 v[0:1], 7, v[24:25]
	;;#ASMSTART
	; O0 v45
	;;#ASMEND
	v_cmp_eq_u32_e64 s4, 0, v45
	v_mov_b32_e32 v2, 0
	v_add_co_u32 v0, vcc_lo, s38, v0
	v_add_co_ci_u32_e32 v1, vcc_lo, s39, v1, vcc_lo
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_22
; %bb.21:                               ;   in Loop: Header=BB2_20 Depth=3
	global_load_dword v2, v[0:1], off glc dlc
.LBB2_22:                               ;   in Loop: Header=BB2_20 Depth=3
	s_or_b32 exec_lo, exec_lo, s5
	v_lshlrev_b64 v[3:4], 5, v[24:25]
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s5, v2
	v_add_nc_u32_e32 v2, s5, v45
	v_add_co_u32 v3, vcc_lo, v3, s56
	v_add_co_ci_u32_e32 v4, vcc_lo, s57, v4, vcc_lo
	s_mov_b32 s5, 0x10100
	global_load_dword v4, v[3:4], off
	v_mul_hi_u32 v3, v2, s71
	v_mul_u32_u24_sdwa v3, v3, s5 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
	v_sub_nc_u32_e32 v5, v2, v3
	s_branch .LBB2_24
.LBB2_23:                               ; %Flow260
                                        ;   in Loop: Header=BB2_24 Depth=4
	s_andn2_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccz .LBB2_44
.LBB2_24:                               ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	v_cmp_gt_u32_e32 vcc_lo, s72, v5
                                        ; implicit-def: $vgpr2_vgpr3
	s_and_saveexec_b32 s6, vcc_lo
	s_xor_b32 s6, exec_lo, s6
; %bb.25:                               ;   in Loop: Header=BB2_24 Depth=4
	s_add_u32 s8, s38, s73
	s_addc_u32 s9, s39, 0
	v_mad_u64_u32 v[2:3], s7, v24, s69, s[8:9]
	v_mad_u64_u32 v[2:3], s7, v5, 24, v[2:3]
; %bb.26:                               ; %Flow258
                                        ;   in Loop: Header=BB2_24 Depth=4
	s_or_saveexec_b32 s6, s6
	s_xor_b32 exec_lo, exec_lo, s6
	s_cbranch_execz .LBB2_28
; %bb.27:                               ;   in Loop: Header=BB2_24 Depth=4
	s_add_u32 s8, s38, s73
	v_add_nc_u32_e32 v6, s74, v5
	s_addc_u32 s9, s39, 0
	v_mad_u64_u32 v[2:3], s7, v24, s69, s[8:9]
	v_lshrrev_b32_e32 v6, 8, v6
	v_mad_u64_u32 v[2:3], s7, v6, 24, v[2:3]
	v_and_b32_e32 v6, s75, v5
	global_load_dwordx2 v[2:3], v[2:3], off glc dlc
	s_waitcnt vmcnt(0)
	v_mad_u64_u32 v[2:3], s7, v6, 24, v[2:3]
.LBB2_28:                               ;   in Loop: Header=BB2_24 Depth=4
	s_or_b32 exec_lo, exec_lo, s6
	global_load_dword v2, v[2:3], off offset:16 glc dlc
	s_waitcnt vmcnt(0)
	v_cmp_lt_u32_e32 vcc_lo, v2, v4
	v_cmp_eq_u32_e64 s6, vcc_lo, 0
	s_and_b32 s6, s6, exec_lo
	s_cbranch_scc1 .LBB2_30
; %bb.29:                               ;   in Loop: Header=BB2_24 Depth=4
	s_ff1_i32_b32 s6, vcc_lo
	s_min_u32 s6, s6, s85
	s_lshl_b32 s6, s6, 2
	v_mov_b32_e32 v2, s6
	ds_bpermute_b32 v2, v2, v5
	s_branch .LBB2_31
.LBB2_30:                               ;   in Loop: Header=BB2_24 Depth=4
	v_mov_b32_e32 v2, -1
.LBB2_31:                               ;   in Loop: Header=BB2_24 Depth=4
	s_waitcnt lgkmcnt(0)
	v_readfirstlane_b32 s7, v2
	s_cmp_eq_u32 s7, -1
	s_cselect_b32 s6, -1, 0
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_34
; %bb.32:                               ;   in Loop: Header=BB2_24 Depth=4
	s_cmp_lt_u32 s7, s72
	s_cbranch_scc0 .LBB2_36
; %bb.33:                               ;   in Loop: Header=BB2_24 Depth=4
	s_add_u32 s8, s38, s73
	s_addc_u32 s9, s39, 0
	v_mad_u64_u32 v[2:3], s8, v24, s69, s[8:9]
	v_mad_u64_u32 v[2:3], s8, s7, 24, v[2:3]
	s_cbranch_execnz .LBB2_38
	s_branch .LBB2_37
.LBB2_34:                               ;   in Loop: Header=BB2_24 Depth=4
                                        ; implicit-def: $vgpr2_vgpr3
	s_branch .LBB2_39
.LBB2_35:                               ;   in Loop: Header=BB2_24 Depth=4
	v_mov_b32_e32 v81, v3
	v_mov_b32_e32 v80, v2
	s_branch .LBB2_42
.LBB2_36:                               ;   in Loop: Header=BB2_24 Depth=4
                                        ; implicit-def: $vgpr2_vgpr3
.LBB2_37:                               ;   in Loop: Header=BB2_24 Depth=4
	s_add_i32 s8, s7, s74
	s_lshr_b32 s10, s8, 8
	s_add_u32 s8, s38, s73
	s_addc_u32 s9, s39, 0
	s_and_b32 s7, s7, s75
	v_mad_u64_u32 v[2:3], s8, v24, s69, s[8:9]
	v_mad_u64_u32 v[2:3], s8, s10, 24, v[2:3]
	global_load_dwordx2 v[2:3], v[2:3], off glc dlc
	s_waitcnt vmcnt(0)
	v_mad_u64_u32 v[2:3], s7, s7, 24, v[2:3]
.LBB2_38:                               ; %Flow252
                                        ;   in Loop: Header=BB2_24 Depth=4
	s_cbranch_execnz .LBB2_35
.LBB2_39:                               ;   in Loop: Header=BB2_24 Depth=4
	v_add_nc_u32_e32 v2, s89, v5
	v_mul_hi_u32 v3, v2, s71
	v_mul_u32_u24_sdwa v3, v3, s70 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
	v_sub_nc_u32_e32 v5, v2, v3
	s_and_saveexec_b32 s7, s4
	s_cbranch_execz .LBB2_41
; %bb.40:                               ;   in Loop: Header=BB2_24 Depth=4
	global_store_dword v[0:1], v5, off
.LBB2_41:                               ;   in Loop: Header=BB2_24 Depth=4
	s_or_b32 exec_lo, exec_lo, s7
	s_sub_i32 s5, s5, s89
.LBB2_42:                               ;   in Loop: Header=BB2_24 Depth=4
	s_mov_b32 s7, -1
	s_andn2_b32 vcc_lo, exec_lo, s6
	s_mov_b32 s6, -1
	s_cbranch_vccnz .LBB2_23
; %bb.43:                               ;   in Loop: Header=BB2_24 Depth=4
	s_cmp_lt_i32 s5, 1
	s_mov_b32 s7, 0
	s_cselect_b32 s6, -1, 0
	s_branch .LBB2_23
.LBB2_44:                               ; %loop.exit.guard
                                        ;   in Loop: Header=BB2_20 Depth=3
	s_andn2_b32 vcc_lo, exec_lo, s7
	s_mov_b32 s5, 0
	s_cbranch_vccz .LBB2_19
; %bb.45:                               ;   in Loop: Header=BB2_20 Depth=3
	v_add_nc_u32_e32 v0, 2, v24
	v_cmp_eq_u32_e32 vcc_lo, v24, v27
	v_and_b32_e32 v32, -2, v0
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	v_cmp_gt_u32_e64 s5, 16, v32
	s_and_b32 s6, vcc_lo, s5
	s_mov_b32 s5, 0
	s_and_saveexec_b32 s92, s6
	s_cbranch_execz .LBB2_18
; %bb.46:                               ;   in Loop: Header=BB2_20 Depth=3
	v_mov_b32_e32 v33, v25
	s_add_u32 s5, s38, s66
	s_addc_u32 s6, s39, 0
	v_lshlrev_b64 v[0:1], 7, v[32:33]
	v_add_co_u32 v82, vcc_lo, s5, v0
	v_add_co_ci_u32_e32 v83, vcc_lo, s6, v1, vcc_lo
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_48
; %bb.47:                               ;   in Loop: Header=BB2_20 Depth=3
	global_load_dword v0, v[82:83], off glc dlc
.LBB2_48:                               ;   in Loop: Header=BB2_20 Depth=3
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s94, v0
	s_mov_b32 s4, -1
	s_cmp_gt_u32 s94, 0x100ff
	s_cbranch_scc1 .LBB2_16
; %bb.49:                               ;   in Loop: Header=BB2_20 Depth=3
	v_lshlrev_b64 v[0:1], 7, v[32:33]
	v_lshlrev_b64 v[2:3], 5, v[32:33]
	s_bcnt1_i32_b64 s93, exec
	s_add_u32 s4, s38, s67
	s_addc_u32 s5, s39, 0
	v_mbcnt_lo_u32_b32 v4, exec_lo, 0
	v_add_co_u32 v84, vcc_lo, s38, v0
	v_add_co_ci_u32_e32 v85, vcc_lo, s39, v1, vcc_lo
	v_add_co_u32 v86, vcc_lo, v2, s44
	v_add_co_ci_u32_e32 v87, vcc_lo, s45, v3, vcc_lo
	v_add_co_u32 v96, vcc_lo, v2, s46
	v_add_co_ci_u32_e32 v97, vcc_lo, s47, v3, vcc_lo
	v_add_co_u32 v98, vcc_lo, s4, v0
	s_add_u32 s4, s38, s68
	v_add_co_ci_u32_e32 v99, vcc_lo, s5, v1, vcc_lo
	s_addc_u32 s5, s39, 0
	v_add_co_u32 v100, vcc_lo, s4, v0
	s_mov_b32 s49, s37
	s_add_u32 s4, s38, s69
	v_add_co_ci_u32_e32 v101, vcc_lo, s5, v1, vcc_lo
	v_mbcnt_hi_u32_b32 v46, exec_hi, v4
	v_lshrrev_b64 v[4:5], v32, s[48:49]
	s_addc_u32 s5, s39, 0
	v_add_co_u32 v102, vcc_lo, s4, v0
	v_add_co_ci_u32_e32 v103, vcc_lo, s5, v1, vcc_lo
	v_add_co_u32 v112, vcc_lo, v2, s50
	v_add_co_ci_u32_e32 v113, vcc_lo, s51, v3, vcc_lo
	v_and_b32_e32 v0, 1, v4
	v_add_co_u32 v114, vcc_lo, v2, s52
	v_add_co_ci_u32_e32 v115, vcc_lo, s53, v3, vcc_lo
	v_add_co_u32 v116, vcc_lo, v2, s54
	v_cmp_eq_u32_e64 s27, 1, v0
	v_add_co_ci_u32_e32 v117, vcc_lo, s55, v3, vcc_lo
	v_cmp_ne_u32_e64 s28, 2, v32
	v_mov_b32_e32 v33, v25
	v_mov_b32_e32 v34, v25
	v_mov_b32_e32 v35, v25
                                        ; implicit-def: $vgpr80_vgpr81
                                        ; implicit-def: $sgpr4
	s_branch .LBB2_53
.LBB2_50:                               ;   in Loop: Header=BB2_53 Depth=4
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s94, v0
.LBB2_51:                               ; %Flow158
                                        ;   in Loop: Header=BB2_53 Depth=4
	v_mov_b32_e32 v24, v27
	s_mov_b32 s4, 0
.LBB2_52:                               ; %Flow245
                                        ;   in Loop: Header=BB2_53 Depth=4
	s_and_b32 vcc_lo, exec_lo, s8
	s_cbranch_vccnz .LBB2_17
.LBB2_53:                               ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB2_58 Depth 5
                                        ;           Child Loop BB2_83 Depth 5
                                        ;             Child Loop BB2_102 Depth 6
                                        ;             Child Loop BB2_107 Depth 6
                                        ;             Child Loop BB2_125 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_129 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_133 Depth 6
                                        ;             Child Loop BB2_135 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_158 Depth 6
                                        ;             Child Loop BB2_161 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_178 Depth 6
                                        ;           Child Loop BB2_208 Depth 5
                                        ;           Child Loop BB2_210 Depth 5
                                        ;           Child Loop BB2_212 Depth 5
                                        ;           Child Loop BB2_214 Depth 5
                                        ;           Child Loop BB2_216 Depth 5
                                        ;           Child Loop BB2_218 Depth 5
                                        ;           Child Loop BB2_220 Depth 5
	s_cmp_eq_u32 s94, 0
	s_mov_b32 s8, -1
	;;#ASMSTART
	; O0 v46
	;;#ASMEND
	s_cbranch_scc1 .LBB2_79
; %bb.54:                               ;   in Loop: Header=BB2_53 Depth=4
	v_cmp_eq_u32_e64 s4, 0, v46
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_56
; %bb.55:                               ;   in Loop: Header=BB2_53 Depth=4
	global_load_dword v0, v[84:85], off glc dlc
.LBB2_56:                               ;   in Loop: Header=BB2_53 Depth=4
	s_or_b32 exec_lo, exec_lo, s5
	global_load_dword v2, v[86:87], off
	v_cvt_f32_u32_e32 v1, s94
	s_sub_i32 s5, 0, s94
	v_rcp_iflag_f32_e32 v1, v1
	v_mul_f32_e32 v1, s96, v1
	v_cvt_u32_f32_e32 v1, v1
	v_mul_lo_u32 v3, s5, v1
	s_waitcnt vmcnt(1)
	v_readfirstlane_b32 s5, v0
	v_add_nc_u32_e32 v0, s5, v46
	s_mov_b32 s5, s94
	v_mul_hi_u32 v3, v1, v3
	v_add_nc_u32_e32 v3, v1, v3
	v_mul_hi_u32 v1, v0, v3
	v_mul_lo_u32 v1, v1, s94
	v_sub_nc_u32_e32 v0, v0, v1
	v_subrev_nc_u32_e32 v1, s94, v0
	v_cmp_le_u32_e32 vcc_lo, s94, v0
	v_cndmask_b32_e32 v0, v0, v1, vcc_lo
	v_subrev_nc_u32_e32 v1, s94, v0
	v_cmp_le_u32_e32 vcc_lo, s94, v0
	v_cndmask_b32_e32 v4, v0, v1, vcc_lo
	s_branch .LBB2_58
.LBB2_57:                               ; %Flow135
                                        ;   in Loop: Header=BB2_58 Depth=5
	s_andn2_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccz .LBB2_78
.LBB2_58:                               ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	v_cmp_gt_u32_e32 vcc_lo, s72, v4
                                        ; implicit-def: $vgpr0_vgpr1
	s_and_saveexec_b32 s6, vcc_lo
	s_xor_b32 s6, exec_lo, s6
; %bb.59:                               ;   in Loop: Header=BB2_58 Depth=5
	s_add_u32 s10, s38, s73
	s_addc_u32 s11, s39, 0
	v_mad_u64_u32 v[0:1], s7, v32, s69, s[10:11]
	v_mad_u64_u32 v[0:1], s7, v4, 24, v[0:1]
; %bb.60:                               ; %Flow133
                                        ;   in Loop: Header=BB2_58 Depth=5
	s_or_saveexec_b32 s6, s6
	s_xor_b32 exec_lo, exec_lo, s6
	s_cbranch_execz .LBB2_62
; %bb.61:                               ;   in Loop: Header=BB2_58 Depth=5
	s_add_u32 s10, s38, s73
	v_add_nc_u32_e32 v5, s74, v4
	s_addc_u32 s11, s39, 0
	v_mad_u64_u32 v[0:1], s7, v32, s69, s[10:11]
	v_lshrrev_b32_e32 v5, 8, v5
	v_mad_u64_u32 v[0:1], s7, v5, 24, v[0:1]
	v_and_b32_e32 v5, s75, v4
	global_load_dwordx2 v[0:1], v[0:1], off glc dlc
	s_waitcnt vmcnt(0)
	v_mad_u64_u32 v[0:1], s7, v5, 24, v[0:1]
.LBB2_62:                               ;   in Loop: Header=BB2_58 Depth=5
	s_or_b32 exec_lo, exec_lo, s6
	global_load_dword v0, v[0:1], off offset:16 glc dlc
	s_waitcnt vmcnt(0)
	v_cmp_lt_u32_e32 vcc_lo, v0, v2
	v_cmp_eq_u32_e64 s6, vcc_lo, 0
	s_and_b32 s6, s6, exec_lo
	s_cbranch_scc1 .LBB2_64
; %bb.63:                               ;   in Loop: Header=BB2_58 Depth=5
	s_ff1_i32_b32 s6, vcc_lo
	s_min_u32 s6, s6, s85
	s_lshl_b32 s6, s6, 2
	v_mov_b32_e32 v0, s6
	ds_bpermute_b32 v0, v0, v4
	s_branch .LBB2_65
.LBB2_64:                               ;   in Loop: Header=BB2_58 Depth=5
	v_mov_b32_e32 v0, -1
.LBB2_65:                               ;   in Loop: Header=BB2_58 Depth=5
	s_waitcnt lgkmcnt(0)
	v_readfirstlane_b32 s7, v0
	s_cmp_eq_u32 s7, -1
	s_cselect_b32 s6, -1, 0
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_68
; %bb.66:                               ;   in Loop: Header=BB2_58 Depth=5
	s_cmp_lt_u32 s7, s72
	s_cbranch_scc0 .LBB2_70
; %bb.67:                               ;   in Loop: Header=BB2_58 Depth=5
	s_add_u32 s10, s38, s73
	s_addc_u32 s11, s39, 0
	v_mad_u64_u32 v[0:1], s9, v32, s69, s[10:11]
	v_mad_u64_u32 v[0:1], s9, s7, 24, v[0:1]
	s_cbranch_execnz .LBB2_72
	s_branch .LBB2_71
.LBB2_68:                               ;   in Loop: Header=BB2_58 Depth=5
                                        ; implicit-def: $vgpr0_vgpr1
	s_branch .LBB2_73
.LBB2_69:                               ;   in Loop: Header=BB2_58 Depth=5
	v_mov_b32_e32 v81, v1
	v_mov_b32_e32 v80, v0
	s_branch .LBB2_76
.LBB2_70:                               ;   in Loop: Header=BB2_58 Depth=5
                                        ; implicit-def: $vgpr0_vgpr1
.LBB2_71:                               ;   in Loop: Header=BB2_58 Depth=5
	s_add_i32 s9, s7, s74
	s_lshr_b32 s9, s9, 8
	s_add_u32 s10, s38, s73
	s_addc_u32 s11, s39, 0
	s_and_b32 s7, s7, s75
	v_mad_u64_u32 v[0:1], s10, v32, s69, s[10:11]
	v_mad_u64_u32 v[0:1], s9, s9, 24, v[0:1]
	global_load_dwordx2 v[0:1], v[0:1], off glc dlc
	s_waitcnt vmcnt(0)
	v_mad_u64_u32 v[0:1], s7, s7, 24, v[0:1]
.LBB2_72:                               ; %Flow128
                                        ;   in Loop: Header=BB2_58 Depth=5
	s_cbranch_execnz .LBB2_69
.LBB2_73:                               ;   in Loop: Header=BB2_58 Depth=5
	v_add_nc_u32_e32 v0, s93, v4
	v_mul_hi_u32 v1, v0, v3
	v_mul_lo_u32 v1, v1, s94
	v_sub_nc_u32_e32 v0, v0, v1
	v_subrev_nc_u32_e32 v1, s94, v0
	v_cmp_le_u32_e32 vcc_lo, s94, v0
	v_cndmask_b32_e32 v0, v0, v1, vcc_lo
	v_subrev_nc_u32_e32 v1, s94, v0
	v_cmp_le_u32_e32 vcc_lo, s94, v0
	v_cndmask_b32_e32 v4, v0, v1, vcc_lo
	s_and_saveexec_b32 s7, s4
	s_cbranch_execz .LBB2_75
; %bb.74:                               ;   in Loop: Header=BB2_58 Depth=5
	global_store_dword v[84:85], v4, off
.LBB2_75:                               ;   in Loop: Header=BB2_58 Depth=5
	s_or_b32 exec_lo, exec_lo, s7
	s_sub_i32 s5, s5, s93
.LBB2_76:                               ;   in Loop: Header=BB2_58 Depth=5
	s_mov_b32 s7, -1
	s_andn2_b32 vcc_lo, exec_lo, s6
	s_mov_b32 s6, -1
	s_cbranch_vccnz .LBB2_57
; %bb.77:                               ;   in Loop: Header=BB2_58 Depth=5
	s_cmp_lt_i32 s5, 1
	s_mov_b32 s7, 0
	s_cselect_b32 s6, -1, 0
	s_branch .LBB2_57
.LBB2_78:                               ; %loop.exit.guard86
                                        ;   in Loop: Header=BB2_53 Depth=4
	v_mov_b32_e32 v24, v27
	s_xor_b32 s5, s7, -1
	s_mov_b32 s4, 0
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB2_52
	s_branch .LBB2_80
.LBB2_79:                               ;   in Loop: Header=BB2_53 Depth=4
	s_cbranch_execz .LBB2_52
.LBB2_80:                               ; %.loopexit63
                                        ;   in Loop: Header=BB2_53 Depth=4
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
                                        ; implicit-def: $vgpr118_vgpr119
	v_mbcnt_hi_u32_b32 v47, exec_hi, v0
	s_branch .LBB2_83
.LBB2_81:                               ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v119, v1
	v_mov_b32_e32 v118, v0
.LBB2_82:                               ; %Flow239
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_xor_b32 s4, s5, -1
	s_andn2_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_203
.LBB2_83:                               ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Loop Header: Depth=5
                                        ;             Child Loop BB2_102 Depth 6
                                        ;             Child Loop BB2_107 Depth 6
                                        ;             Child Loop BB2_125 Depth 6
                                        ;             Child Loop BB2_127 Depth 6
                                        ;             Child Loop BB2_129 Depth 6
                                        ;             Child Loop BB2_131 Depth 6
                                        ;             Child Loop BB2_133 Depth 6
                                        ;             Child Loop BB2_135 Depth 6
                                        ;             Child Loop BB2_137 Depth 6
                                        ;             Child Loop BB2_158 Depth 6
                                        ;             Child Loop BB2_161 Depth 6
                                        ;             Child Loop BB2_166 Depth 6
                                        ;             Child Loop BB2_178 Depth 6
	;;#ASMSTART
	; O0 v47
	;;#ASMEND
	v_cmp_eq_u32_e64 s29, 0, v47
	v_mov_b32_e32 v0, 0
	s_mov_b32 s5, 0
	s_and_saveexec_b32 s4, s29
	s_cbranch_execz .LBB2_85
; %bb.84:                               ;   in Loop: Header=BB2_83 Depth=5
	global_load_dword v0, v[82:83], off glc dlc
.LBB2_85:                               ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s49, v0
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_cmp_eq_u32 s49, s70
	s_cbranch_scc1 .LBB2_81
; %bb.86:                               ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s4, s29
	s_cbranch_execz .LBB2_88
; %bb.87:                               ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v24, s72
	global_atomic_cmpswap v0, v[98:99], v[24:25], off glc
	s_waitcnt vmcnt(0)
	v_cmp_ne_u32_e32 vcc_lo, 0, v0
	v_cndmask_b32_e32 v0, s72, v0, vcc_lo
.LBB2_88:                               ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s4
	v_readfirstlane_b32 s63, v0
	s_cmp_lg_u32 s49, s63
	s_cbranch_scc1 .LBB2_104
; %bb.89:                               ;   in Loop: Header=BB2_83 Depth=5
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	v_mbcnt_hi_u32_b32 v56, exec_hi, v0
	;;#ASMSTART
	; O0 v56
	;;#ASMEND
	v_cmp_eq_u32_e32 vcc_lo, 0, v56
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_91
; %bb.90:                               ;   in Loop: Header=BB2_83 Depth=5
	global_load_dword v0, v[98:99], off glc dlc
.LBB2_91:                               ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s59, v0
	s_mov_b32 s9, 2
	s_cmp_eq_u32 s59, s70
	s_cbranch_scc1 .LBB2_121
; %bb.92:                               ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, 1
	s_and_saveexec_b32 s5, vcc_lo
	s_cbranch_execz .LBB2_96
; %bb.93:                               ;   in Loop: Header=BB2_83 Depth=5
	global_load_dwordx2 v[2:3], v[100:101], off glc dlc
	s_memrealtime s[6:7]
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_sub_co_u32 v0, s4, s6, v2
	v_sub_co_ci_u32_e64 v1, s4, s7, v3, s4
	v_cmp_lt_u64_e64 s4, s[36:37], v[0:1]
	v_mov_b32_e32 v0, 1
	s_and_saveexec_b32 s8, s4
	s_cbranch_execz .LBB2_95
; %bb.94:                               ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, s6
	v_mov_b32_e32 v1, s7
	global_atomic_cmpswap_x2 v[0:1], v[100:101], v[0:3], off glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e64 s4, v[0:1], v[2:3]
	v_cndmask_b32_e64 v0, 1, 2, s4
.LBB2_95:                               ; %Flow233
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s8
.LBB2_96:                               ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s5
	v_readfirstlane_b32 s61, v0
	s_mov_b32 s9, 1
	s_cmp_eq_u32 s61, 1
	s_cbranch_scc1 .LBB2_121
; %bb.97:                               ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_and_saveexec_b32 s95, vcc_lo
	s_cbranch_execz .LBB2_99
; %bb.98:                               ;   in Loop: Header=BB2_83 Depth=5
	s_load_dwordx2 s[12:13], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, v25
	v_mov_b32_e32 v4, v25
	v_mov_b32_e32 v5, 0x1800
	v_mov_b32_e32 v6, v25
	v_mov_b32_e32 v7, v25
	v_mov_b32_e32 v8, v25
	v_mov_b32_e32 v9, v25
	v_mov_b32_e32 v10, v25
	v_mov_b32_e32 v11, v25
	v_mov_b32_e32 v12, v25
	v_mov_b32_e32 v13, v25
	v_mov_b32_e32 v14, v25
	v_mov_b32_e32 v15, v25
	v_mov_b32_e32 v16, v25
	v_mov_b32_e32 v17, v25
	v_mov_b32_e32 v18, v25
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s12
	v_mov_b32_e32 v1, s13
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[30:31]
	s_add_u32 s30, s30, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s31, s31, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[30:31]
.LBB2_99:                               ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s95
	v_readfirstlane_b32 s12, v0
	v_readfirstlane_b32 s13, v1
	s_cmp_eq_u64 s[12:13], 0
	s_cbranch_scc1 .LBB2_120
; %bb.100:                              ;   in Loop: Header=BB2_83 Depth=5
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	s_mov_b64 s[4:5], exec
	v_mbcnt_hi_u32_b32 v24, exec_hi, v0
	v_cmp_gt_u32_e32 vcc_lo, s76, v24
	s_and_saveexec_b32 s6, vcc_lo
	s_cbranch_execz .LBB2_103
; %bb.101:                              ; %.preheader24.preheader
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_bcnt1_i32_b64 s5, s[4:5]
	s_mov_b32 s7, 0
	.p2align	6
.LBB2_102:                              ; %.preheader24
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	v_lshlrev_b64 v[0:1], 3, v[24:25]
	v_add_nc_u32_e32 v24, s5, v24
	v_mov_b32_e32 v2, v25
	v_mov_b32_e32 v3, v25
	v_cmp_lt_u32_e32 vcc_lo, s77, v24
	v_add_co_u32 v0, s4, s12, v0
	v_add_co_ci_u32_e64 v1, s4, s13, v1, s4
	s_or_b32 s7, vcc_lo, s7
	global_store_dwordx2 v[0:1], v[2:3], off
	s_andn2_b32 exec_lo, exec_lo, s7
	s_cbranch_execnz .LBB2_102
.LBB2_103:                              ; %Flow228
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s6
	s_branch .LBB2_107
.LBB2_104:                              ;   in Loop: Header=BB2_83 Depth=5
	s_mov_b32 s8, -1
	s_branch .LBB2_139
.LBB2_105:                              ;   in Loop: Header=BB2_107 Depth=6
	s_mov_b32 s6, -1
	s_mov_b32 s5, 0
.LBB2_106:                              ; %Flow224
                                        ;   in Loop: Header=BB2_107 Depth=6
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_116
.LBB2_107:                              ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	;;#ASMSTART
	; O0 v56
	;;#ASMEND
	v_cmp_eq_u32_e64 s4, 0, v56
	v_mov_b32_e32 v0, s59
	s_mov_b32 s95, s61
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_109
; %bb.108:                              ;   in Loop: Header=BB2_107 Depth=6
	global_load_dword v0, v[98:99], off glc dlc
.LBB2_109:                              ;   in Loop: Header=BB2_107 Depth=6
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s59, v0
	s_mov_b32 s5, -1
	s_mov_b32 s6, -1
                                        ; implicit-def: $sgpr61
	s_cmp_lg_u32 s59, s70
	s_cbranch_scc0 .LBB2_106
; %bb.110:                              ;   in Loop: Header=BB2_107 Depth=6
	v_mov_b32_e32 v0, s95
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_114
; %bb.111:                              ;   in Loop: Header=BB2_107 Depth=6
	s_add_i32 s6, s59, s74
	v_mov_b32_e32 v23, s12
	s_lshr_b32 s8, s6, 8
	s_add_u32 s6, s38, s73
	s_addc_u32 s7, s39, 0
	v_mov_b32_e32 v24, s13
	v_mad_u64_u32 v[0:1], s6, v32, s69, s[6:7]
	v_mov_b32_e32 v26, v25
	v_mad_u64_u32 v[0:1], s6, s8, 24, v[0:1]
	global_atomic_cmpswap_x2 v[0:1], v[0:1], v[23:26], off glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e32 vcc_lo, 0, v[0:1]
	v_mov_b32_e32 v0, s95
	s_and_saveexec_b32 s6, vcc_lo
	s_cbranch_execz .LBB2_113
; %bb.112:                              ;   in Loop: Header=BB2_107 Depth=6
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_add v[98:99], v40, off
	v_mov_b32_e32 v0, 0
.LBB2_113:                              ; %Flow221
                                        ;   in Loop: Header=BB2_107 Depth=6
	s_or_b32 exec_lo, exec_lo, s6
.LBB2_114:                              ;   in Loop: Header=BB2_107 Depth=6
	s_or_b32 exec_lo, exec_lo, s5
	v_readfirstlane_b32 s61, v0
	s_cmp_eq_u32 s61, 0
	s_cbranch_scc1 .LBB2_105
; %bb.115:                              ;   in Loop: Header=BB2_107 Depth=6
	s_mov_b32 s6, 0
	s_sleep 2
	s_mov_b32 s5, 0
	s_branch .LBB2_106
.LBB2_116:                              ; %loop.exit.guard92
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_and_b32 vcc_lo, exec_lo, s5
	s_mov_b32 s61, 0
	s_cbranch_vccz .LBB2_120
; %bb.117:                              ;   in Loop: Header=BB2_83 Depth=5
	s_and_saveexec_b32 s59, s4
	s_cbranch_execz .LBB2_119
; %bb.118:                              ;   in Loop: Header=BB2_83 Depth=5
	s_load_dwordx2 s[30:31], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, s12
	v_mov_b32_e32 v4, s13
	v_mov_b32_e32 v5, v25
	v_mov_b32_e32 v6, v25
	v_mov_b32_e32 v7, v25
	v_mov_b32_e32 v8, v25
	v_mov_b32_e32 v9, v25
	v_mov_b32_e32 v10, v25
	v_mov_b32_e32 v11, v25
	v_mov_b32_e32 v12, v25
	v_mov_b32_e32 v13, v25
	v_mov_b32_e32 v14, v25
	v_mov_b32_e32 v15, v25
	v_mov_b32_e32 v16, v25
	v_mov_b32_e32 v17, v25
	v_mov_b32_e32 v18, v25
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s30
	v_mov_b32_e32 v1, s31
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[98:99]
	s_add_u32 s98, s98, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s99, s99, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[98:99]
.LBB2_119:                              ; %Flow219
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s59
	s_mov_b32 s61, s95
.LBB2_120:                              ; %Flow230
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_mov_b32 s9, s61
.LBB2_121:                              ; %.loopexit23
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_cmp_eq_u32 s9, 0
	s_cselect_b32 s8, -1, 0
	s_and_b32 vcc_lo, exec_lo, s8
	s_cbranch_vccnz .LBB2_139
; %bb.122:                              ;   in Loop: Header=BB2_83 Depth=5
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	v_mbcnt_hi_u32_b32 v0, exec_hi, v0
	v_cmp_eq_u32_e32 vcc_lo, 0, v0
	s_and_saveexec_b32 s10, vcc_lo
	s_cbranch_execz .LBB2_138
; %bb.123:                              ;   in Loop: Header=BB2_83 Depth=5
	global_load_dwordx2 v[0:1], v[100:101], off glc dlc
	s_memrealtime s[4:5]
	s_mov_b32 s59, s37
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_sub_co_u32 v0, vcc_lo, s4, v0
	v_sub_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo
	v_cmp_gt_u64_e32 vcc_lo, s[58:59], v[0:1]
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB2_138
; %bb.124:                              ;   in Loop: Header=BB2_83 Depth=5
	s_memrealtime s[6:7]
	v_sub_nc_u32_e32 v0, s58, v0
	v_readfirstlane_b32 s4, v0
	s_ashr_i32 s5, s4, 31
	s_waitcnt lgkmcnt(0)
	s_add_u32 s4, s6, s4
	s_addc_u32 s5, s7, s5
	s_add_u32 s12, s6, s78
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_126
.LBB2_125:                              ; %.preheader21
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	s_sleep 0x7f
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s78
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_125
.LBB2_126:                              ; %Flow215
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_add_u32 s12, s6, s79
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_128
.LBB2_127:                              ; %.preheader19
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	s_sleep 63
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s79
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_127
.LBB2_128:                              ; %Flow212
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_add_u32 s12, s6, s80
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_130
.LBB2_129:                              ; %.preheader17
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	s_sleep 31
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s80
	s_addc_u32 s13, s7, 0
	v_cmp_gt_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_129
.LBB2_130:                              ; %.loopexit18
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_add_u32 s12, s6, s81
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_132
.LBB2_131:                              ; %.preheader15
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	s_sleep 15
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s81
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_131
.LBB2_132:                              ; %Flow206
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_add_u32 s12, s6, s82
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_134
.LBB2_133:                              ; %.preheader13
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	s_sleep 7
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s82
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_133
.LBB2_134:                              ; %Flow203
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_add_u32 s12, s6, 38
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_136
.LBB2_135:                              ; %.preheader11
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	s_sleep 3
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, 38
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_135
.LBB2_136:                              ; %Flow200
                                        ;   in Loop: Header=BB2_83 Depth=5
	v_cmp_le_u64_e64 s6, s[4:5], s[6:7]
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_138
.LBB2_137:                              ; %.preheader10
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	s_sleep 1
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	v_cmp_gt_u64_e64 s6, s[4:5], s[6:7]
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_137
.LBB2_138:                              ; %__ockl_rtcwait_u32.exit1
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s10
	s_cmp_lg_u32 s9, 2
	v_mov_b32_e32 v119, s37
	s_cselect_b32 s4, -1, 0
	v_cndmask_b32_e64 v118, 0, 1, s4
.LBB2_139:                              ; %Flow236
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_and_b32 vcc_lo, exec_lo, s8
	s_mov_b32 s5, 0
	s_cbranch_vccz .LBB2_82
; %bb.140:                              ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, 1
	v_mov_b32_e32 v1, 0
	s_and_saveexec_b32 s6, s29
	s_cbranch_execz .LBB2_144
; %bb.141:                              ;   in Loop: Header=BB2_83 Depth=5
	global_load_dwordx2 v[2:3], v[102:103], off glc dlc
	s_memrealtime s[4:5]
	s_mov_b32 s61, s37
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_sub_co_u32 v0, vcc_lo, s4, v2
	v_sub_co_ci_u32_e32 v1, vcc_lo, s5, v3, vcc_lo
	v_cmp_lt_u64_e32 vcc_lo, s[60:61], v[0:1]
	v_mov_b32_e32 v0, 1
	v_mov_b32_e32 v1, 0
	s_and_saveexec_b32 s7, vcc_lo
	s_cbranch_execz .LBB2_143
; %bb.142:                              ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, s4
	v_mov_b32_e32 v1, s5
	global_atomic_cmpswap_x2 v[0:1], v[102:103], v[0:3], off glc
	s_waitcnt vmcnt(0)
	v_cmp_ne_u64_e32 vcc_lo, v[0:1], v[2:3]
	v_mov_b32_e32 v1, s37
	v_cndmask_b32_e64 v0, 0, 1, vcc_lo
.LBB2_143:                              ; %Flow194
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s7
.LBB2_144:                              ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s6
	v_readfirstlane_b32 s4, v0
	v_readfirstlane_b32 s5, v1
	s_cmp_eq_u64 s[4:5], 0
	s_cbranch_scc1 .LBB2_146
; %bb.145:                              ;   in Loop: Header=BB2_83 Depth=5
	s_mov_b32 s6, 0
	s_branch .LBB2_147
.LBB2_146:                              ;   in Loop: Header=BB2_83 Depth=5
	s_mov_b32 s6, -1
                                        ; implicit-def: $sgpr4_sgpr5
.LBB2_147:                              ; %Flow192
                                        ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, s4
	v_mov_b32_e32 v1, s5
	s_andn2_b32 vcc_lo, exec_lo, s6
	s_mov_b32 s5, 0
	s_cbranch_vccnz .LBB2_200
; %bb.148:                              ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_and_saveexec_b32 s59, s29
	s_cbranch_execz .LBB2_154
; %bb.149:                              ;   in Loop: Header=BB2_83 Depth=5
	s_clause 0x1
	global_load_dwordx2 v[0:1], v25, s[40:41] glc dlc
	global_load_dwordx2 v[2:3], v25, s[42:43]
	s_waitcnt vmcnt(0)
	v_cmp_ge_u64_e64 s4, v[0:1], v[2:3]
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_151
; %bb.150:                              ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v24, s83
	s_andn2_b32 s4, s4, exec_lo
	global_atomic_add_x2 v[0:1], v25, v[24:25], s[40:41] glc
	s_waitcnt vmcnt(0)
	v_cmp_ge_u64_e32 vcc_lo, v[0:1], v[2:3]
	s_and_b32 s5, vcc_lo, exec_lo
	s_or_b32 s4, s4, s5
	s_and_saveexec_b32 s29, s4
	s_cbranch_execz .LBB2_153
	s_branch .LBB2_152
.LBB2_151:                              ;   in Loop: Header=BB2_83 Depth=5
                                        ; implicit-def: $vgpr0_vgpr1
	s_and_saveexec_b32 s29, s4
	s_cbranch_execz .LBB2_153
.LBB2_152:                              ;   in Loop: Header=BB2_83 Depth=5
	s_load_dwordx2 s[12:13], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, v25
	v_mov_b32_e32 v4, v25
	v_mov_b32_e32 v5, 0x200000
	v_mov_b32_e32 v6, v25
	v_mov_b32_e32 v7, v25
	v_mov_b32_e32 v8, v25
	v_mov_b32_e32 v9, v25
	v_mov_b32_e32 v10, v25
	v_mov_b32_e32 v11, v25
	v_mov_b32_e32 v12, v25
	v_mov_b32_e32 v13, v25
	v_mov_b32_e32 v14, v25
	v_mov_b32_e32 v15, v25
	v_mov_b32_e32 v16, v25
	v_mov_b32_e32 v17, v25
	v_mov_b32_e32 v18, v25
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s12
	v_mov_b32_e32 v1, s13
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[30:31]
	s_add_u32 s30, s30, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s31, s31, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[30:31]
.LBB2_153:                              ; %Flow190
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s29
.LBB2_154:                              ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s59
	v_readfirstlane_b32 s12, v0
	v_readfirstlane_b32 s13, v1
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_cmp_eq_u64 s[12:13], 0
	s_cbranch_scc1 .LBB2_199
; %bb.155:                              ;   in Loop: Header=BB2_83 Depth=5
	global_load_dword v0, v[96:97], off
	v_mbcnt_lo_u32_b32 v1, exec_lo, 0
	s_bcnt1_i32_b64 s5, exec
	v_mbcnt_hi_u32_b32 v2, exec_hi, v1
	;;#ASMSTART
	; O0 v2
	;;#ASMEND
	s_waitcnt vmcnt(0)
	v_add_nc_u32_e32 v3, 31, v0
	v_lshrrev_b32_e32 v1, 5, v3
	s_and_saveexec_b32 s4, s27
	s_xor_b32 s6, exec_lo, s4
	s_cbranch_execz .LBB2_163
; %bb.156:                              ;   in Loop: Header=BB2_83 Depth=5
	global_load_dword v3, v[112:113], off
	v_cmp_lt_u32_e32 vcc_lo, v2, v1
	s_and_saveexec_b32 s7, vcc_lo
	s_cbranch_execz .LBB2_159
; %bb.157:                              ; %.preheader8.preheader
                                        ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v24, v2
	s_mov_b32 s8, 0
.LBB2_158:                              ; %.preheader8
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	v_lshlrev_b64 v[4:5], 2, v[24:25]
	v_add_nc_u32_e32 v24, s5, v24
	v_cmp_ge_u32_e32 vcc_lo, v24, v1
	v_add_co_u32 v4, s4, s12, v4
	v_add_co_ci_u32_e64 v5, s4, s13, v5, s4
	s_or_b32 s8, vcc_lo, s8
	global_store_dword v[4:5], v25, off offset:16
	s_andn2_b32 exec_lo, exec_lo, s8
	s_cbranch_execnz .LBB2_158
.LBB2_159:                              ; %Flow179
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s7
	global_load_dword v4, v[114:115], off
	s_waitcnt vmcnt(1)
	v_mul_lo_u32 v5, v3, v2
	s_waitcnt vmcnt(0)
	v_add_nc_u32_e32 v4, v4, v5
	v_cmp_lt_u32_e32 vcc_lo, v4, v0
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_162
; %bb.160:                              ; %.preheader6.preheader
                                        ;   in Loop: Header=BB2_83 Depth=5
	v_mul_lo_u32 v3, v3, s5
	s_mov_b32 s7, 0
.LBB2_161:                              ; %.preheader6
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	v_lshlrev_b32_e64 v5, v4, 1
	v_lshrrev_b32_e32 v6, 3, v4
	v_add_nc_u32_e32 v4, v4, v3
	v_and_b32_e32 v6, s84, v6
	v_cmp_ge_u32_e32 vcc_lo, v4, v0
	global_store_dword v6, v5, s[12:13] offset:16
	s_or_b32 s7, vcc_lo, s7
	s_andn2_b32 exec_lo, exec_lo, s7
	s_cbranch_execnz .LBB2_161
.LBB2_162:                              ; %Flow176
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s4
.LBB2_163:                              ; %Flow184
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_saveexec_b32 s6, s6
	s_xor_b32 exec_lo, exec_lo, s6
	s_cbranch_execz .LBB2_168
; %bb.164:                              ;   in Loop: Header=BB2_83 Depth=5
	v_cmp_lt_u32_e32 vcc_lo, v2, v1
	s_and_saveexec_b32 s7, vcc_lo
	s_cbranch_execz .LBB2_167
; %bb.165:                              ; %.preheader.preheader
                                        ;   in Loop: Header=BB2_83 Depth=5
	global_load_dword v3, v[116:117], off
	v_mov_b32_e32 v24, v2
	s_mov_b32 s8, 0
.LBB2_166:                              ; %.preheader
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	v_lshlrev_b64 v[4:5], 2, v[24:25]
	v_add_nc_u32_e32 v24, s5, v24
	v_cmp_ge_u32_e32 vcc_lo, v24, v1
	v_add_co_u32 v4, s4, s12, v4
	v_add_co_ci_u32_e64 v5, s4, s13, v5, s4
	s_or_b32 s8, vcc_lo, s8
	s_waitcnt vmcnt(0)
	global_store_dword v[4:5], v3, off offset:16
	s_andn2_b32 exec_lo, exec_lo, s8
	s_cbranch_execnz .LBB2_166
.LBB2_167:                              ; %Flow182
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s7
.LBB2_168:                              ; %.loopexit5
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s6
	v_cmp_eq_u32_e32 vcc_lo, 0, v2
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_172
; %bb.169:                              ;   in Loop: Header=BB2_83 Depth=5
	s_and_saveexec_b32 s5, s28
	s_cbranch_execz .LBB2_171
; %bb.170:                              ;   in Loop: Header=BB2_83 Depth=5
	v_add_nc_u32_e32 v24, -1, v1
	v_lshlrev_b64 v[1:2], 2, v[24:25]
	v_add_co_u32 v1, vcc_lo, s12, v1
	v_add_co_ci_u32_e32 v2, vcc_lo, s13, v2, vcc_lo
	global_load_dword v3, v[1:2], off offset:16
	s_waitcnt vmcnt(0)
	v_lshl_or_b32 v0, -1, v0, v3
	global_store_dword v[1:2], v0, off offset:16
.LBB2_171:                              ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s5
	global_store_dwordx4 v25, v[32:35], s[12:13]
.LBB2_172:                              ; %Flow173
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s4
	s_branch .LBB2_178
.LBB2_173:                              ; %Flow163
                                        ;   in Loop: Header=BB2_178 Depth=6
	s_or_b32 exec_lo, exec_lo, s6
.LBB2_174:                              ; %Flow166
                                        ;   in Loop: Header=BB2_178 Depth=6
	s_or_b32 exec_lo, exec_lo, s5
	v_readfirstlane_b32 s6, v2
	v_readfirstlane_b32 s7, v3
	s_mov_b32 s5, -1
	s_cmp_eq_u64 s[6:7], 0
	s_cbranch_scc1 .LBB2_177
.LBB2_175:                              ; %Flow171
                                        ;   in Loop: Header=BB2_178 Depth=6
	s_mov_b32 s8, 0
.LBB2_176:                              ; %Flow170
                                        ;   in Loop: Header=BB2_178 Depth=6
	s_mov_b32 s9, 0
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB2_178
	s_branch .LBB2_192
.LBB2_177:                              ;   in Loop: Header=BB2_178 Depth=6
	s_mov_b32 s5, 0
	s_sleep 2
	s_branch .LBB2_175
.LBB2_178:                              ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ;           Parent Loop BB2_83 Depth=5
                                        ; =>          This Inner Loop Header: Depth=6
	;;#ASMSTART
	; O0 v47
	;;#ASMEND
	v_cmp_eq_u32_e64 s4, 0, v47
	v_mov_b32_e32 v0, s49
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_180
; %bb.179:                              ;   in Loop: Header=BB2_178 Depth=6
	global_load_dword v0, v[82:83], off glc dlc
.LBB2_180:                              ;   in Loop: Header=BB2_178 Depth=6
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s49, v0
	s_cmp_eq_u32 s49, s70
	s_cbranch_scc1 .LBB2_187
; %bb.181:                              ;   in Loop: Header=BB2_178 Depth=6
	v_mov_b32_e32 v0, s63
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_183
; %bb.182:                              ;   in Loop: Header=BB2_178 Depth=6
	global_load_dword v0, v[98:99], off glc dlc
.LBB2_183:                              ;   in Loop: Header=BB2_178 Depth=6
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s63, v0
	s_mov_b32 s8, -1
	s_mov_b32 s5, -1
                                        ; implicit-def: $sgpr6_sgpr7
	s_cmp_lg_u32 s49, s63
	s_cbranch_scc0 .LBB2_176
; %bb.184:                              ;   in Loop: Header=BB2_178 Depth=6
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_174
; %bb.185:                              ;   in Loop: Header=BB2_178 Depth=6
	s_cmp_lt_u32 s49, s72
	s_cbranch_scc0 .LBB2_188
; %bb.186:                              ;   in Loop: Header=BB2_178 Depth=6
	s_add_u32 s6, s38, s73
	s_addc_u32 s7, s39, 0
	v_mad_u64_u32 v[0:1], s6, v32, s69, s[6:7]
	v_mad_u64_u32 v[0:1], s6, s49, 24, v[0:1]
	s_cbranch_execnz .LBB2_190
	s_branch .LBB2_189
.LBB2_187:                              ;   in Loop: Header=BB2_178 Depth=6
	s_mov_b32 s9, -1
	s_mov_b32 s8, 0
                                        ; implicit-def: $sgpr63
                                        ; implicit-def: $sgpr6_sgpr7
	s_cbranch_execz .LBB2_178
	s_branch .LBB2_192
.LBB2_188:                              ;   in Loop: Header=BB2_178 Depth=6
                                        ; implicit-def: $vgpr0_vgpr1
.LBB2_189:                              ;   in Loop: Header=BB2_178 Depth=6
	s_add_i32 s6, s49, s74
	s_lshr_b32 s8, s6, 8
	s_add_u32 s6, s38, s73
	s_addc_u32 s7, s39, 0
	v_mad_u64_u32 v[0:1], s6, v32, s69, s[6:7]
	v_mad_u64_u32 v[0:1], s6, s8, 24, v[0:1]
	s_and_b32 s6, s49, s75
	global_load_dwordx2 v[0:1], v[0:1], off glc dlc
	s_waitcnt vmcnt(0)
	v_mad_u64_u32 v[0:1], s6, s6, 24, v[0:1]
.LBB2_190:                              ;   in Loop: Header=BB2_178 Depth=6
	v_mov_b32_e32 v2, s49
	v_mov_b32_e32 v23, s12
	v_mov_b32_e32 v24, s13
	v_mov_b32_e32 v26, v25
	global_store_dword v25, v2, s[12:13] offset:4
	global_atomic_cmpswap_x2 v[2:3], v[0:1], v[23:26], off offset:8 glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e32 vcc_lo, 0, v[2:3]
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_saveexec_b32 s6, vcc_lo
	s_cbranch_execz .LBB2_173
; %bb.191:                              ;   in Loop: Header=BB2_178 Depth=6
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_add v[82:83], v42, off
	v_mov_b32_e32 v3, v1
	v_mov_b32_e32 v2, v0
	s_branch .LBB2_173
.LBB2_192:                              ; %loop.exit.guard96
                                        ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_and_b32 vcc_lo, exec_lo, s9
	s_mov_b32 s5, 0
	s_cbranch_vccnz .LBB2_200
; %bb.193:                              ; %loop.exit.guard98
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_xor_b32 s5, s8, -1
	s_and_b32 vcc_lo, exec_lo, s5
	s_mov_b32 s5, -1
	s_cbranch_vccz .LBB2_195
; %bb.194:                              ;   in Loop: Header=BB2_83 Depth=5
	s_mov_b32 s5, 0
.LBB2_195:                              ; %Flow160
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_andn2_b32 vcc_lo, exec_lo, s5
	s_mov_b32 s5, 0
	s_cbranch_vccnz .LBB2_201
; %bb.196:                              ;   in Loop: Header=BB2_83 Depth=5
	s_and_saveexec_b32 s29, s4
	s_cbranch_execz .LBB2_198
; %bb.197:                              ;   in Loop: Header=BB2_83 Depth=5
	s_load_dwordx2 s[30:31], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, s12
	v_mov_b32_e32 v4, s13
	v_mov_b32_e32 v5, 0
	v_mov_b32_e32 v6, 0
	v_mov_b32_e32 v7, 0
	v_mov_b32_e32 v8, 0
	v_mov_b32_e32 v9, 0
	v_mov_b32_e32 v10, 0
	v_mov_b32_e32 v11, 0
	v_mov_b32_e32 v12, 0
	v_mov_b32_e32 v13, 0
	v_mov_b32_e32 v14, 0
	v_mov_b32_e32 v15, 0
	v_mov_b32_e32 v16, 0
	v_mov_b32_e32 v17, 0
	v_mov_b32_e32 v18, 0
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s30
	v_mov_b32_e32 v1, s31
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[98:99]
	s_add_u32 s98, s98, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s99, s99, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[98:99]
	v_mov_b32_e32 v47, 0
.LBB2_198:                              ; %Flow159
                                        ;   in Loop: Header=BB2_83 Depth=5
	s_or_b32 exec_lo, exec_lo, s29
	s_mov_b32 s5, -1
	s_branch .LBB2_202
.LBB2_199:                              ;   in Loop: Header=BB2_83 Depth=5
	s_mov_b32 s5, 0
.LBB2_200:                              ; %Flow193
                                        ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v119, v1
	v_mov_b32_e32 v118, v0
	s_branch .LBB2_82
.LBB2_201:                              ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, s6
	v_mov_b32_e32 v119, s7
	v_mov_b32_e32 v1, s7
	v_mov_b32_e32 v118, s6
.LBB2_202:                              ; %Flow161
                                        ;   in Loop: Header=BB2_83 Depth=5
	v_mov_b32_e32 v0, v118
	v_mov_b32_e32 v1, v119
	s_branch .LBB2_82
.LBB2_203:                              ;   in Loop: Header=BB2_53 Depth=4
	v_cmp_ne_u64_e64 s8, 1, v[118:119]
	s_and_b32 vcc_lo, exec_lo, s8
	s_cbranch_vccz .LBB2_205
; %bb.204:                              ;   in Loop: Header=BB2_53 Depth=4
	v_mov_b32_e32 v80, v118
	v_mov_b32_e32 v81, v119
	s_branch .LBB2_51
.LBB2_205:                              ;   in Loop: Header=BB2_53 Depth=4
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	v_mbcnt_hi_u32_b32 v0, exec_hi, v0
	v_cmp_eq_u32_e32 vcc_lo, 0, v0
	s_and_saveexec_b32 s9, vcc_lo
	s_cbranch_execz .LBB2_221
; %bb.206:                              ;   in Loop: Header=BB2_53 Depth=4
	global_load_dwordx2 v[0:1], v[102:103], off glc dlc
	s_memrealtime s[4:5]
	s_mov_b32 s63, s37
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_sub_co_u32 v0, vcc_lo, s4, v0
	v_sub_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo
	v_cmp_gt_u64_e32 vcc_lo, s[62:63], v[0:1]
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB2_221
; %bb.207:                              ;   in Loop: Header=BB2_53 Depth=4
	s_memrealtime s[6:7]
	v_sub_nc_u32_e32 v0, s62, v0
	v_readfirstlane_b32 s4, v0
	s_ashr_i32 s5, s4, 31
	s_waitcnt lgkmcnt(0)
	s_add_u32 s4, s6, s4
	s_addc_u32 s5, s7, s5
	s_add_u32 s10, s6, s78
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_209
.LBB2_208:                              ; %.preheader60
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 0x7f
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s78
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_208
.LBB2_209:                              ; %Flow156
                                        ;   in Loop: Header=BB2_53 Depth=4
	s_add_u32 s10, s6, s79
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_211
.LBB2_210:                              ; %.preheader58
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 63
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s79
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_210
.LBB2_211:                              ; %Flow153
                                        ;   in Loop: Header=BB2_53 Depth=4
	s_add_u32 s10, s6, s80
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_213
.LBB2_212:                              ; %.preheader56
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 31
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s80
	s_addc_u32 s11, s7, 0
	v_cmp_gt_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_212
.LBB2_213:                              ; %.loopexit57
                                        ;   in Loop: Header=BB2_53 Depth=4
	s_add_u32 s10, s6, s81
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_215
.LBB2_214:                              ; %.preheader54
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 15
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s81
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_214
.LBB2_215:                              ; %Flow147
                                        ;   in Loop: Header=BB2_53 Depth=4
	s_add_u32 s10, s6, s82
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_217
.LBB2_216:                              ; %.preheader52
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 7
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s82
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_216
.LBB2_217:                              ; %Flow144
                                        ;   in Loop: Header=BB2_53 Depth=4
	s_add_u32 s10, s6, 38
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_219
.LBB2_218:                              ; %.preheader50
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 3
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, 38
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_218
.LBB2_219:                              ; %Flow141
                                        ;   in Loop: Header=BB2_53 Depth=4
	v_cmp_le_u64_e64 s6, s[4:5], s[6:7]
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_221
.LBB2_220:                              ; %.preheader49
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_20 Depth=3
                                        ;         Parent Loop BB2_53 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 1
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	v_cmp_gt_u64_e64 s6, s[4:5], s[6:7]
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_220
.LBB2_221:                              ; %__ockl_rtcwait_u32.exit
                                        ;   in Loop: Header=BB2_53 Depth=4
	s_or_b32 exec_lo, exec_lo, s9
	v_cmp_eq_u32_e32 vcc_lo, 0, v46
	v_mov_b32_e32 v0, s94
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_50
; %bb.222:                              ;   in Loop: Header=BB2_53 Depth=4
	global_load_dword v0, v[82:83], off glc dlc
	s_branch .LBB2_50
.LBB2_223:                              ;   in Loop: Header=BB2_11 Depth=2
                                        ; implicit-def: $vgpr80_vgpr81
	s_cbranch_execnz .LBB2_225
	s_branch .LBB2_398
.LBB2_224:                              ; %Flow262
                                        ;   in Loop: Header=BB2_11 Depth=2
	s_or_b32 exec_lo, exec_lo, s91
	s_branch .LBB2_398
.LBB2_225:                              ; %.preheader82.preheader
                                        ;   in Loop: Header=BB2_11 Depth=2
                                        ; implicit-def: $vgpr80_vgpr81
	s_branch .LBB2_228
.LBB2_226:                              ;   in Loop: Header=BB2_228 Depth=3
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s90, v0
.LBB2_227:                              ; %Flow383
                                        ;   in Loop: Header=BB2_228 Depth=3
	s_and_b32 vcc_lo, exec_lo, s8
	s_cbranch_vccnz .LBB2_398
.LBB2_228:                              ; %.preheader82
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB2_233 Depth 4
                                        ;         Child Loop BB2_258 Depth 4
                                        ;           Child Loop BB2_277 Depth 5
                                        ;           Child Loop BB2_282 Depth 5
                                        ;           Child Loop BB2_300 Depth 5
                                        ;           Child Loop BB2_302 Depth 5
                                        ;           Child Loop BB2_304 Depth 5
                                        ;           Child Loop BB2_306 Depth 5
                                        ;           Child Loop BB2_308 Depth 5
                                        ;           Child Loop BB2_310 Depth 5
                                        ;           Child Loop BB2_312 Depth 5
                                        ;           Child Loop BB2_333 Depth 5
                                        ;           Child Loop BB2_336 Depth 5
                                        ;           Child Loop BB2_341 Depth 5
                                        ;           Child Loop BB2_353 Depth 5
                                        ;         Child Loop BB2_383 Depth 4
                                        ;         Child Loop BB2_385 Depth 4
                                        ;         Child Loop BB2_387 Depth 4
                                        ;         Child Loop BB2_389 Depth 4
                                        ;         Child Loop BB2_391 Depth 4
                                        ;         Child Loop BB2_393 Depth 4
                                        ;         Child Loop BB2_395 Depth 4
	s_cmp_eq_u32 s90, 0
	s_mov_b32 s8, -1
	;;#ASMSTART
	; O0 v44
	;;#ASMEND
	s_cbranch_scc1 .LBB2_254
; %bb.229:                              ;   in Loop: Header=BB2_228 Depth=3
	v_cmp_eq_u32_e64 s4, 0, v44
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_231
; %bb.230:                              ;   in Loop: Header=BB2_228 Depth=3
	global_load_dword v0, v[38:39], off glc dlc
.LBB2_231:                              ;   in Loop: Header=BB2_228 Depth=3
	s_or_b32 exec_lo, exec_lo, s5
	global_load_dword v2, v[48:49], off
	v_cvt_f32_u32_e32 v1, s90
	s_sub_i32 s5, 0, s90
	v_rcp_iflag_f32_e32 v1, v1
	v_mul_f32_e32 v1, s96, v1
	v_cvt_u32_f32_e32 v1, v1
	v_mul_lo_u32 v3, s5, v1
	s_waitcnt vmcnt(1)
	v_readfirstlane_b32 s5, v0
	v_add_nc_u32_e32 v0, s5, v44
	s_mov_b32 s5, s90
	v_mul_hi_u32 v3, v1, v3
	v_add_nc_u32_e32 v3, v1, v3
	v_mul_hi_u32 v1, v0, v3
	v_mul_lo_u32 v1, v1, s90
	v_sub_nc_u32_e32 v0, v0, v1
	v_subrev_nc_u32_e32 v1, s90, v0
	v_cmp_le_u32_e32 vcc_lo, s90, v0
	v_cndmask_b32_e32 v0, v0, v1, vcc_lo
	v_subrev_nc_u32_e32 v1, s90, v0
	v_cmp_le_u32_e32 vcc_lo, s90, v0
	v_cndmask_b32_e32 v4, v0, v1, vcc_lo
	s_branch .LBB2_233
.LBB2_232:                              ; %Flow273
                                        ;   in Loop: Header=BB2_233 Depth=4
	s_andn2_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccz .LBB2_253
.LBB2_233:                              ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	v_cmp_gt_u32_e32 vcc_lo, s72, v4
                                        ; implicit-def: $vgpr0_vgpr1
	s_and_saveexec_b32 s6, vcc_lo
	s_xor_b32 s6, exec_lo, s6
; %bb.234:                              ;   in Loop: Header=BB2_233 Depth=4
	s_add_u32 s10, s38, s73
	s_addc_u32 s11, s39, 0
	v_mad_u64_u32 v[0:1], s7, v27, s69, s[10:11]
	v_mad_u64_u32 v[0:1], s7, v4, 24, v[0:1]
; %bb.235:                              ; %Flow271
                                        ;   in Loop: Header=BB2_233 Depth=4
	s_or_saveexec_b32 s6, s6
	s_xor_b32 exec_lo, exec_lo, s6
	s_cbranch_execz .LBB2_237
; %bb.236:                              ;   in Loop: Header=BB2_233 Depth=4
	s_add_u32 s10, s38, s73
	v_add_nc_u32_e32 v5, s74, v4
	s_addc_u32 s11, s39, 0
	v_mad_u64_u32 v[0:1], s7, v27, s69, s[10:11]
	v_lshrrev_b32_e32 v5, 8, v5
	v_mad_u64_u32 v[0:1], s7, v5, 24, v[0:1]
	v_and_b32_e32 v5, s75, v4
	global_load_dwordx2 v[0:1], v[0:1], off glc dlc
	s_waitcnt vmcnt(0)
	v_mad_u64_u32 v[0:1], s7, v5, 24, v[0:1]
.LBB2_237:                              ;   in Loop: Header=BB2_233 Depth=4
	s_or_b32 exec_lo, exec_lo, s6
	global_load_dword v0, v[0:1], off offset:16 glc dlc
	s_waitcnt vmcnt(0)
	v_cmp_lt_u32_e32 vcc_lo, v0, v2
	v_cmp_eq_u32_e64 s6, vcc_lo, 0
	s_and_b32 s6, s6, exec_lo
	s_cbranch_scc1 .LBB2_239
; %bb.238:                              ;   in Loop: Header=BB2_233 Depth=4
	s_ff1_i32_b32 s6, vcc_lo
	s_min_u32 s6, s6, s85
	s_lshl_b32 s6, s6, 2
	v_mov_b32_e32 v0, s6
	ds_bpermute_b32 v0, v0, v4
	s_branch .LBB2_240
.LBB2_239:                              ;   in Loop: Header=BB2_233 Depth=4
	v_mov_b32_e32 v0, -1
.LBB2_240:                              ;   in Loop: Header=BB2_233 Depth=4
	s_waitcnt lgkmcnt(0)
	v_readfirstlane_b32 s7, v0
	s_cmp_eq_u32 s7, -1
	s_cselect_b32 s6, -1, 0
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_243
; %bb.241:                              ;   in Loop: Header=BB2_233 Depth=4
	s_cmp_lt_u32 s7, s72
	s_cbranch_scc0 .LBB2_245
; %bb.242:                              ;   in Loop: Header=BB2_233 Depth=4
	s_add_u32 s10, s38, s73
	s_addc_u32 s11, s39, 0
	v_mad_u64_u32 v[0:1], s9, v27, s69, s[10:11]
	v_mad_u64_u32 v[0:1], s9, s7, 24, v[0:1]
	s_cbranch_execnz .LBB2_247
	s_branch .LBB2_246
.LBB2_243:                              ;   in Loop: Header=BB2_233 Depth=4
                                        ; implicit-def: $vgpr0_vgpr1
	s_branch .LBB2_248
.LBB2_244:                              ;   in Loop: Header=BB2_233 Depth=4
	v_mov_b32_e32 v81, v1
	v_mov_b32_e32 v80, v0
	s_branch .LBB2_251
.LBB2_245:                              ;   in Loop: Header=BB2_233 Depth=4
                                        ; implicit-def: $vgpr0_vgpr1
.LBB2_246:                              ;   in Loop: Header=BB2_233 Depth=4
	s_add_i32 s9, s7, s74
	s_lshr_b32 s9, s9, 8
	s_add_u32 s10, s38, s73
	s_addc_u32 s11, s39, 0
	s_and_b32 s7, s7, s75
	v_mad_u64_u32 v[0:1], s10, v27, s69, s[10:11]
	v_mad_u64_u32 v[0:1], s9, s9, 24, v[0:1]
	global_load_dwordx2 v[0:1], v[0:1], off glc dlc
	s_waitcnt vmcnt(0)
	v_mad_u64_u32 v[0:1], s7, s7, 24, v[0:1]
.LBB2_247:                              ; %Flow265
                                        ;   in Loop: Header=BB2_233 Depth=4
	s_cbranch_execnz .LBB2_244
.LBB2_248:                              ;   in Loop: Header=BB2_233 Depth=4
	v_add_nc_u32_e32 v0, s89, v4
	v_mul_hi_u32 v1, v0, v3
	v_mul_lo_u32 v1, v1, s90
	v_sub_nc_u32_e32 v0, v0, v1
	v_subrev_nc_u32_e32 v1, s90, v0
	v_cmp_le_u32_e32 vcc_lo, s90, v0
	v_cndmask_b32_e32 v0, v0, v1, vcc_lo
	v_subrev_nc_u32_e32 v1, s90, v0
	v_cmp_le_u32_e32 vcc_lo, s90, v0
	v_cndmask_b32_e32 v4, v0, v1, vcc_lo
	s_and_saveexec_b32 s7, s4
	s_cbranch_execz .LBB2_250
; %bb.249:                              ;   in Loop: Header=BB2_233 Depth=4
	global_store_dword v[38:39], v4, off
.LBB2_250:                              ;   in Loop: Header=BB2_233 Depth=4
	s_or_b32 exec_lo, exec_lo, s7
	s_sub_i32 s5, s5, s89
.LBB2_251:                              ;   in Loop: Header=BB2_233 Depth=4
	s_mov_b32 s7, -1
	s_andn2_b32 vcc_lo, exec_lo, s6
	s_mov_b32 s6, -1
	s_cbranch_vccnz .LBB2_232
; %bb.252:                              ;   in Loop: Header=BB2_233 Depth=4
	s_cmp_lt_i32 s5, 1
	s_mov_b32 s7, 0
	s_cselect_b32 s6, -1, 0
	s_branch .LBB2_232
.LBB2_253:                              ; %loop.exit.guard105
                                        ;   in Loop: Header=BB2_228 Depth=3
	s_xor_b32 s4, s7, -1
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_227
	s_branch .LBB2_255
.LBB2_254:                              ;   in Loop: Header=BB2_228 Depth=3
	s_cbranch_execz .LBB2_227
.LBB2_255:                              ; %.loopexit78
                                        ;   in Loop: Header=BB2_228 Depth=3
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
                                        ; implicit-def: $vgpr32_vgpr33
	v_mbcnt_hi_u32_b32 v34, exec_hi, v0
	s_branch .LBB2_258
.LBB2_256:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v33, v1
	v_mov_b32_e32 v32, v0
.LBB2_257:                              ; %Flow377
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_xor_b32 s4, s5, -1
	s_andn2_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_378
.LBB2_258:                              ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB2_277 Depth 5
                                        ;           Child Loop BB2_282 Depth 5
                                        ;           Child Loop BB2_300 Depth 5
                                        ;           Child Loop BB2_302 Depth 5
                                        ;           Child Loop BB2_304 Depth 5
                                        ;           Child Loop BB2_306 Depth 5
                                        ;           Child Loop BB2_308 Depth 5
                                        ;           Child Loop BB2_310 Depth 5
                                        ;           Child Loop BB2_312 Depth 5
                                        ;           Child Loop BB2_333 Depth 5
                                        ;           Child Loop BB2_336 Depth 5
                                        ;           Child Loop BB2_341 Depth 5
                                        ;           Child Loop BB2_353 Depth 5
	;;#ASMSTART
	; O0 v34
	;;#ASMEND
	v_cmp_eq_u32_e64 s27, 0, v34
	v_mov_b32_e32 v0, 0
	s_mov_b32 s5, 0
	s_and_saveexec_b32 s4, s27
	s_cbranch_execz .LBB2_260
; %bb.259:                              ;   in Loop: Header=BB2_258 Depth=4
	global_load_dword v0, v[36:37], off glc dlc
.LBB2_260:                              ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s28, v0
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_cmp_eq_u32 s28, s70
	s_cbranch_scc1 .LBB2_256
; %bb.261:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s4, s27
	s_cbranch_execz .LBB2_263
; %bb.262:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v24, s72
	global_atomic_cmpswap v0, v[52:53], v[24:25], off glc
	s_waitcnt vmcnt(0)
	v_cmp_ne_u32_e32 vcc_lo, 0, v0
	v_cndmask_b32_e32 v0, s72, v0, vcc_lo
.LBB2_263:                              ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s4
	v_readfirstlane_b32 s29, v0
	s_cmp_lg_u32 s28, s29
	s_cbranch_scc1 .LBB2_279
; %bb.264:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	v_mbcnt_hi_u32_b32 v35, exec_hi, v0
	;;#ASMSTART
	; O0 v35
	;;#ASMEND
	v_cmp_eq_u32_e32 vcc_lo, 0, v35
	v_mov_b32_e32 v0, 0
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_266
; %bb.265:                              ;   in Loop: Header=BB2_258 Depth=4
	global_load_dword v0, v[52:53], off glc dlc
.LBB2_266:                              ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s4
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s49, v0
	s_mov_b32 s9, 2
	s_cmp_eq_u32 s49, s70
	s_cbranch_scc1 .LBB2_296
; %bb.267:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, 1
	s_and_saveexec_b32 s5, vcc_lo
	s_cbranch_execz .LBB2_271
; %bb.268:                              ;   in Loop: Header=BB2_258 Depth=4
	global_load_dwordx2 v[2:3], v[54:55], off glc dlc
	s_memrealtime s[6:7]
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_sub_co_u32 v0, s4, s6, v2
	v_sub_co_ci_u32_e64 v1, s4, s7, v3, s4
	v_cmp_lt_u64_e64 s4, s[36:37], v[0:1]
	v_mov_b32_e32 v0, 1
	s_and_saveexec_b32 s8, s4
	s_cbranch_execz .LBB2_270
; %bb.269:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, s6
	v_mov_b32_e32 v1, s7
	global_atomic_cmpswap_x2 v[0:1], v[54:55], v[0:3], off glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e64 s4, v[0:1], v[2:3]
	v_cndmask_b32_e64 v0, 1, 2, s4
.LBB2_270:                              ; %Flow371
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s8
.LBB2_271:                              ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s5
	v_readfirstlane_b32 s59, v0
	s_mov_b32 s9, 1
	s_cmp_eq_u32 s59, 1
	s_cbranch_scc1 .LBB2_296
; %bb.272:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_and_saveexec_b32 s61, vcc_lo
	s_cbranch_execz .LBB2_274
; %bb.273:                              ;   in Loop: Header=BB2_258 Depth=4
	s_load_dwordx2 s[12:13], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, v25
	v_mov_b32_e32 v4, v25
	v_mov_b32_e32 v5, 0x1800
	v_mov_b32_e32 v6, v25
	v_mov_b32_e32 v7, v25
	v_mov_b32_e32 v8, v25
	v_mov_b32_e32 v9, v25
	v_mov_b32_e32 v10, v25
	v_mov_b32_e32 v11, v25
	v_mov_b32_e32 v12, v25
	v_mov_b32_e32 v13, v25
	v_mov_b32_e32 v14, v25
	v_mov_b32_e32 v15, v25
	v_mov_b32_e32 v16, v25
	v_mov_b32_e32 v17, v25
	v_mov_b32_e32 v18, v25
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s12
	v_mov_b32_e32 v1, s13
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[30:31]
	s_add_u32 s30, s30, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s31, s31, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[30:31]
.LBB2_274:                              ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s61
	v_readfirstlane_b32 s12, v0
	v_readfirstlane_b32 s13, v1
	s_cmp_eq_u64 s[12:13], 0
	s_cbranch_scc1 .LBB2_295
; %bb.275:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	s_mov_b64 s[4:5], exec
	v_mbcnt_hi_u32_b32 v24, exec_hi, v0
	v_cmp_gt_u32_e32 vcc_lo, s76, v24
	s_and_saveexec_b32 s6, vcc_lo
	s_cbranch_execz .LBB2_278
; %bb.276:                              ; %.preheader47.preheader
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_bcnt1_i32_b64 s5, s[4:5]
	s_mov_b32 s7, 0
.LBB2_277:                              ; %.preheader47
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	v_lshlrev_b64 v[0:1], 3, v[24:25]
	v_add_nc_u32_e32 v24, s5, v24
	v_mov_b32_e32 v26, v25
	v_cmp_lt_u32_e32 vcc_lo, s77, v24
	v_add_co_u32 v0, s4, s12, v0
	v_add_co_ci_u32_e64 v1, s4, s13, v1, s4
	s_or_b32 s7, vcc_lo, s7
	global_store_dwordx2 v[0:1], v[25:26], off
	s_andn2_b32 exec_lo, exec_lo, s7
	s_cbranch_execnz .LBB2_277
.LBB2_278:                              ; %Flow366
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s6
	s_branch .LBB2_282
.LBB2_279:                              ;   in Loop: Header=BB2_258 Depth=4
	s_mov_b32 s8, -1
	s_branch .LBB2_314
.LBB2_280:                              ;   in Loop: Header=BB2_282 Depth=5
	s_mov_b32 s6, -1
	s_mov_b32 s5, 0
.LBB2_281:                              ; %Flow362
                                        ;   in Loop: Header=BB2_282 Depth=5
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_291
.LBB2_282:                              ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	;;#ASMSTART
	; O0 v35
	;;#ASMEND
	v_cmp_eq_u32_e64 s4, 0, v35
	v_mov_b32_e32 v0, s49
	s_mov_b32 s61, s59
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_284
; %bb.283:                              ;   in Loop: Header=BB2_282 Depth=5
	global_load_dword v0, v[52:53], off glc dlc
.LBB2_284:                              ;   in Loop: Header=BB2_282 Depth=5
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s49, v0
	s_mov_b32 s5, -1
	s_mov_b32 s6, -1
                                        ; implicit-def: $sgpr59
	s_cmp_lg_u32 s49, s70
	s_cbranch_scc0 .LBB2_281
; %bb.285:                              ;   in Loop: Header=BB2_282 Depth=5
	v_mov_b32_e32 v0, s61
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_289
; %bb.286:                              ;   in Loop: Header=BB2_282 Depth=5
	s_add_i32 s6, s49, s74
	v_mov_b32_e32 v23, s12
	s_lshr_b32 s8, s6, 8
	s_add_u32 s6, s38, s73
	s_addc_u32 s7, s39, 0
	v_mov_b32_e32 v24, s13
	v_mad_u64_u32 v[0:1], s6, v27, s69, s[6:7]
	v_mov_b32_e32 v26, v25
	v_mad_u64_u32 v[0:1], s6, s8, 24, v[0:1]
	global_atomic_cmpswap_x2 v[0:1], v[0:1], v[23:26], off glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e32 vcc_lo, 0, v[0:1]
	v_mov_b32_e32 v0, s61
	s_and_saveexec_b32 s6, vcc_lo
	s_cbranch_execz .LBB2_288
; %bb.287:                              ;   in Loop: Header=BB2_282 Depth=5
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_add v[52:53], v40, off
	v_mov_b32_e32 v0, 0
.LBB2_288:                              ; %Flow359
                                        ;   in Loop: Header=BB2_282 Depth=5
	s_or_b32 exec_lo, exec_lo, s6
.LBB2_289:                              ;   in Loop: Header=BB2_282 Depth=5
	s_or_b32 exec_lo, exec_lo, s5
	v_readfirstlane_b32 s59, v0
	s_cmp_eq_u32 s59, 0
	s_cbranch_scc1 .LBB2_280
; %bb.290:                              ;   in Loop: Header=BB2_282 Depth=5
	s_mov_b32 s6, 0
	s_sleep 2
	s_mov_b32 s5, 0
	s_branch .LBB2_281
.LBB2_291:                              ; %loop.exit.guard108
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_and_b32 vcc_lo, exec_lo, s5
	s_mov_b32 s59, 0
	s_cbranch_vccz .LBB2_295
; %bb.292:                              ;   in Loop: Header=BB2_258 Depth=4
	s_and_saveexec_b32 s49, s4
	s_cbranch_execz .LBB2_294
; %bb.293:                              ;   in Loop: Header=BB2_258 Depth=4
	s_load_dwordx2 s[30:31], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, s12
	v_mov_b32_e32 v4, s13
	v_mov_b32_e32 v5, v25
	v_mov_b32_e32 v6, v25
	v_mov_b32_e32 v7, v25
	v_mov_b32_e32 v8, v25
	v_mov_b32_e32 v9, v25
	v_mov_b32_e32 v10, v25
	v_mov_b32_e32 v11, v25
	v_mov_b32_e32 v12, v25
	v_mov_b32_e32 v13, v25
	v_mov_b32_e32 v14, v25
	v_mov_b32_e32 v15, v25
	v_mov_b32_e32 v16, v25
	v_mov_b32_e32 v17, v25
	v_mov_b32_e32 v18, v25
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s30
	v_mov_b32_e32 v1, s31
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[92:93]
	s_add_u32 s92, s92, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s93, s93, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[92:93]
.LBB2_294:                              ; %Flow357
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s49
	s_mov_b32 s59, s61
.LBB2_295:                              ; %Flow368
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_mov_b32 s9, s59
.LBB2_296:                              ; %.loopexit46
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_cmp_eq_u32 s9, 0
	s_cselect_b32 s8, -1, 0
	s_and_b32 vcc_lo, exec_lo, s8
	s_cbranch_vccnz .LBB2_314
; %bb.297:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	v_mbcnt_hi_u32_b32 v0, exec_hi, v0
	v_cmp_eq_u32_e32 vcc_lo, 0, v0
	s_and_saveexec_b32 s10, vcc_lo
	s_cbranch_execz .LBB2_313
; %bb.298:                              ;   in Loop: Header=BB2_258 Depth=4
	global_load_dwordx2 v[0:1], v[54:55], off glc dlc
	s_memrealtime s[4:5]
	s_mov_b32 s59, s37
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_sub_co_u32 v0, vcc_lo, s4, v0
	v_sub_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo
	v_cmp_gt_u64_e32 vcc_lo, s[58:59], v[0:1]
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB2_313
; %bb.299:                              ;   in Loop: Header=BB2_258 Depth=4
	s_memrealtime s[6:7]
	v_sub_nc_u32_e32 v0, s58, v0
	v_readfirstlane_b32 s4, v0
	s_ashr_i32 s5, s4, 31
	s_waitcnt lgkmcnt(0)
	s_add_u32 s4, s6, s4
	s_addc_u32 s5, s7, s5
	s_add_u32 s12, s6, s78
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_301
.LBB2_300:                              ; %.preheader44
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 0x7f
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s78
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_300
.LBB2_301:                              ; %Flow353
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_add_u32 s12, s6, s79
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_303
.LBB2_302:                              ; %.preheader42
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 63
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s79
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_302
.LBB2_303:                              ; %Flow350
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_add_u32 s12, s6, s80
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_305
.LBB2_304:                              ; %.preheader40
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 31
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s80
	s_addc_u32 s13, s7, 0
	v_cmp_gt_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_304
.LBB2_305:                              ; %.loopexit41
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_add_u32 s12, s6, s81
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_307
.LBB2_306:                              ; %.preheader38
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 15
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s81
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_306
.LBB2_307:                              ; %Flow344
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_add_u32 s12, s6, s82
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_309
.LBB2_308:                              ; %.preheader36
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 7
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, s82
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_308
.LBB2_309:                              ; %Flow341
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_add_u32 s12, s6, 38
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccnz .LBB2_311
.LBB2_310:                              ; %.preheader34
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 3
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s6, 38
	s_addc_u32 s13, s7, 0
	v_cmp_le_u64_e64 s11, s[4:5], s[12:13]
	s_and_b32 vcc_lo, exec_lo, s11
	s_cbranch_vccz .LBB2_310
.LBB2_311:                              ; %Flow338
                                        ;   in Loop: Header=BB2_258 Depth=4
	v_cmp_le_u64_e64 s6, s[4:5], s[6:7]
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_313
.LBB2_312:                              ; %.preheader33
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	s_sleep 1
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	v_cmp_gt_u64_e64 s6, s[4:5], s[6:7]
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_312
.LBB2_313:                              ; %__ockl_rtcwait_u32.exit2
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s10
	s_cmp_lg_u32 s9, 2
	v_mov_b32_e32 v33, s37
	s_cselect_b32 s4, -1, 0
	v_cndmask_b32_e64 v32, 0, 1, s4
.LBB2_314:                              ; %Flow374
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_and_b32 vcc_lo, exec_lo, s8
	s_mov_b32 s5, 0
	s_cbranch_vccz .LBB2_257
; %bb.315:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, 1
	v_mov_b32_e32 v1, 0
	s_and_saveexec_b32 s6, s27
	s_cbranch_execz .LBB2_319
; %bb.316:                              ;   in Loop: Header=BB2_258 Depth=4
	global_load_dwordx2 v[2:3], v[64:65], off glc dlc
	s_memrealtime s[4:5]
	s_mov_b32 s61, s37
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_sub_co_u32 v0, vcc_lo, s4, v2
	v_sub_co_ci_u32_e32 v1, vcc_lo, s5, v3, vcc_lo
	v_cmp_lt_u64_e32 vcc_lo, s[60:61], v[0:1]
	v_mov_b32_e32 v0, 1
	v_mov_b32_e32 v1, 0
	s_and_saveexec_b32 s7, vcc_lo
	s_cbranch_execz .LBB2_318
; %bb.317:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, s4
	v_mov_b32_e32 v1, s5
	global_atomic_cmpswap_x2 v[0:1], v[64:65], v[0:3], off glc
	s_waitcnt vmcnt(0)
	v_cmp_ne_u64_e32 vcc_lo, v[0:1], v[2:3]
	v_mov_b32_e32 v1, s37
	v_cndmask_b32_e64 v0, 0, 1, vcc_lo
.LBB2_318:                              ; %Flow332
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s7
.LBB2_319:                              ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s6
	v_readfirstlane_b32 s4, v0
	v_readfirstlane_b32 s5, v1
	s_cmp_eq_u64 s[4:5], 0
	s_cbranch_scc1 .LBB2_321
; %bb.320:                              ;   in Loop: Header=BB2_258 Depth=4
	s_mov_b32 s6, 0
	s_branch .LBB2_322
.LBB2_321:                              ;   in Loop: Header=BB2_258 Depth=4
	s_mov_b32 s6, -1
                                        ; implicit-def: $sgpr4_sgpr5
.LBB2_322:                              ; %Flow330
                                        ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, s4
	v_mov_b32_e32 v1, s5
	s_andn2_b32 vcc_lo, exec_lo, s6
	s_mov_b32 s5, 0
	s_cbranch_vccnz .LBB2_375
; %bb.323:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_and_saveexec_b32 s49, s27
	s_cbranch_execz .LBB2_329
; %bb.324:                              ;   in Loop: Header=BB2_258 Depth=4
	s_clause 0x1
	global_load_dwordx2 v[0:1], v25, s[40:41] glc dlc
	global_load_dwordx2 v[2:3], v25, s[42:43]
	s_waitcnt vmcnt(0)
	v_cmp_ge_u64_e64 s4, v[0:1], v[2:3]
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_326
; %bb.325:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v24, s83
	s_andn2_b32 s4, s4, exec_lo
	global_atomic_add_x2 v[0:1], v25, v[24:25], s[40:41] glc
	s_waitcnt vmcnt(0)
	v_cmp_ge_u64_e32 vcc_lo, v[0:1], v[2:3]
	s_and_b32 s5, vcc_lo, exec_lo
	s_or_b32 s4, s4, s5
	s_and_saveexec_b32 s27, s4
	s_cbranch_execz .LBB2_328
	s_branch .LBB2_327
.LBB2_326:                              ;   in Loop: Header=BB2_258 Depth=4
                                        ; implicit-def: $vgpr0_vgpr1
	s_and_saveexec_b32 s27, s4
	s_cbranch_execz .LBB2_328
.LBB2_327:                              ;   in Loop: Header=BB2_258 Depth=4
	s_load_dwordx2 s[12:13], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, v25
	v_mov_b32_e32 v4, v25
	v_mov_b32_e32 v5, 0x200000
	v_mov_b32_e32 v6, v25
	v_mov_b32_e32 v7, v25
	v_mov_b32_e32 v8, v25
	v_mov_b32_e32 v9, v25
	v_mov_b32_e32 v10, v25
	v_mov_b32_e32 v11, v25
	v_mov_b32_e32 v12, v25
	v_mov_b32_e32 v13, v25
	v_mov_b32_e32 v14, v25
	v_mov_b32_e32 v15, v25
	v_mov_b32_e32 v16, v25
	v_mov_b32_e32 v17, v25
	v_mov_b32_e32 v18, v25
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s12
	v_mov_b32_e32 v1, s13
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[30:31]
	s_add_u32 s30, s30, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s31, s31, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[30:31]
.LBB2_328:                              ; %Flow328
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s27
.LBB2_329:                              ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s49
	v_readfirstlane_b32 s12, v0
	v_readfirstlane_b32 s13, v1
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_cmp_eq_u64 s[12:13], 0
	s_cbranch_scc1 .LBB2_374
; %bb.330:                              ;   in Loop: Header=BB2_258 Depth=4
	global_load_dword v0, v[50:51], off
	v_mbcnt_lo_u32_b32 v1, exec_lo, 0
	s_bcnt1_i32_b64 s5, exec
	v_mbcnt_hi_u32_b32 v2, exec_hi, v1
	;;#ASMSTART
	; O0 v2
	;;#ASMEND
	s_waitcnt vmcnt(0)
	v_add_nc_u32_e32 v3, 31, v0
	v_lshrrev_b32_e32 v1, 5, v3
	s_and_saveexec_b32 s4, s15
	s_xor_b32 s6, exec_lo, s4
	s_cbranch_execz .LBB2_338
; %bb.331:                              ;   in Loop: Header=BB2_258 Depth=4
	global_load_dword v3, v[66:67], off
	v_cmp_lt_u32_e32 vcc_lo, v2, v1
	s_and_saveexec_b32 s7, vcc_lo
	s_cbranch_execz .LBB2_334
; %bb.332:                              ; %.preheader31.preheader
                                        ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v24, v2
	s_mov_b32 s8, 0
.LBB2_333:                              ; %.preheader31
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	v_lshlrev_b64 v[4:5], 2, v[24:25]
	v_add_nc_u32_e32 v24, s5, v24
	v_cmp_ge_u32_e32 vcc_lo, v24, v1
	v_add_co_u32 v4, s4, s12, v4
	v_add_co_ci_u32_e64 v5, s4, s13, v5, s4
	s_or_b32 s8, vcc_lo, s8
	global_store_dword v[4:5], v25, off offset:16
	s_andn2_b32 exec_lo, exec_lo, s8
	s_cbranch_execnz .LBB2_333
.LBB2_334:                              ; %Flow317
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s7
	global_load_dword v4, v[68:69], off
	s_waitcnt vmcnt(1)
	v_mul_lo_u32 v5, v3, v2
	s_waitcnt vmcnt(0)
	v_add_nc_u32_e32 v4, v4, v5
	v_cmp_lt_u32_e32 vcc_lo, v4, v0
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_337
; %bb.335:                              ; %.preheader29.preheader
                                        ;   in Loop: Header=BB2_258 Depth=4
	v_mul_lo_u32 v3, v3, s5
	s_mov_b32 s7, 0
.LBB2_336:                              ; %.preheader29
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	v_lshlrev_b32_e64 v5, v4, 1
	v_lshrrev_b32_e32 v6, 3, v4
	v_add_nc_u32_e32 v4, v4, v3
	v_and_b32_e32 v6, s84, v6
	v_cmp_ge_u32_e32 vcc_lo, v4, v0
	global_store_dword v6, v5, s[12:13] offset:16
	s_or_b32 s7, vcc_lo, s7
	s_andn2_b32 exec_lo, exec_lo, s7
	s_cbranch_execnz .LBB2_336
.LBB2_337:                              ; %Flow314
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s4
.LBB2_338:                              ; %Flow322
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_saveexec_b32 s6, s6
	s_xor_b32 exec_lo, exec_lo, s6
	s_cbranch_execz .LBB2_343
; %bb.339:                              ;   in Loop: Header=BB2_258 Depth=4
	v_cmp_lt_u32_e32 vcc_lo, v2, v1
	s_and_saveexec_b32 s7, vcc_lo
	s_cbranch_execz .LBB2_342
; %bb.340:                              ; %.preheader27.preheader
                                        ;   in Loop: Header=BB2_258 Depth=4
	global_load_dword v3, v[70:71], off
	v_mov_b32_e32 v24, v2
	s_mov_b32 s8, 0
.LBB2_341:                              ; %.preheader27
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	v_lshlrev_b64 v[4:5], 2, v[24:25]
	v_add_nc_u32_e32 v24, s5, v24
	v_cmp_ge_u32_e32 vcc_lo, v24, v1
	v_add_co_u32 v4, s4, s12, v4
	v_add_co_ci_u32_e64 v5, s4, s13, v5, s4
	s_or_b32 s8, vcc_lo, s8
	s_waitcnt vmcnt(0)
	global_store_dword v[4:5], v3, off offset:16
	s_andn2_b32 exec_lo, exec_lo, s8
	s_cbranch_execnz .LBB2_341
.LBB2_342:                              ; %Flow320
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s7
.LBB2_343:                              ; %.loopexit28
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s6
	v_cmp_eq_u32_e32 vcc_lo, 0, v2
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_347
; %bb.344:                              ;   in Loop: Header=BB2_258 Depth=4
	s_and_saveexec_b32 s5, s26
	s_cbranch_execz .LBB2_346
; %bb.345:                              ;   in Loop: Header=BB2_258 Depth=4
	v_add_nc_u32_e32 v24, -1, v1
	v_lshlrev_b64 v[1:2], 2, v[24:25]
	v_add_co_u32 v1, vcc_lo, s12, v1
	v_add_co_ci_u32_e32 v2, vcc_lo, s13, v2, vcc_lo
	global_load_dword v3, v[1:2], off offset:16
	s_waitcnt vmcnt(0)
	v_lshl_or_b32 v0, -1, v0, v3
	global_store_dword v[1:2], v0, off offset:16
.LBB2_346:                              ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s5
	global_store_dwordx4 v25, v[27:30], s[12:13]
.LBB2_347:                              ; %Flow311
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s4
	s_branch .LBB2_353
.LBB2_348:                              ; %Flow301
                                        ;   in Loop: Header=BB2_353 Depth=5
	s_or_b32 exec_lo, exec_lo, s6
.LBB2_349:                              ; %Flow304
                                        ;   in Loop: Header=BB2_353 Depth=5
	s_or_b32 exec_lo, exec_lo, s5
	v_readfirstlane_b32 s6, v2
	v_readfirstlane_b32 s7, v3
	s_mov_b32 s5, -1
	s_cmp_eq_u64 s[6:7], 0
	s_cbranch_scc1 .LBB2_352
.LBB2_350:                              ; %Flow309
                                        ;   in Loop: Header=BB2_353 Depth=5
	s_mov_b32 s8, 0
.LBB2_351:                              ; %Flow308
                                        ;   in Loop: Header=BB2_353 Depth=5
	s_mov_b32 s9, 0
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB2_353
	s_branch .LBB2_367
.LBB2_352:                              ;   in Loop: Header=BB2_353 Depth=5
	s_mov_b32 s5, 0
	s_sleep 2
	s_branch .LBB2_350
.LBB2_353:                              ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ;         Parent Loop BB2_258 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	;;#ASMSTART
	; O0 v34
	;;#ASMEND
	v_cmp_eq_u32_e64 s4, 0, v34
	v_mov_b32_e32 v0, s28
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_355
; %bb.354:                              ;   in Loop: Header=BB2_353 Depth=5
	global_load_dword v0, v[36:37], off glc dlc
.LBB2_355:                              ;   in Loop: Header=BB2_353 Depth=5
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s28, v0
	s_cmp_eq_u32 s28, s70
	s_cbranch_scc1 .LBB2_362
; %bb.356:                              ;   in Loop: Header=BB2_353 Depth=5
	v_mov_b32_e32 v0, s29
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_358
; %bb.357:                              ;   in Loop: Header=BB2_353 Depth=5
	global_load_dword v0, v[52:53], off glc dlc
.LBB2_358:                              ;   in Loop: Header=BB2_353 Depth=5
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	v_readfirstlane_b32 s29, v0
	s_mov_b32 s8, -1
	s_mov_b32 s5, -1
                                        ; implicit-def: $sgpr6_sgpr7
	s_cmp_lg_u32 s28, s29
	s_cbranch_scc0 .LBB2_351
; %bb.359:                              ;   in Loop: Header=BB2_353 Depth=5
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB2_349
; %bb.360:                              ;   in Loop: Header=BB2_353 Depth=5
	s_cmp_lt_u32 s28, s72
	s_cbranch_scc0 .LBB2_363
; %bb.361:                              ;   in Loop: Header=BB2_353 Depth=5
	s_add_u32 s6, s38, s73
	s_addc_u32 s7, s39, 0
	v_mad_u64_u32 v[0:1], s6, v27, s69, s[6:7]
	v_mad_u64_u32 v[0:1], s6, s28, 24, v[0:1]
	s_cbranch_execnz .LBB2_365
	s_branch .LBB2_364
.LBB2_362:                              ;   in Loop: Header=BB2_353 Depth=5
	s_mov_b32 s9, -1
	s_mov_b32 s8, 0
                                        ; implicit-def: $sgpr29
                                        ; implicit-def: $sgpr6_sgpr7
	s_cbranch_execz .LBB2_353
	s_branch .LBB2_367
.LBB2_363:                              ;   in Loop: Header=BB2_353 Depth=5
                                        ; implicit-def: $vgpr0_vgpr1
.LBB2_364:                              ;   in Loop: Header=BB2_353 Depth=5
	s_add_i32 s6, s28, s74
	s_lshr_b32 s8, s6, 8
	s_add_u32 s6, s38, s73
	s_addc_u32 s7, s39, 0
	v_mad_u64_u32 v[0:1], s6, v27, s69, s[6:7]
	v_mad_u64_u32 v[0:1], s6, s8, 24, v[0:1]
	s_and_b32 s6, s28, s75
	global_load_dwordx2 v[0:1], v[0:1], off glc dlc
	s_waitcnt vmcnt(0)
	v_mad_u64_u32 v[0:1], s6, s6, 24, v[0:1]
.LBB2_365:                              ;   in Loop: Header=BB2_353 Depth=5
	v_mov_b32_e32 v2, s28
	v_mov_b32_e32 v23, s12
	v_mov_b32_e32 v24, s13
	v_mov_b32_e32 v26, v25
	global_store_dword v25, v2, s[12:13] offset:4
	global_atomic_cmpswap_x2 v[2:3], v[0:1], v[23:26], off offset:8 glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u64_e32 vcc_lo, 0, v[2:3]
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_saveexec_b32 s6, vcc_lo
	s_cbranch_execz .LBB2_348
; %bb.366:                              ;   in Loop: Header=BB2_353 Depth=5
	s_waitcnt vmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_atomic_add v[36:37], v42, off
	v_mov_b32_e32 v3, v1
	v_mov_b32_e32 v2, v0
	s_branch .LBB2_348
.LBB2_367:                              ; %loop.exit.guard113
                                        ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_and_b32 vcc_lo, exec_lo, s9
	s_mov_b32 s5, 0
	s_cbranch_vccnz .LBB2_375
; %bb.368:                              ; %loop.exit.guard115
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_xor_b32 s5, s8, -1
	s_and_b32 vcc_lo, exec_lo, s5
	s_mov_b32 s5, -1
	s_cbranch_vccz .LBB2_370
; %bb.369:                              ;   in Loop: Header=BB2_258 Depth=4
	s_mov_b32 s5, 0
.LBB2_370:                              ; %Flow298
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_andn2_b32 vcc_lo, exec_lo, s5
	s_mov_b32 s5, 0
	s_cbranch_vccnz .LBB2_376
; %bb.371:                              ;   in Loop: Header=BB2_258 Depth=4
	s_and_saveexec_b32 s27, s4
	s_cbranch_execz .LBB2_373
; %bb.372:                              ;   in Loop: Header=BB2_258 Depth=4
	s_load_dwordx2 s[28:29], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, s12
	v_mov_b32_e32 v4, s13
	v_mov_b32_e32 v5, 0
	v_mov_b32_e32 v6, 0
	v_mov_b32_e32 v7, 0
	v_mov_b32_e32 v8, 0
	v_mov_b32_e32 v9, 0
	v_mov_b32_e32 v10, 0
	v_mov_b32_e32 v11, 0
	v_mov_b32_e32 v12, 0
	v_mov_b32_e32 v13, 0
	v_mov_b32_e32 v14, 0
	v_mov_b32_e32 v15, 0
	v_mov_b32_e32 v16, 0
	v_mov_b32_e32 v17, 0
	v_mov_b32_e32 v18, 0
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s28
	v_mov_b32_e32 v1, s29
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[30:31]
	s_add_u32 s30, s30, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s31, s31, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[30:31]
	v_mov_b32_e32 v34, 0
.LBB2_373:                              ; %Flow297
                                        ;   in Loop: Header=BB2_258 Depth=4
	s_or_b32 exec_lo, exec_lo, s27
	s_mov_b32 s5, -1
	s_branch .LBB2_377
.LBB2_374:                              ;   in Loop: Header=BB2_258 Depth=4
	s_mov_b32 s5, 0
.LBB2_375:                              ; %Flow331
                                        ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v33, v1
	v_mov_b32_e32 v32, v0
	s_branch .LBB2_257
.LBB2_376:                              ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, s6
	v_mov_b32_e32 v33, s7
	v_mov_b32_e32 v1, s7
	v_mov_b32_e32 v32, s6
.LBB2_377:                              ; %Flow299
                                        ;   in Loop: Header=BB2_258 Depth=4
	v_mov_b32_e32 v0, v32
	v_mov_b32_e32 v1, v33
	s_branch .LBB2_257
.LBB2_378:                              ;   in Loop: Header=BB2_228 Depth=3
	v_cmp_ne_u64_e64 s8, 1, v[32:33]
	s_and_b32 vcc_lo, exec_lo, s8
	s_cbranch_vccz .LBB2_380
; %bb.379:                              ;   in Loop: Header=BB2_228 Depth=3
	v_mov_b32_e32 v81, v33
	v_mov_b32_e32 v80, v32
	s_branch .LBB2_227
.LBB2_380:                              ;   in Loop: Header=BB2_228 Depth=3
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	v_mbcnt_hi_u32_b32 v0, exec_hi, v0
	v_cmp_eq_u32_e32 vcc_lo, 0, v0
	s_and_saveexec_b32 s9, vcc_lo
	s_cbranch_execz .LBB2_396
; %bb.381:                              ;   in Loop: Header=BB2_228 Depth=3
	global_load_dwordx2 v[0:1], v[64:65], off glc dlc
	s_memrealtime s[4:5]
	s_mov_b32 s63, s37
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_sub_co_u32 v0, vcc_lo, s4, v0
	v_sub_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo
	v_cmp_gt_u64_e32 vcc_lo, s[62:63], v[0:1]
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB2_396
; %bb.382:                              ;   in Loop: Header=BB2_228 Depth=3
	s_memrealtime s[6:7]
	v_sub_nc_u32_e32 v0, s62, v0
	v_readfirstlane_b32 s4, v0
	s_ashr_i32 s5, s4, 31
	s_waitcnt lgkmcnt(0)
	s_add_u32 s4, s6, s4
	s_addc_u32 s5, s7, s5
	s_add_u32 s10, s6, s78
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_384
.LBB2_383:                              ; %.preheader75
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	s_sleep 0x7f
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s78
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_383
.LBB2_384:                              ; %Flow294
                                        ;   in Loop: Header=BB2_228 Depth=3
	s_add_u32 s10, s6, s79
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_386
.LBB2_385:                              ; %.preheader73
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	s_sleep 63
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s79
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_385
.LBB2_386:                              ; %Flow291
                                        ;   in Loop: Header=BB2_228 Depth=3
	s_add_u32 s10, s6, s80
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_388
.LBB2_387:                              ; %.preheader71
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	s_sleep 31
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s80
	s_addc_u32 s11, s7, 0
	v_cmp_gt_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_387
.LBB2_388:                              ; %.loopexit72
                                        ;   in Loop: Header=BB2_228 Depth=3
	s_add_u32 s10, s6, s81
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_390
.LBB2_389:                              ; %.preheader69
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	s_sleep 15
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s81
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_389
.LBB2_390:                              ; %Flow285
                                        ;   in Loop: Header=BB2_228 Depth=3
	s_add_u32 s10, s6, s82
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_392
.LBB2_391:                              ; %.preheader67
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	s_sleep 7
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, s82
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_391
.LBB2_392:                              ; %Flow282
                                        ;   in Loop: Header=BB2_228 Depth=3
	s_add_u32 s10, s6, 38
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccnz .LBB2_394
.LBB2_393:                              ; %.preheader65
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	s_sleep 3
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s6, 38
	s_addc_u32 s11, s7, 0
	v_cmp_le_u64_e64 s10, s[4:5], s[10:11]
	s_and_b32 vcc_lo, exec_lo, s10
	s_cbranch_vccz .LBB2_393
.LBB2_394:                              ; %Flow279
                                        ;   in Loop: Header=BB2_228 Depth=3
	v_cmp_le_u64_e64 s6, s[4:5], s[6:7]
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_396
.LBB2_395:                              ; %.preheader64
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ;       Parent Loop BB2_228 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	s_sleep 1
	s_memrealtime s[6:7]
	s_waitcnt lgkmcnt(0)
	v_cmp_gt_u64_e64 s6, s[4:5], s[6:7]
	s_and_b32 vcc_lo, exec_lo, s6
	s_cbranch_vccnz .LBB2_395
.LBB2_396:                              ; %__ockl_rtcwait_u32.exit3
                                        ;   in Loop: Header=BB2_228 Depth=3
	s_or_b32 exec_lo, exec_lo, s9
	v_cmp_eq_u32_e32 vcc_lo, 0, v44
	v_mov_b32_e32 v0, s90
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_226
; %bb.397:                              ;   in Loop: Header=BB2_228 Depth=3
	global_load_dword v0, v[36:37], off glc dlc
	s_branch .LBB2_226
.LBB2_398:                              ; %.loopexit77
                                        ;   in Loop: Header=BB2_11 Depth=2
	v_readfirstlane_b32 s6, v80
	v_readfirstlane_b32 s7, v81
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v1, 0
	s_cmp_eq_u64 s[6:7], 0
	s_cbranch_scc1 .LBB2_9
; %bb.399:                              ;   in Loop: Header=BB2_11 Depth=2
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	v_mov_b32_e32 v2, 0
	s_mov_b64 s[4:5], exec
	v_mbcnt_hi_u32_b32 v6, exec_hi, v0
	;;#ASMSTART
	; O0 v6
	;;#ASMEND
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	global_load_dwordx2 v[0:1], v25, s[6:7] offset:8 glc dlc
	s_waitcnt vmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	v_cmp_eq_u32_e32 vcc_lo, 0, v6
	global_load_dword v24, v[0:1], off
	s_and_saveexec_b32 s8, vcc_lo
	s_cbranch_execz .LBB2_401
; %bb.400:                              ;   in Loop: Header=BB2_11 Depth=2
	s_bcnt1_i32_b64 s4, s[4:5]
	v_mov_b32_e32 v2, s4
	global_atomic_add v2, v[0:1], v2, off offset:8 glc
.LBB2_401:                              ;   in Loop: Header=BB2_11 Depth=2
	s_or_b32 exec_lo, exec_lo, s8
	s_waitcnt vmcnt(0)
	v_lshlrev_b64 v[4:5], 5, v[24:25]
	v_readfirstlane_b32 s9, v2
	v_add_co_u32 v3, s4, v4, s46
	v_add_co_ci_u32_e64 v7, s4, s47, v5, s4
	v_readfirstlane_b32 s4, v3
	v_mov_b32_e32 v2, 0
	v_readfirstlane_b32 s5, v7
	v_mov_b32_e32 v3, 0
	s_load_dword s5, s[4:5], 0x0
	s_waitcnt lgkmcnt(0)
	s_add_i32 s8, s5, 31
	s_cmp_lt_u32 s8, 32
	s_cbranch_scc1 .LBB2_411
; %bb.402:                              ;   in Loop: Header=BB2_11 Depth=2
	v_cvt_f32_u32_e32 v2, s5
	s_getpc_b64 s[10:11]
	s_add_u32 s10, s10, __unnamed_1@rel32@lo+32
	s_addc_u32 s11, s11, __unnamed_1@rel32@hi+40
	v_add_nc_u32_e32 v6, s9, v6
	s_mov_b32 s9, 0
	v_rcp_iflag_f32_e32 v7, v2
	v_add_co_u32 v2, s4, v4, s10
	v_add_co_ci_u32_e64 v3, s4, s11, v5, s4
	v_readfirstlane_b32 s10, v2
	v_readfirstlane_b32 s11, v3
	v_mul_f32_e32 v2, s96, v7
	v_bfe_i32 v7, v24, 0, 1
	s_load_dword s4, s[10:11], 0x0
	s_sub_i32 s10, 0, s5
	v_cvt_u32_f32_e32 v2, v2
	v_mul_lo_u32 v3, s10, v2
	v_mul_hi_u32 v3, v2, v3
	s_waitcnt lgkmcnt(0)
	v_mul_lo_u32 v6, s4, v6
	v_add_nc_u32_e32 v2, v2, v3
	v_lshrrev_b32_e32 v3, 1, v24
	v_mul_hi_u32 v2, v6, v2
	v_add_nc_u32_e32 v3, 4, v3
	v_lshlrev_b32_e64 v3, v3, 1
	v_mul_lo_u32 v2, v2, s5
	v_lshrrev_b32_e32 v8, 1, v3
	v_sub_nc_u32_e32 v2, v6, v2
	v_subrev_nc_u32_e32 v6, s5, v2
	v_cmp_le_u32_e64 s4, s5, v2
	v_cndmask_b32_e64 v2, v2, v6, s4
	v_subrev_nc_u32_e32 v6, s5, v2
	v_cmp_le_u32_e64 s4, s5, v2
	v_cndmask_b32_e64 v2, v2, v6, s4
	v_and_b32_e32 v6, v7, v8
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, __unnamed_1@rel32@lo+16
	s_addc_u32 s5, s5, __unnamed_1@rel32@hi+24
	s_lshr_b32 s8, s8, 5
	v_add_co_u32 v4, s4, v4, s4
	v_lshrrev_b32_e32 v24, 5, v2
	v_add_nc_u32_e32 v8, v6, v3
	v_mov_b32_e32 v2, 0
	v_add_co_ci_u32_e64 v5, s4, s5, v5, s4
	v_sub_nc_u32_e64 v9, s8, 1 clamp
	v_mov_b32_e32 v3, 0
	s_branch .LBB2_404
.LBB2_403:                              ;   in Loop: Header=BB2_404 Depth=3
	s_or_b32 exec_lo, exec_lo, s5
	v_cmp_ne_u32_e64 s4, 0, v10
	v_cmp_eq_u32_e64 s5, 0, v9
	v_add_nc_u32_e32 v9, -1, v9
	s_or_b32 s4, s4, s5
	s_and_b32 s4, exec_lo, s4
	s_or_b32 s9, s4, s9
	s_andn2_b32 exec_lo, exec_lo, s9
	s_cbranch_execz .LBB2_410
.LBB2_404:                              ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_11 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	v_lshlrev_b64 v[6:7], 2, v[24:25]
	s_mov_b32 s11, -1
                                        ; implicit-def: $vgpr10
	v_add_co_u32 v6, s4, v0, v6
	v_add_co_ci_u32_e64 v7, s4, v1, v7, s4
	global_load_dword v11, v[6:7], off offset:16 glc dlc
	s_waitcnt vmcnt(0)
	v_cmp_ne_u32_e64 s4, -1, v11
	s_and_saveexec_b32 s10, s4
	s_cbranch_execz .LBB2_408
; %bb.405:                              ;   in Loop: Header=BB2_404 Depth=3
	v_not_b32_e32 v10, v11
	v_add_co_u32 v6, s4, v6, 16
	v_add_co_ci_u32_e64 v7, s4, 0, v7, s4
	v_ffbl_b32_e32 v10, v10
	v_min_u32_e32 v11, 32, v10
	v_lshlrev_b32_e64 v10, v11, 1
	global_atomic_or v6, v[6:7], v10, off glc
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v6, v6, v10
	v_mov_b32_e32 v10, 0
	v_cmp_ne_u32_e64 s4, 0, v6
	v_cmp_eq_u32_e64 s5, 0, v6
	s_and_saveexec_b32 s11, s5
	s_cbranch_execz .LBB2_407
; %bb.406:                              ;   in Loop: Header=BB2_404 Depth=3
	v_readfirstlane_b32 s12, v4
	v_readfirstlane_b32 s13, v5
	v_lshl_add_u32 v2, v24, 5, v11
	v_mov_b32_e32 v10, 2
	s_load_dword s5, s[12:13], 0x0
	v_mul_lo_u32 v2, v2, v8
	s_waitcnt lgkmcnt(0)
	v_add_co_u32 v3, s5, v0, s5
	v_add_co_ci_u32_e64 v6, s5, 0, v1, s5
	v_add_co_u32 v2, s5, v3, v2
	v_add_co_ci_u32_e64 v3, s5, 0, v6, s5
.LBB2_407:                              ;   in Loop: Header=BB2_404 Depth=3
	s_or_b32 exec_lo, exec_lo, s11
	s_orn2_b32 s11, s4, exec_lo
.LBB2_408:                              ; %Flow123
                                        ;   in Loop: Header=BB2_404 Depth=3
	s_or_b32 exec_lo, exec_lo, s10
	s_and_saveexec_b32 s5, s11
	s_cbranch_execz .LBB2_403
; %bb.409:                              ;   in Loop: Header=BB2_404 Depth=3
	v_cvt_f32_u32_e32 v6, s8
	s_sub_i32 s4, 0, s8
	v_add_nc_u32_e32 v10, 1, v24
	v_rcp_iflag_f32_e32 v6, v6
	v_mul_f32_e32 v6, s96, v6
	v_cvt_u32_f32_e32 v6, v6
	v_mul_lo_u32 v7, s4, v6
	v_mul_hi_u32 v7, v6, v7
	v_add_nc_u32_e32 v6, v6, v7
	v_mul_hi_u32 v6, v10, v6
	v_mul_lo_u32 v6, v6, s8
	v_sub_nc_u32_e32 v6, v10, v6
	v_mov_b32_e32 v10, 0
	v_subrev_nc_u32_e32 v7, s8, v6
	v_cmp_le_u32_e64 s4, s8, v6
	v_cndmask_b32_e64 v6, v6, v7, s4
	v_subrev_nc_u32_e32 v7, s8, v6
	v_cmp_le_u32_e64 s4, s8, v6
	v_cndmask_b32_e64 v24, v6, v7, s4
	s_branch .LBB2_403
.LBB2_410:                              ; %Flow124
                                        ;   in Loop: Header=BB2_11 Depth=2
	s_or_b32 exec_lo, exec_lo, s9
.LBB2_411:                              ; %.loopexit81
                                        ;   in Loop: Header=BB2_11 Depth=2
	v_cmp_ne_u64_e64 s4, 0, v[2:3]
	s_and_saveexec_b32 s8, vcc_lo
	s_cbranch_execz .LBB2_413
; %bb.412:                              ;   in Loop: Header=BB2_11 Depth=2
	s_mov_b32 s5, s37
	s_bcnt1_i32_b64 s4, s[4:5]
	v_mov_b32_e32 v0, s4
	global_atomic_add v25, v0, s[6:7] offset:16
.LBB2_413:                              ;   in Loop: Header=BB2_11 Depth=2
	s_or_b32 exec_lo, exec_lo, s8
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_and_saveexec_b32 s4, vcc_lo
	s_cbranch_execz .LBB2_8
; %bb.414:                              ;   in Loop: Header=BB2_11 Depth=2
	v_mov_b32_e32 v43, 0
	v_mov_b32_e32 v41, 0
	s_branch .LBB2_8
.LBB2_415:                              ; %Flow398
	s_or_saveexec_b32 s4, s65
	s_xor_b32 exec_lo, exec_lo, s4
	s_cbranch_execz .LBB2_419
; %bb.416:
	s_load_dwordx2 s[12:13], s[18:19], 0x50
	v_mov_b32_e32 v2, 3
	v_mov_b32_e32 v3, 0
	v_mov_b32_e32 v4, 0
	v_mov_b32_e32 v5, v0
	v_mov_b32_e32 v6, v1
	v_mov_b32_e32 v7, 0
	v_mov_b32_e32 v8, 0
	v_mov_b32_e32 v9, 0
	v_mov_b32_e32 v10, 0
	v_mov_b32_e32 v11, 0
	v_mov_b32_e32 v12, 0
	v_mov_b32_e32 v13, 0
	v_mov_b32_e32 v14, 0
	v_mov_b32_e32 v15, 0
	v_mov_b32_e32 v16, 0
	v_mov_b32_e32 v17, 0
	v_mov_b32_e32 v18, 0
	s_mov_b64 s[4:5], s[24:25]
	s_mov_b64 s[6:7], s[22:23]
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s12
	v_mov_b32_e32 v1, s13
	s_mov_b64 s[8:9], s[18:19]
	s_mov_b64 s[10:11], s[20:21]
	s_mov_b32 s12, s35
	s_mov_b32 s13, s34
	s_getpc_b64 s[26:27]
	s_add_u32 s26, s26, __ockl_hostcall_internal@rel32@lo+4
	s_addc_u32 s27, s27, __ockl_hostcall_internal@rel32@hi+12
	s_swappc_b64 s[30:31], s[26:27]
	v_cmp_ne_u64_e32 vcc_lo, 0, v[0:1]
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB2_419
; %bb.417:
	v_mbcnt_lo_u32_b32 v0, exec_lo, 0
	s_mov_b64 s[4:5], exec
	v_mbcnt_hi_u32_b32 v0, exec_hi, v0
	v_cmp_eq_u32_e32 vcc_lo, 0, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB2_419
; %bb.418:
	s_load_dwordx2 s[6:7], s[18:19], 0x60
	s_bcnt1_i32_b64 s4, s[4:5]
	v_mov_b32_e32 v1, 0
	v_mov_b32_e32 v0, s4
	v_mov_b32_e32 v2, 0x1a800
	s_waitcnt lgkmcnt(0)
	global_atomic_add_x2 v2, v[0:1], s[6:7] offset:128
	s_or_b32 exec_lo, exec_lo, s64
	s_waitcnt_vscnt null, 0x0
	s_setpc_b64 s[16:17]
.LBB2_419:                              ; %.loopexit88
	s_or_b32 exec_lo, exec_lo, s64
	s_waitcnt_vscnt null, 0x0
	s_setpc_b64 s[16:17]
.Lfunc_end2:
	.size	__ockl_dm_alloc, .Lfunc_end2-__ockl_dm_alloc
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata
; Function info:
; codeLenInByte = 12140
; NumSgprs: 102
; NumVgprs: 120
; ScratchSize: 160
; MemoryBound: 0
	.text
	.globl	_Z2mm                           ; -- Begin function _Z2mm
	.p2align	8
	.type	_Z2mm,@function
_Z2mm:                                  ; @_Z2mm
.Lfunc_begin3:
	.file	1 "/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl"
	.loc	1 369 0                         ; /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:369:0
	.cfi_startproc
; %bb.0:                                ; %conversion
	s_add_u32 s12, s12, s17
	s_mov_b32 s32, 0
	s_mov_b32 s33, 0
	s_addc_u32 s13, s13, 0
	s_setreg_b32 hwreg(HW_REG_FLAT_SCR_LO), s12
	s_setreg_b32 hwreg(HW_REG_FLAT_SCR_HI), s13
	v_lshlrev_b32_e32 v2, 20, v2
	v_lshlrev_b32_e32 v1, 10, v1
	s_add_u32 s0, s0, s17
	s_addc_u32 s1, s1, 0
.Ltmp0:
	.file	2 "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl"
	.loc	2 4 0 prologue_end              ; /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4:0
	s_add_u32 s8, s8, 56
	s_mov_b32 s13, s15
	v_or3_b32 v31, v0, v1, v2
	v_mov_b32_e32 v0, 0x80
	v_mov_b32_e32 v1, 0
	s_mov_b32 s12, s14
	s_addc_u32 s9, s9, 0
	s_mov_b32 s14, s16
	s_getpc_b64 s[18:19]
	s_add_u32 s18, s18, __ockl_dm_alloc@rel32@lo+4
	s_addc_u32 s19, s19, __ockl_dm_alloc@rel32@hi+12
	s_swappc_b64 s[30:31], s[18:19]
.Ltmp1:
	.loc	1 372 0                         ; /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:372:0
	s_endpgm
.Ltmp2:
	.section	.rodata,#alloc
	.p2align	6
	.amdhsa_kernel _Z2mm
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 160
		.amdhsa_kernarg_size 112
		.amdhsa_user_sgpr_count 14
		.amdhsa_user_sgpr_private_segment_buffer 1
		.amdhsa_user_sgpr_dispatch_ptr 1
		.amdhsa_user_sgpr_queue_ptr 1
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 1
		.amdhsa_user_sgpr_flat_scratch_init 1
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_system_sgpr_private_segment_wavefront_offset 1
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 1
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 2
		.amdhsa_next_free_vgpr 120
		.amdhsa_next_free_sgpr 100
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
.Lfunc_end3:
	.size	_Z2mm, .Lfunc_end3-_Z2mm
	.cfi_endproc
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 108
; NumSgprs: 102
; NumVgprs: 120
; ScratchSize: 160
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 12
; VGPRBlocks: 14
; NumSGPRsForWavesPerEU: 102
; NumVGPRsForWavesPerEU: 120
; Occupancy: 8
; WaveLimiterHint : 1
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 1
; COMPUTE_PGM_RSRC2:USER_SGPR: 14
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 1
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 2
	.text
	.p2alignl 6, 3214868480
	.fill 48, 4, 3214868480
	.type	__unnamed_1,@object             ; @0
	.section	.rodata,#alloc
	.p2align	2
__unnamed_1:
	.long	130054                          ; 0x1fc06
	.long	129546                          ; 0x1fa0a
	.long	110114                          ; 0x1ae22
	.long	16288                           ; 0x3fa0
	.long	6                               ; 0x6
	.long	256                             ; 0x100
	.long	0                               ; 0x0
	.long	4195                            ; 0x1063
	.long	86927                           ; 0x1538f
	.long	86758                           ; 0x152e6
	.long	73744                           ; 0x12010
	.long	10904                           ; 0x2a98
	.long	399                             ; 0x18f
	.long	512                             ; 0x200
	.long	0                               ; 0x0
	.long	2804                            ; 0xaf4
	.long	65280                           ; 0xff00
	.long	64770                           ; 0xfd02
	.long	55054                           ; 0xd70e
	.long	8192                            ; 0x2000
	.long	0                               ; 0x0
	.long	128                             ; 0x80
	.long	0                               ; 0x0
	.long	2107                            ; 0x83b
	.long	43576                           ; 0xaa38
	.long	43406                           ; 0xa98e
	.long	36895                           ; 0x901f
	.long	5504                            ; 0x1580
	.long	56                              ; 0x38
	.long	256                             ; 0x100
	.long	0                               ; 0x0
	.long	1405                            ; 0x57d
	.long	32703                           ; 0x7fbf
	.long	32193                           ; 0x7dc1
	.long	27364                           ; 0x6ae4
	.long	4160                            ; 0x1040
	.long	63                              ; 0x3f
	.long	64                              ; 0x40
	.long	0                               ; 0x0
	.long	1054                            ; 0x41e
	.long	21816                           ; 0x5538
	.long	21646                           ; 0x548e
	.long	18399                           ; 0x47df
	.long	2816                            ; 0xb00
	.long	56                              ; 0x38
	.long	128                             ; 0x80
	.long	0                               ; 0x0
	.long	703                             ; 0x2bf
	.long	16367                           ; 0x3fef
	.long	15856                           ; 0x3df0
	.long	13477                           ; 0x34a5
	.long	2176                            ; 0x880
	.long	15                              ; 0xf
	.long	32                              ; 0x20
	.long	32768                           ; 0x8000
	.long	527                             ; 0x20f
	.long	10915                           ; 0x2aa3
	.long	10745                           ; 0x29f9
	.long	9133                            ; 0x23ad
	.long	1472                            ; 0x5c0
	.long	35                              ; 0x23
	.long	64                              ; 0x40
	.long	0                               ; 0x0
	.long	352                             ; 0x160
	.long	8187                            ; 0x1ffb
	.long	7676                            ; 0x1dfc
	.long	6524                            ; 0x197c
	.long	1280                            ; 0x500
	.long	11                              ; 0xb
	.long	16                              ; 0x10
	.long	134219776                       ; 0x8000800
	.long	265                             ; 0x109
	.long	5459                            ; 0x1553
	.long	5289                            ; 0x14a9
	.long	4495                            ; 0x118f
	.long	896                             ; 0x380
	.long	19                              ; 0x13
	.long	32                              ; 0x20
	.long	524288                          ; 0x80000
	.long	176                             ; 0xb0
	.long	4094                            ; 0xffe
	.long	3583                            ; 0xdff
	.long	3045                            ; 0xbe5
	.long	1024                            ; 0x400
	.long	6                               ; 0x6
	.long	8                               ; 0x8
	.long	1077952576                      ; 0x40404040
	.long	133                             ; 0x85
	.long	2730                            ; 0xaaa
	.long	2560                            ; 0xa00
	.long	2176                            ; 0x880
	.long	512                             ; 0x200
	.long	10                              ; 0xa
	.long	16                              ; 0x10
	.long	67109888                        ; 0x4000400
	.long	89                              ; 0x59
	.long	2047                            ; 0x7ff
	.long	1536                            ; 0x600
	.long	1305                            ; 0x519
	.long	1024                            ; 0x400
	.long	3                               ; 0x3
	.long	4                               ; 0x4
	.long	2290649224                      ; 0x88888888
	.long	66                              ; 0x42
	.long	1365                            ; 0x555
	.long	1195                            ; 0x4ab
	.long	1015                            ; 0x3f7
	.long	512                             ; 0x200
	.long	5                               ; 0x5
	.long	8                               ; 0x8
	.long	538976288                       ; 0x20202020
	.long	44                              ; 0x2c
	.long	1023                            ; 0x3ff
	.long	512                             ; 0x200
	.long	435                             ; 0x1b3
	.long	2048                            ; 0x800
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.long	2863311530                      ; 0xaaaaaaaa
	.long	34                              ; 0x22
	.long	682                             ; 0x2aa
	.long	512                             ; 0x200
	.long	435                             ; 0x1b3
	.long	2048                            ; 0x800
	.long	2                               ; 0x2
	.long	4                               ; 0x4
	.long	1145324612                      ; 0x44444444
	.long	35                              ; 0x23
	.size	__unnamed_1, 512

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
	.byte	1                               ; Abbrev [1] 0xb:0x4c DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string1                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string2                  ; DW_AT_comp_dir
	.quad	.Lfunc_begin3                   ; DW_AT_low_pc
	.long	.Lfunc_end3-.Lfunc_begin3       ; DW_AT_high_pc
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string3                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	3                               ; Abbrev [3] 0x30:0x26 DW_TAG_subprogram
	.quad	.Lfunc_begin3                   ; DW_AT_low_pc
	.long	.Lfunc_end3-.Lfunc_begin3       ; DW_AT_high_pc
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	4                               ; Abbrev [4] 0x41:0x14 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Ltmp0                          ; DW_AT_low_pc
	.long	.Ltmp1-.Ltmp0                   ; DW_AT_high_pc
	.byte	1                               ; DW_AT_call_file
	.short	370                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"julia"                         ; string offset=0
.Linfo_string1:
	.asciz	"/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl" ; string offset=6
.Linfo_string2:
	.asciz	"."                             ; string offset=51
.Linfo_string3:
	.asciz	"#dm_alloc;"                    ; string offset=53
.Linfo_string4:
	.asciz	"mm"                            ; string offset=64
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
	.ident	"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"
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
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         64
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         72
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .address_space:  global
        .offset:         80
        .size:           8
        .value_kind:     hidden_none
      - .address_space:  global
        .offset:         88
        .size:           8
        .value_kind:     hidden_none
      - .address_space:  global
        .offset:         96
        .size:           8
        .value_kind:     hidden_none
      - .address_space:  global
        .offset:         104
        .size:           8
        .value_kind:     hidden_multigrid_sync_arg
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 112
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z2mm
    .private_segment_fixed_size: 160
    .sgpr_count:     102
    .sgpr_spill_count: 0
    .symbol:         _Z2mm.kd
    .vgpr_count:     120
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
