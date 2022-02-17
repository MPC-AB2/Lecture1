I = im2gray(imread("Lenna_(original_image).png"));
I2 = im2gray(imread("Lenna_(noisy_image).png"));

peaksnr = psnr(I,I2)
%% Gausian FILTER
I_gaus2 = imgaussfilt(I2,2);
I_gaus = imgaussfilt(I2,2);
imshow(I_gaus2);
imshow(I_gaus);
peaksnr = psnr(I,I_gaus2)
%% 