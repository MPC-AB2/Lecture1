addpath("C:\Users\xsando01\Documents\AB2\Lecture1")
dir C:\Users\xsando01\Documents\AB2\Lecture1\images_noise

imagefiles = dir('*.jpg');      
nfiles = length(imagefiles);    % počet souborů

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
end




%% FILTRACE
for iter = 1:55

    a = images{iter};
    p(1) = piqe(a(:,:,1));
    p(2) = piqe(a(:,:,2));
    p(3) = piqe(a(:,:,3));
    
    p = round(p/10)+2;
    
    R = imgaussfilt(a(:,:,1),p(1));
    G = imgaussfilt(a(:,:,2),p(2));
    B = imgaussfilt(a(:,:,3),p(3));
    
    q(:,:,1) = R;
    q(:,:,2) = G;
    q(:,:,3) = B;

    vysledek{iter} = q;
end


%% UKLÁDÁNÍ
for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   imwrite(vysledek{ii},["C:\Users\xsando01\Documents\AB2\Lecture1\ToNebudeFungovat\task2\Filtrovane\"+currentfilename]);
end



vy = noise_eval('C:\Users\xsando01\Documents\AB2\Lecture1\ToNebudeFungovat\task2\Filtrovane\', true)
