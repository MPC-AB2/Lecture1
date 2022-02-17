import cv2
import numpy as np
from skimage.metrics import structural_similarity
import imquality.brisque as brisque

if __name__ == '__main__':
    img1 = cv2.imread('/Users/ondra/dev/school/Lecture1/prvni/task1/Lecture1_first_data/Lenna_(noisy_image).png',
                      cv2.IMREAD_GRAYSCALE)
    img2 = cv2.imread('/Users/ondra/dev/school/Lecture1/prvni/task1/Lecture1_first_data/Lenna_(original_image).png',
                      cv2.IMREAD_GRAYSCALE)
    psnr = cv2.PSNR(img1, img2)
    print(f"PSNR: {psnr}")
    ssim = structural_similarity(img1, img2, data_range=img1.max() - img1.min())
    print(f"SSIM: {ssim}")

    brisque_score = brisque.score(img2)
    print(f"Brisque: {brisque_score}")
