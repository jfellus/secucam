/*
 * main.cpp
 *
 *  Created on: 13 avr. 2015
 *      Author: jfellus
 */

#include "v4l2/V4LIn.h"
#include "jpg.h"
#include <stdio.h>
#include <math.h>
#include <string.h>

#define THRESHOLD 50

bool detect(unsigned char* last, unsigned char* in, int w, int h) {
	float dif = 0;
	for(int i=0; i<w*h*3; i++) {
		dif += fabs((float)in[i]);
	}
	dif /= (w*h*3);
	printf("%f %s\n", dif, dif>THRESHOLD ? "YEEESS!!!" : "-");
	return dif>THRESHOLD;
}

int main(int argc, char **argv) {
	V4LIn in("/dev/video0");
	in.start();
	system("rm -rf .v; mkdir -p .v");
	char outf[1024];
	unsigned char* last_frame = new unsigned char[in.w*in.h*3];
	for(size_t i=0;;i++) {
		in.readFrame();
		sprintf(outf, ".v/%09lu.jpg", i);
		if(detect(last_frame, in.data, in.w, in.h)) save_jpg(in.data, in.w, in.h, outf);
		//memcpy(last_frame, in.data, in.w*in.h*3);
	}
}
