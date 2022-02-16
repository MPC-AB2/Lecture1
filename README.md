# Lecture 1 – IMAGE DENOISING

## Preparation

1. Each team will Sign Up for GitHub and will give the name of the GitHub profile to the lecturers.
2. If not available download **PORTABLE** version of the Git.
3. Run Git bash.
4. Set username by: `$ git config --global user.name "name_of_your_GitHub_profile"`
5. Set email by: `$ git config --global user.email "email@example.com"`
6. Select some MAIN folder with write permision.
7. Clone the **Lecture1** repository from GitHub by: `$ git clone https://github.com/MPC-AB2/Lecture1.git`
8. In the MAIN folder should be new folder Lecture1.
9. In the **Lecture1** folder create subfolder **NAME_OF_YOUR_TEAM**.
10. In the **NAME_OF_YOUR_TEAM** folder create two subfolders: **TASK1** and **TASK2**
11. Run Git bash in **Lecture1** folder (should be *main* branch active).
12. Create new branch for your team by: `$ git checkout -b NAME_OF_YOUR_TEAM`
13. Check that  *NAME_OF_YOUR_TEAM* branch is active.
14. Continue to First task...

## Tasks to do

### First task – demonstration of filterring methods

1. Download the images in a zip folder from [here](https://www.vut.cz/www_base/vutdisk.php?i=283822a7cc). The zip folder contains an original image and its noisy version. Assume the additive Gaussian white noise with zero mean and unknown variance. Convert both images into the gray-scale version (keep intensity value in the range 0 to 255). Further, you will use these two images for testing of various denoising algorithms. The goal will be to get a new - denoised image as much as similar to the original one.

2. Make a script in **Lecture1\NAME_OF_YOUR_TEAM\TASK1** folder for computation of PSNR, SSIM, and any of non-reference image quality assessment criteria and calculate these parameters between the original image and its noisy variant. Look at the results and think about the parameters’ values – when will the values be decreasing and when increasing?

3. Run Git GUI by: `$ git gui`
4. Commit new code into Git through GUI (stage changed (your new script should be vissible and moved) -> fill commit window -> sign off -> commit).

5. Implementation and application of different denoising methods:
   * Apply Gaussian filter (or averaging mask) on testing image
   * Implement the basic variant of Wiener filter using the equation from presentation and apply it on testing image
   * Apply an adaptive variant of the Wiener filter on testing image
   * Apply bilateral filter on testing image
   * Apply non-linear anisotropic diffusion filter on testing image
   * Apply total variation filter on testing image
   * Apply non-local means (NLM) filter on testing image

6. Explore each method more deeply and try to find the optimal parameters’ setting of each method in order to get the most efficient and useful result (estimation of denoised image). Calculate above-mentioned evaluation criteria for each method. Save one **TIFF** image as a joined figure consisted of 7 subfigures showing the best achieved results of particular denoising methods (also with evaluation criteria values). **Push** your program script into GitHub repository **Lecture1** using the **branch of your team** (stage changed -> fill commit window -> sign off -> commit -> push -> select NAME_OF_YOUR_TEAM branch -> push).

### Second task – a student competition

1. Download the images in a zip folder from [here](https://www.vut.cz/www_base/vutdisk.php?i=283824a5ed). Extract the content of the zip folder into **Lecture1** folder. The zip folder contains an encrypted ground truht images (*GT.mat*) and their noisy versions (**images_noisy** folder). The encrypted MATLAB function *noise_eval.p* will serve for evaluation of your results obtained in a challenge competition. The function allows automatic calculation of PSNR, SSIM, and PIQE from the denoised images at the input path. Function could be called as:

* `noise_eval(path_to_denoised_images)` to print the evaluation values, or
* `evaluation_details = noise_eval(path_to_denoised_images)` to get strucure of the detailed evaluation for each image, or
* `noise_eval(path_to_denoised_images, True)` to get the graphical output in addition to printed values.

2. In the next step, explore the data. Make a script in **Lecture1\NAME_OF_YOUR_TEAM\TASK2** folder to apply any of the tested methods, or their combination, to the image dataset and try to get the best denoising results. Please, note that the dataset covers images of various degrees of noise, which may differ also between particular RGB channels of each image. You need to consider all these aspects in development of your method.

3. Submit the best-obtained result of your method evaluated on the competition dataset using the evaluation function (i.e. submit the calculated evaluation values) into a shared Excel table. The evaluation of results from each team will be presented at the end of the lecture. **Push** your final program with the best results into GitHub repository **Lecture1** using the **branch of your team** (stage changed -> fill commit window -> sign off -> commit -> push -> select NAME_OF_YOUR_TEAM branch -> push).
