
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
%% RESENI cislo 2 - podobny vysledek
for i = 1:length(listing)
    Obr = im2double(imread(['Lecture1_second_data\images_noise\', listing(i).name]));
    
    R = Obr(:,:,1);
    G = Obr(:,:,2);
    B = Obr(:,:,3);

    R = imresize(R,0.25,'lanczos3','Antialiasing',true);
    G = imresize(G,0.25,'lanczos3','Antialiasing',true);
    B = imresize(B,0.25,'lanczos3','Antialiasing',true);

%     figure;imshow(R,[])
%     figure;imshow(G,[])
%     figure;imshow(B,[])
    
    diff_R = imdiffusefilt(R);
    diff_G = imdiffusefilt(G);
    diff_B = imdiffusefilt(B);
    
%     figure;imshow(diff_R,[])
%     figure;imshow(diff_G,[])
%     figure;imshow(diff_B,[])

    gauss_R = imgaussfilt(R,10,'FilterSize',25,'Padding','replicate','FilterDomain','frequency');
    gauss_G = imgaussfilt(G,10,'FilterSize',25,'Padding','replicate','FilterDomain','frequency');
    gauss_B = imgaussfilt(B,10,'FilterSize',25,'Padding','replicate','FilterDomain','frequency');
     
%     figure;imshow(gauss_R,[])
%     figure;imshow(gauss_G,[])
%     figure;imshow(gauss_B,[])
    
%     gauss_Obr = cat(3,gauss_R,gauss_G,gauss_B);

    n=10;
    med_R = medfilt2(R, [n n]);
    med_G = medfilt2(G, [n n]);
    med_B = medfilt2(B, [n n]);

%     figure;imshow(med_R,[])
%     figure;imshow(med_G,[])
%     figure;imshow(med_B,[])
    
    med_Obr = cat(3,med_R,med_G,med_B);
    
    m=5;
    wien_R = wiener2(R, [m m]);
    wien_G = wiener2(G, [m m]);
    wien_B = wiener2(B, [m m]);
    wien_Obr = cat(3,wien_R,wien_G,wien_B);

    R_f = imresize(imsharpen(((diff_R + gauss_R + med_R + wien_R)./4)), 4,'lanczos3','Antialiasing',true);
    G_f = imresize(imsharpen(((diff_G + gauss_G + med_G + wien_G)./4)), 4,'lanczos3','Antialiasing',true);
    B_f = imresize(imsharpen(((diff_B + gauss_B + med_B + wien_B)./4)), 4,'lanczos3','Antialiasing',true);

    Obr_f = cat(3,R_f,G_f,B_f);

    Obr_f = uint8(im2double(Obr_f).*255);
    
%     figure;
%     montage({Obr,Obr_f},'ThumbnailSize',[])
%     title('Original (left) vs. Restored (Right)')
    imwrite(Obr_f,['V:/MPC_AB2/1/task2/Lecture1_second_data/images_denoise/' listing(i).name])
end