//
//# Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
//# SPDX-License-Identifier: X11
//
//
//  This block implements ShiftRows() Transformation.
//  This block operates on 4x4 (byte) square block data, and each input 32-bit
//  vectors represents a column of data.
//                       |  | |  | |  | |  |  31  -  S00
//                       |S0| |S1| |S2| |S3|
//                       |  | |  | |  | |  |
//                       |  | |  | |  | |  |   0  -  S30

`timescale 1ns/1ps

module AesShiftRows (
        S0_in,
        S1_in,
        S2_in,
        S3_in,
        
        S0_out,
        S1_out,
        S2_out,
        S3_out
  );
  
  input  [31:0] S0_in;
  input  [31:0] S1_in;
  input  [31:0] S2_in;
  input  [31:0] S3_in;
  
  output [31:0] S0_out;
  output [31:0] S1_out;
  output [31:0] S2_out;
  output [31:0] S3_out;
  
  wire   [31:0] S0_out;
  wire   [31:0] S1_out;
  wire   [31:0] S2_out;
  wire   [31:0] S3_out;
  
  assign S0_out [31:24] = S0_in [31:24];
  assign S1_out [31:24] = S1_in [31:24];
  assign S2_out [31:24] = S2_in [31:24];
  assign S3_out [31:24] = S3_in [31:24];
  
  assign S0_out [23:16] = S1_in [23:16];
  assign S1_out [23:16] = S2_in [23:16];
  assign S2_out [23:16] = S3_in [23:16];
  assign S3_out [23:16] = S0_in [23:16];

  assign S0_out [15: 8] = S2_in [15: 8];
  assign S1_out [15: 8] = S3_in [15: 8];
  assign S2_out [15: 8] = S0_in [15: 8];
  assign S3_out [15: 8] = S1_in [15: 8];

  assign S0_out [ 7: 0] = S3_in [ 7: 0];
  assign S1_out [ 7: 0] = S0_in [ 7: 0];
  assign S2_out [ 7: 0] = S1_in [ 7: 0];
  assign S3_out [ 7: 0] = S2_in [ 7: 0];
  
endmodule