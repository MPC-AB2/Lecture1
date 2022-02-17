clear all
original = 'Lenna_(original_image).png';
sum = 'Lenna_(noisy_image).png';

Lenna_sum = imread(sum);
Lenna_orig = imread(original);

Lenna_sum_gray = rgb2gray(Lenna_sum);
Lenna_orig_gray = rgb2gray(Lenna_orig);
PSNR = [];
SSIM = [];
BRISQUE = [];

[PSNR(end+1), SSIM(end+1), BRISQUE(end+1)] = evaluate(Lenna_orig_gray,Lenna_sum_gray);
%% gaus
filtred_gauss = imgaussfilt(Lenna_sum_gray, 0.3, 'FilterSize',5);
[PSNR(end+1), SSIM(end+1), BRISQUE(end+1)] = evaluate(Lenna_orig_gray,uint8(filtred_gauss));


%% wiener filter

lena_spect  = fft2(Lenna_sum_gray)/512^2;
lena_pspect = (lena_spect.^2)/512^2;

homogen_part  = fft2(imcrop(Lenna_sum_gray));
sum_spect = (homogen_part(1:30,1:30)/30^2);
sum_vspect = (sum_spect.^2)/30^2;
sum_vspect = imresize(sum_vspect,512/30);

WKF = (lena_pspect - sum_vspect)/lena_pspect;
WKF(WKF < 0) = 0;

filtred_wiener = real(ifft(WKF.*lena_spect));

[PSNR(end+1), SSIM(end+1), BRISQUE(end+1)] = evaluate(Lenna_orig_gray,uint8(filtred_wiener));
%% adaptive wiener
ada_wiener = wiener2(Lenna_sum_gray,[7 7]);

[PSNR(end+1), SSIM(end+1), BRISQUE(end+1)] = evaluate(Lenna_orig_gray,ada_wiener);
%% bilatelar
bilat_filt = imbilatfilt(Lenna_sum_gray);
[PSNR(end+1), SSIM(end+1), BRISQUE(end+1)] = evaluate(Lenna_orig_gray,uint8(bilat_filt));

%% non-linear anisotropic diffusion filter

diifus_filt = imdiffusefilt(Lenna_sum_gray);
[PSNR(end+1), SSIM(end+1), BRISQUE(end+1)] = evaluate(Lenna_orig_gray,uint8(diifus_filt));

%% total variation
PSNR(end+1) = 0;

%%  non-local means

non_loc_filt= imnlmfilt(Lenna_sum_gray);
[PSNR(end+1), SSIM(end+1), BRISQUE(end+1)] = evaluate(Lenna_orig_gray,uint8(non_loc_filt));

%%
figure
subplot 241
imshow(filtred_gauss)
title(["Gausian filter - PSNR ", num2str(PSNR(2))])
subplot 242
imshow(filtred_wiener)
title(["Wiener filter - PSNR ", num2str(PSNR(3))])
subplot 243
imshow(ada_wiener)
title(["Adaptive Wiener filter - PSNR ", num2str(PSNR(4))])
subplot 244
imshow(bilat_filt)
title(["Bilateral filter - PSNR ", num2str(PSNR(5))])
subplot 245
imshow(diifus_filt)
title(["Non-linear anisotropic diffusion filter - PSNR ", num2str(PSNR(6))])
subplot 246
imshow(Lenna_sum_gray)
title(["Total variation filter - PSNR ", num2str(PSNR(7))])
subplot 247
imshow(non_loc_filt)
title(["Non-local means (NLM) filter - PSNR ", num2str(PSNR(8))])
