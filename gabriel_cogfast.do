*******GENERALIZED LINEAR MODELS OF OUTCOMES UP TO FIVE YEARS AMONG STROKE SURVIVORS IN ABEOKUTA AND IBADAN by Ogunde Gabriel******
drop age_grp
recode base_age (35/50=1 "<50 yrs") (50/59=2 "50-59 yrs") (60/69=3 "60-69 yrs") (70/95=4 ">=70 yrs"), gen(age_grp)

drop education
recode eduyrs_R (0=1 "No formal") (1/6=2 "Primary") (7/12=3 "Secondary") (13/20=4 "Tertiary"), gen(education)

gen occupation_r=0 if occupation=="Unemployed" | occupation== "Pensioner" | occupation== "Housewife"
replace occupation_r=1 if occupation== "Artisan"
replace occupation_r=2 if occupation== "Professional" | occupation== "Civil Servants" | occupation== "Office worker" 
replace occupation_r=3 if occupation== "Farmer" | occupation== "Unskilled labourer" | occupation== "Trading"
replace occupation_r=4 if occupation== "Others"
label define occupation_r 0 "Not working" 1 "Artisan" 2 "Professional/Civil servant" 3 "Trading/Unskilled" 4 "Others"
label value occupation_r occupation_r

gen ethnicity_r=1 if ethnicity=="EDO", after(ethnicity)
replace ethnicity_r=1 if ethnicity=="IGBO"
replace ethnicity_r=0 if ethnicity=="YORUBA"
replace ethnicity_r=1 if ethnicity_r==.
label define ethnicity_r 1 "Non-Yoruba"  0 "Yoruba"
label value ethnicity_r ethnicity_r

gen income_r=1 if income=="10,000-25,000", after(income)
replace income_r=2 if income=="100,001-150,000"
replace income_r=3 if income=="25,001-50,000"
replace income_r=4 if income=="50,001-100,000"
replace income_r=5 if income=="< = 10,000"
replace income_r=6 if income==">150,000"
label define income_r 1 "10,000-25,000" 2 "100,001-150,000" 3 "25,001-50,000" 4 "50,001-100,000" 5 "<=10,000" 6 ">150,000"
label value income_r income_r

gen living_r=1 if living=="Lives alone", after(living)
replace living_r=2 if living=="Lives with spouse"
replace living_r=2 if living=="Lives with spouse and children"
replace living_r=3 if living=="Lives with extended family"
label define living_r 1 "Lives alone" 2 "Lives with spouse/spouse and children" 3 "Lives with extended family"
label value living_r living_r

gen prevstroke_r=1 if prev_stroke=="Yes"
replace prevstroke_r=0 if prev_strok=="No"
label define prevstroke_r 0 "No" 1 "Yes"
label value prevstroke_r prevstroke_r

gen strokesub_r=1 if stroke_sub=="Ischaemic", after(stroke_sub)
replace strokesub_r=2 if stroke_sub=="Heamorrhagic"
replace strokesub_r=2 if stroke_sub=="Haemorrhagic infarct"
replace strokesub_r=1 if stroke_sub=="Ischaemic & Haemorrhagic"
label define strokesub_r 1 "Ischemic" 2 "Haemorrhagic"
label value strokesub_r strokesub_r

destring bmi, force gen(bmi_r)
recode bmi_r (0/30=0 "<=30") (30.01/max=1 ">30"), gen(obesity)
gen alcohol_r=0 if alcohol=="Never used alcohol", after(alcohol)
replace alcohol_r=1 if alcohol_r==. & alcohol!=""
label define alcohol_r 0 "No" 1 "Yes"
label value alcohol_r alcohol_r

gen smoking_r=0 if smoking=="Never"
replace smoking_r=1 if smoking_r==. & smoking!=""
label define smoking_r 0 "No" 1 "Yes"
label value smoking_r smoking_r

gen uncontrolled_bp=1 if avg_sysbp>140 | avg_diabp>90
replace uncontrolled_bp=0 if uncontrolled_bp==. & ( avg_sysbp!=. & avg_diabp!=.)
ta uncontrolled_bp if visit_no==1

gen cog_exe=1 if aft<2  | vrt<1
replace cog_exe=0 if cog_exe==. & (aft!=. | vrt!=.)
label define cog_exe 0 "No" 1 "Yes"
label value cog_exe cog_exe

recode bnt  (7/15=0 "No") (0/6=1 "Yes"), gen(cog_lang)

gen cog_memory=1 if wll<11 | rsd_total<2 | rwl_1<2
replace cog_memory=0 if cog_memory==. & wll!=.
label define cog_memory 0 "No" 1 "Yes"
label value cog_memory cog_memory

gen token=mtt_1 + mtt_2
gen cog_visuo=1 if token<17 | sd_total<9
replace cog_visuo=0 if cog_visuo==. & sd_total!=.
label define cog_visuo 0 "No" 1 "Yes"
label value cog_visuo cog_visuo

gen cognition=1 if cog_exe==1 | cog_lang==1 | cog_memory==1 | cog_visuo==1
replace cognition=0 if cognition==. & cog_exe!=.
label define cognition 0 "Normal" 1 "Impaired"
label value cognition cognition

recode barthel_R (1=1 "Dependent") (2=0 "Independent"), gen(func_dep)
******TABLE 1: Socio-demographic xteristics****
sum base_age if visit_no==1
tab1 age_grp centre gender_R education occupation_r domicile_R maritalstatus_R ethnicity_r income_r living_r if visit_no==1

*****TABLE 1.1: Clinical profile of respondents*******
tab1 prevstroke_r strokesub_r severity obesity alcohol_r smoking_r uncontrolled_bpif visit_no==1
sum avg_sysbp avg_diabp if visit_no==1

