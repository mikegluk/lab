function [arOut] = immultiplyone(arIn1,arIn2)
% arOut = immultiplyone(arIn1,arIn2)
%   Same as imadd but values over 1 are truncated
%arOut=immultiply(arIn1,arIn2);
arOut=arIn1.*arIn2;
arOut(arOut>1)=1;

end

