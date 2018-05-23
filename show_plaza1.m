function h=show_plaza1(CARTYPE,h,n);

[L,W]=size(CARTYPE); 
CARTYPE=CARTYPE/2;
CARTYPE(:,[1,W])=-1;
temp=CARTYPE;
temp(temp==1)=0;%create the palza without any cars
temp(temp==0.5)=0.7;
plaza_draw=CARTYPE;  

PLAZA(:,:,1)=plaza_draw;
PLAZA(:,:,2)=plaza_draw;
PLAZA(:,:,3)=temp;
PLAZA=1-PLAZA;
PLAZA(PLAZA>1)=PLAZA(PLAZA>1)/6;

if ishandle(h)
   set(h,'CData',PLAZA);
   pause(n);
else
    figure('position',[100 100 200 700]);
    h=imagesc(PLAZA);
    %colorbar;
    hold on;
    plot([[0:W]',[0:W]']+0.5,[0,L]+0.5,'k');
    plot([0,W]+0.5,[[0:L]',[0:L]']+0.5,'k');
    axis image
    set(gca, 'xtick', [], 'ytick', []);
    pause(n);
end
end