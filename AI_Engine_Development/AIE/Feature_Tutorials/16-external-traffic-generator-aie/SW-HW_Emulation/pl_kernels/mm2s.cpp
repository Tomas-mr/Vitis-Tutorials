/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: X11
*/


#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

#ifndef DATA_WIDTH
#error "You should define DATA_WIDTH in compiler arguments v++ ... -DDATA_WIDTH=32 ... for example"
#endif

#if DATA_WIDTH != 32 && DATA_WIDTH != 64 && DATA_WIDTH != 128
#error "DATA_WIDTH should be equal to 32, 64 or 128"
#endif

extern "C" {

void mm2s(ap_int<DATA_WIDTH>* mem, hls::stream<ap_axis<DATA_WIDTH, 0, 0, 0>  >& s, int size) {
#pragma HLS INTERFACE m_axi port=mem offset=slave bundle=gmem

#pragma HLS interface axis port=s

#pragma HLS INTERFACE s_axilite port=mem bundle=control
#pragma HLS INTERFACE s_axilite port=size bundle=control
#pragma HLS interface s_axilite port=return bundle=control

	for(int i = 0; i < size; i++) {
#pragma HLS PIPELINE II=1
		ap_axis<DATA_WIDTH, 0, 0, 0> x;
		x.data = mem[i];
		s.write(x);
	}

}

}