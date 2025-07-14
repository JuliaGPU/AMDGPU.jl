	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1100"
	.globl	_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE ; -- Begin function _Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
	.p2align	8
	.type	_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE,@function
_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE: ; @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
.Lfunc_begin0:
	.file	1 "." "/home/pxlth/.julia/dev/t.jl"
	.loc	1 3 0                           ; /home/pxlth/.julia/dev/t.jl:3:0
	.cfi_sections .debug_frame
	.cfi_startproc
; %bb.0:                                ; %conversion
	.file	2 "." "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl"
	.loc	2 39 0 prologue_end             ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	s_load_b64 s[2:3], s[0:1], 0x0
.Ltmp0:
	.loc	2 39 0 is_stmt 0                ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	v_dual_mov_b32 v1, 1 :: v_dual_mov_b32 v2, 0
	s_mov_b32 s0, 0
.Ltmp1:
	.file	3 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl"
	.loc	3 112 0 is_stmt 1               ; /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112:0
	s_mov_b32 s1, exec_lo
.Ltmp2:
	.loc	2 39 0                          ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v4, s3 :: v_dual_mov_b32 v3, s2
.Ltmp3:
	.loc	2 39 0 is_stmt 0                ; /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39:0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	flat_atomic_cmpswap_b32 v1, v[3:4], v[1:2] offset:4 glc
	s_waitcnt vmcnt(0) lgkmcnt(0)
	buffer_gl0_inv
	buffer_gl1_inv
	v_cmpx_ne_u32_e32 0, v1
.Ltmp4:
	.loc	3 112 0 is_stmt 1               ; /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112:0
	s_xor_b32 s1, exec_lo, s1
	s_cbranch_execz .LBB0_10
; %bb.1:                                ; %L46.i
.Ltmp5:
	.file	4 "." "pointer.jl"
	.loc	4 153 0                         ; pointer.jl:153:0
	v_dual_mov_b32 v1, s2 :: v_dual_mov_b32 v2, s3
.Ltmp6:
	.loc	3 118 0                         ; /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:118:0
	s_mov_b32 s4, exec_lo
.Ltmp7:
	.loc	4 153 0                         ; pointer.jl:153:0
	s_clause 0x3
	flat_load_u8 v3, v[1:2] offset:4
	flat_load_u8 v4, v[1:2] offset:5
	flat_load_u8 v5, v[1:2] offset:6
	flat_load_u8 v1, v[1:2] offset:7
	s_waitcnt vmcnt(2) lgkmcnt(2)
	v_lshl_or_b32 v2, v4, 8, v3
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v1, v1, 8, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v1, v1, 16, v2
.Ltmp8:
	.file	5 "." "promotion.jl"
	.loc	5 639 0                         ; promotion.jl:639:0
	v_cmpx_eq_u32_e32 1, v1
.Ltmp9:
	.loc	3 118 0                         ; /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:118:0
	s_cbranch_execz .LBB0_9
; %bb.2:                                ; %L53.i
.Ltmp10:
	.loc	4 316 0                         ; pointer.jl:316:0
	v_dual_mov_b32 v1, s2 :: v_dual_mov_b32 v2, s3
.Ltmp11:
	.file	6 "." "tuple.jl"
	.loc	6 552 0                         ; tuple.jl:552:0
	s_mov_b32 s5, exec_lo
.Ltmp12:
	.loc	4 153 0                         ; pointer.jl:153:0
	s_clause 0x3
	flat_load_u8 v3, v[1:2] offset:8
	flat_load_u8 v4, v[1:2] offset:9
	flat_load_u8 v5, v[1:2] offset:10
	flat_load_u8 v1, v[1:2] offset:11
	s_waitcnt vmcnt(2) lgkmcnt(2)
	v_lshl_or_b32 v2, v4, 8, v3
	v_and_b32_e32 v3, 0x3ff, v0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v1, v1, 8, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshl_or_b32 v1, v1, 16, v2
.Ltmp13:
	.file	7 "." "int.jl"
	.loc	7 87 0                          ; int.jl:87:0
	v_add_nc_u32_e32 v2, 1, v3
	s_delay_alu instid0(VALU_DEP_1)
.Ltmp14:
	.loc	5 639 0                         ; promotion.jl:639:0
	v_cmpx_eq_u32_e64 v1, v2
.Ltmp15:
	.loc	6 552 0                         ; tuple.jl:552:0
	s_cbranch_execz .LBB0_8
.Ltmp16:
; %bb.3:                                ; %L74.i
	.loc	4 316 0                         ; pointer.jl:316:0
	v_dual_mov_b32 v1, s2 :: v_dual_mov_b32 v2, s3
.Ltmp17:
	.loc	4 153 0                         ; pointer.jl:153:0
	s_clause 0x7
	flat_load_u8 v3, v[1:2] offset:16
	flat_load_u8 v4, v[1:2] offset:17
	flat_load_u8 v5, v[1:2] offset:18
	flat_load_u8 v6, v[1:2] offset:19
	flat_load_u8 v7, v[1:2] offset:12
	flat_load_u8 v8, v[1:2] offset:13
	flat_load_u8 v9, v[1:2] offset:14
	flat_load_u8 v1, v[1:2] offset:15
	v_bfe_u32 v2, v0, 20, 10
	v_bfe_u32 v0, v0, 10, 10
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
.Ltmp18:
	.loc	7 87 0                          ; int.jl:87:0
	v_add_nc_u32_e32 v2, 1, v2
.Ltmp19:
	.loc	7 87 0 is_stmt 0                ; int.jl:87:0
	v_add_nc_u32_e32 v0, 1, v0
.Ltmp20:
	.loc	4 153 0 is_stmt 1               ; pointer.jl:153:0
	s_waitcnt vmcnt(6) lgkmcnt(6)
	v_lshl_or_b32 v3, v4, 8, v3
	s_waitcnt vmcnt(4) lgkmcnt(4)
	v_lshl_or_b32 v5, v6, 8, v5
	s_waitcnt vmcnt(2) lgkmcnt(2)
	v_lshl_or_b32 v4, v8, 8, v7
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v1, v1, 8, v9
	v_lshl_or_b32 v3, v5, 16, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v1, v1, 16, v4
	v_cmp_eq_u32_e64 s0, v3, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
