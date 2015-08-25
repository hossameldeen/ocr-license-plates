% Image: Black & white, cropped, .. etc.
function [centX, centY] = hossamCentroid(someImage)
sumX = 0; sumY = 0;
[nRows, nCols] = size(someImage);
for (i = 1:nRows)
    for (j = 1:nCols)
        sumX = sumX + i * someImage(i, j);
        sumY = sumY + j * someImage(i, j);
    end
end
if (sum(sum(someImage)) == 0)
  centX = ceil(nRows / 2);
  centY = ceil(nCols / 2);
else
  centX = sumX / sum(sum(someImage));
  centY = sumY / sum(sum(someImage));
end
end

