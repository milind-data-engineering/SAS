/* Step 1: Data Cleaning - Filter the data */

	data nyc_all_s1;
	set nyc_all;
	if sale_price>999 and total_units>0 and gross_square_feet>0 and land_square_feet>0;
	gross_squr= input(gross_square_feet,best.);
  	land_squr=input(land_square_feet,best.);
	run;

/* Step 2 : Keep the required fields of the entire dataset */

	data nyc_all_s2;
	keep borough zip_code total_units land_squr gross_squr sale_price;
	set nyc_all_s1;
	run;

/* Step 3: Filter data for borough 1 */ 

	data nyc_all_s2_b1;
	set nyc_all_s2;
	if borough=1;
	run;

/* Step 4: Apply Mutiple Regression on the dependent variable to verify outliers */

	proc reg data = nyc_all_s2_b1;
	    model Sale_price = total_units gross_squr land_squr / dwProb VIF selection=stepwise; 
	run;

/* Step 5: Apply univariate analysis to identify and remove outliers */

	proc univariate data = nyc_all_s2_b1 ;
	var Sale_price total_units gross_squr land_squr;
	HISTOGRAM / NORMAL (COLOR=RED);
	run;

/* Step 6: Removing Outliers from dataset */

data nyc_all_s2_del_b1;
	set nyc_all_s2_b1;
	if land_squr > 66825 then delete;
	if gross_squr > 555954 then delete;

	keep borough zip_code total_units land_squr gross_squr sale_price;
	
run;

/* Step 7: Dummy Variable concept*/ 

data nyc_all_bor_1;
	set nyc_all_s2_del_b1;
if zip_code=10001  then ZipCode_1=1;
   		else ZipCode_1=0;
	if zip_code=10002  then ZipCode_2=1;
   		else ZipCode_2=0;
	if zip_code=10003  then ZipCode_3=1;
   		else ZipCode_3=0;
	if zip_code=10004  then ZipCode_4=1;
   		else ZipCode_4=0;
	if zip_code=10005  then ZipCode_5=1;
   		else ZipCode_5=0;
	if zip_code=10006  then ZipCode_6=1;
   		else ZipCode_6=0;
	if zip_code=10007  then ZipCode_7=1;
   		else ZipCode_7=0;
	if zip_code=10009  then ZipCode_8=1;
   		else ZipCode_8=0;
	if zip_code=10010  then ZipCode_9=1;
   		else ZipCode_9=0;
	if zip_code=10011  then ZipCode_10=1;
   		else ZipCode_10=0;
	if zip_code=10012  then ZipCode_11=1;
   		else ZipCode_11=0;
	if zip_code=10013  then ZipCode_12=1;
   		else ZipCode_12=0;
	if zip_code=10014  then ZipCode_13=1;
   		else ZipCode_13=0;
	if zip_code=10016  then ZipCode_14=1;
   		else ZipCode_14=0;
	if zip_code=10017  then ZipCode_15=1;
   		else ZipCode_15=0;
	if zip_code=10018  then ZipCode_16=1;
   		else ZipCode_16=0;
	if zip_code=10019  then ZipCode_17=1;
   		else ZipCode_17=0;
	if zip_code=10021  then ZipCode_18=1;
   		else ZipCode_18=0;
	if zip_code=10022  then ZipCode_19=1;
   		else ZipCode_19=0;
	if zip_code=10023  then ZipCode_20=1;
   		else ZipCode_20=0;
	if zip_code=10024  then ZipCode_21=1;
   		else ZipCode_21=0;
	if zip_code=10025  then ZipCode_22=1;
   		else ZipCode_22=0;
	if zip_code=10026  then ZipCode_23=1;
   		else ZipCode_23=0;
	if zip_code=10027 then ZipCode_24=1;
  		else ZipCode_24=0;
	if zip_code=10028 then ZipCode_25=1;
   		else ZipCode_25=0;
	if zip_code=10029 then ZipCode_26=1;
   		else ZipCode_26=0;
	if zip_code=10030 then ZipCode_27=1;
   		else ZipCode_27=0;
	if zip_code=10031 then ZipCode_28=1;
   		else ZipCode_28=0;
	if zip_code=10032 then ZipCode_29=1;
   		else ZipCode_29=0;
	if zip_code=10033 then ZipCode_30=1;
   		else ZipCode_30=0;
	if zip_code=10034 then ZipCode_31=1;
   		else ZipCode_31=0;
	if zip_code=10035 then ZipCode_32=1;
   		else ZipCode_32=0;
	if zip_code=10036 then ZipCode_33=1;
   		else ZipCode_33=0;
	if zip_code=10037 then ZipCode_34=1;
   		else ZipCode_34=0;
	if zip_code=10039 then ZipCode_35=1;
   		else ZipCode_35=0;
	if zip_code=10040 then ZipCode_36=1;
   		else ZipCode_36=0;
	if zip_code=10040 then ZipCode_37=1;
   		else ZipCode_37=0;
	if zip_code=10044 then ZipCode_38=1;
   		else ZipCode_38=0;
	if zip_code=10065 then ZipCode_39=1;
   		else ZipCode_39=0;
	if zip_code=10069 then ZipCode_40=1;
   		else ZipCode_40=0;
	if zip_code=10075 then ZipCode_41=1;
   		else ZipCode_41=0;
	if zip_code=10105 then ZipCode_42=1;
   		else ZipCode_42=0;
	if zip_code=10128 then ZipCode_43=1;
   		else ZipCode_43=0;
	if zip_code=10167 then ZipCode_44=1;
   		else ZipCode_44=0;
	if zip_code=10280 then ZipCode_44=1;
   		else ZipCode_44=0;
	if zip_code=10282 then ZipCode_45=1;
   		else ZipCode_45=0;
	if zip_code=10463 then ZipCode_46=1;
   		else ZipCode_46=0;
run;

/* Step 8: Sort the data as per zipcode */

proc sort data=nyc_all_bor_1;
	by zip_code;
run;

/* Step 9: Applying mutiple regression on the selected variables*/

proc reg data=nyc_all_bor_1;

	model sale_price= total_units gross_squr land_squr Zipcode_1 --Zipcode_46 /VIF selection=stepwise slentry=0.05;;

run;

/* Step 10: Applying Multiple Regression on the selected variables which have a variance deviation of less than 5%*/

proc reg data=nyc_all_bor_1_pca PLOTS(MAXPOINTS=10000 );

	model sale_price= gross_squr zipcode_1 zipcode_4 zipcode_5 zipcode_6 zipcode_9 zipcode_17 zipcode_34;
	
run;
