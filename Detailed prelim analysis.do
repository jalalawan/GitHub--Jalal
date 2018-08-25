
*Section 3 - Data Analysis*
xtset
xttab year
xtdes
*sort by emiscode year, if any year has missing unique school id, drop corresponding observation to have a strongly balanced dataset
sort emiscode year
by emiscode: egen nonmissing1to4 = count(year) if (year==2004 | year==2005 | year==2006| year==2007)
drop if nonmissing1to4 <4
*check balance
xtset
tab school_type
*drop all schools other than 0 or 1*
 drop if school_type==2
 drop if school_type==3
 drop if school_type==4
 drop if school_type==5
 drop if school_type==6
 drop if school_type==7
 
 tab school_type
 
 *2a*
 
foreach var of varlist tot* {
di "`var'"
ttest `var', by(school_type)
}

*2b*

foreach var of varlist boys* {
di "`var'"
ttest `var', by(school_type)
}

*3*

reg sc_funds_from_govt drink_water toilets boundary_wall computer sports library main_gate sewerage electricity play_ground
lvr2plot
logit sc_funds_from_govt drink_water toilets boundary_wall computer sports library main_gate sewerage electricity play_ground
*to evaluate Logit Goodness-of-Fit, I need Idev package*
search Idev
Idev
*^ could not run this!*
*The prtab command computes a table of predicted values for specified values of the independent variables listed in the model. Other independent variables are held constant at their mean by default. “*
prtab

*4a*
egen tot_enrollment = rowtotal(tot_enr_*)
reg tot_enrollment drink_water toilets boundary_wall computer sports library main_gate sewerage electricity play_ground
. reg tot_enrollment drink_water toilets boundary_wall computer sports library main_gate sewerage electricity play_ground dist_id est_year
