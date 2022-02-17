I_noisy = imread( "Lenna_(noisy_image).png");
I_orig = imread("Lenna_(original_image).png");
I_noisy = rgb2gray(I_noisy);
I_orig = rgb2gray(I_orig);


%% Task 1__ implementation and application of different denoising methods 
%% GAUSS FILTER
[piqe_score,ssimval,peaksnr] =  image_quality(I_orig,I_noisy);
sigma = 2.5;
gauss = imgaussfilt(I_noisy, sigma);
figure; imshow(gauss);
[piqegauss,ssimgauss,peaksnrgauss] =  image_quality(I_orig,gauss)
title(["gauss_filter PSNR = " num2str(peaksnrgauss)]);

%% TASK1 - WIENER FILTER
[m n] = size(I_noisy);
G = fft2(I_noisy)/(m*n);
G2 = real(G.^2)./(m*n);
figure; imshow(I_noisy);
v = imcrop(I_noisy);
[s1 s2] = size(v);
V = fft2(v,size(I_noisy,1),size(I_noisy,2))/(s1*s2);
V2 = real(V.^2)/(s1*s2);
WKF = (G2 - V2)./G2;
WKF(WKF>1) = 1;
WKF(WKF<0) = 0;

F = WKF .* G;
wiener = real(ifft2(F));
[piqewiener,ssimwiener,peaksnrwiener] =  image_quality(double(I_orig),wiener);
figure; 
imshow(wiener,[]);
title(["wiener filter; PSNR = " num2str(peaksnrwiener)])

%% TASK1 - ADAPTIVE WIENER

[Wiener_adapt, noise] = wiener2(I_noisy, [5,5]);

[piqewieneradapt,ssimwieneradapt,peaksnrwieneradapt] =  image_quality(I_orig,Wiener_adapt);

figure; imshow(Wiener_adapt,[]);
title(["adaptive wiener filter; PSNR = " num2str(peaksnrwieneradapt)])

%% TASK1 - BILATERAL FILTER
degreeOfSmoothing = 0.01*diff(getrangefromclass(I_noisy)).^2;
J = imbilatfilt(I_noisy,degreeOfSmoothing);

[piqebilateral,ssimbilateral,peaksnrbilateral] =  image_quality(I_orig,J);

figure; imshow(J,[]);
title(["Bilateral filter; PSNR = " num2str(peaksnrbilateral)])


%% TASK1 - NON-LINEAR FILTER

NL = imdiffusefilt(I_noisy);

[piqenonlinear,ssimnonlinear,peaksnrnonlinear] =  image_quality(I_orig,NL);

figure; imshow(NL,[]);
title(["Non-linear filter; PSNR = " num2str(peaksnrnonlinear)])

%% TASK1 - TOTAL VARIATION FILTER
im=I_noisy;
TV=TVL1denoise(im, 1.0, 100);

[piqeTV,ssimTV,peaksnrTV] =  image_quality(double(I_orig),TV);

figure; imshow(TV,[]);
title(["TV filter; PSNR = " num2str(peaksnrTV)])
%% TASK1 - NON-LOCAL MEANS FILTER


J = imnlmfilt(I_noisy);

[piqenonlocal,ssimnonlocal,peaksnrnonlocal] =  image_quality(I_orig,J);

figure; imshow(J,[]);
title(["Non-local means filter; PSNR = " num2str(peaksnrnonlocal)])
