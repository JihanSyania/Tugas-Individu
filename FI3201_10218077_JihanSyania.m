% Jihan Syania_10218077
% Fisika Komputasi
% TUGAS INDIVIDU FINITE DIFFERENCE METHOD
clc;
clear all;

%Input syarat dan batas dari konduksi plat persegi pajang 2 dimensi 
K = 81;     %Konduktivitas
L = 0.833;  %Panjang
w = 0.83;   %Lebar
T1 = 100;   %Batas Suhu kiri,kanan, bawah
T2 = 20;    %Batas Suhu atas
n = 11;     %jumlah titik masing-masing sumbu 

T = zeros(n); 
%suhu pada setiap bagian plat
T(n,n)=T1;
T(n,1)=T1;
T(1,n)=(T1+T2)/2;
T(n,:)=T1;
T(:,n)=T1;
T(1,:)=T2;
T(:,1)=T1;
T(1,1)=(T1+T2)/2;

toleransi = 1e-6; %galat toleransi
error_max = 1;    %error maksimum
iter = 0;         %iterasi awal

%looping 
while error_max > toleransi;
  iter++; % penjumlahan iterasi
  Told=T;
  for i = 2:n-1;    %pada searah sumbu x
    for j = 2:n-1;  %pada searah sumbu y
   T(i,j)=(T(i+1,j)+T(i-1,j)+T(i,j+1)+T(i,j-1))/4;
    end
  end
  error_max = max(max(abs(Told-T)));
end

%Result Countor plotting
[x,y] = meshgrid(0.83:-0.083:0,0.83:-0.083:0);
imagesc(x,y,T);
colormap jet; axis equal tight;
hold on 
title('konduksi plat persegi pajang 2 dimensi')
hcb = colorbar %menampilkan nilai temperatur
colorTitleHandle = get(hcb,'Title');
titleString = 'Temperatur(\degC)';
set(colorTitleHandle, 'String', titleString);
set(gca, 'ydir','reverse')
view(-180,90) %orientasi plot
hold off

%Results at x = 0.0833 and x = 0.5
xx = linspace(0,0.833,n);
T1 = transpose(T(:,2)); %untuk x = 0.0833 
T11= transpose(T(:,7)); %untuk x = 0.5
m  = 1;

for i =n:-1:1
 T2(m)=T1(1,i);
 T22(m)=T11(1,i);
 m++;
end

figure;
scatter(xx,T2)
hold on;
scatter(xx,T22)
hold on;
plot(xx,T2,xx,T22)
title("Temperatur terhadap jarak")
legend('THESEUS-FE: x= 0.0833','THESEUS-FE: x= 0.5','Analytical: x= 0.0833','Analytical: x= 0.5');
xlabel('Distance [m]'),ylabel('T [^OC]');
