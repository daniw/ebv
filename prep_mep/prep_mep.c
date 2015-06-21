void CalcDeriv()
{
    int c, r;
    for(r = nc; r < nr*nc-nc; r+= nc) {/* we skip the first and last line */
        for(c = 1; c < nc-1; c++) {
            /* do pointer arithmetics with respect to center pixel location */
            unsigned char* p = &data.u8TempImage[SENSORIMG][r+c];
            /* implement Sobel filter in x-direction */
            int dx =    -(int) *(p-nc-1) + (int) *(p-nc+1)
                     -2* (int) *(p-1) + 2* (int) *(p+1)
                        -(int) *(p+nc-1) + (int) *(p+nc+1);

            /* implement Sobel filter in y-direction */
            int dy =    -(int) *(p-nc-1) -2* (int) *(p-nc) - (int) *(p-nc+1)
                        +(int) *(p+nc-1) +2* (int) *(p+nc) + (int) *(p+nc+1);

            avgDxy[0][r+c] = dx*dx;
            avgDxy[1][r+c] = dy*dy;
            avgDxy[2][r+c] = dx*dy;

            //data.u8TempImage[THRESHOLD][r+c] = MAX(0, MIN(255, (dx*dx >> 10)));
        }
    }
}


#ifdef GAUSS

void AvgDeriv(int Index)
{
    //do average in x-direction
    int c, r;
    for(r = nc; r < nr*nc-nc; r+= nc) {/* we skip first and last lines (empty) */
        for(c = Border+1; c < nc-(Border+1); c++) {/* +1 because we have one empty border column */
            /* do pointer arithmetics with respect to center pixel location */
            int* p = &avgDxy[Index][r+c];
            int sx = (*(p-6) + *(p+6))  + ((*(p-5) + *(p+5)) << 2)  + (*(p-4) + *(p+4))*11 +
                     (*(p-3) + *(p+3))*27 + (*(p-2) + *(p+2))*50 + (*(p-1) + *(p+1))*72 + (*p)*82;
            //now averaged
            helpBuf[r+c] = (sx >> 8);
        }
    }
    //do average in y-direction
    for(r = nc*(Border+1); r < nr*nc-nc*(Border+1); r+= nc) {/* we skip the border lines */
        for(c = Border+1; c < nc-(Border+1); c++) {
            /* do pointer arithmetics with respect to center pixel location */
            int* p = &helpBuf[r+c];
            int sy = (*(p-6*nc) + *(p+6*nc))  + ((*(p-5*nc) + *(p+5*nc)) << 2)  + (*(p-4*nc) + *(p+4*nc))*11 +
                     (*(p-3*nc) + *(p+3*nc))*27 + (*(p-2*nc) + *(p+2*nc))*50 + (*(p-1*nc) + *(p+1*nc))*72 + (*p)*82;
            //now averaged; scale not of interest; avoid integer division just do shift
            //dx has maximum of (4 x 255); thus dx^2 < (4 x 255)^2; with average x (412/256)^2 at most 2^22
            avgDxy[Index][r+c] = sy >> 8;

            //data.u8TempImage[BACKGROUND][r+c] = MAX(0, MIN(255, (avgDxy[Index][r+c] >> 11)));
        }
    }
}

#else

void AvgDeriv(int Index)
{
    //do average in x-direction
    int c, r;
    for(r = nc; r < nr*nc-nc; r+= nc) {/* we skip first and last lines (empty) */
        for(c = Border+1; c < nc-(Border+1); c++) {/* +1 because we have one empty border column */
            /* do pointer arithmetics with respect to center pixel location */
            int* p = &avgDxy[Index][r+c];
            int sx = (*(p-6) + *(p+6))       + ((*(p-5) + *(p+5)) << 2) + ((*(p-4) + *(p+4)) << 3) +
                    ((*(p-3) + *(p+3)) << 5) + ((*(p-2) + *(p+2)) << 6) + ((*(p-1) + *(p+1)) << 6) + ((*p << 6) + (*p << 5));
            //now averaged
            helpBuf[r+c] = (sx >> 8);
        }
    }
    //do average in y-direction
    for(r = nc*(Border+1); r < nr*nc-nc*(Border+1); r+= nc) {/* we skip the border lines */
        for(c = Border+1; c < nc-(Border+1); c++) {
            /* do pointer arithmetics with respect to center pixel location */
            int* p = &helpBuf[r+c];
            int sy = (*(p-6*nc) + *(p+6*nc))       + ((*(p-5*nc) + *(p+5*nc)) << 2) + ((*(p-4*nc) + *(p+4*nc)) << 3) +
                    ((*(p-3*nc) + *(p+3*nc)) << 5) + ((*(p-2*nc) + *(p+2*nc)) << 6) + ((*(p-1*nc) + *(p+1*nc)) << 6) + ((*p << 6) + (*p << 5));
            //now averaged; scale not of interest; avoid integer division just do shift
            //dx has maximum of (4 x 255); thus dx^2 < (4 x 255)^2; with average x (474/256)^2 at most 2^22
            avgDxy[Index][r+c] = (sy >> 8);

            //data.u8TempImage[BACKGROUND][r+c] = MAX(0, MIN(255, (avgDxy[Index][r+c] >> 11)));
        }
    }
}

#endif

void Dilatation()
{
    int c, r;
    for(r = nc; r < nr*nc-nc; r+= nc) {/* we skip the first and last line */
        for(c = 1; c < nc-1; c++) {
            /* do pointer arithmetics with respect to center pixel location */
            unsigned char* p = &data.u8TempImage[SENSORIMG][r+c];
            /* implement Dilatation */
            int dx = (p-nc-1) || (p-nc) || (p-nc+1)
                  || (p-1)    ||        ||   (p+1)
                  || (p+nc-1) || (p+nc) || (p+nc+1);

            avgDxy[0][r+c] = dx;

            //data.u8TempImage[THRESHOLD][r+c] = MAX(0, MIN(255, (dx >> 10)));
        }
    }
}

void Erosion()
{
    int c, r;
    for(r = nc; r < nr*nc-nc; r+= nc) {/* we skip the first and last line */
        for(c = 1; c < nc-1; c++) {
            /* do pointer arithmetics with respect to center pixel location */
            unsigned char* p = &data.u8TempImage[SENSORIMG][r+c];
            /* implement Erosion */
            int dx = (p-nc-1) && (p-nc) && (p-nc+1)
                  && (p-1)    &&        &&   (p+1)
                  && (p+nc-1) && (p+nc) && (p+nc+1);

            avgDxy[0][r+c] = dx;

            //data.u8TempImage[THRESHOLD][r+c] = MAX(0, MIN(255, (dx >> 10)));
        }
    }
}
