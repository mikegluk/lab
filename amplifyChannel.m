function fgOut = amplifyChannel(fcIn,plusCh,minusCh,coefSub,coefMult,isInt)
%fgOut = amplifyChannel(fcIn,plusCh,minusCh,coefSub,coefMult)
  pCh=chCode(plusCh);
  mCh=chCode(minusCh);
  if isInt
    fgOut=fcIn(:,:,pCh)-fcIn(:,:,mCh);    
    fgOut=(fgOut-coefSub).*coefMult; % Amplify green channel
  else
    fgOut=imsubtzero(fcIn(:,:,pCh),fcIn(:,:,mCh));    
    fgOut=immultiplyone(imsubtzero(fgOut,coefSub),coefMult); % Amplify green channel
  end
end
function ChN = chCode(chCh)
  if ismember(chCh,['r' 'R' '1'])
    ChN=1;
  elseif ismember(chCh,['g' 'G' '2'])
    ChN=2;
  elseif ismember(chCh,['b' 'B' '3'])
    ChN=3;
  else
    error('Wrong channel name');
  end
end

