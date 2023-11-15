function ChargeBalance = funcADM1_ChargeBalanceDefinition

ChargeBalance.funcAcid   = @(KA, Acid, H) KA*Acid / (KA + H);
ChargeBalance.funcBase   = @(KA, Base, H)  H*Base / (KA + H);
ChargeBalance.funcZero   = @(H, S, P)   S.cat + H ...
                         - S.an  - P.KA.W/H         ...
                         + ChargeBalance.funcBase(P.KA.NH4, S.IN,  H) ...
                          - ChargeBalance.funcAcid(P.KA.IC,  S.IC,  H)       ... 
                          - ChargeBalance.funcAcid(P.KA.ac,  S.ac,  H) / 64  ...
                          - ChargeBalance.funcAcid(P.KA.pro, S.pro, H) / 112 ...
                          - ChargeBalance.funcAcid(P.KA.bu,  S.bu,  H) / 160 ...
                          - ChargeBalance.funcAcid(P.KA.va,  S.va,  H) / 208;
