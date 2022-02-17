original = 'Lenna_(original_image).png';
sum = 'Lenna_(noisy_image).png';

PSNR = [];
SSIM = [];
BRISQUE = [];

[PSNR, SSIM, BRISQUE] = evaluate(original,sum)