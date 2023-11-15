%% ADM1: MAIN
clc
clear 

%% Prepare parameters and inputs from Excel file
% Ensure that the Excel file is closed before running the MATLAB code
filename = 'ADM1_input.xlsx';
[~,Input_DATA.Name] = xlsread(filename,'Inputs','A1:A29');
Input_DATA.U        = xlsread(filename,'Inputs','B1:B29');
Input_DATA.Yss      = xlsread(filename,'SteadyStateOutputs','B1:B30');
[~,Param_DATA.Name] = xlsread(filename,'Parameters','A1:A102');
Param_DATA.Value    = xlsread(filename,'Parameters','B1:B102');

for k = 1 : 29
    eval(['IN.',Input_DATA.Name{k},' = ', num2str(Input_DATA.U(k)),';']);
    eval(['SS.',Input_DATA.Name{k},' = ', num2str(Input_DATA.Yss(k)),';']);
end
SS.pH = Input_DATA.Yss(end);


Parameters    = funcADM1_ParameterSpec(Param_DATA);
funcRate      = funcADM1_RateDefinition;                     % Rate = @(S, X, pH, Parameters)
ChargeBalance = funcADM1_ChargeBalanceDefinition;
[matStoich, compDescrp] = funcADM1_StoichMatrixConstruction(Parameters);

%% Adjust process parameters
Parameters.Process.Vl = 3000;


%% Simulate ADM1 using input data and parameters for 100 hrs
U  = Input_DATA.U;
Y0 = Input_DATA.Yss(1:29);
[t,Ymat] = ode23s(@(t,Y) funcADM1_ODE(Y, U, funcRate, matStoich, ChargeBalance, Parameters), ...
               [0 100], Y0);

%% Store results in useful structures
for k = 1 : length(t)
    [S, X] = funcADM1_stateUnpack(Ymat(k,:));
    time_series.pH(k)   = fzero(@(pH) ChargeBalance.funcZero(10.^-pH, S, Parameters), 7);
    time_series.Pgas(k) = Parameters.Amb.pH2O + S.ch4g*Parameters.Amb.R*Parameters.Amb.T/64 ...
                                              + S.co2g*Parameters.Amb.R*Parameters.Amb.T/1 ...
                                              + S.h2g *Parameters.Amb.R*Parameters.Amb.T/16;
    time_series.Qgas(k) = Parameters.Process.kp * (time_series.Pgas(k) - Parameters.Amb.P) * (time_series.Pgas(k)/Parameters.Amb.P);

    for l = 1 : 29
        eval(['time_series.',compDescrp{l},'(k) = ',compDescrp{l},';']);
    end
end

%% Store final steady state results
[S, X] = funcADM1_stateUnpack(Ymat(k,:));
final.pH   = fzero(@(pH) ChargeBalance.funcZero(10.^-pH, S, Parameters), 7);
final.Pgas = Parameters.Amb.pH2O + S.ch4g*Parameters.Amb.R*Parameters.Amb.T/64 ...
                                    + S.co2g*Parameters.Amb.R*Parameters.Amb.T/1 ...
                                    + S.h2g *Parameters.Amb.R*Parameters.Amb.T/16;
final.Qgas = Parameters.Process.kp * (time_series.Pgas(k) - Parameters.Amb.P) * (time_series.Pgas(k)/Parameters.Amb.P);

for l = 1 : 29
    eval(['final',compDescrp{l},' = ',compDescrp{l},';']);
end

final.yCH4 =  (finalS.ch4g*Parameters.Amb.R*Parameters.Amb.T/64 / final.Pgas);
writetable(struct2table(final), 'MainResults.xlsx')
%%
subplot(4,3,1)
Ydescrp = 'S.su';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y) + 1e-6]);

subplot(4,3,2)
Ydescrp = 'X.c';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*(max(Y) + 1e-6)]);

subplot(4,3,3)
Ydescrp = 'X.ch';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);

subplot(4,3,4)
Ydescrp = 'X.su';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);

subplot(4,3,5)
Ydescrp = 'X.aa';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);

subplot(4,3,6)
Ydescrp = 'X.fa';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);

subplot(4,3,7)
Ydescrp = 'X.c4';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);

subplot(4,3,8)
Ydescrp = 'X.pro';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);

subplot(4,3,9)
Ydescrp = 'X.ac';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);

subplot(4,3,10)
Ydescrp = 'S.IC';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);

subplot(4,3,11)
Ydescrp = 'X.ac';
eval(['Y = time_series.',Ydescrp,';']);
eval(['Yss = SS.',Ydescrp,';']);
plot(t, Y, t, 0*t + Yss, 'k--'); ylabel(Ydescrp); xlabel('Time (d)');
axis([0 t(end) 0 1.1*max(Y)]);


subplot(4,3,12)
plot(t, time_series.pH, t, 0*t + SS.pH, 'k--'); ylabel('pH'); xlabel('Time (d)');

%%
% clf
% plot(t, time_series.X.su, ...
%      t, time_series.X.aa, ...
%      t, time_series.X.fa, ...
%      t, time_series.X.c4, ...
%      t, time_series.X.pro, ...
%      t, time_series.X.ac, ...
%      t, time_series.X.h2)
%  legend('su','aa','fa','c4','pro','ac','h2')