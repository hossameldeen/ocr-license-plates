% negatedImage :: The character is white, background is black. Of course, bw already.
function[featureVector] = ass3getFeatureVector(negatedImage)
  
  % Add border for the case of image character touching the border.
  r = size(negatedImage, 1);  c = size(negatedImage, 2);   % Note: I'm using r down with another meaning. That's okay.
  negatedImage = [zeros(1, c); negatedImage; zeros(1, c)];
  r = size(negatedImage, 1);  c = size(negatedImage, 2);
  negatedImage = [zeros(r, 1) negatedImage zeros(r, 1)];
  % End of border adding
  
  [centX, centY] = ass3calcCentroid(negatedImage);
  [R] = ass3calcRadius(negatedImage, centX, centY);
  nTracks = 4;
  nSectors = 4;
  N_DIRECTIONS = 8;
  
  cntArray = cell([nTracks, nSectors, N_DIRECTIONS]);
  for i = 1:nTracks
    for j = 1:nSectors
      for k = 1:N_DIRECTIONS
        cntArray{i, j, k} = 0;
      end
    end
  end
  
  [nRows, nCols] = size(negatedImage);
  startX = 1; startY = 1;
  somethingFound = 0;
  for i = 1:nRows
    if (somethingFound)
      break;
    end
    for j = 1:nCols
      if (negatedImage(i, j) == 1)
        startX = i; startY = j;
        somethingFound = 1;
        break
      end
    end
  end
  
  di = [ 0; -1; -1; -1; 0; 1; 1;  1];
  dj = [-1; -1;  0;  1; 1; 1; 0; -1];
  
  curX = startX; curY = startY;
  curDir = -5;  % To initialize correctly
  %startX
  %startY
  nBoundary = 0;
  
  %============================================================================
  % Since everyone is using wbtraceboundary, but I don't have access to it. For
  % now, I'll just be okay with the cases of entering infinite loops, and will
  % give it special handling.
  %============================================================================
  
  countPoints = 0;
  
  do
    nBoundary = nBoundary + 1;
    startDir = -1000;
    for dir = 0:7
      tempX = curX + di(mod(dir + curDir + 4 + 1, 8) + 1);
      tempY = curY + dj(mod(dir + curDir + 4 + 1, 8) + 1);
      if (negatedImage(tempX, tempY) == 0)
        startDir = mod(dir + curDir + 4 + 1, 8);
        break;
      end
    end
    
    curDir = -1000;
    for dir = 0:7
      tempX = curX + di(mod(startDir + dir, 8) + 1);
      tempY = curY + dj(mod(startDir + dir, 8) + 1);
      if (negatedImage(tempX, tempY) == 1)
        curX = tempX;
        curY = tempY;
        curDir = mod(startDir + dir, 8) + 1;
        break;
      end
    end
    %curX
    %curY
    %negatedImage((-2+curX):(2+curX), (-2+curY):(2+curY))
    
    r = hypot(curX - centX, curY - centY);
    curTrack = min(floor((r / R) * nTracks) + 1, nTracks);
    theta = atan2(curX - centX, curY - centY) * 180 / pi;
    if (theta < 0) theta = theta + 360; end
    curSector = min(floor(theta / 360 * nSectors) + 1, nSectors);
    
    cntArray{curTrack, curSector, curDir} = cntArray{curTrack, curSector, curDir} + 1;
    ++countPoints;
  until ([curX, curY] == [startX, startY] || countPoints > size(negatedImage, 1) * size(negatedImage, 2))
  
  featureVector = zeros(nTracks * nSectors * N_DIRECTIONS, 1);
  for i = 1:nTracks
    for j = 1:nSectors
      for k = 1:N_DIRECTIONS
        featureVector(((i - 1) * nSectors + j - 1) * N_DIRECTIONS + k) = cntArray{i, j, k} / nBoundary;
      end
    end
  end
end