% this function provides easier array or image padding.
function T=ImPad(I,x1,x2,y1,y2)
T=I;
T=padarray(I,[x1,0],'pre');
T=padarray(T,[x2,0],'post');
T=padarray(T,[0,y1],'pre');
T=padarray(T,[0,y2],'post');

