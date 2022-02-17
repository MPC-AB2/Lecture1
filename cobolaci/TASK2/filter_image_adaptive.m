function [I_filt] = filter_image_adaptive(I_orig);
window = floor(size(I_orig,1)/200);
I_filt = uint8(zeros(size(I_orig,1),size(I_orig,2),3));
patches = 1:window:size(I_orig,1);
 for index1 = 1:window-1
     for index2 = 1:window-1
         I = im2double(I_orig(patches(index1):patches(index1+1)-1,patches(index2):patches(index2+1)-1,:));
          I_filt_part = uint8(zeros(window,window,3));
             for i = 1:3
                 std_image = std(std(I(:,:,i)));
                     sigma = 23.9234*std_image;
                     I_filt_part(:,:,i) = imgaussfilt(I(:,:,i),sigma);
                     I_filt(patches(index1):patches(index1+1)-1,patches(index2):patches(index2+1)-1,i) = I_filt_part;
            end
     end
 end

end