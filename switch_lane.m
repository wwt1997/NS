function [cartype,plaza,v,vmax]=switch_lane(cartype,plaza,v,vmax,gap);
    [L,W]=size(plaza);% The size of the lane
    changeL=zeros(L,W);% can turn left
    changeR=zeros(L,W);% can turn right
    % can turn left?
    for lanes=2:W-2
        temp=find(plaza(:,lanes)==1);
        nn=length(temp); 
        for k=1:nn
            i=temp(k);
              if(k==nn)
                   if(v(i,lanes)<(sum(v(:,lanes+1))/sum(plaza(:,lanes+1)))&&sum(plaza([i:L],lanes+1))==0 && sum(plaza([1:mod(i+gap(i,lanes),L)+1],lanes+1))==0 && plaza(mod(i-2,L)+1,lanes+1)==0)
                    changeL(i,lanes)=1;
                   end
              else
                   if(v(i,lanes)<sum(v(:,lanes+1))/sum(plaza(:,lanes+1))&&sum(plaza([i:i+gap(i,lanes)+1],lanes+1))==0&&plaza(mod(i-2,L)+1,lanes+1)==0)
                    changeL(i,lanes)=1;
                   end
              end
        end
    end

    for lanes=W-2:2
        temp=find(plaza(:,lanes)==1);
        nn=length(temp);
        for k=1:nn
            i=temp(k);
           if(k==nn)
               if(v(i,lanes)<sum(v(:,lanes-1))/sum(plaza(:,lanes-1))&&sum(plaza([i:L],lanes-1))==0 && sum(plaza([1:mod(i+gap(i,lanes),L)+1],lanes-1))==0&&plaza(mod(i-2,L)+1,lanes-1)==0)
                changeL(i,lanes)=1;
               end
           else
               if(v(i,lanes)<sum(v(:,lanes-1))/sum(plaza(:,lanes-1))&&sum(plaza([i:i+gap(i,lanes)+1],lanes-1))==0&&plaza(mod(i-2,L)+1,lanes-1)==0)
                changeL(i,lanes)=1;
               end
            end
        end
    end

      for lanes=2:W-2
        temp=find(changeL(:,lanes)==1);
        nn=length(temp);
        for k=1:nn
            i=temp(k);
            if(plaza(i,lanes-1==0))
            plaza(i,lanes-1)=1;
            cartype(i,lanes-1)=cartype(i,lanes);
            v(i,lanes-1)=max(v(i,lanes)-1,1);
            vmax(i,lanes-1)=vmax(i,lanes);
            plaza(i,lanes)=0;
            cartype(i,lanes)=0;
            v(i,lanes)=0;
            vmax(i,lanes)=0;
            changeL(i,lanes)=0;
            end
        end
      end
    
    for lanes=W-2:2
        temp=find(changeR(:,lanes)==1);
        nn=length(temp);
        for k=1:nn
            i=temp(k);
                if(plaza(i,lanes-1)==0)
                plaza(i,lanes-1)=1;
                cartype(i,lanes-1)=cartype(i,lanes);
                v(i,lanes-1)=max(v(i,lanes)-1,1);
                vmax(i,lanes-1)=vmax(i,lanes);
                plaza(i,lanes)=0;
                cartype(i,lanes)=0;
                v(i,lanes)=0;
                vmax(i,lanes)=0;                      
                changeR(i,lanes)=0;
                end
        end

    end
end