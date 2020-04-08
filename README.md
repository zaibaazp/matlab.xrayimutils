# xrayimutils: Utilities for handling Xray images

## Quick start
Load the image into matlab with `imread`:

```Matlab
Im = imread('/path/to/your/image.tiff'); %
```

then run the program with the following command:
```Matlab
[rotIm, thetaIm] = detectAngleNRotate(Im);
```
visualise the output with `plotSpotsImage` or `imagesc`:
```Matlab
figure(1)
plotSpotsImage(rotIm);
``` 
