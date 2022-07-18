function out=to_3d_point(img,vanishing_point,recVertex)    
    [m,n,p]=size(img);
    recVertex([1,2],:)=toimgcoordinate(recVertex)+[vanishing_point(2),vanishing_point(1)]';
    mask1 = poly2mask(recVertex(1,[1,2,8,7]),recVertex(2,[1,2,8,7]),m,n);%back
    mask2 = poly2mask(recVertex(1,[1,7,11,5]),recVertex(2,[1,7,11,5]),m,n);%left
    mask3 = poly2mask(recVertex(1,[1,3,4,2]),recVertex(2,[1,3,4,2]),m,n);%down
    mask4 = poly2mask(recVertex(1,[2,8,12,6]),recVertex(2,[2,8,12,6]),m,n);%right
    mask5 = poly2mask(recVertex(1,[7,8,10,9]),recVertex(2,[7,8,10,9]),m,n);%up
    mask=mask1+2*mask2+3*mask3+4*mask4+5*mask5;
    
    out=ones(m,n);
    for i=[1:m]
        for j=[1:n]
            switch mask(i,j)
                case 1 %bottom
                    out(i,j)=recVertex(3,1);
                case 2 %left
                    out(i,j)=(vanishing_point(2)-recVertex(1,5))/(vanishing_point(2)-j)*recVertex(3,5);
                case 3 %bottom
                    out(i,j)=(vanishing_point(1)-recVertex(2,3))/(vanishing_point(1)-i)*recVertex(3,3);
                case 4 %left
                    out(i,j)=(vanishing_point(2)-recVertex(1,6))/(vanishing_point(2)-j)*recVertex(3,6);
                case 5 %bottom
                    out(i,j)=(vanishing_point(1)-recVertex(2,10))/(vanishing_point(1)-i)*recVertex(3,10);

        end
    end
end