.Ltmp21:
	.loc	5 639 0                         ; promotion.jl:639:0
	v_cmp_eq_u32_e32 vcc_lo, v1, v0
	s_and_b32 s7, vcc_lo, s0
	s_mov_b32 s0, 0
.Ltmp22:
	.loc	3 118 0                         ; /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:118:0
	s_and_saveexec_b32 s6, s7
	s_cbranch_execz .LBB0_7
; %bb.4:                                ; %L91.i
.Ltmp23:
	.loc	4 316 0                         ; pointer.jl:316:0
	v_dual_mov_b32 v0, s2 :: v_dual_mov_b32 v1, s3
.Ltmp24:
	.loc	7 87 0                          ; int.jl:87:0
	s_add_i32 s0, s13, 1
.Ltmp25:
	.loc	4 153 0                         ; pointer.jl:153:0
	s_clause 0x3
	flat_load_u8 v2, v[0:1] offset:20
	flat_load_u8 v3, v[0:1] offset:21
	flat_load_u8 v4, v[0:1] offset:22
	flat_load_u8 v0, v[0:1] offset:23
	s_waitcnt vmcnt(2) lgkmcnt(2)
	v_lshl_or_b32 v1, v3, 8, v2
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v0, v0, 8, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v0, 16, v1
.Ltmp26:
	.loc	5 639 0                         ; promotion.jl:639:0
	v_cmp_eq_u32_e32 vcc_lo, s0, v0
	s_mov_b32 s0, 0
.Ltmp27:
	.loc	6 552 0                         ; tuple.jl:552:0
	s_and_saveexec_b32 s7, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s7, exec_lo, s7
	s_cbranch_execz .LBB0_6
.Ltmp28:
; %bb.5:                                ; %L112.i
	.loc	4 316 0                         ; pointer.jl:316:0
	v_dual_mov_b32 v0, s2 :: v_dual_mov_b32 v1, s3
.Ltmp29:
	.loc	7 87 0                          ; int.jl:87:0
	s_add_i32 s0, s14, 1
.Ltmp30:
	.loc	7 87 0 is_stmt 0                ; int.jl:87:0
	s_add_i32 s8, s15, 1
.Ltmp31:
	.loc	4 153 0 is_stmt 1               ; pointer.jl:153:0
	s_clause 0x7
	flat_load_u8 v2, v[0:1] offset:28
	flat_load_u8 v3, v[0:1] offset:29
	flat_load_u8 v4, v[0:1] offset:30
	flat_load_u8 v5, v[0:1] offset:31
	flat_load_u8 v6, v[0:1] offset:24
	flat_load_u8 v7, v[0:1] offset:25
	flat_load_u8 v8, v[0:1] offset:26
	flat_load_u8 v0, v[0:1] offset:27
	s_waitcnt vmcnt(6) lgkmcnt(6)
	v_lshl_or_b32 v1, v3, 8, v2
	s_waitcnt vmcnt(4) lgkmcnt(4)
	v_lshl_or_b32 v3, v5, 8, v4
	s_waitcnt vmcnt(2) lgkmcnt(2)
	v_lshl_or_b32 v2, v7, 8, v6
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_lshl_or_b32 v0, v0, 8, v8
	v_lshl_or_b32 v1, v3, 16, v1
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v0, 16, v2
.Ltmp32:
	.loc	5 639 0                         ; promotion.jl:639:0
	v_cmp_eq_u32_e32 vcc_lo, s0, v0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cmp_eq_u32_e64 s0, s8, v1
	s_and_b32 s0, vcc_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s0, s0, exec_lo
.Ltmp33:
.LBB0_6:                                ; %Flow6
	.loc	5 0 0 is_stmt 0                 ; promotion.jl:0:0
	s_or_b32 exec_lo, exec_lo, s7
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s0, s0, exec_lo
.LBB0_7:                                ; %Flow5
	s_or_b32 exec_lo, exec_lo, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s0, s0, exec_lo
.LBB0_8:                                ; %Flow4
	s_or_b32 exec_lo, exec_lo, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s0, s0, exec_lo
.LBB0_9:                                ; %Flow3
	s_or_b32 exec_lo, exec_lo, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 s0, s0, exec_lo
                                        ; implicit-def: $vgpr0
.LBB0_10:                               ; %Flow
	.loc	3 112 0 is_stmt 1               ; /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112:0
	s_and_not1_saveexec_b32 s1, s1
	s_cbranch_execz .LBB0_12
; %bb.11:                               ; %L12.i
	.loc	3 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:0:0
	v_and_b32_e32 v1, 0x3ff, v0
	v_bfe_u32 v2, v0, 10, 10
	v_bfe_u32 v3, v0, 20, 10
.Ltmp34:
	.loc	7 87 0 is_stmt 1                ; int.jl:87:0
	s_add_i32 s4, s13, 1
.Ltmp35:
	.loc	7 87 0 is_stmt 0                ; int.jl:87:0
	s_add_i32 s5, s14, 1
.Ltmp36:
	.loc	7 87 0                          ; int.jl:87:0
	v_add_nc_u32_e32 v4, 1, v1
.Ltmp37:
	.loc	4 316 0 is_stmt 1               ; pointer.jl:316:0
	v_dual_mov_b32 v0, s2 :: v_dual_mov_b32 v1, s3
	v_dual_mov_b32 v5, 0 :: v_dual_add_nc_u32 v2, 1, v2
.Ltmp38:
	.loc	7 87 0                          ; int.jl:87:0
	v_add_nc_u32_e32 v3, 1, v3
	s_delay_alu instid0(VALU_DEP_4)
.Ltmp39:
	.loc	4 180 0                         ; pointer.jl:180:0
	v_lshrrev_b32_e32 v6, 8, v4
	s_clause 0x1
	flat_store_b8 v[0:1], v4 offset:8
	flat_store_b8 v[0:1], v2 offset:12
	v_lshrrev_b32_e32 v4, 8, v2
	v_lshrrev_b32_e32 v2, 8, v3
.Ltmp40:
	.loc	4 180 0 is_stmt 0               ; pointer.jl:180:0
	s_lshr_b32 s6, s4, 24
.Ltmp41:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x8
	flat_store_b8 v[0:1], v5 offset:11
	flat_store_b8 v[0:1], v5 offset:10
	flat_store_b8 v[0:1], v6 offset:9
	flat_store_b8 v[0:1], v5 offset:15
	flat_store_b8 v[0:1], v5 offset:14
	flat_store_b8 v[0:1], v4 offset:13
	flat_store_b8 v[0:1], v3 offset:16
	flat_store_b8 v[0:1], v5 offset:18
	flat_store_b8 v[0:1], v2 offset:17
