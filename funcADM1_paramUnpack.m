function [f, Y, N, Ci, Process, k, su, aa, fa, va, bu, pro, ac, h2, KA, KH, Amb] = funcADM1_paramUnpack(Parameters)

f  = Parameters.f; Y  = Parameters.Y; N  = Parameters.N;
Ci = Parameters.Ci;

k  = Parameters.k;

su  = Parameters.su;  aa  = Parameters.aa;  fa  = Parameters.fa;
va  = Parameters.va;  bu  = Parameters.bu;  pro = Parameters.pro; 
ac  = Parameters.ac;  h2  = Parameters.h2;

KA = Parameters.KA;     KH = Parameters.KH;
Amb = Parameters.Amb;   Process = Parameters.Process;