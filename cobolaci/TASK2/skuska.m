 
original_Image = imread('image1_07.jpg');
velkost = 512;
% I = original_Image(1:velkost,1:velkost,:);
%     
% % noisy_Image = imnoise(original_Image,'gaussian',0,0.03);
% net = denoisingNetwork('DnCNN');
% I1 = denoiseImage(I(:,:,1), net);
% I2 = denoiseImage(I(:,:,2), net);
% I3 = denoiseImage(I(:,:,3), net);
% % montage({original_Image, denoised_Image})
% % figure;title('First one is original image, second one is noisy image and the third one is denoised image')
% 
% 
% % montage({original_Image(1:velkost,1:velkost,:), denoised_Image(1:velkost,1:velkost,:)})


original_Image = imread('image1_07.jpg');
velkost = 512;
I_filt = uint8(zeros(([256 339 3])));
I_rec = uint8(zeros(([3072 4608 3])));
net = denoisingNetwork('DnCNN');
patches1 = [1:256:3073];
patches2 = [1:339:4609];

for i = 1:12
    for k = 1:12
    tic
    I = original_Image(patches1(i):patches1(i+1)-1,patches2(k):patches2(k+1)-1,:);
    I1 = denoiseImage(I(:,:,1), net);
    I2 = denoiseImage(I(:,:,2), net);
    I3 = denoiseImage(I(:,:,3), net);
    I_filt(:,:,1) = I1;
    I_filt(:,:,2) = I2;
    I_filt(:,:,3) = I3;
    I_rec(patches1(i):patches1(i+1)-1,patches2(i):patches2(i+1)-1,1:3) = I_filt;
    krok = i+k
    toc
    end
end

