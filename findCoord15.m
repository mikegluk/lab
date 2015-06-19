function [arWrkROI,arDivLn]=findCoord15(fcIn)
%   Finds workarea, separator and rotation angle

  arLROI=[1 90 25 205];       
  arRROI=[614 90 25 205];
  arCROI=[300 90 50 205];

%  fgOut=amplifyChannel(fcIn,'G','R',0.01,40,false);            % Amplify green channel
  fgOut=amplifyChannel(fcIn,'G','R',0.15,40,false);            % Amplify green channel
  vaLCorners=detectHarrisFeatures(fgOut,'ROI',arLROI);    %
  vaCCorners=detectHarrisFeatures(fgOut,'ROI',arCROI);    % Detect features for workfield extrapolation
  vaRCorners=detectHarrisFeatures(fgOut,'ROI',arRROI);    %
  arLCorners=vaLCorners.selectStrongest(10).Location;
  arCCorners=vaCCorners.selectStrongest(10).Location;
  arRCorners=vaRCorners.selectStrongest(10).Location;
  nMin=min([size(arLCorners,1) size(arCCorners,1) size(arRCorners,1)]);
  %figure; imshow(fgOut) 
  %hold on
  %plot(vaLCorners.selectStrongest(nMin))
  %plot(vaCCorners.selectStrongest(nMin))
  %plot(vaRCorners.selectStrongest(nMin))
  arPoints=[arLCorners(1:nMin,:) arRCorners(1:nMin,:) arCCorners(1:nMin,:)]; % Get coordinates for 10 strongest points for each region
%  arPoints=[vaLCorners.selectStrongest(nMin).Location vaRCorners.selectStrongest(nMin).Location ...
%  vaCCorners.selectStrongest(nMin).Location]; % Get coordinates for 10 strongest points for each region

  arMean=(max(arPoints)+min(arPoints))/2;                  % ~ half way between upper and lower borders
  arPnt=bsxfun(@minus,arPoints,arMean);   % Set y=0 at the midpoint
  arL1=sortrows(arPnt(arPnt(:,2)<-60,1:2));
  arL2=sortrows(arPnt(arPnt(:,2)>60,1:2));
  arR1=sortrows(arPnt(arPnt(:,4)<-60,3:4));
  arR2=sortrows(arPnt(arPnt(:,4)>60,3:4));
  arWrkROI=[ceil(max([arL1(end,1)+arMean(1) arL2(end,1)+arMean(1)])) ceil(max([arL1(end,2)+arMean(2) arR1(1,2)+arMean(2)]))];
  arWrkROI=[arWrkROI floor(min([arR1(1,1)+arMean(3) arR2(1,1)+arMean(3)]))-arWrkROI(1) ...
      floor(min([arL2(end,2)+arMean(4) arR2(1,2)+arMean(4)]))-arWrkROI(2)]; % Extrapolate workspace ROI
  arDivLn=[ceil(arMean(5))-arWrkROI(1) 1 ceil(arMean(5))-arWrkROI(1) arWrkROI(4)];
  arWrkROI=arWrkROI+[85 15 -150 -35];
  arDivLn=arDivLn + [-85 0 -85 -35];
end

