function [y2] = myStateTransitionFcn (y1, y2)

y2=0.75*y2;
y1=0.75*y1;

g=y1/(y1+200);
y2=y2+g;



end 

