function [cartype,plaza,v,vmax,vave]=move_forward(cartype,plaza,v,vmax,Gsafe);
    [L,W]=size(plaza);% The size of the lane
     % Compute values to get type of cars: turn left or stay
    gap=zeros(L,W);
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)==1); 
        nn=length(temp);% The number of the cars in the lane
        for k=1:nn;
            i=temp(k);
            if(k==nn)
                gap(i,lanes)=L-(temp(k)-temp(1)+1);% periodic boundary 
                continue;
            end
            gap(i,lanes)=temp(k+1)-temp(k)-1;
        end
    end

     for lanes=2:W-1;
         temp=find(plaza(:,lanes)==1);
         nn=length(temp);
         for k=nn:-1:1;
             i=temp(k);
             if(cartype(i,lanes)==2)
                if(v(i,lanes)+Gsafe(2)<=gap(i,lanes))
                    pos=mod(i+v(i,lanes)-1,L)+1;
                end
                if(v(i,lanes)+Gsafe(2)>gap(i,lanes))
                    pos=mod(i+max(gap(i,lanes)-Gsafe(2),0)-1,L)+1;
                    v(i,lanes)=max(gap(i,lanes)-Gsafe(2),0);
                end
             else
                if(k==nn)
                    if(cartype(temp(1),lanes)==1)                    
                         if(v(i,lanes)+Gsafe(1)<=gap(i,lanes))
                            pos=mod(i+v(i,lanes)-1,L)+1;
                         end
                         if(v(i,lanes)+Gsafe(1)>gap(i,lanes))
                            pos=mod(i+max(gap(i,lanes)-Gsafe(1),0)-1,L)+1;
                            v(i,lanes)=max(gap(i,lanes)-Gsafe(1),0);
                         end
                    else
                         if(v(i,lanes)+Gsafe(1)<=gap(i,lanes))
                             pos=mod(i+v(i,lanes)-1,L)+1;
                         end
                         if(v(i,lanes)+Gsafe(1)>gap(i,lanes))
                            pos=mod(i+max(gap(i,lanes)-Gsafe(1),0)-1,L)+1;
                            v(i,lanes)=max(gap(i,lanes)-Gsafe(1),0);
                         end
                    end
                 else
                         if(cartype(temp(k+1),lanes)==1)                    
                              if(v(i,lanes)+Gsafe(1)<=gap(i,lanes)+v(temp(k+1),lanes))
                                pos=mod(i+v(i,lanes)-1,L)+1;
                            end
                            if(v(i,lanes)+Gsafe(1)>gap(i,lanes)+v(temp(k+1),lanes))
                                pos=mod(i+max(gap(i,lanes)-Gsafe(1)+v(temp(k+1)),0)-1,L)+1;
                                v(i,lanes)=max(gap(i,lanes)-Gsafe(1)+v(temp(k+1)),0);
                            end
                       
                         else
                                if(v(i,lanes)+Gsafe(1)<=gap(i,lanes))
                                    pos=mod(i+v(i,lanes)-1,L)+1;
                                end
                                if(v(i,lanes)+Gsafe(1)>gap(i,lanes))
                                    pos=mod(i+max(gap(i,lanes)-Gsafe(1),0)-1,L)+1;
                                    v(i,lanes)=max(gap(i,lanes)-Gsafe(1),0);
                                end
                         end  
                end
             end
             if(pos~=i)
                plaza(pos,lanes)=1;
                cartype(pos,lanes)=cartype(i,lanes);
                v(pos,lanes)=v(i,lanes);
                vmax(pos,lanes)=vmax(i,lanes);
                 plaza(i,lanes)=0;
                 cartype(i,lanes)=0;
                 v(i,lanes)=0;
                 vmax(i,lanes)=0;
             end
         end
     end
vave=sum((sum(v(:,2:W-1)))')/sum((sum(plaza(:,2:W-1)))');
end