.Ltmp42:
	.loc	7 87 0 is_stmt 1                ; int.jl:87:0
	v_mov_b32_e32 v2, s4
.Ltmp43:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_lshr_b32 s4, s4, 8
	s_delay_alu instid0(SALU_CYCLE_1)
	v_dual_mov_b32 v3, s6 :: v_dual_mov_b32 v4, s4
	s_lshr_b32 s4, s5, 8
.Ltmp44:
	.loc	7 87 0                          ; int.jl:87:0
	s_add_i32 s6, s15, 1
.Ltmp45:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x2
	flat_store_b8 v[0:1], v5 offset:19
	flat_store_b8 v[0:1], v2 offset:20
	flat_store_b8 v[0:1], v3 offset:23
.Ltmp46:
	.loc	4 180 0 is_stmt 0               ; pointer.jl:180:0
	v_mov_b32_e32 v5, s4
	s_lshr_b32 s4, s5, 24
.Ltmp47:
	.loc	7 87 0 is_stmt 1                ; int.jl:87:0
	v_mov_b32_e32 v3, s5
.Ltmp48:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x1
	flat_store_d16_hi_b8 v[0:1], v2 offset:22
	flat_store_b8 v[0:1], v4 offset:21
	v_mov_b32_e32 v2, s4
	s_lshr_b32 s4, s6, 24
.Ltmp49:
	.loc	7 87 0                          ; int.jl:87:0
	v_mov_b32_e32 v4, s6
.Ltmp50:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x1
	flat_store_b8 v[0:1], v3 offset:24
	flat_store_b8 v[0:1], v5 offset:25
	s_lshr_b32 s5, s6, 8
	s_delay_alu instid0(SALU_CYCLE_1)
	v_dual_mov_b32 v5, s4 :: v_dual_mov_b32 v6, s5
	s_or_b32 s0, s0, exec_lo
	s_clause 0x5
	flat_store_d16_hi_b8 v[0:1], v3 offset:26
	flat_store_b8 v[0:1], v2 offset:27
	flat_store_b8 v[0:1], v4 offset:28
	flat_store_b8 v[0:1], v5 offset:31
	flat_store_d16_hi_b8 v[0:1], v4 offset:30
	flat_store_b8 v[0:1], v6 offset:29
.Ltmp51:
	.file	8 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl"
	.loc	8 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
.Ltmp52:
	.loc	8 28 0                          ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28:0
	s_barrier
.Ltmp53:
	.loc	8 5 0                           ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5:0
	s_waitcnt vmcnt(0) lgkmcnt(0)
	s_waitcnt_vscnt null, 0x0
	buffer_gl0_inv
.Ltmp54:
.LBB0_12:                               ; %Flow7
	.loc	8 0 0 is_stmt 0                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:0:0
	s_or_b32 exec_lo, exec_lo, s1
	.loc	3 112 0 is_stmt 1               ; /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112:0
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB0_14
.Ltmp55:
; %bb.13:                               ; %L133.i.critedge
	.loc	4 180 0                         ; pointer.jl:180:0
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, __unnamed_1@rel32@lo+4
	s_addc_u32 s5, s5, __unnamed_1@rel32@hi+12
.Ltmp56:
	.loc	4 316 0                         ; pointer.jl:316:0
	v_dual_mov_b32 v0, s2 :: v_dual_mov_b32 v1, s3
.Ltmp57:
	.loc	4 180 0                         ; pointer.jl:180:0
	v_dual_mov_b32 v2, s5 :: v_dual_mov_b32 v3, s4
	s_lshr_b32 s0, s5, 24
	s_lshr_b32 s5, s5, 8
	s_lshr_b32 s6, s4, 24
	s_lshr_b32 s4, s4, 8
	s_delay_alu instid0(SALU_CYCLE_1)
	v_dual_mov_b32 v4, s0 :: v_dual_mov_b32 v5, s4
	v_dual_mov_b32 v6, s5 :: v_dual_mov_b32 v7, s6
	s_clause 0x5
	flat_store_b8 v[0:1], v3 offset:32
	flat_store_d16_hi_b8 v[0:1], v3 offset:34
	flat_store_b8 v[0:1], v2 offset:36
	flat_store_b8 v[0:1], v4 offset:39
	flat_store_d16_hi_b8 v[0:1], v2 offset:38
	flat_store_b8 v[0:1], v6 offset:37
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v3, 11
.Ltmp58:
	.loc	4 180 0 is_stmt 0               ; pointer.jl:180:0
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, __unnamed_2@rel32@lo+4
	s_addc_u32 s5, s5, __unnamed_2@rel32@hi+12
.Ltmp59:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x9
	flat_store_b8 v[0:1], v7 offset:35
	flat_store_b8 v[0:1], v5 offset:33
	flat_store_b8 v[0:1], v2 offset:55
	flat_store_b8 v[0:1], v2 offset:54
	flat_store_b8 v[0:1], v2 offset:53
	flat_store_b8 v[0:1], v2 offset:52
	flat_store_b8 v[0:1], v2 offset:51
	flat_store_b8 v[0:1], v2 offset:50
	flat_store_b8 v[0:1], v2 offset:49
	flat_store_b8 v[0:1], v3 offset:48
.Ltmp60:
	.loc	4 180 0                         ; pointer.jl:180:0
	v_dual_mov_b32 v3, s4 :: v_dual_mov_b32 v4, s5
	s_lshr_b32 s0, s4, 8
	s_lshr_b32 s6, s5, 24
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_dual_mov_b32 v5, s0 :: v_dual_mov_b32 v6, s6
	s_lshr_b32 s0, s5, 8
	s_lshr_b32 s4, s4, 24
	v_dual_mov_b32 v7, s0 :: v_dual_mov_b32 v8, s4
	s_clause 0x7
	flat_store_b8 v[0:1], v3 offset:40
	flat_store_d16_hi_b8 v[0:1], v3 offset:42
	flat_store_b8 v[0:1], v4 offset:44
	flat_store_b8 v[0:1], v6 offset:47
	flat_store_d16_hi_b8 v[0:1], v4 offset:46
	flat_store_b8 v[0:1], v7 offset:45
	flat_store_b8 v[0:1], v8 offset:43
	flat_store_b8 v[0:1], v5 offset:41
	v_mov_b32_e32 v3, 26
