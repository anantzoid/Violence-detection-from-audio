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
      test_dimensions=zeros(10,1);
        r= [1:10];
        for i=r;
        filename= 'audio';            
        filename= strcat(filename,int2str(i));
      
          % Read speech samples, sampling rate and precision from file
            [ speech, fs, nbits ] = wavread( strcat('testdata\',filename,'.wav' ));
       
          
          % Feature extraction (feature vectors as columns)
          [ MFCCs, FBEs, frames, sz ] = ...
                          mfcc( speech, fs, Tw, Ts, alpha, hamming, R, M, C, L );
           MFCCs = MFCCs(:,all(~isnan(MFCCs)));
           
           name = strcat('test_mfcc\',filename,'.mat');
           
           save (name, 'MFCCs');
           test_dimensions(i) = size(MFCCs,2);
          if i==r(1)
              test_data = MFCCs;
          else    
            test_data = [test_data MFCCs];
          end
      end

     save ('test_data.mat', 'test_data');
     save('test_dimensions.mat','test_dimensions');
   