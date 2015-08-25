% crops and scales image
% Sent image: the character is black, and background is white
% Returned Image: the character is white, and background is black.
% Character is 255 NOT 1, i.e., grayImage
function[croppedAndScaledImage] = hossamCrop(someImage, goalDimR, goalDimC)
    %Inverting the image
    [nRows, nCols] = size(someImage);
    someImage = 1 - someImage;
    mnX = 100000; mnY = 100000;
    mxX = 0; mxY = 0;
    for (i = 1:nRows)
        for (j = 1:nCols)
            if (someImage(i, j) == 1)
                mnX = min([i, mnX]);
                mnY = min([j, mnY]);
                mxX = max([i, mxX]);
                mxY = max([j, mxY]);
            end
        end
    end
    %subplot(2, 2, 1);
    %imshow(someImage);
    croppedImage = someImage(mnX:mxX, mnY:mxY);
    %subplot(2, 2, 2);
    %imshow(croppedImage);
    expandedImage = croppedImage;
    for (i = 1:nRows)
        for (j = (mxY + 1):goalDimC)
            expandedImage(i, j) = 0;
        end
    end
    for (i = (nRows + 1):goalDimR)
        for (j = 1:goalDimC)
            expandedImage(i, j) = 0;
        end
    end
    %subplot(2, 2, 3);
    croppedAndScaledImage = expandedImage;
    %imshow(croppedAndScaledImage);
end