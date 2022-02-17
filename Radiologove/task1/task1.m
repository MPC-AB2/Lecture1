
I = im2gray(imread("Lenna_(original_image).png"));
I2 = im2gray(imread("Lenna_(noisy_image).png"));
[SSIM,PSNR,NIQE,PIQE]=quality(I2,I)
%% Gausian FILTER
I_gaus2 = imgaussfilt(I2,2);
I_gaus = imgaussfilt(I2,0.5);
imshow(I_gaus2);
%imshow(I_gaus);
[SSIM,PSNR,NIQE,PIQE]=quality(I,I_gaus2)
%GAUSIAN_PSNR = psnr(I_gaus2,I)
%% WIENNER - vyber oblast
%---------------vyrez
%a = imcrop(I2);
a= load("a.mat");
a=a.a;
d= size(a) ;
scale= d(1)*d(2);
A = fft2(a, 512,512)./(scale);
%B = imresize(A,[512 512], "cubic");
A=A.^2;
A=A./(scale);
% ----cely Obr
Sg = fft2(I2)./(512*512);
Sgg =real(Sg.^2);
Sgg= Sgg./(512*512)
WKF = real((Sgg-A)./Sgg);
WKF(WKF>1)=1;
WKF(WKF<0)=0;
F= WKF.*double(Sg);
f = real(ifft2(F));
imshow(f,[])
[SSIM,PSNR,NIQE,PIQE]=quality(I,I_gaus2)

%% AdaWiener
m=7;

Wiener = wiener2(I2,[m,m]);
[SSIM,PSNR,NIQE,PIQE]=quality(Wiener,I)

figure
subplot(1,2,1)
imshow(I2);
title('Original')
subplot(1,2,2)
imshow(Wiener);
title('adaWiener')

%% Bilateral filter
degree = 0.01*diff(getrangefromclass(I2)).^2;
patch = imcrop(I2,[170, 35, 50 50]);
patchVar = std2(patch)^2;
DoS = 2*patchVar;
Bilat = imbilatfilt(I2,DoS,1.5);
figure
subplot(1,2,1)
imshow(I2);
title('Original')
subplot(1,2,2)
imshow(Bilat);
title('Bilateral filter')
%% total variance
im = TVL1denoise(y,1.3,200);
imshow(im)
[SSIM,PSNR,NIQE,PIQE]=quality(I2,I_gaus2)
%% non-linear anisotropic diffusion filter
anisto_diff = imdiffusefilt(I2,'GradientThreshold',800);

%% non-local means
n_local_mean = imnlmfilt(I2,'DegreeOfSmoothing',39);


%%
figure()
subplot 331
imshow(I)
title("Original")

subplot 332
imshow(I2)
title("Noisy")

subplot 333
imshow(I_gaus2)
title("Gausian")

subplot 334
imshow(f,[])
title("Wienner")

subplot 335
imshow(Wiener)
title("ADA - Wienner")

subplot 336
imshow(Bilat);
title("BILAT")

subplot 337
imshow(im)
title("Total var.")

subplot 338
imshow(anisto_diff)
title("non-linear anisotropic diffusion filter")


subplot 339
imshow(n_local_mean)
title("NON local mean")