********Table 2: Background characteristics of participants whose living status was ascertained compared to those whose living status could not be confirmed****
tab age_grp follow_status if visit_no==1, col chi2
tab centre follow_status if visit_no==1, col chi2
tab gender_R follow_status if visit_no==1, col chi2
tab education follow_status if visit_no==1, col chi2
tab occupation_r follow_status if visit_no==1, col chi2
tab domicile_R follow_status if visit_no==1, col chi2
tab maritalstatus_R follow_status if visit_no==1, col chi2
tab ethnicity_r follow_status if visit_no==1, col chi2
tab income_r follow_status if visit_no==1, col chi2
tab living_r follow_status if visit_no==1, col chi2
tab prevstroke_r follow_status if visit_no==1, col chi2
tab strokesub_r follow_status if visit_no==1, col chi2
tab severity follow_status if visit_no==1, col chi2
tab obesity follow_status if visit_no==1, col chi2
tab alcohol_r follow_status if visit_no==1, col chi2
tab smoking_r follow_status if visit_no==1, col chi2
tab uncontrolled_bp follow_status if visit_no==1, col chi2

*******TABLE 3: Trajectory of Outcomes*******
gen tte=date_diff if date_diff<=63, after (date_diff)
replace tte=63 if date_diff>63

gen liv_stat=0 if living_status2==1, after(living_status)
replace liv_stat=1 if living_status2==0
replace liv_stat=1 if living_status2==2
label define liv_stat 0 "Alive" 1 "Dead"
label value liv_stat liv_stat

recode csi_total (0/6=0 "Low stress") (7/12=1 "High stress"), gen(caregiver_burden)

gen gds_total= gds1+ gds2+ gds3+ gds4
recode gds_total (0=0 "No") (1/4=1 "Yes"), gen(depression)

duplicates drop studyid, force
stset tte, failure(liv_stat==1)

sts graph
sts graph, xlabel (0 12 24 36 48)
sts graph, by(centre) xlabel (0 12 24 36 48)
sts graph, by(cognition) xlabel (0 12 24 36 48)
sts graph, by(depression) xlabel (0 12 24 36 48)
sts list, failure 

streg i.age_grp, distribution(weibull) level(90) nolog
streg i.centre, distribution(weibull) level(90) nolog
streg i.gender_R, distribution(weibull) level(90) nolog
streg i.domicile_R, distribution(weibull) level(90) nolog
streg i.education, distribution(weibull) level(90) nolog
streg i.maritalstatus_R, distribution(weibull) level(90) nolog
streg ib2.occupation_r, distribution(weibull) level(90) nolog
streg ib1.ethnicity_r, distribution(weibull) level(90) nolog
streg ib5.income_r, distribution(weibull) level(90) nolog
streg i.living_r, distribution(weibull) level(90) nolog
streg ib3.severity, distribution(weibull) level(90) nolog
streg i.prevstroke_r, distribution(weibull) level(90) nolog
streg i.obesity, distribution(weibull) level(90) nolog
streg i.alcohol_r, distribution(weibull) level(90) nolog
streg i.smoking_r, distribution(weibull) level(90) nolog
streg i.cognition, distribution(weibull) level(90) nolog
streg i.barthel_R, distribution(weibull) level(90) nolog
streg i.depression, distribution(weibull) level(90) nolog

streg i.centre ib2.occupation_r i.ethnicity_r i.living_r , distribution(weibull) level(90) nolog

xtset studyid
xtgee func_dep i.age_grp, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.centre, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.gender_R, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.domicile_R, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.education, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.maritalstatus_R, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep ib2.occupation_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep ib1.ethnicity_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep ib5.income_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.living_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep ib3.severity, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.prevstroke_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.obesity, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.alcohol_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.smoking_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.cognition, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee func_dep i.depression, family(binomial) link(logit) corr(exchangeable) eform nolog


xtset studyid
xtgee cognition i.age_grp, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.centre, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.gender_R, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.domicile_R, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.education, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.maritalstatus_R, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition ib2.occupation_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition ib1.ethnicity_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition ib5.income_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.living_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition ib3.severity, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.prevstroke_r, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.obesity, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition i.depression, family(binomial) link(logit) corr(exchangeable) eform nolog
xtgee cognition burden, family(binomial) link(logit) corr(exchangeable) eform nolog


xtgee cognition i.age_grp i.gender_R i.education i.maritalstatus_R ib2.occupation_r ib5.income_r ib3.severity i.prevstroke_r  burden, family(binomial) link(logit) corr(exchangeable) eform nolog

xtset studyid
mixed burden i.age_grp ||centre: ||studyid:
mixed burden i.centre ||centre: ||studyid:
mixed burden i.gender_R ||centre: ||studyid:
mixed burden i.domicile_R ||centre: ||studyid:
mixed burden i.education ||centre: ||studyid:
mixed burden i.maritalstatus_R ||centre: ||studyid:
mixed burden ib2.occupation_r ||centre: ||studyid:
mixed burden ib1.ethnicity_r ||centre: ||studyid:
mixed burden ib5.income_r ||centre: ||studyid:
mixed burden i.living_r ||centre: ||studyid:
mixed burden ib3.severity ||centre: ||studyid:
mixed burden i.prevstroke_r ||centre: ||studyid:
mixed burden i.obesity ||centre: ||studyid:
mixed burden i.depression ||centre: ||studyid:
mixed burden i.cognition ||centre: ||studyid:

mixed burden i.age_grp i.education ib3.severity i.prevstroke_r i.depression i.cognition ||centre: ||studyid:








tab cog_exe visit_no, col
tab cog_lang visit_no, col
tab cog_memory visit_no, col
tab cog_visuo visit_no, col
tab cognition visit_no, col


