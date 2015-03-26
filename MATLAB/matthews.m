function mat=matthews(model)
    C=model.confusion;
    n=length(C);
    top=0;
    bottomLeft=0;
    bottomRight=0;
    for k=1:n
       Clk=0;
       Ckl=0;
       Cgf=0;
       Cfg=0;
       for l=1:n
          for m=1:n
              top=top+C(k,k)*C(m,l)-C(l,k)*C(k,m);
          end
          Clk=Clk+C(l,k);
          Ckl=Ckl+C(k,l);
       end
       
       for f=1:n
              for g=1:n
                  if f~=k
                      Cgf=Cgf+C(g,f);
                      Cfg=Cfg+C(f,g);
                  end
              end
       end
       
       bottomLeft=bottomLeft+(Clk*Cgf);
       bottomRight=bottomRight+(Ckl*Cfg);
    end
    bottom=sqrt(bottomLeft*bottomRight);
    
    mat=top/bottom;
    
    
end