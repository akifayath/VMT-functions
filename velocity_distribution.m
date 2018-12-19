 %Gives the downstream velociy distribution of each ensemble. User has to
 %input the ensemble number that the user wants to know about.

 %********Change the d and v value according to your data********
 %****d=depth at that ensemble= Minimumum depth : bin size : maximum (interpolate to which extent vmt gives a nan value for a single ensemble) 
 %****for v is imaginary zero velocity for the quiver to give the
 % projection for each ensemble. v =zeros(number of rows,1)
 %Changee the ylimit for the graphs if needed, maximum ylimit here is 25
 %meters.
 % give the how many ensembles a big number, that will allow to have a
 % number of ensembles to work with
 % The function works with the smoothed transverse and streamwise velocity
 % The function's ensemble number actually means the ensembles taken at 1 m
 % interval from left to right. Not actually the ensemble numbers from
 % winriver II but better matches with the VMT. 
 % Type return to stop the function
 
 % x value of quiver is an arbitrary value of the x coordinate for the function to work
 % input file is generated from Velocity Mapping Toolbox(VMT)...
 % Save the file at VMT as .mat and use the function to see the streamwise
 % and transverse velocity distribution at each ensemble 
 % Call your function as: myfunction('path/MyMat.mat') and answer the
 % Example:: velocity_distribution('D:\Google Drive Kifayath\ADCP FLOW STRUCTURE ANALYSIS\ADCP Data\wld_2013_02_15 for VMT\ADCP-2014-06-17\ADCP\VMTProcFiles/WLO_000_000_a_apex_fall_2.mat')
 % questions. Sample answers, 
 % Do you want the downstream velocity distribution or the transverse distribution? [D/T]
 % If you want streamwise distribution, Press D
 % Which ensemble data do you want to see?
 % If you want the streamwise distribution at ensemble 150, Type 150
 
function velocity_distribution(myMat)
  load(myMat); 
  
  reply=input('Do you want the downstream velocity distribution or the transverse distribution? [D/T]\n','s');
            if strcmp(reply,'D')
                udown=(V.uSmooth);
                d=A.Wat.binDepth(:,1);
                [x,y]=size(udown);
                v=zeros(x,1);
                udown(isnan(udown))=0;%giving the nan portion a value of zero
                x=mean(V.mcsDist,2);%setting up the x for quiver
                N=input('How many ensembles are you looking for?');
  for i=1:N
                n=input('Which ensemble data do you want to see?\n');
                
                figure
                
                subplot(2,1,1)
                plot(udown(:,n),-d)
                ylim([-25 0])
                xlabel('Streamwise velocity [cm/s]')
                ylabel('Depth[m]')
                title(['Section at distance ' sprintf('%i', n) ' m right from left bank' ])
                subplot(2,1,2)
                quiver(x,-d,udown(:,n),v,0.1);
                ylim([-25 0])
                ylabel('Depth[m]')
                
  end
            elseif strcmp(reply,'T')
                utrans=(V.vSmooth);
                d=A.Wat.binDepth(:,1);
                [x,y]=size(utrans);
                v=zeros(x,1);
                utrans(isnan(utrans))=0;
                x=mean(V.mcsDist,2);
                N=input('How many ensembles are you looking for?');
  for i=1:N
                n=input('which ensemble data do you want to see?\n');
                figure
                subplot(2,1,1)
                plot(-utrans(:,n),-d)% There's a conflict with the direction, if (-utrans) is used, the direction matches with the transverse direction in VMT
                ylim([-25 0])
                xlabel('Transverse velocity [cm/s]')
                ylabel('Depth[m]')
                title(['Section at distance ' sprintf('%i', n) ' m right from left bank' ])
                subplot(2,1,2)
                quiver(x,-d,-utrans(:,n),v,1); % There's a conflict with the direction, if (-utrans) is used, the direction matches with the transverse direction in VMT
                ylim([-25 0])
                ylabel('Depth[m]')
  end
            end
          