% Image already negated.
function [centX, centY] = ass3calcCentroid(negatedImage)
  sumX = 0; sumY = 0;
  [nRows, nCols] = size(negatedImage);
  for (i = 1:nRows)
      for (j = 1:nCols)
          sumX = sumX + i * negatedImage(i, j);
          sumY = sumY + j * negatedImage(i, j);
      end
  end
  if (sum(sum(negatedImage)) == 0)
    centX = ceil(nRows / 2);
    centY = ceil(nCols / 2);
  else
    centX = sumX / sum(sum(negatedImage));
    centY = sumY / sum(sum(negatedImage));
  end
end

