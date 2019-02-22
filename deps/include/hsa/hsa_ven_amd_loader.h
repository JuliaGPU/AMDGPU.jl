////////////////////////////////////////////////////////////////////////////////
//
// The University of Illinois/NCSA
// Open Source License (NCSA)
//
// Copyright (c) 2014-2015, Advanced Micro Devices, Inc. All rights reserved.
//
// Developed by:
//
//                 AMD Research and AMD HSA Software Development
//
//                 Advanced Micro Devices, Inc.
//
//                 www.amd.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal with the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
//  - Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimers.
//  - Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimers in
//    the documentation and/or other materials provided with the distribution.
//  - Neither the names of Advanced Micro Devices, Inc,
//    nor the names of its contributors may be used to endorse or promote
//    products derived from this Software without specific prior written
//    permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS WITH THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////

// HSA AMD extension for additional loader functionality.

#ifndef HSA_VEN_AMD_LOADER_H
#define HSA_VEN_AMD_LOADER_H

#include "hsa.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/**
 * @brief Queries equivalent host address for given @p device_address, and
 * records it in @p host_address.
 *
 *
 * @details Contents of memory pointed to by @p host_address would be identical
 * to contents of memory pointed to by @p device_address. Only difference
 * between the two is host accessibility: @p host_address is always accessible
 * from host, @p device_address might not be accessible from host.
 *
 * If @p device_address already points to host accessible memory, then the value
 * of @p device_address is simply copied into @p host_address.
 *
 * The lifetime of @p host_address is the same as the lifetime of @p
 * device_address, and both lifetimes are limited by the lifetime of the
 * executable that is managing these addresses.
 *
 *
 * @param[in] device_address Device address to query equivalent host address
 * for.
 *
 * @param[out] host_address Pointer to application-allocated buffer to record
 * queried equivalent host address in.
 *
 *
 * @retval HSA_STATUS_SUCCESS Function is executed successfully.
 *
 * @retval HSA_STATUS_ERROR_NOT_INITIALIZED Runtime is not initialized.
 *
 * @retval HSA_STATUS_ERROR_INVALID_ARGUMENT @p device_address is invalid or
 * null, or @p host_address is null.
 */
hsa_status_t HSA_API hsa_ven_amd_loader_query_host_address(
  const void *device_address,
  const void **host_address);

/**
 * @brief The storage type of the code object that is backing loaded memory
 * segment.
 */
typedef enum {
  /**
   * Loaded memory segment is not backed by any code object (anonymous), as the
   * case would be with BSS (uninitialized data).
   */
  HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_NONE = 0,
  /**
   * Loaded memory segment is backed by the code object that is stored in the
   * file.
   */
  HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_FILE = 1,
  /**
   * Loaded memory segment is backed by the code object that is stored in the
   * memory.
   */
  HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_MEMORY = 2
} hsa_ven_amd_loader_code_object_storage_type_t;

/**
 * @brief Loaded memory segment descriptor.
 *
 *
 * @details Loaded memory segment descriptor describes underlying loaded memory
 * segment. Loaded memory segment is created/allocated by the executable during
 * the loading of the code object that is backing underlying memory segment.
 *
 * The lifetime of underlying memory segment is limited by the lifetime of the
 * executable that is managing underlying memory segment.
 */
typedef struct hsa_ven_amd_loader_segment_descriptor_s {
  /**
   * Agent underlying memory segment is allocated on. If the code object that is
   * backing underlying memory segment is program code object, then 0.
   */
  hsa_agent_t agent;
  /**
   * Executable that is managing this underlying memory segment.
   */
  hsa_executable_t executable;
  /**
   * Storage type of the code object that is backing underlying memory segment.
   */
  hsa_ven_amd_loader_code_object_storage_type_t code_object_storage_type;
  /**
   * If the storage type of the code object that is backing underlying memory
   * segment is:
   *   - HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_NONE, then null;
   *   - HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_FILE, then null-terminated
   *     filepath to the code object;
   *   - HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_MEMORY, then host
   *     accessible pointer to the first byte of the code object.
   */
  const void *code_object_storage_base;
  /**
   * If the storage type of the code object that is backing underlying memory
   * segment is:
   *   - HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_NONE, then 0;
   *   - HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_FILE, then the length of
   *     the filepath to the code object (including null-terminating character);
   *   - HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_MEMORY, then the size, in
   *     bytes, of the memory occupied by the code object.
   */
  size_t code_object_storage_size;
  /**
   * If the storage type of the code object that is backing underlying memory
   * segment is:
   *   - HSA_VEN_AMD_LOADER_CODE_OBJECT_STORAGE_TYPE_NONE, then 0;
   *   - other, then offset, in bytes, from the beginning of the code object to
   *     the first byte in the code object data is copied from.
   */
  size_t code_object_storage_offset;
  /**
   * Starting address of the underlying memory segment.
   */
  const void *segment_base;
  /**
   * Size, in bytes, of the underlying memory segment.
   */
  size_t segment_size;
} hsa_ven_amd_loader_segment_descriptor_t;

