%% clear all
clear all
%% reading images

addpath('C:\Users\xschne08\Documents\mpc_ab2\Lecture1\images_noise')
   path_directory='C:\Users\xschne08\Documents\mpc_ab2\Lecture1\images_noise'; % 'Folder name'
   original_files=dir([path_directory '/*.jpg']); 
   load("names.mat")
   %%
   for k=1:length(original_files)
      filename=[path_directory '/' original_files(k).name];
      image_orginal=imread(filename);
      % Image_original{1} matrix of first image 

   image_original_red(:, :) = image_orginal(:, :, 1);
   image_original_green(:, :) = image_orginal(:, :, 2);

   image_original_blue(:, :) = image_orginal(:, :, 3);



   image_original_red_filtered_med(:, :) = medfilt2(im2double(image_original_red(:, :)), [15 15]);

   image_original_green_filtered_med(:, :) = medfilt2(im2double(image_original_green(:, :)),  [15 15]);

   image_original_blue_filtered_med(:, :) = medfilt2(im2double(image_original_blue(:, :)), [15 15]);






   image_original_red_filtered(:, :) = wiener2((image_original_red_filtered_med(:, :)), [15 15]);

   image_original_green_filtered(:, :) = wiener2((image_original_green_filtered_med(:, :)), [15 15]);

   image_original_blue_filtered(:, :) = wiener2((image_original_blue_filtered_med(:, :)), [15 15]);






    obraz(:,:,1) = uint8(image_original_red_filtered(:, :).*255);
    obraz(:,:,2) = uint8(image_original_green_filtered(:, :).*255);
    obraz(:,:,3) = uint8(image_original_blue_filtered(:, :).*255);
    imwrite(obraz,['C:\Users\xschne08\Documents\mpc_ab2\Lecture1\filtered\', names{k}])
end
