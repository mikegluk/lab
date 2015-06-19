function [arOut] = imsubtzero(arIn1,arIn2)
% arOut = imsubtzero(arIn1,arIn2)
%   Same as imsubtract but negative values are substituted with zeros
%arOut=imsubtract(arIn1,arIn2);
arOut=arIn1-arIn2;
arOut(arOut<0)=0;

end

