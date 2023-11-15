function [matStoich, dscrp] = funcADM1_StoichMatrixConstruction(Parameters)
% ADM1: Creation of rate coefficient matrix
[f, Y, N, Ci, Process] = funcADM1_paramUnpack(Parameters);

k = 1; dscrp{k} = 'S.su';
S.su.j = [2; 4; 5];                 S.su.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.su.v = [1; 1-f.fa.li; -1];

k = 2; dscrp{k} = 'S.aa';
S.aa.j = [3; 6];                    S.aa.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.aa.v = [1; -1];

k = 3; dscrp{k} = 'S.fa';
S.fa.j = [4; 7];                    S.fa.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.fa.v = [f.fa.li; -1];

k = 4; dscrp{k} = 'S.va';
S.va.j = [6; 8];                    S.va.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.va.v = [(1-Y.aa)*f.va.aa; -1];

k = 5; dscrp{k} = 'S.bu';
S.bu.j = [5; 6; 9];                 S.bu.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.bu.v = [(1-Y.su)*f.bu.su; (1-Y.aa)*f.bu.aa; -1];

k = 6; dscrp{k} = 'S.pro';
S.pro.j = [5; 6; 8; 10];            S.pro.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.pro.v = [(1-Y.su)*f.pro.su; (1-Y.aa)*f.pro.aa; (1-Y.c4)*0.54; -1];

k = 7; dscrp{k} = 'S.ac';
S.ac.j = [5; 6; 7; 8; 9; 10; 11];   S.ac.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.ac.v = [(1-Y.su)*f.ac.su; (1-Y.aa)*f.ac.aa; (1-Y.fa)*0.7; (1-Y.c4)*0.31; (1-Y.c4)*0.8; (1-Y.pro)*0.57; -1];

k = 8; dscrp{k} = 'S.h2';
S.h2.j = [5; 6; 7; 8; 9; 10; 12; 22]; S.h2.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.h2.v = [(1-Y.su)*f.h2.su; (1-Y.aa)*f.h2.aa; (1-Y.fa)*0.3; (1-Y.c4)*0.15; (1-Y.c4)*0.2; (1-Y.pro)*0.43; -1; -1];

k = 9; dscrp{k} = 'S.ch4';
S.ch4.j = [11; 12; 20];               S.ch4.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.ch4.v = [(1-Y.ac); (1-Y.h2); -1];

% Component 10 = IC = inorganic carbon, calculation done right at the end

k = 11; dscrp{k} = 'S.IN';
S.IN.j = [1; 5; 6; 7; 8; 9; 10; 11; 12];  S.IN.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.IN.v = [N.xc; -Y.su*N.bac; N.aa-Y.aa*N.bac; -Y.fa*N.bac; -Y.c4*N.bac; -Y.c4*N.bac; -Y.pro*N.bac; -Y.ac*N.bac; -Y.h2*N.bac;];

k = 12; dscrp{k} = 'S.I';
S.I.j = 1;                          S.I.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.I.v = [f.sI.xc];

k = 13; dscrp{k} = 'X.c';
X.c.j = [1; (13:19).'];             X.c.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.c.v = [-1; ones(7,1)];

k = 14; dscrp{k} = 'X.ch';
X.ch.j = [1; 2];                    X.ch.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.ch.v = [f.ch.xc; -1];

k = 15; dscrp{k} = 'X.pr';
X.pr.j = [1; 3];                    X.pr.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.pr.v = [f.pr.xc; -1];

k = 16; dscrp{k} = 'X.li';
X.li.j = [1; 4];                    X.li.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.li.v = [f.li.xc; -1];

k = 17; dscrp{k} = 'X.su';
X.su.j = [5; 13];                   X.su.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.su.v = [Y.su; -1];

k = 18; dscrp{k} = 'X.aa';
X.aa.j = [6; 14];                   X.aa.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.aa.v = [Y.aa; -1];

k = 19; dscrp{k} = 'X.fa';
X.fa.j = [7; 15];                   X.fa.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.fa.v = [Y.fa; -1];

k = 20; dscrp{k} = 'X.c4';
X.c4.j = [8; 9; 16];                X.c4.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.c4.v = [Y.c4; Y.c4; -1];

k = 21; dscrp{k} = 'X.pro';
X.pro.j = [10; 17];                 X.pro.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.pro.v = [Y.pro; -1];

k = 22; dscrp{k} = 'X.ac';
X.ac.j = [11; 18];                  X.ac.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.ac.v = [Y.ac; -1];

k = 23; dscrp{k} = 'X.h2';
X.h2.j = [12; 19];                  X.h2.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.h2.v = [Y.h2; -1];

k = 24; dscrp{k} = 'X.I';
X.I.j = 1;                          X.I.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
X.I.v = [f.xI.xc];

k = 25; dscrp{k} = 'S.cat';
k = 26; dscrp{k} = 'S.an';

k = 27; dscrp{k} = 'S.ch4g';
S.ch4g.j = 20;                       S.ch4g.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.ch4g.v = Process.Vl/Process.Vg;

k = 28; dscrp{k} = 'S.co2g';
S.co2g.j = 21;                       S.co2g.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.co2g.v = Process.Vl/Process.Vg;

k = 29; dscrp{k} = 'S.h2g';
S.h2g.j = 22;                        S.h2g.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.h2g.v = Process.Vl/Process.Vg;


i = []; j = []; v = [];
for k = [(1:9) (11:24) (27:29)]
    i = [i; eval(['',dscrp{k},'.i'])];
    j = [j; eval(['',dscrp{k},'.j'])];
    v = [v; eval(['',dscrp{k},'.v'])];
end

matStoich = sparse(i, j, v, 29, 22);

k = 10; dscrp{k} = 'S.IC';
S.IC.j = [5; 6; 10; 11; 12; 21];        S.IC.i = k*ones(eval(['length(',dscrp{k},'.j)']), 1);
S.IC.v = [-(matStoich([(1:9) (11:24)], [5 6 10 11 12]) ).'*Ci([(1:9) (11:24)]); -1];

matStoich = matStoich + sparse(S.IC.i, S.IC.j, S.IC.v, 29, 22);

%Stoich.S = S; Stoich.X = X; Stoich.dscrp = dscrp; Stoich.Mat = Mat;