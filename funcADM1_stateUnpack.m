function [S, X] = funcADM1_stateUnpack(Y)
S.su  = Y(1);
S.aa  = Y(2);
S.fa  = Y(3);
S.va  = Y(4);
S.bu  = Y(5);
S.pro = Y(6);
S.ac  = Y(7);
S.h2  = Y(8);
S.ch4 = Y(9);
S.IC  = Y(10);
S.IN  = Y(11);
S.I   = Y(12);

X.c   = Y(13);
X.ch  = Y(14);
X.pr  = Y(15);
X.li  = Y(16);
X.su  = Y(17);
X.aa  = Y(18);
X.fa  = Y(19);
X.c4  = Y(20);
X.pro = Y(21);
X.ac  = Y(22);
X.h2  = Y(23);
X.I   = Y(24);

S.cat = Y(25);
S.an  = Y(26);

S.ch4g = Y(27);
S.co2g = Y(28);
S.h2g  = Y(29);