function Parameters = funcADM1_ParameterSpec(Param_DATA)
% ADM1: Parameter specifications
% Based on those specified in:
% http://iwa-mia.org/wp-content/uploads/2018/01/BSM_TG_Tech_Report_no_3_BSM2_General_Description.pdf

for i = 1 : 102
    eval([Param_DATA.Name{i},' = ', num2str(Param_DATA.Value(i)),';']);
end

%     su      aa    fa      va     bu     pro     ac      h2;  ch4;    IC;  IN;  I
Ci = [0.0313; 0.03; 0.0217; 0.024; 0.025; 0.0268; 0.0313; 0;   0.0156; 0;   0;   0.03; ...
...   Xc       Xch     Xpr   Xli    Xsu - Xh2         XI
      0.02786; 0.0313; 0.03; 0.022; 0.0313*ones(7,1); 0.03];

% Create structure
Parameters.f = f;     Parameters.Y = Y;   Parameters.N = N;   
Parameters.Ci = Ci;

Parameters.k = k; 
Parameters.su = su;   Parameters.aa = aa; Parameters.fa = fa; 
Parameters.va = va;   Parameters.bu = bu; Parameters.pro = pro; 
Parameters.ac = ac;   Parameters.h2 = h2;

Parameters.KA = KA;   Parameters.KH = KH;
Parameters.Amb = Amb; Parameters.Process = Process;
