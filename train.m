%{
  - A generic train function.
  - It'll produce feature vectors. Of course, it's not very generic. It'll probably
    work only with classifiers like minimum distance.
  - Will both save the feature vectors & return them.
%}

function [fvsOfCharacters] = train (trainingImagesFolder, savingPath, featureVectorFunction)
  imagesOfCharacters = toOCR(trainingImagesFolder, 'imagesOfCharacters');
  fvsOfCharacters = cell(0);
  allChars = ['0':'9' 'A':'Z'];
  for i = 1:length(allChars)
    for j = 1:length(imagesOfCharacters{allChars(i)})
      fvsOfCharacters{allChars(i)}{j} = featureVectorFunction(imagesOfCharacters{allChars(i)}{j});
    endfor
  endfor
  save(savingPath, '', 'fvsOfCharacters');
endfunction
