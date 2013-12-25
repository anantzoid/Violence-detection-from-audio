%function[data] = test() 
clearvars -global
 clc
      Tw = 25;           % analysis frame duration (ms)
      Ts = 10;           % analysis frame shift (ms)
      alpha = 0.97;      % preemphasis coefficient
      R = [ 300 3700 ];  % frequency range to consider
      M = 20;            % number of filterbank channels 
      C = 13;            % number of cepstral coefficients
      L = 22;            % cepstral sine lifter parameter

      % hamming window (see Eq. (5.2) on p.73 of [1])
      hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
      %r = [1:58 100:156];
      dimensions=zeros(1795,1);
      r=[1:999];
      for i=r
           if(i<10)
             filename = '000';
           elseif (i<100)
             filename = '00';
           else
             filename = '0';  
           end
            
        filename= strcat(filename,int2str(i));
      
          % Read speech samples, sampling rate and precision from file
            [ speech, fs, nbits ] = wavread( strcat('sounds\',filename,'.wav' ));
       
          
          % Feature extraction (feature vectors as columns)
          [ MFCCs, FBEs, frames, sz ] = ...
                          mfcc( speech, fs, Tw, Ts, alpha, hamming, R, M, C, L );
           MFCCs = MFCCs(:,all(~isnan(MFCCs)));
           
           name = strcat('data_mfcc\',filename,'.mat');
           
           save (name, 'MFCCs');
           dimensions(i) = size(MFCCs,2);  
          
          if i==r(1)
              data = MFCCs;
          else    
            data = [data MFCCs];
          end
      end
      r=[1:795];
      for i=r
        if(i<10)
            filename = '100';
        elseif (i<100)
            filename = '10';
        else
            filename = '1';  
        end 
        filename= strcat(filename,int2str(i));
      
          % Read speech samples, sampling rate and precision from file
            [ speech, fs, nbits ] = wavread( strcat('sounds\',filename,'.wav' ));
       
          
          % Feature extraction (feature vectors as columns)
          [ MFCCs, FBEs, frames, sz ] = ...
                          mfcc( speech, fs, Tw, Ts, alpha, hamming, R, M, C, L );
           MFCCs = MFCCs(:,all(~isnan(MFCCs)));
           
           name = strcat('data_mfcc\',filename,'.mat');
           
           save (name, 'MFCCs');
           dimensions(1000+i) = size(MFCCs,2);  
           data = [data MFCCs];
      end
         save ('data.mat', 'data');
         save ('dimensions.mat','dimensions');
%end         
   