.Ltmp61:
	.loc	4 180 0                         ; pointer.jl:180:0
	s_clause 0x7
	flat_store_b8 v[0:1], v2 offset:63
	flat_store_b8 v[0:1], v2 offset:62
	flat_store_b8 v[0:1], v2 offset:61
	flat_store_b8 v[0:1], v2 offset:60
	flat_store_b8 v[0:1], v2 offset:59
	flat_store_b8 v[0:1], v2 offset:58
	flat_store_b8 v[0:1], v2 offset:57
	flat_store_b8 v[0:1], v3 offset:56
.Ltmp62:
.LBB0_14:                               ; %L287.i
	.loc	4 0 0                           ; pointer.jl:0:0
	s_or_b32 exec_lo, exec_lo, s1
.Ltmp63:
	.loc	4 180 0                         ; pointer.jl:180:0
	v_dual_mov_b32 v0, s2 :: v_dual_mov_b32 v3, 1
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s3
	s_clause 0x3
	flat_store_b8 v[0:1], v2 offset:3
	flat_store_b8 v[0:1], v2 offset:2
	flat_store_b8 v[0:1], v2 offset:1
	flat_store_b8 v[0:1], v3
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
.Ltmp64:
	.file	9 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl"
	.loc	9 6 0 is_stmt 1                 ; /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6:0
	s_endpgm
.Ltmp65:
	.section	.rodata,#alloc
	.p2align	6, 0x0
	.amdhsa_kernel _Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 64
		.amdhsa_user_sgpr_count 13
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 1
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 2
		.amdhsa_next_free_vgpr 10
		.amdhsa_next_free_sgpr 16
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
	.file	10 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl"
	.file	11 "." "abstractarray.jl"
	.file	12 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl"
	.file	13 "." "none"
	.file	14 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl"
	.file	15 "." "namedtuple.jl"
	.file	16 "." "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl"
                                        ; -- End function
	.section	.AMDGPU.csdata
; Kernel info:
; codeLenInByte = 1732
; NumSgprs: 18
; NumVgprs: 10
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 2
; VGPRBlocks: 1
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 10
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 13
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 1
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 2
	.text
	.p2alignl 7, 3214868480
	.fill 96, 4, 3214868480
	.type	__unnamed_1,@object             ; @0
	.section	.rodata.str1.1,"aMS",@progbits,1
__unnamed_1:
	.asciz	"BoundsError"
	.size	__unnamed_1, 12

	.type	__unnamed_2,@object             ; @1
