zasumeny = imread('Lenna_(noisy_image).png');
original = imread('Lenna_(original_image).png');
zasum_sed = rgb2gray(zasumeny);
orig_sed = rgb2gray(original);


PSNR_h = psnr(zasum_sed,orig_sed);
SIMS_h = ssim(zasum_sed,orig_sed);
PIQE_h = piqe(zasum_sed);






% Apply Gaussian filter (or averaging mask) on testing image
gaus_filtace = imgaussfilt(zasum_sed);  

% Implement the basic variant of Wiener filter using the equation from presentation and apply it on testing image
%% Implement the basic variant of Wiener filter using the equation from presentation and apply it on testing image
    % odhad sumu - homogenní oblast z obrazku a z toho vypočítám výkon, lokální rozptyl v homogenní oblasti
% zaščuměná obraz...vyberu si homogenní zašuměnou oblast(z toho udělám
% spektrum, ale aby měl stejnou velikost jako velikost obrazu (spektrum
% šumu jakoby) a ty spektra dosadáíím do vzorce
im_noise = zasum_sed;


Icropped = imcrop(im_noise);
size_orig = (size(im_noise,1)*size(im_noise,2));
size_crop = (size(Icropped,1)*size(Icropped,2));

im_noise_fft = ((fft2(im_noise)/size_orig).^2)/size_orig;
noise_fft = ((fft2(Icropped, size(im_noise_fft,1), size(im_noise_fft,2)) / size_crop).^2)/size_crop;
%dělím velikostí obrazů pro stejný výkon


WKF = real( (im_noise_fft - noise_fft) ./ im_noise_fft);
WKF(WKF<0) = 0;
WKF(WKF>1) = 1;

F = WKF.* (fft2(im_noise)/size_orig);
wiener_1 = real(ifft2(F));


% Apply an adaptive variant of the Wiener filter on testing image
wiener_2 = wiener2(zasum_sed,[5 5]);
 
% Apply bilateral filter on testing image
bilater = imbilatfilt(zasum_sed);

% Apply non-linear anisotropic diffusion filter on testing image
anis_difus = imdiffusefilt(zasum_sed);

% Apply total variation filter on testing image

lam = 0.85;
iter =300;
var_fil = TVL1denoise(zasum_sed, lam, iter);

% Apply non-local means (NLM) filter on testing image
non_loc_mean = imnlmfilt(zasum_sed);

figure;
subplot(241)
imshow(zasum_sed,[])
title( ['puvodni zasumeny, SNR = ',  num2str(psnr(zasum_sed,orig_sed))])

subplot(242)
imshow(gaus_filtace,[])
title(['Gausova filtrace, SNR = ',  num2str(psnr(gaus_filtace,orig_sed))])

subplot(243)
imshow(wiener_1,[])
title(['wiener filtr, SNR = ',  num2str(psnr( im2uint8(wiener_1),orig_sed))])

subplot(244)
imshow(wiener_2,[])
title(['adaptivni wiener filtr, SNR = ',  num2str(psnr(wiener_2,orig_sed))])

subplot(245)
imshow(bilater,[])
title(['Bilateralni, SNR = ',  num2str(psnr(bilater,orig_sed))])

subplot(246)
imshow(anis_difus,[])
title(['non-linear anisotropic diffusion, SNR = ',  num2str(psnr(anis_difus,orig_sed))])

subplot(247)
imshow(var_fil,[])
title(['total variation filter, SNR = ',  num2str(psnr(im2uint8(var_fil),orig_sed))])

subplot(248)
imshow(non_loc_mean,[])
title(['non-local means, SNR = ',  num2str(psnr(non_loc_mean,orig_sed))])



