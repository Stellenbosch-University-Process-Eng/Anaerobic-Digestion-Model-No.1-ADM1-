function [final, finalS, finalX] = funcADM1(Input_DATA, Param_DATA)

%%
Parameters    = funcADM1_ParameterSpec(Param_DATA);
funcRate      = funcADM1_RateDefinition;                     % Rate = @(S, X, pH, Parameters)
ChargeBalance = funcADM1_ChargeBalanceDefinition;
[matStoich, compDescrp] = funcADM1_StoichMatrixConstruction(Parameters);

%%
U  = Input_DATA.U;
Y0 = Input_DATA.Yss(1:29);
[~,Ymat] = ode23s(@(t,Y) funcADM1_ODE(Y, U, funcRate, matStoich, ChargeBalance, Parameters), ...
               [0 100], Y0);

%% Store final steady state results
[S, X] = funcADM1_stateUnpack(Ymat(end,:));
final.pH   = fzero(@(pH) ChargeBalance.funcZero(10.^-pH, S, Parameters), 7);
final.Pgas = Parameters.Amb.pH2O + S.ch4g*Parameters.Amb.R*Parameters.Amb.T/64 ...
                                    + S.co2g*Parameters.Amb.R*Parameters.Amb.T/1 ...
                                    + S.h2g *Parameters.Amb.R*Parameters.Amb.T/16;
final.Qgas = Parameters.Process.kp * (final.Pgas - Parameters.Amb.P) * (final.Pgas/Parameters.Amb.P);

for l = 1 : 29
    eval(['final',compDescrp{l},' = ',compDescrp{l},';']);
end

final.yCH4 =  (finalS.ch4g*Parameters.Amb.R*Parameters.Amb.T/64 / final.Pgas);