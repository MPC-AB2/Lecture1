zasumeny = imread('Lenna_(noisy_image).png');
original = imread('Lenna_(original_image).png');
zasum_sed = rgb2gray(zasumeny);
orig_sed = rgb2gray(original);


PSNR_h = psnr(zasum_sed,orig_sed);
SIMS_h = ssim(zasum_sed,orig_sed);
PIQE_h = piqe(zasum_sed);