%% LAB1: OBJECTS COUNTING ON IMAGES by Hiba khayati

%% Cleaning the window
clc;
clear all;
close all;

%% 1. Reading the image
image=imread('D:\BLOODCELLS.jpg');

%% 2. Transforming the image into a binary image
BW = im2bw(image);

%% 3. Showing the two images 
subplot(1,2,1), imshow(image),title('BLOODCELLS IMAGE'); 
subplot(1,2,2), imshow(BW), title('BLOODCELLS BINARY IMAGE'), figure; 

%% 4. Image observation and solution
% The morphological operator works on the white pixels in the binary
% image. The value of each pixel in the output image is based on a 
% comparison of the corresponding pixel in the input image with its neighbors.
% We observe that the number of white pixels is too much more than the number of 
% the dark ones. To resolve this problem we should use binary image (black and 
% white) so we can use Morphological Dilation and Erosion to precise exactly our
% need. Should we remove or add pixels to the image.

%% Erosion

%% 5. Imerode function
% imerode - Erode image
% This MATLAB function erodes the grayscale, binary, or packed binary image IM,
% returning the eroded image IM2.

    % IM2 = imerode(IM,SE)
    % IM2 = imerode(IM,NHOOD)
    % IM2 = imerode(___,PACKOPT,M)
    % IM2 = imerode(___,SHAPE)
    % gpuarrayIM2 = imerode(gpuarrayIM,___)

%% 6. The structuring element SE
% For the structuring element we chose a disk because the shape of our
% BLOODCELLs is a disk so we wanted to see the result of erosion on the
% same shape.
se1 = strel('disk',3);

%% 7. Eroded image BW        
erodedBW1 = imerode(BW,se1);
imshow(erodedBW1), title('Eroded image'), figure ; 

%% 8. Different sizes of the SE
se2 = strel('disk',6);        
erodedBW2 = imerode(BW,se2);
se3 = strel('disk',10);        
erodedBW3 = imerode(BW,se3);
se4 = strel('disk',14);        
erodedBW4 = imerode(BW,se4);

%% 9. Visualization of results
subplot(1,4,1), imshow(erodedBW1),title('SE=3'); 
subplot(1,4,2), imshow(erodedBW2) , title('SE=6') ; 
subplot(1,4,3), imshow(erodedBW3),title('SE=10'); 
subplot(1,4,4), imshow(erodedBW4), title('SE=14'), figure ;

%% 10. Discussion
% Erosion removes pixels on object boundaries.
% So the number of pixels removed from the objects in an image 
% depends on the size and shape of the structuring element used to process the image.
% The more we increase the SE, the more the number of pixels removed increases
% and we observe that our dark disk expands in the image progressively.

%% Dilation

%% 1. Imdilate function
% imdilate - Dilate image
% This MATLAB function dilates the grayscale, binary, or packed binary image IM,
% returning the dilated image, IM2.

    % IM2 = imdilate(IM,SE)
    % IM2 = imdilate(IM,NHOOD)
    % IM2 = imdilate(___,PACKOPT)
    % IM2 = imdilate(___,SHAPE)
    % gpuarrayIM2 = imdilate(gpuarrayIM,___)

%% 2. The structuring element SE
% We will create a vertical line shaped structuring element.
se = strel('line',8,90);

%% 3. Application of the dilation operator
DilatedBW = imdilate(BW,se);

%% 4. Repeat the operation with different sizes of the SE
se1 = strel('line',12,90);
DilatedBW1 = imdilate(BW,se1);
se2 = strel('line',14,90);
DilatedBW2 = imdilate(BW,se2);
se3 = strel('line',18,90);
DilatedBW3 = imdilate(BW,se3);

%% 5. Different sizes of the SE
subplot(1,4,1), imshow(DilatedBW),title('1'); 
subplot(1,4,2), imshow(DilatedBW1) , title('2') ; 
subplot(1,4,3), imshow(DilatedBW2),title('3'); 
subplot(1,4,4), imshow(DilatedBW3), title('4'), figure ; 

%% 6. Discussion
% Dilation adds pixels to the boundaries of objects in an image
% So the number of pixels added from the objects in an image 
% depends on the size and shape of the structuring element used to process the image.
% The more we increase the SE, the more the number of pixels added increases
% and we observe that our vertical line widens gradually in the image.

%% Improvments

%% 7. Solution to propose
% In fact, if we use the erosion or dilation separated each time, we
% don't get the best result. Because on each time when we apply either
% dilation or erosion we only extract or add pixels so we don't obtain a
% precise result. That's why we suggest to use Dilation and erosion in 
% combination to implement image processing operations. We can use either
% errosion followed by a dilation to define a morphological opening of an
% image, or the reverse to define a morphological closing of an image.

%% 8. Our solution
SE = strel('disk',12);
BW2 = imerode(BW,SE);  % Erode the image with the structuring element.
BW3 = imdilate(BW2,SE);% To restore the rectangles to their original sizes,
                       % dilate the eroded image using the same structuring element, SE.
imshow(BW3), title('image tested'), figure; 

%%Labellization and counting

%% 9. Bwlabel function
% bwlabel - Label connected components in 2-D binary image
% This MATLAB function returns the label matrix L that contains labels for the
% 8-connected objects found in BW.

    % L = bwlabel(BW)
    % L = bwlabel(BW,n)
    % [L,num] = bwlabel(___)
    % [gpuarrayL,num] = bwlabel(gpuarrayBW,n)
    
%% 10. Applying BWlabel function on our result
L = bwlabel(BW, 8);
[r, c] = find(L==2);
rc = [r c]

%% 11. Number of cells obtained
29;

%% 12. Show the labelled cells using different colors
% I didn't understand the question

%% 13. Regionprops function
% regionprops - Measure properties of image regions

% This MATLAB function returns measurements for the set of properties specified by
% properties for each connected component (object) in the binary image, BW.

    % stats = regionprops(BW,properties)
    % stats = regionprops(CC,properties)
    % stats = regionprops(L,properties)
    % stats = regionprops(___,I,properties)
    % stats = regionprops(output,___)
    % stats = regionprops(gpuarrayImg,___)

%% 14. Calculating centroids for connected components in the image using regionprops.
c = [43 185 212];
r = [38 68 181];
BW2 = bwselect(BW,c,r,4);

%% 15. Show the result
% I didn't understand the question so i plot the result
imshow(BW2); 


