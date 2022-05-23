nSamplePoints = 10000;
rN = rand(1, nSamplePoints);
rBinary = round(rN);   

Fc = 1;                     
Fs = 16;                    
nCycles = 1;
Tb = nCycles/Fc;            
t = 0:1/Fs:(nCycles-1/Fs);
xC = cos(2*pi*Fc*t);  


A = 1;                      
Eb = (A^2*Tb)/2;           
Eb_N0dB = 0 : 4 : 40;      
Eb_N0 = 10.^(Eb_N0dB/10);              
nVar = (Eb)./ Eb_N0;       

bitStream = [];
carrierSignal = [];
i = 1;
ber= 0.5*erfc(sqrt(Eb_N0));

fprintf("Error rate %d\n",ber);
while(i<=nSamplePoints)
    if(rBinary(i))
        bitStream = [bitStream ones(1,length(xC))];
    else
        bitStream = [bitStream zeros(1,length(xC))];
    end
    carrierSignal = [carrierSignal A*xC];
    i = i+1;
end

bits = 2*(bitStream-0.5);
bpskSignal = carrierSignal.*bits;
plot(bits);
xlim([0 300]); ylim([-1.2 1.2]);

figure(1);
subplot(3,1,1); plot(bitStream); title('Digital Signal');
xlim([0 300]); ylim([-0.2 1.2]);
subplot(3,1,2); plot(carrierSignal); title('Carrier Signal');
xlim([0 300]); ylim([-1.2 1.2]);
subplot(3,1,3); plot(bpskSignal); title('BPSK modulated signal');
xlim([0 300]); ylim([-1.2 1.2]);

figure(2)
plot(Eb_N0dB,ber);
