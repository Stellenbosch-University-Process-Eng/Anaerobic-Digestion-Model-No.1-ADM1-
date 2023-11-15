function dYdt = funcADM1_ODE(Y, U, funcRate, matStoich, ChargeBalance, Parameters)
% U is the input vector. It has the same form as Y
[S, X] = funcADM1_stateUnpack(Y);

pH = fzero(@(pH) ChargeBalance.funcZero(10.^-pH, S, Parameters), 7);
%pH = 7.27;
Pgas = Parameters.Amb.pH2O + S.ch4g*Parameters.Amb.R*Parameters.Amb.T/64 ...
                           + S.co2g*Parameters.Amb.R*Parameters.Amb.T/1 ...
                           + S.h2g *Parameters.Amb.R*Parameters.Amb.T/16;
Qgas = Parameters.Process.kp * (Pgas - Parameters.Amb.P) * (Pgas/Parameters.Amb.P);

In           = Parameters.Process.Q * U        / Parameters.Process.Vl;
Out(1:26,:)  = Parameters.Process.Q * Y(1:26)  / Parameters.Process.Vl;
Out(27:29,:) =                 Qgas * Y(27:29) / Parameters.Process.Vg;
Generation = matStoich * funcRate(S, X, pH, Parameters);
dYdt = In - Out + Generation;
