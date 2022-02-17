function newim = TVL1denoise(im, lambda, niter)
  if(nargin<3) || isempty(niter)
    niter=100;
  end
  L2=8.0;
  tau=0.02;
  sigma=1.0/(L2*tau);
  theta=1.0;
  lt=lambda*tau;
  [height width]=size(im); 
  unew=zeros(height, width);
  p=zeros(height, width, 2);
  d=zeros(height, width);
  ux=zeros(height, width);
  uy=zeros(height, width);
  mx=max(im(:));
  if(mx>1.0)
    nim=double(im)/double(mx); % normalize
  else
    nim=double(im); % leave intact
  end
  u=nim;
  %[p(:, :, 1), p(:, :, 2)]=imgradientxy(u, 'IntermediateDifference');
  p(:, :, 1)=u(:, [2:width, width]) - u;
  p(:, :, 2)=u([2:height, height], :) - u;
  for k=1:niter
    % projection
    % compute gradient in ux, uy
    %[ux, uy]=imgradientxy(u, 'IntermediateDifference');
    ux=u(:, [2:width, width]) - u;
    uy=u([2:height, height], :) - u;
    p=p + sigma*cat(3, ux, uy);
    % project
    normep=max(1, sqrt(p(:, :, 1).^2 + p(:, :, 2).^2)); 
    p(:, :, 1)=p(:, :, 1)./normep;
    p(:, :, 2)=p(:, :, 2)./normep;
    % shrinkage
    % compute divergence in div
    div=[p([1:height-1], :, 2); zeros(1, width)] - [zeros(1, width); p([1:height-1], :, 2)];
    div=[p(:, [1:width-1], 1)  zeros(height, 1)] - [zeros(height, 1)  p(:, [1:width-1], 1)] + div;
    %% TV-L2 model
    %unew=(u + tau*div + lt*nim)/(1+tau);
    % TV-L1 model
    v=u + tau*div;
    unew=(v-lt).*(v-nim>lt) + (v+lt).*(v-nim<-lt) + nim.*(abs(v-nim)<=lt);
    %if(v-nim>lt); unew=v-lt; elseif(v-nim<-lt) unew=v+lt; else unew=nim; end
    % extragradient step
    u=unew + theta*(unew-u);
    %% energy being minimized
    % ux=u(:, [2:width, width]) - u;
    % uy=u([2:height, height], :) - u;
    % E=sum(sqrt(ux(:).^2 + uy(:).^2)) + lambda*sum(abs(u(:) - nim(:)));
    % fprintf('Iteration %d: energy %g\n', k, E);
  end
  newim=u;