__unnamed_2:
	.asciz	"Out-of-bounds array access"
	.size	__unnamed_2, 27

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
	.byte	6                               ; Abbreviation Code
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
	.byte	7                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	16                              ; DW_FORM_ref_addr
	.byte	85                              ; DW_AT_ranges
	.byte	23                              ; DW_FORM_sec_offset
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	8                               ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	0                               ; DW_CHILDREN_no
	.byte	49                              ; DW_AT_abstract_origin
	.byte	16                              ; DW_FORM_ref_addr
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
	.byte	10                              ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	16                              ; DW_FORM_ref_addr
	.byte	85                              ; DW_AT_ranges
	.byte	23                              ; DW_FORM_sec_offset
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	5                               ; DW_FORM_data2
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	11                              ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	0                               ; DW_CHILDREN_no
	.byte	49                              ; DW_AT_abstract_origin
	.byte	16                              ; DW_FORM_ref_addr
	.byte	85                              ; DW_AT_ranges
	.byte	23                              ; DW_FORM_sec_offset
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	5                               ; DW_FORM_data2
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	12                              ; Abbreviation Code
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
	.byte	5                               ; DW_FORM_data2
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	13                              ; Abbreviation Code
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
	.section	.debug_info
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 ; Length of Unit
.Ldebug_info_start0:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0x59f DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string0                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string1                  ; DW_AT_comp_dir
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string5                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x30:0x6 DW_TAG_subprogram
	.long	.Linfo_string6                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x36:0x6 DW_TAG_subprogram
	.long	.Linfo_string7                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	3                               ; Abbrev [3] 0x3c:0x56d DW_TAG_subprogram
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       ; DW_AT_high_pc
	.long	.Linfo_string29                 ; DW_AT_name
	.byte	4                               ; Abbrev [4] 0x4d:0x55b DW_TAG_inlined_subroutine
	.long	54                              ; DW_AT_abstract_origin
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Ltmp65-.Lfunc_begin0           ; DW_AT_high_pc
	.byte	1                               ; DW_AT_call_file
	.byte	4                               ; DW_AT_call_line
	.byte	4                               ; Abbrev [4] 0x60:0x547 DW_TAG_inlined_subroutine
	.long	48                              ; DW_AT_abstract_origin
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Ltmp65-.Lfunc_begin0           ; DW_AT_high_pc
	.byte	10                              ; DW_AT_call_file
	.byte	85                              ; DW_AT_call_line
	.byte	5                               ; Abbrev [5] 0x73:0x533 DW_TAG_inlined_subroutine
	.long	42                              ; DW_AT_abstract_origin
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Ltmp65-.Lfunc_begin0           ; DW_AT_high_pc
	.byte	11                              ; DW_AT_call_file
	.short	699                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x87:0x51e DW_TAG_inlined_subroutine
	.long	.debug_info+1504                ; DW_AT_abstract_origin
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Ltmp65-.Lfunc_begin0           ; DW_AT_high_pc
	.byte	12                              ; DW_AT_call_file
	.byte	36                              ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x9a:0x50a DW_TAG_inlined_subroutine
	.long	.debug_info+1498                ; DW_AT_abstract_origin
	.quad	.Lfunc_begin0                   ; DW_AT_low_pc
	.long	.Ltmp65-.Lfunc_begin0           ; DW_AT_high_pc
	.byte	12                              ; DW_AT_call_file
	.byte	35                              ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0xad:0x23 DW_TAG_inlined_subroutine
	.long	.debug_info+1492                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges0                 ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	133                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0xb8:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1486                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges1                 ; DW_AT_ranges
	.byte	13                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0xc3:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1480                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges2                 ; DW_AT_ranges
	.byte	13                              ; DW_AT_call_file
	.byte	0                               ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0xd0:0x3f0 DW_TAG_inlined_subroutine
	.long	.debug_info+1522                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges3                 ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	134                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0xdb:0x23 DW_TAG_inlined_subroutine
	.long	.debug_info+1516                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges4                 ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	112                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0xe6:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1510                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges5                 ; DW_AT_ranges
	.byte	14                              ; DW_AT_call_file
	.byte	37                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0xf1:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1480                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges6                 ; DW_AT_ranges
	.byte	14                              ; DW_AT_call_file
	.byte	37                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0xfe:0x51 DW_TAG_inlined_subroutine
	.long	.debug_info+1534                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges7                 ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	118                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x109:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1528                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges8                 ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	27                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x114:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1528                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges9                 ; DW_AT_ranges
	.byte	4                               ; DW_AT_call_file
	.byte	153                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x120:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1528                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges10                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	32                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x12b:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1528                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges11                ; DW_AT_ranges
	.byte	4                               ; DW_AT_call_file
	.byte	153                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x137:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1528                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges12                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	35                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x142:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1528                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges13                ; DW_AT_ranges
	.byte	4                               ; DW_AT_call_file
	.byte	153                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0x14f:0x13 DW_TAG_inlined_subroutine
	.long	.debug_info+1540                ; DW_AT_abstract_origin
	.quad	.Ltmp8                          ; DW_AT_low_pc
	.long	.Ltmp9-.Ltmp8                   ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.byte	118                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x162:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1534                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges14                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	112                             ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x16d:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1546                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges15                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	29                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x179:0x4a DW_TAG_inlined_subroutine
	.long	.debug_info+1564                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges16                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	118                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x184:0x3e DW_TAG_inlined_subroutine
	.long	.debug_info+1558                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges17                ; DW_AT_ranges
	.byte	15                              ; DW_AT_call_file
	.byte	244                             ; DW_AT_call_line
	.byte	10                              ; Abbrev [10] 0x18f:0x32 DW_TAG_inlined_subroutine
	.long	.debug_info+1552                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges18                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.short	547                             ; DW_AT_call_line
	.byte	11                              ; Abbrev [11] 0x19b:0xc DW_TAG_inlined_subroutine
	.long	.debug_info+1540                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges19                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.short	551                             ; DW_AT_call_line
	.byte	10                              ; Abbrev [10] 0x1a7:0x19 DW_TAG_inlined_subroutine
	.long	.debug_info+1552                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges20                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.short	557                             ; DW_AT_call_line
	.byte	11                              ; Abbrev [11] 0x1b3:0xc DW_TAG_inlined_subroutine
	.long	.debug_info+1540                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges21                ; DW_AT_ranges
	.byte	6                               ; DW_AT_call_file
	.short	551                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x1c3:0xc0 DW_TAG_inlined_subroutine
	.long	.debug_info+1582                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges22                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	118                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x1ce:0x3c DW_TAG_inlined_subroutine
	.long	.debug_info+1576                ; DW_AT_abstract_origin
	.quad	.Ltmp13                         ; DW_AT_low_pc
	.long	.Ltmp14-.Ltmp13                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	122                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x1e1:0x28 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp13                         ; DW_AT_low_pc
	.long	.Ltmp14-.Ltmp13                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	87                              ; DW_AT_call_line
	.byte	12                              ; Abbrev [12] 0x1f4:0x14 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp13                         ; DW_AT_low_pc
	.long	.Ltmp14-.Ltmp13                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x20a:0x3c DW_TAG_inlined_subroutine
	.long	.debug_info+1588                ; DW_AT_abstract_origin
	.quad	.Ltmp18                         ; DW_AT_low_pc
	.long	.Ltmp19-.Ltmp18                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	122                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x21d:0x28 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp18                         ; DW_AT_low_pc
	.long	.Ltmp19-.Ltmp18                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	87                              ; DW_AT_call_line
	.byte	12                              ; Abbrev [12] 0x230:0x14 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp18                         ; DW_AT_low_pc
	.long	.Ltmp19-.Ltmp18                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x246:0x3c DW_TAG_inlined_subroutine
	.long	.debug_info+1594                ; DW_AT_abstract_origin
	.quad	.Ltmp19                         ; DW_AT_low_pc
	.long	.Ltmp20-.Ltmp19                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	122                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x259:0x28 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp19                         ; DW_AT_low_pc
	.long	.Ltmp20-.Ltmp19                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	87                              ; DW_AT_call_line
	.byte	12                              ; Abbrev [12] 0x26c:0x14 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp19                         ; DW_AT_low_pc
	.long	.Ltmp20-.Ltmp19                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x283:0xc0 DW_TAG_inlined_subroutine
	.long	.debug_info+1606                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges23                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	118                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x28e:0x3c DW_TAG_inlined_subroutine
	.long	.debug_info+1600                ; DW_AT_abstract_origin
	.quad	.Ltmp24                         ; DW_AT_low_pc
	.long	.Ltmp25-.Ltmp24                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	130                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x2a1:0x28 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp24                         ; DW_AT_low_pc
	.long	.Ltmp25-.Ltmp24                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	93                              ; DW_AT_call_line
	.byte	12                              ; Abbrev [12] 0x2b4:0x14 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp24                         ; DW_AT_low_pc
	.long	.Ltmp25-.Ltmp24                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x2ca:0x3c DW_TAG_inlined_subroutine
	.long	.debug_info+1612                ; DW_AT_abstract_origin
	.quad	.Ltmp29                         ; DW_AT_low_pc
	.long	.Ltmp30-.Ltmp29                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	130                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x2dd:0x28 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp29                         ; DW_AT_low_pc
	.long	.Ltmp30-.Ltmp29                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	93                              ; DW_AT_call_line
	.byte	12                              ; Abbrev [12] 0x2f0:0x14 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp29                         ; DW_AT_low_pc
	.long	.Ltmp30-.Ltmp29                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x306:0x3c DW_TAG_inlined_subroutine
	.long	.debug_info+1618                ; DW_AT_abstract_origin
	.quad	.Ltmp30                         ; DW_AT_low_pc
	.long	.Ltmp31-.Ltmp30                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	130                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x319:0x28 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp30                         ; DW_AT_low_pc
	.long	.Ltmp31-.Ltmp30                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	93                              ; DW_AT_call_line
	.byte	12                              ; Abbrev [12] 0x32c:0x14 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp30                         ; DW_AT_low_pc
	.long	.Ltmp31-.Ltmp30                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x343:0x78 DW_TAG_inlined_subroutine
	.long	.debug_info+1606                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges24                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x34e:0x24 DW_TAG_inlined_subroutine
	.long	.debug_info+1600                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges25                ; DW_AT_ranges
	.byte	16                              ; DW_AT_call_file
	.byte	130                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x359:0x18 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges26                ; DW_AT_ranges
	.byte	16                              ; DW_AT_call_file
	.byte	93                              ; DW_AT_call_line
	.byte	11                              ; Abbrev [11] 0x364:0xc DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges27                ; DW_AT_ranges
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x372:0x24 DW_TAG_inlined_subroutine
	.long	.debug_info+1612                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges28                ; DW_AT_ranges
	.byte	16                              ; DW_AT_call_file
	.byte	130                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x37d:0x18 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges29                ; DW_AT_ranges
	.byte	16                              ; DW_AT_call_file
	.byte	93                              ; DW_AT_call_line
	.byte	11                              ; Abbrev [11] 0x388:0xc DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges30                ; DW_AT_ranges
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x396:0x24 DW_TAG_inlined_subroutine
	.long	.debug_info+1618                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges31                ; DW_AT_ranges
	.byte	16                              ; DW_AT_call_file
	.byte	130                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x3a1:0x18 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges32                ; DW_AT_ranges
	.byte	16                              ; DW_AT_call_file
	.byte	93                              ; DW_AT_call_line
	.byte	11                              ; Abbrev [11] 0x3ac:0xc DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges33                ; DW_AT_ranges
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x3bb:0x84 DW_TAG_inlined_subroutine
	.long	.debug_info+1582                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges34                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	114                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x3c6:0x3c DW_TAG_inlined_subroutine
	.long	.debug_info+1576                ; DW_AT_abstract_origin
	.quad	.Ltmp36                         ; DW_AT_low_pc
	.long	.Ltmp37-.Ltmp36                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	122                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x3d9:0x28 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp36                         ; DW_AT_low_pc
	.long	.Ltmp37-.Ltmp36                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	87                              ; DW_AT_call_line
	.byte	12                              ; Abbrev [12] 0x3ec:0x14 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp36                         ; DW_AT_low_pc
	.long	.Ltmp37-.Ltmp36                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x402:0x3c DW_TAG_inlined_subroutine
	.long	.debug_info+1588                ; DW_AT_abstract_origin
	.quad	.Ltmp38                         ; DW_AT_low_pc
	.long	.Ltmp39-.Ltmp38                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	122                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x415:0x28 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp38                         ; DW_AT_low_pc
	.long	.Ltmp39-.Ltmp38                 ; DW_AT_high_pc
	.byte	16                              ; DW_AT_call_file
	.byte	87                              ; DW_AT_call_line
	.byte	12                              ; Abbrev [12] 0x428:0x14 DW_TAG_inlined_subroutine
	.long	.debug_info+1570                ; DW_AT_abstract_origin
	.quad	.Ltmp38                         ; DW_AT_low_pc
	.long	.Ltmp39-.Ltmp38                 ; DW_AT_high_pc
	.byte	7                               ; DW_AT_call_file
	.short	1013                            ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x43f:0x23 DW_TAG_inlined_subroutine
	.long	.debug_info+1630                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges35                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	114                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x44a:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges36                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	72                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x455:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges37                ; DW_AT_ranges
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x462:0x23 DW_TAG_inlined_subroutine
	.long	.debug_info+1630                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges38                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	115                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x46d:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges39                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	75                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x478:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges40                ; DW_AT_ranges
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x485:0x3a DW_TAG_inlined_subroutine
	.long	.debug_info+1642                ; DW_AT_abstract_origin
	.quad	.Ltmp51                         ; DW_AT_low_pc
	.long	.Ltmp54-.Ltmp51                 ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.byte	116                             ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x498:0x13 DW_TAG_inlined_subroutine
	.long	.debug_info+1636                ; DW_AT_abstract_origin
	.quad	.Ltmp51                         ; DW_AT_low_pc
	.long	.Ltmp52-.Ltmp51                 ; DW_AT_high_pc
	.byte	8                               ; DW_AT_call_file
	.byte	27                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x4ab:0x13 DW_TAG_inlined_subroutine
	.long	.debug_info+1636                ; DW_AT_abstract_origin
	.quad	.Ltmp53                         ; DW_AT_low_pc
	.long	.Ltmp54-.Ltmp53                 ; DW_AT_high_pc
	.byte	8                               ; DW_AT_call_file
	.byte	29                              ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x4c0:0x23 DW_TAG_inlined_subroutine
	.long	.debug_info+1630                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges41                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	136                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x4cb:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges42                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	80                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x4d6:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges43                ; DW_AT_ranges
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0x4e3:0x23 DW_TAG_inlined_subroutine
	.long	.debug_info+1630                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges44                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	140                             ; DW_AT_call_line
	.byte	7                               ; Abbrev [7] 0x4ee:0x17 DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges45                ; DW_AT_ranges
	.byte	3                               ; DW_AT_call_file
	.byte	86                              ; DW_AT_call_line
	.byte	8                               ; Abbrev [8] 0x4f9:0xb DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.long	.Ldebug_ranges46                ; DW_AT_ranges
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x506:0x3b DW_TAG_inlined_subroutine
	.long	.debug_info+1630                ; DW_AT_abstract_origin
	.quad	.Ltmp61                         ; DW_AT_low_pc
	.long	.Ltmp62-.Ltmp61                 ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.byte	141                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x519:0x27 DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.quad	.Ltmp61                         ; DW_AT_low_pc
	.long	.Ltmp62-.Ltmp61                 ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.byte	99                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x52c:0x13 DW_TAG_inlined_subroutine
	.long	.debug_info+1624                ; DW_AT_abstract_origin
	.quad	.Ltmp61                         ; DW_AT_low_pc
	.long	.Ltmp62-.Ltmp61                 ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	6                               ; Abbrev [6] 0x541:0x62 DW_TAG_inlined_subroutine
	.long	.debug_info+1691                ; DW_AT_abstract_origin
	.quad	.Ltmp63                         ; DW_AT_low_pc
	.long	.Ltmp65-.Ltmp63                 ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.byte	144                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x554:0x3b DW_TAG_inlined_subroutine
	.long	.debug_info+1685                ; DW_AT_abstract_origin
	.quad	.Ltmp63                         ; DW_AT_low_pc
	.long	.Ltmp64-.Ltmp63                 ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	114                             ; DW_AT_call_line
	.byte	6                               ; Abbrev [6] 0x567:0x27 DW_TAG_inlined_subroutine
	.long	.debug_info+1679                ; DW_AT_abstract_origin
	.quad	.Ltmp63                         ; DW_AT_low_pc
	.long	.Ltmp64-.Ltmp63                 ; DW_AT_high_pc
	.byte	3                               ; DW_AT_call_file
	.byte	67                              ; DW_AT_call_line
	.byte	9                               ; Abbrev [9] 0x57a:0x13 DW_TAG_inlined_subroutine
	.long	.debug_info+1679                ; DW_AT_abstract_origin
	.quad	.Ltmp63                         ; DW_AT_low_pc
	.long	.Ltmp64-.Ltmp63                 ; DW_AT_high_pc
	.byte	4                               ; DW_AT_call_file
	.byte	180                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0x58f:0x13 DW_TAG_inlined_subroutine
	.long	.debug_info+1697                ; DW_AT_abstract_origin
	.quad	.Ltmp64                         ; DW_AT_low_pc
	.long	.Ltmp65-.Ltmp64                 ; DW_AT_high_pc
	.byte	14                              ; DW_AT_call_file
	.byte	127                             ; DW_AT_call_line
	.byte	0                               ; End Of Children Mark
	.byte	0                               ; End Of Children Mark
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
	.byte	13                              ; Abbrev [13] 0xb:0xbc DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string0                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string1                  ; DW_AT_comp_dir
	.byte	2                               ; Abbrev [2] 0x1e:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x24:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string3                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x30:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x36:0x6 DW_TAG_subprogram
	.long	.Linfo_string4                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x3c:0x6 DW_TAG_subprogram
	.long	.Linfo_string2                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x42:0x6 DW_TAG_subprogram
	.long	.Linfo_string8                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x48:0x6 DW_TAG_subprogram
	.long	.Linfo_string9                  ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x4e:0x6 DW_TAG_subprogram
	.long	.Linfo_string10                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x54:0x6 DW_TAG_subprogram
	.long	.Linfo_string11                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x5a:0x6 DW_TAG_subprogram
	.long	.Linfo_string12                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x60:0x6 DW_TAG_subprogram
	.long	.Linfo_string13                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x66:0x6 DW_TAG_subprogram
	.long	.Linfo_string14                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x6c:0x6 DW_TAG_subprogram
	.long	.Linfo_string12                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x72:0x6 DW_TAG_subprogram
	.long	.Linfo_string12                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x78:0x6 DW_TAG_subprogram
	.long	.Linfo_string13                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x7e:0x6 DW_TAG_subprogram
	.long	.Linfo_string15                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x84:0x6 DW_TAG_subprogram
	.long	.Linfo_string16                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x8a:0x6 DW_TAG_subprogram
	.long	.Linfo_string17                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x90:0x6 DW_TAG_subprogram
	.long	.Linfo_string18                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x96:0x6 DW_TAG_subprogram
	.long	.Linfo_string19                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x9c:0x6 DW_TAG_subprogram
	.long	.Linfo_string20                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xa2:0x6 DW_TAG_subprogram
	.long	.Linfo_string21                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xa8:0x6 DW_TAG_subprogram
	.long	.Linfo_string22                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xae:0x6 DW_TAG_subprogram
	.long	.Linfo_string23                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xb4:0x6 DW_TAG_subprogram
	.long	.Linfo_string24                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xba:0x6 DW_TAG_subprogram
	.long	.Linfo_string25                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0xc0:0x6 DW_TAG_subprogram
	.long	.Linfo_string26                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end1:
