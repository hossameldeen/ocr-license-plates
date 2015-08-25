%{
  - Error is calculated as follows:
    - If the classifier doesn't get the no. of characters in the image correct,
      it'll be counted as No. of characters in image.
    - If it gets it right, it'll be counted as No. of mistaken characters.
  - The error will be the percentage of correct character gotten / th Error
  - accuracy is just a fancy way for showing the same thing :D
%}

function [myError, accuracy] = calcError (trainFunction,
                               trainingImagesFolder,
                               fvsPath,
                               featureVectorFunction,
                               testImagesFolder
                               )
  
  fvs = trainFunction(trainingImagesFolder, fvsPath, featureVectorFunction);
  totalCharacters = 0;
  wrongCharacters = 0;
  
  
  if (testImagesFolder(end) != '\') testImagesFolder = strcat(testImagesFolder, '\'); endif
  imagesPaths = readdir(testImagesFolder);
  
  for i = 1:length(imagesPaths)
    imgCorrectCharacters = imagesPaths{i}(1:(strfind(imagesPaths{i}, '.')-1))
    fflush(stdout);
    if (strcmp(imagesPaths{i}, '.') == 1 || strcmp(imagesPaths{i}, '..') == 1)  continue  endif
    testImgPath = strcat(testImagesFolder, imagesPaths{i});
    totalCharacters = totalCharacters + length(testImgPath);
    bestChars = test(testImgPath, fvsPath, featureVectorFunction);
    if (length(bestChars) != length(imgCorrectCharacters))
      wrongCharacters = wrongCharacters + 1;
    else
      for j = 1:length(bestChars)
        if (bestChars(j) != imgCorrectCharacters(j))
          wrongCharacters = wrongCharacters + 1;
        endif
      endfor
    endif
  endfor
  
  myError = wrongCharacters / totalCharacters;
  accuracy = (1 - myError) * 100.0;
  
endfunction
