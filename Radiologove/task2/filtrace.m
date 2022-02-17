
%% nacitani obrazku
imagefiles = dir('C:\Users\xkanto13\Desktop\ABO2\Lecture1\images_noise\*.jpg');
%addpath("images_noise\");
path = 'C:\Users\xkanto13\Desktop\ABO2\path_save2\'
j=1;

for j=1:length(imagefiles)
    filename=imagefiles(j).name;
    A=imread(filename);
   % A = imread('image4_02.jpg');
    for i =1:3
        An=A(:,:,i);
        AInv = imcomplement(An);
        BInv = imreducehaze(AInv);
        B = imcomplement(BInv);
        %B(B<10) = 10;
        An=(B+An)/2;
        %An = medfilt2(An,[2,2]);
        A(:,:,i)=An;
    end
    imwrite(A,[path filename])
end

%imshow(A)


%% 


A = imread('image1_03.jpg');
for i =1:3
    An=A(:,:,i);
    AInv = imcomplement(An);
    BInv = imreducehaze(AInv);
    B = imcomplement(BInv);
    B(B<10) = 10;
    An=(B+An)/2;
    A(:,:,i)=An;
end
imshow(A)

%%
res = noise_eval('C:\Users\xkanto13\Desktop\ABO2\path_save\', true);