.Lcu_begin2:
	.long	.Ldebug_info_end2-.Ldebug_info_start2 ; Length of Unit
.Ldebug_info_start2:
	.short	4                               ; DWARF version number
	.long	.debug_abbrev                   ; Offset Into Abbrev. Section
	.byte	8                               ; Address Size (in bytes)
	.byte	13                              ; Abbrev [13] 0xb:0x2c DW_TAG_compile_unit
	.long	.Linfo_string0                  ; DW_AT_producer
	.short	31                              ; DW_AT_language
	.long	.Linfo_string0                  ; DW_AT_name
	.long	.Lline_table_start0             ; DW_AT_stmt_list
	.long	.Linfo_string1                  ; DW_AT_comp_dir
	.byte	2                               ; Abbrev [2] 0x1e:0x6 DW_TAG_subprogram
	.long	.Linfo_string23                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x24:0x6 DW_TAG_subprogram
	.long	.Linfo_string24                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string27                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	2                               ; Abbrev [2] 0x30:0x6 DW_TAG_subprogram
	.long	.Linfo_string28                 ; DW_AT_name
	.byte	1                               ; DW_AT_inline
	.byte	0                               ; End Of Children Mark
.Ldebug_info_end2:
	.section	.debug_ranges
.Ldebug_ranges0:
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges1:
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges2:
	.quad	.Lfunc_begin0-.Lfunc_begin0
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges3:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp2-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges4:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges5:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges6:
	.quad	.Ltmp0-.Lfunc_begin0
	.quad	.Ltmp1-.Lfunc_begin0
	.quad	.Ltmp3-.Lfunc_begin0
	.quad	.Ltmp4-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges7:
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp6-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	.Ltmp8-.Lfunc_begin0
	.quad	.Ltmp12-.Lfunc_begin0
	.quad	.Ltmp13-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp18-.Lfunc_begin0
	.quad	.Ltmp20-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges8:
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp6-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	.Ltmp8-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges9:
	.quad	.Ltmp5-.Lfunc_begin0
	.quad	.Ltmp6-.Lfunc_begin0
	.quad	.Ltmp7-.Lfunc_begin0
	.quad	.Ltmp8-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges10:
	.quad	.Ltmp12-.Lfunc_begin0
	.quad	.Ltmp13-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp18-.Lfunc_begin0
	.quad	.Ltmp20-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges11:
	.quad	.Ltmp12-.Lfunc_begin0
	.quad	.Ltmp13-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp18-.Lfunc_begin0
	.quad	.Ltmp20-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges12:
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges13:
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges14:
	.quad	.Ltmp10-.Lfunc_begin0
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp16-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp23-.Lfunc_begin0
	.quad	.Ltmp24-.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges15:
	.quad	.Ltmp10-.Lfunc_begin0
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp16-.Lfunc_begin0
	.quad	.Ltmp17-.Lfunc_begin0
	.quad	.Ltmp23-.Lfunc_begin0
	.quad	.Ltmp24-.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges16:
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp12-.Lfunc_begin0
	.quad	.Ltmp14-.Lfunc_begin0
	.quad	.Ltmp16-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges17:
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp12-.Lfunc_begin0
	.quad	.Ltmp14-.Lfunc_begin0
	.quad	.Ltmp16-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges18:
	.quad	.Ltmp11-.Lfunc_begin0
	.quad	.Ltmp12-.Lfunc_begin0
	.quad	.Ltmp14-.Lfunc_begin0
	.quad	.Ltmp16-.Lfunc_begin0
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp28-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges19:
	.quad	.Ltmp14-.Lfunc_begin0
	.quad	.Ltmp15-.Lfunc_begin0
	.quad	.Ltmp26-.Lfunc_begin0
	.quad	.Ltmp27-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges20:
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges21:
	.quad	.Ltmp21-.Lfunc_begin0
	.quad	.Ltmp22-.Lfunc_begin0
	.quad	.Ltmp32-.Lfunc_begin0
	.quad	.Ltmp33-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges22:
	.quad	.Ltmp13-.Lfunc_begin0
	.quad	.Ltmp14-.Lfunc_begin0
	.quad	.Ltmp18-.Lfunc_begin0
	.quad	.Ltmp20-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges23:
	.quad	.Ltmp24-.Lfunc_begin0
	.quad	.Ltmp25-.Lfunc_begin0
	.quad	.Ltmp29-.Lfunc_begin0
	.quad	.Ltmp31-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges24:
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges25:
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges26:
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges27:
	.quad	.Ltmp34-.Lfunc_begin0
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges28:
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges29:
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges30:
	.quad	.Ltmp35-.Lfunc_begin0
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges31:
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges32:
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges33:
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges34:
	.quad	.Ltmp36-.Lfunc_begin0
	.quad	.Ltmp37-.Lfunc_begin0
	.quad	.Ltmp38-.Lfunc_begin0
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges35:
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges36:
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges37:
	.quad	.Ltmp39-.Lfunc_begin0
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp42-.Lfunc_begin0
	.quad	.Ltmp45-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges38:
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges39:
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges40:
	.quad	.Ltmp40-.Lfunc_begin0
	.quad	.Ltmp41-.Lfunc_begin0
	.quad	.Ltmp43-.Lfunc_begin0
	.quad	.Ltmp44-.Lfunc_begin0
	.quad	.Ltmp46-.Lfunc_begin0
	.quad	.Ltmp47-.Lfunc_begin0
	.quad	.Ltmp48-.Lfunc_begin0
	.quad	.Ltmp49-.Lfunc_begin0
	.quad	.Ltmp50-.Lfunc_begin0
	.quad	.Ltmp51-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges41:
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges42:
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges43:
	.quad	.Ltmp55-.Lfunc_begin0
	.quad	.Ltmp56-.Lfunc_begin0
	.quad	.Ltmp57-.Lfunc_begin0
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges44:
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges45:
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
	.quad	0
	.quad	0
