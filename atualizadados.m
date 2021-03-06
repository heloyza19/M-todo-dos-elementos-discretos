function  [Dados,campo]=atualizadados(e,Dados,campo,Fres,Xmin,Ymin,dx,dt)
%For�a resultante sobre a part�cula
Fr_x=Fres(e,1);
Fr_y=Fres(e,2);    
%Dados da part�cula 'e'  (e=n�mero da part�cula)
vx=Dados.velocidade(e,1);
vy=Dados.velocidade(e,2);
r=Dados.raio(e);
m=Dados.massa(e);
ax=Fr_x/m;          %Acelera��o a part�cula
ay=Fr_y/m;
        
%Atualiza velocidade
nvx=vx+ax*dt;
nvy=vy+ay*dt;
        
%Atualiza posi��o por RK2
P1=Dados.posicao(e,1)+0.5*dt*(nvx+vx);
P2=Dados.posicao(e,2)+0.5*dt*(nvy+vy);

%Apaga a part�cula da posi��o anterior no campo
[I0,J0]=mapeamento(Dados.posicao(e,1),Dados.posicao(e,2),Xmin,Ymin,dx);
p=find(campo{I0,J0}==e);
campo{I0,J0}(p)=[];
        
%AN�LISE DO ESPA�O AP�S A ATUALIZA��O DA POSI��O 
[I,J]=mapeamento(P1,P2,Xmin,Ymin,dx);

%COLOCA OS DADOS ATUALIZADOS NA NOVA C�LULA  
campo{I,J}=[campo{I,J},e];
Dados.posicao(e,1)=P1;
Dados.posicao(e,2)=P2;
Dados.velocidade(e,1)=nvx;
Dados.velocidade(e,2)=nvy;

end

