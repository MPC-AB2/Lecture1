I_noisy = imread( "Lenna_(noisy_image).png");
I_orig = imread("Lenna_(original_image).png");
I_noisy = rgb2gray(I_noisy);
I_orig = rgb2gray(I_orig);
[piqe_score,ssimval,peaksnr] =  image_quality(I_orig,I_noisy)

out = awgn(I_orig,10);
