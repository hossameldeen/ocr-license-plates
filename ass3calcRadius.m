% Already contouredImage
function[R] = ass3calcRadius(contouredImage, centX, centY)
  R = 1.0;
  for i = 1:size(contouredImage, 1)
    for j = 1:size(contouredImage, 2)
      if (contouredImage(i, j) == 1)
        R = max(R, hypot(i - centX, j - centY));
      end
    end
  end
end