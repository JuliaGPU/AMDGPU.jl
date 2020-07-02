:g/# Skipping/d
:%s/ HSA_/ /
:%s/ hsa_/ /g
:g/const/g/_t /g/_s /d
:%s/_t::/::/
:%s/_s::/::/
:%s/_e::/::/
:%s/_s$//
:%s/_t$//
:%s/_e$//
:%s/::hsa_/::/
:%s/_t = / = /
:%s/ amd_/ AMD_/g
:%s/::amd_/::AMD_/g
:%s/ ext_/ EXT_/g
:%s/ven_amd/VenAMD/g
:g/@cenum /s/_\([a-z]\)/\u\1/g
:g/struct /s/_\([a-z]\)/\u\1/g
:%s/ venAmd/ VenAMD/