/**
 * @brief Either queries loaded memory segment descriptors, or total number of
 * loaded memory segment descriptors.
 *
 *
 * @details If @p segment_descriptors is not null and @p num_segment_descriptors
 * points to number that exactly matches total number of loaded memory segment
 * descriptors, then queries loaded memory segment descriptors, and records them
 * in @p segment_descriptors. If @p segment_descriptors is null and @p
 * num_segment_descriptors points to zero, then queries total number of loaded
 * memory segment descriptors, and records it in @p num_segment_descriptors. In
 * all other cases returns appropriate error code (see below).
 *
 * The caller of this function is responsible for the allocation/deallocation
 * and the lifetime of @p segment_descriptors and @p num_segment_descriptors.
 *
 * The lifetime of loaded memory segments that are described by queried loaded
 * memory segment descriptors is limited by the lifetime of the executable that
 * is managing loaded memory segments.
 *
 * Queried loaded memory segment descriptors are always self-consistent: they
 * describe a complete set of loaded memory segments that are being backed by
 * fully loaded code objects that are present at the time (i.e. this function
 * is blocked until all executable manipulations are fully complete).
 *
 *
 * @param[out] segment_descriptors Pointer to application-allocated buffer to
 * record queried loaded memory segment descriptors in. Can be null if @p
 * num_segment_descriptors points to zero.
 *
 * @param[in,out] num_segment_descriptors Pointer to application-allocated
 * buffer that contains either total number of loaded memory segment descriptors
 * or zero.
 *
 *
 * @retval HSA_STATUS_SUCCESS Function is executed successfully.
 *
 * @retval HSA_STATUS_ERROR_NOT_INITIALIZED Runtime is not initialized.
 *
 * @retval HSA_STATUS_ERROR_INVALID_ARGUMENT @p segment_descriptors is null
 * while @p num_segment_descriptors points to non-zero number, @p
 * segment_descriptors is not null while @p num_segment_descriptors points to
 * zero, or @p num_segment_descriptors is null.
 *
 * @retval HSA_STATUS_ERROR_INCOMPATIBLE_ARGUMENTS @p num_segment_descriptors
 * does not point to number that exactly matches total number of loaded memory
 * segment descriptors.
 */
hsa_status_t HSA_API hsa_ven_amd_loader_query_segment_descriptors(
  hsa_ven_amd_loader_segment_descriptor_t *segment_descriptors,
  size_t *num_segment_descriptors);

/**
 * @brief Obtains the handle of executable to which the device address belongs.
 *
 * @details This method should not be used to obtain executable handle by using
 * a host address. The executable returned is expected to be alive until its
 * destroyed by the user.
 *
 * @retval HSA_STATUS_SUCCESS Function is executed successfully.
 *
 * @retval HSA_STATUS_ERROR_NOT_INITIALIZED Runtime is not initialized.
 *
 * @retval HSA_STATUS_ERROR_INVALID_ARGUMENT The input is invalid or there
 * is no exectuable found for this kernel code object.
 */
hsa_status_t hsa_ven_amd_loader_query_executable(
  const void *device_address,
  hsa_executable_t *executable);

/**
 * @brief Extension version.
 */
#define hsa_ven_amd_loader 001000

/**
 * @brief Extension function table.
 */
typedef struct hsa_ven_amd_loader_1_00_pfn_s {
  hsa_status_t (*hsa_ven_amd_loader_query_host_address)(
    const void *device_address,
    const void **host_address);

  hsa_status_t (*hsa_ven_amd_loader_query_segment_descriptors)(
    hsa_ven_amd_loader_segment_descriptor_t *segment_descriptors,
    size_t *num_segment_descriptors);

  hsa_status_t (*hsa_ven_amd_loader_query_executable)(
    const void *device_address,
    hsa_executable_t *executable);
} hsa_ven_amd_loader_1_00_pfn_t;

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* HSA_VEN_AMD_LOADER_H */
