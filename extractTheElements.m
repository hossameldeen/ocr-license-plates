%{

Parameters:
  img :: The plate image.
  0 <= minRPerc, minCPerc <= 1 :: each returned element must be at least these
                                  percentages of img's dimensions
  0 <= maxRPerc, maxCPerc <= 1 :: each returned element must be at most these
                                  percentages of img's dimensions

Preconditions:
  img is black and white.
  Can deal with black background or white background.
  Assumes the background has more pixels than the foreground.

Return value:
  Returns a vector x, where x[i] is a matrix representing the digit/character.
  x[i] will have white foreground and black background, regardless of the original image state.

%}

function [retVal] = extractTheElements (img, minRPerc, minCPerc, maxRPerc, maxCPerc)

  r = size(img, 1);
  c = size(img, 2);

  % Counting the number of pixels to see if I'll invert.
  whiteCnt = 0;
  for i = 1:r
    for j = 1:c
      whiteCnt = whiteCnt + img(i, j);
    endfor
  endfor
  if (whiteCnt > r * c - whiteCnt)
    img = 1 - img;
  endif
  % End of background detection and (possible) inversion.
  
  % Doing the component extraction
  
  di = [0 0 1 -1 1 1 -1 -1];
  dj = [1 -1 0 0 1 -1 1 -1];
  
  vis = zeros(r, c);
  components = cell(0);
  for j = 1:c
    for i = 1:r
      
      if (vis(i, j) == 1 || img(i, j) == 0) continue  endif
      minR = i; maxR = i; minC = j; maxC = j;
      Q = [i j];
      vis(i, j) = 1;
      while(size(Q, 1) != 0)
        
        curR = Q(end, 1); curC = Q(end, 2);
        Q = Q(1:(end - 1), :);
        
        minR = min(minR, curR); maxR = max(maxR, curR);
        minC = min(minC, curC); maxC = max(maxC, curC);
        
        for k = 1:8
          tmpR = curR + di(k);  tmpC = curC + dj(k);
          if (tmpR < 1 || tmpC < 1 || tmpR > r || tmpC > c || vis(tmpR, tmpC) || img(tmpR, tmpC) == 0) continue  endif
          vis(tmpR, tmpC) = 1;
          Q = [Q; tmpR tmpC];
        endfor
        
      endwhile
      
      if (maxR - minR >= minRPerc * r && maxR - minR <= maxRPerc * r &&
          maxC - minC >= minCPerc * c && maxC - minC <= maxCPerc * c)
        components{end + 1} = img(minR:maxR, minC:maxC);
      endif
      
    endfor
  endfor
  % End of component extraction
  
  retVal = components;
  
endfunction
















