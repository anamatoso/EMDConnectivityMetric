function [M_memd] = performmemd(Mpatients,minimf)

M_memd=Mpatients;
[n_patients, ~]=size(M_memd);
[~,n_signals]=size(M_memd{1});
f = waitbar(0,"Starting calculating and saving the IMFs...");
for p=1:n_patients
    m=memdalt(M_memd{p},minimf); % minimum number of IMFs=8
    for i=1:n_signals
        M_memd{p,i+1}= (squeeze(m(i,:,:)))';
    end
    waitbar(p/n_patients,f);
end
close(f)
% check if minimum number of IMFs corresponds to the one above
realminimf=inf;%=4
for p=1:n_patients
        [~,mi]=size(M_memd{p,2});
        if mi<realminimf
            realminimf=mi;
        end
end

if realminimf==minimf
    disp("Minimum IMF was achieved")
    
else
    disp("Minimum IMF was not achieved. Minimum number of IMFs is "+realminimf +".")
end

end