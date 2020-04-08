# xrayimutils: Utilities for handling Xray images

## Quick start
Load the image into matlab with `imread`:

```matlab
Im = imread('/path/to/your/image.tiff'); %
```

then run the program with the following command:
```matlab
[rotIm, thetaIm] = detectAngleNRotate(Im);
```
