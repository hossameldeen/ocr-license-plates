%{
  - Converts the problem into an OCR problem by extracting the characters
    from the images & returning them with their correct values.
  - Skips the "." and ".." files.
  - Assumes imagesFolder doesn't have a '.' in its name.
  - returns x, where:
    x{c} is a cell array that has some images of the character c.
  - Also, saves the return value in savingPath
%}

function [imagesOfCharacters] = toOCR (imagesFolder, savingPath)
  if (imagesFolder(end) != '\') imagesFolder = strcat(imagesFolder, '\'); endif
  imagesPaths = readdir(imagesFolder);
  
  allChars = ['0':'9' 'A':'Z'];
  imagesOfCharacters = cell(0);
  for i = 1:length(allChars)
    imagesOfCharacters{allChars(i)} = cell(0);
  endfor

  for i = 1:length(imagesPaths)
    if (strcmp(imagesPaths{i}, '.') == 1 || strcmp(imagesPaths{i}, '..') == 1)  continue  endif
    extractedChars = extractTheElements(im2bw(imresize(imread(strcat(imagesFolder, imagesPaths{i})), [100 200])), 0.36, 0.01, 0.85, 0.33);
    % I've made a test to make sure the # of extractedChars == length of file name in all training data
    for j = 1:length(extractedChars)
      imagesOfCharacters{imagesPaths{i}(j)}{end + 1} = extractedChars{j};
    endfor
  endfor
  
  save(savingPath, '', 'imagesOfCharacters');

endfunction
