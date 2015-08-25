%{
  - A function for extracting the biggest dimensions in our data.
  - If it happens that something exceeds these dimensions, we'll just crop it.
  
  - From running & check return value = [61 28]. We decide to make the maximum dimensions [84 84]
%}

function [retVal] = getBiggestDimensions (imagesOfCharacters)
  allChars = ['0':'9' 'A':'Z'];
  maxR = 0; maxC = 0;
  for i = 1:length(allChars)
    images = imagesOfCharacters{allChars(i)};
    for j = 1:length(images)
      img = images{j};
      maxR = max(maxR, size(img, 1)); maxC = max(maxC, size(img, 2));
    endfor
  endfor
  retVal = [maxR maxC];
endfunction
