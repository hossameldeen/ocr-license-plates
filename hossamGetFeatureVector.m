function[featureVector] = hossamGetFeatureVector(img)
goalDimR = 84;
goalDimC = 84;
blockDim = 7;
blockCount = goalDimR / blockDim; % count is actually this ^ 2
img = hossamCrop(img, goalDimR, goalDimC); % Now, it's scaled to 405, 405 & Cropped.
for i = 1:blockCount
  for j = 1:blockCount
    currentBlock = img(((i - 1) * blockDim + 1):(i * blockDim),
                       ((j - 1) * blockDim + 1):(j * blockDim));
    [currentCentX, currentCentY] = hossamCentroid(currentBlock);
    featureVector(((i - 1) * blockDim + j - 1) * 2 + 1) = currentCentX;
    featureVector(((i - 1) * blockDim + j - 1) * 2 + 1 + 1) = currentCentY;
  end
end
end