.Ldebug_ranges46:
	.quad	.Ltmp58-.Lfunc_begin0
	.quad	.Ltmp59-.Lfunc_begin0
	.quad	.Ltmp60-.Lfunc_begin0
	.quad	.Ltmp61-.Lfunc_begin0
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
	.asciz	"_throw_boundserror"            ; string offset=39
.Linfo_string5:
	.asciz	"#throw_boundserror;"           ; string offset=58
.Linfo_string6:
	.asciz	"checkbounds;"                  ; string offset=78
.Linfo_string7:
	.asciz	"#setindex!;"                   ; string offset=91
.Linfo_string8:
	.asciz	"llvm_atomic_cas;"              ; string offset=103
.Linfo_string9:
	.asciz	"lock_output!;"                 ; string offset=120
.Linfo_string10:
	.asciz	"unsafe_load;"                  ; string offset=134
.Linfo_string11:
	.asciz	"getproperty;"                  ; string offset=147
.Linfo_string12:
	.asciz	"==;"                           ; string offset=160
.Linfo_string13:
	.asciz	"+;"                            ; string offset=164
.Linfo_string14:
	.asciz	"_eq;"                          ; string offset=167
.Linfo_string15:
	.asciz	"workitemIdx_x;"                ; string offset=172
.Linfo_string16:
	.asciz	"workitemIdx;"                  ; string offset=187
.Linfo_string17:
	.asciz	"workitemIdx_z;"                ; string offset=200
.Linfo_string18:
	.asciz	"workitemIdx_y;"                ; string offset=215
.Linfo_string19:
	.asciz	"workgroupIdx_x;"               ; string offset=230
.Linfo_string20:
	.asciz	"workgroupIdx;"                 ; string offset=246
.Linfo_string21:
	.asciz	"workgroupIdx_y;"               ; string offset=260
.Linfo_string22:
	.asciz	"workgroupIdx_z;"               ; string offset=276
.Linfo_string23:
	.asciz	"unsafe_store!;"                ; string offset=292
.Linfo_string24:
	.asciz	"setproperty!;"                 ; string offset=307
.Linfo_string25:
	.asciz	"fence;"                        ; string offset=321
.Linfo_string26:
	.asciz	"sync_workgroup;"               ; string offset=328
.Linfo_string27:
	.asciz	"signal_exception"              ; string offset=344
.Linfo_string28:
	.asciz	"endpgm;"                       ; string offset=361
.Linfo_string29:
	.asciz	"ker!"                          ; string offset=369
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
	.ident	"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"
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
        .size:           40
        .value_kind:     by_value
      - .offset:         40
        .size:           24
        .value_kind:     by_value
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 64
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 1024
    .name:           _Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE.kd
    .vgpr_count:     10
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
