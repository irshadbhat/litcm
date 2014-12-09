# include this directive for wx2utf subroutine.
use Encode;

sub wx2iscii {
    $_=$_[0]; 
    my %hash = (
            "k"=>"\x{B3}",
            "K"=>"\x{B4}", 
            "g"=>"\x{B5}", 
            "G"=>"\x{B6}",
            "f"=>"\x{B7}",
            "c"=>"\x{B8}",
            "C"=>"\x{B9}",
            "j"=>"\x{BA}",
            "J"=>"\x{BB}",
            "F"=>"\x{BC}",
            "t"=>"\x{BD}",
            "T"=>"\x{BE}",
            "d"=>"\x{BF}",
            "D"=>"\x{C0}",
            "N"=>"\x{C1}",
            "w"=>"\x{C2}",
            "W"=>"\x{C3}",
            "x"=>"\x{C4}",
            "X"=>"\x{C5}",
            "n"=>"\x{C6}",
            "p"=>"\x{C8}",
            "P"=>"\x{C9}",
            "b"=>"\x{CA}",
            "B"=>"\x{CB}",
            "m"=>"\x{CC}",
            "y"=>"\x{CD}",
            "r"=>"\x{CF}",
            "l"=>"\x{D1}",
            "v"=>"\x{D4}",
            "S"=>"\x{D5}",
            "s"=>"\x{D7}",
            "R"=>"\x{D6}",
            "h"=>"\x{D8}",
            "_"=>"\x{E8}",	
            "Z"=>"\x{E9}",
            "."=>"\x{EA}",
            "Y"=>"\x{FB}",
            "lY"=>"\x{D2}",
            #Added for tamil wx to utf -Rashid
            "rY"=>"\x{D0}",
            "nY"=>"\x{C7}",
            "lYY"=>"\x{D3}",
    );
    my %hash_v = (
		"a"=>"\x{A4}",
		"A"=>"\x{A5}",
		"aA"=>"\x{A5}",
		"i"=>"\x{A6}",
		"ai"=>"\x{A6}",
		"I"=>"\x{A7}",
		"aI"=>"\x{A7}",
		"u"=>"\x{A8}",
		"au"=>"\x{A8}",
		"U"=>"\x{A9}",
		"aU"=>"\x{A9}",
		"q"=>"\x{AA}",
		"aq"=>"\x{AA}",
		"eV"=>"\x{AB}",
		"aeV"=>"\x{AB}",
		"e"=>"\x{AC}",
		"ae"=>"\x{AC}",
		"E"=>"\x{AD}",
		"aE"=>"\x{AD}",
		"EY"=>"\x{AE}",
		"aEY"=>"\x{AE}",
		"oV"=>"\x{AF}",
		"aoV"=>"\x{AF}",
		"o"=>"\x{B0}",
		"ao"=>"\x{B0}",
		"O"=>"\x{B1}",
		"aO"=>"\x{B1}",
		"OY"=>"\x{B2}",
		"aOY"=>"\x{B2}",
	);

    my %hash_m = (
		"A"=>"\x{DA}",
		"aA"=>"\x{DA}",
		"i"=>"\x{DB}",
		"ai"=>"\x{DB}",
		"I"=>"\x{DC}",
		"aI"=>"\x{DC}",
		"u"=>"\x{DD}",
		"au"=>"\x{DD}",
		"U"=>"\x{DE}",
		"aU"=>"\x{DE}",
		"q"=>"\x{DF}",
		"aq"=>"\x{DF}",
		"eV"=>"\x{E0}",
		"aeV"=>"\x{E0}",
		"e"=>"\x{E1}",
		"ae"=>"\x{E1}",
		"E"=>"\x{E2}",
		"aE"=>"\x{E2}",
		"EY"=>"\x{E3}",
		"aEY"=>"\x{E3}",
		"oV"=>"\x{E4}",
		"aoV"=>"\x{E4}",
		"o"=>"\x{E5}",
		"ao"=>"\x{E5}",
		"O"=>"\x{E6}",
		"aO"=>"\x{E6}",
		"OY"=>"\x{E7}",
		"aOY"=>"\x{E7}",
	);
	
	my %hash_mod = (
		"z"=>"\x{A1}",
		"M"=>"\x{A2}",
		"H"=>"\x{A3}",
	);

	
	$_=~s/k_ReV([MHz])/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{"eV"}$hash_mod{$1}/g;
	$_=~s/k_ReV/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{"eV"}/g;

	$_=~s/k_REY([MHz])/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{"EY"}$hash_mod{$1}/g;
	$_=~s/k_REY/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{"EY"}/g; 

	$_=~s/k_RoV([MHz])/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{"oV"}$hash_mod{$1}/g;
	$_=~s/k_RoV/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{"oV"}/g;		

	$_=~s/k_ROY([MHz])/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{"OY"}$hash_mod{$1}/g;
	$_=~s/k_ROY/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{"OY"}/g;		

	$_=~s/k_R([AiIuUoO])([MHz])/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{$1}$hash_mod{$1}/g;
	$_=~s/k_R([AiIuUoO])/$hash{"k"}$hash{"_"}$hash{"R"}$hash_m{$1}/g;		

	$_=~s/k_Ra([MHz])/$hash{"k"}$hash{"_"}$hash{"R"}$hash_mod{$1}/g;		
	$_=~s/k_Ra/$hash{"k"}$hash{"_"}$hash{"R"}/g;		
	$_=~s/k_R/$hash{"k"}$hash{"_"}$hash{"R"}$hash{"_"}/g;
	$_=~s/w_reV([MHz])/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{"eV"}$hash_mod{$1}/g;
	$_=~s/w_reV/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{"eV"}/g;		

	$_=~s/w_rEY([MHz])/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{"EY"}$hash_mod{$1}/g;
	$_=~s/w_rEY/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{"EY"}/g;		

	$_=~s/w_roV([MHz])/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{"oV"}$hash_mod{$1}/g;
	$_=~s/w_roV/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{"oV"}/g;		

	$_=~s/w_rOY([MHz])/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{"OY"}$hash_mod{$1}/g;
	$_=~s/w_rOY/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{"OY"}/g;		

	$_=~s/w_r([AiIuUeEoO])([MHz])/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{$1}$hash_mod{$2}/g;
	$_=~s/w_r([AiIuUeEoO])/$hash{"w"}$hash{"_"}$hash{"r"}$hash_m{$1}/g;	

	$_=~s/w_ra([MHz])/$hash{"w"}$hash{"_"}$hash{"r"}$hash_mod{$1}/g;		
	$_=~s/w_ra/$hash{"w"}$hash{"_"}$hash{"r"}/g;		
	$_=~s/w_r/$hash{"w"}$hash{"_"}$hash{"r"}$hash{"_"}/g;
	$_=~s/j_FeV([MHz])/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{"eV"}$hash_mod{$1}/g;
	$_=~s/j_FeV/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{"eV"}/g;		

	$_=~s/j_FEY([MHz])/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{"EY"}$hash_mod{$1}/g;
	$_=~s/j_FEY/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{"EY"}/g;		

	$_=~s/j_FoV([MHz])/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{"oV"}$hash_mod{$1}/g;
	$_=~s/j_FoV/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{"oV"}/g;		

	$_=~s/j_FOY([MHz])/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{"OY"}$hash_mod{$1}/g;
	$_=~s/j_FOY/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{"OY"}/g;		

	$_=~s/j_F([AiIuUeEoO])([MHz])/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{$1}$hash_mod{$2}/g;
	$_=~s/j_F([AiIuUeEoO])/$hash{"j"}$hash{"_"}$hash{"F"}$hash_m{$1}/g;		

	$_=~s/j_Fa([MHz])/$hash{"j"}$hash{"_"}$hash{"F"}$hash_mod{$1}/g;		
	$_=~s/j_Fa/$hash{"j"}$hash{"_"}$hash{"F"}/g;		
	$_=~s/j_F/$hash{"j"}$hash{"_"}$hash{"F"}$hash{"_"}/g;
	
	$_=~s/S_reV([MHz])/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{"eV"}$hash_mod{$1}/g;
	$_=~s/S_reV/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{"eV"}/g;		

	$_=~s/S_rEY([MHz])/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{"EY"}$hash_mod{$1}/g;
	$_=~s/S_rEY/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{"EY"}/g;		

	$_=~s/S_roV([MHz])/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{"oV"}$hash_mod{$1}/g;	
	$_=~s/S_roV/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{"oV"}/g;	

	$_=~s/S_rOY([MHz])/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{"OY"}$hash_mod{$1}/g;
	$_=~s/S_rOY/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{"OY"}/g;		

	$_=~s/S_r([AiIuUeEoO])([MHz])/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{$1}$hash_mod{$2}/g;
	$_=~s/S_r([AiIuUeEoO])/$hash{"S"}$hash{"_"}$hash{"r"}$hash_m{$1}/g;	

	$_=~s/S_ra([MHz])/$hash{"S"}$hash{"_"}$hash{"r"}$hash_mod{$1}/g;		
	$_=~s/S_ra/$hash{"S"}$hash{"_"}$hash{"r"}/g;		
	$_=~s/S_r/$hash{"S"}$hash{"_"}$hash{"r"}$hash{"_"}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])eV([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{"aeV"}$hash_mod{$4}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])eV/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{"aeV"}/g;

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])EY([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{"aEY"}$hash_mod{$4}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])EY/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{"aEY"}/g;
	
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])oV([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{"aoV"}$hash_mod{$4}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])oV/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{"aoV"}/g;

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])OY([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{"aOY"}$hash_mod{$4}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])OY/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{"aOY"}/g;

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([AiIuUeEoO])([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{$4}$hash_mod{$5}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([AiIuUeEoO])/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_m{$4}/g;

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])a([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash_mod{$4}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])a/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])/$hash{$1}$hash{"_"}$hash{$2}$hash{"_"}$hash{$3}$hash{"_"}/g;	
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])eV([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash_m{"eV"}$hash_mod{$3}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])eV/$hash{$1}$hash{"_"}$hash{$2}$hash_m{"eV"}/g;

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])EY([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash_m{"EY"}$hash_mod{$3}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])EY/$hash{$1}$hash{"_"}$hash{$2}$hash_m{"EY"}/g;

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])oV([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash_m{"oV"}$hash_mod{$3}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])oV/$hash{$1}$hash{"_"}$hash{$2}$hash_m{"oV"}/g;

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])OY([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash_m{"OY"}$hash_mod{$3}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])OY/$hash{$1}$hash{"_"}$hash{$2}$hash_m{"OY"}/g;


	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([AiIuUeEoO])([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash_m{$3}$hash_mod{$4}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([AiIuUeEoO])/$hash{$1}$hash{"_"}$hash{$2}$hash_m{$3}/g;
        #PAWAN March 12 for experiment to optimize the RE
	#$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh]){2})([AiIuUeEoO])/$hash{$1}$hash{"_"}$hash{$2}$hash_m{$3}/g;

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])a([MHz])/$hash{$1}$hash{"_"}$hash{$2}$hash_mod{$3}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])a/$hash{$1}$hash{"_"}$hash{$2}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])eV([MHz])/$hash{$1}$hash_m{"eV"}$hash_mod{$2}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])eV/$hash{$1}$hash_m{"eV"}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])EY([MHz])/$hash{$1}$hash_m{"EY"}$hash_mod{$2}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])EY/$hash{$1}$hash_m{"EY"}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])oV([MHz])/$hash{$1}$hash_m{"oV"}$hash_mod{$2}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])oV/$hash{$1}$hash_m{"oV"}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])OY([MHz])/$hash{$1}$hash_m{"OY"}$hash_mod{$2}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])OY/$hash{$1}$hash_m{"OY"}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])Z([AiIuUeEoO])([MHz])/$hash{$1}$hash{"Z"}$hash_m{$2}$hash_mod{$3}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])Z([AiIuUeEoO])/$hash{$1}$hash{"Z"}$hash_m{$2}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])Za([MHz])/$hash{$1}$hash{"Z"}$hash_mod{$3}/g;		

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])Za/$hash{$1}$hash{"Z"}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])Z/$hash{$1}$hash{"Z"}$hash{"_"}/g;#new added 19-july-10		

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])q([MHz])/$hash{$1}$hash_m{"q"}$hash_mod{$2}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])q/$hash{$1}$hash_m{"q"}/g;		

        #Added for the case Vowel(U090B)+Modifier
	$_=~s/(aq)([MHz])/$hash_v{$1}$hash_mod{$2}/g;	
	$_=~s/aq/$hash_v{"aq"}/g;
	$_=~s/q/$hash_v{"aq"}/g;

	#Added for the case lYYa,lYY[AiIuUeEoO],lYY[MHz]
	$_=~s/(lYY)eV([MHz])/$hash{$1}$hash_m{"eV"}$hash_mod{$2}/g;		
	$_=~s/(lYY)eV/$hash{$1}$hash_m{"eV"}/g;		
	$_=~s/(lYY)EY([MHz])/$hash{$1}$hash_m{"EY"}$hash_mod{$2}/g;		
	$_=~s/(lYY)EY/$hash{$1}$hash_m{"EY"}/g;		
	$_=~s/(lYY)oV([MHz])/$hash{$1}$hash_m{"oV"}$hash_mod{$2}/g;		
	$_=~s/(lYY)oV/$hash{$1}$hash_m{"oV"}/g;		
	$_=~s/(lYY)OY([MHz])/$hash{$1}$hash_m{"OY"}$hash_mod{$2}/g;		
	$_=~s/(lYY)OY/$hash{$1}$hash_m{"OY"}/g;		
	$_=~s/(lYY)([AiIuUeEoO])([MHz])/$hash{$1}$hash_m{$2}$hash_mod{$3}/g;	
	$_=~s/(lYY)([AiIuUeEoO])/$hash{$1}$hash_m{$2}/g;	
	$_=~s/(lYY)a([MHz])/$hash{$1}$hash_mod{$2}/g;	
	$_=~s/(lYY)a/$hash{$1}/g;	
	$_=~s/(lYY)/$hash{$1}$hash{"_"}/g;	

	#Added for the case lYa,lY[AiIuUeEoO],lY[MHz]
	$_=~s/(lY)eV([MHz])/$hash{$1}$hash_m{"eV"}$hash_mod{$2}/g;		
	$_=~s/(lY)eV/$hash{$1}$hash_m{"eV"}/g;		
	$_=~s/(lY)EY([MHz])/$hash{$1}$hash_m{"EY"}$hash_mod{$2}/g;		
	$_=~s/(lY)EY/$hash{$1}$hash_m{"EY"}/g;		
	$_=~s/(lY)oV([MHz])/$hash{$1}$hash_m{"oV"}$hash_mod{$2}/g;		
	$_=~s/(lY)oV/$hash{$1}$hash_m{"oV"}/g;		
	$_=~s/(lY)OY([MHz])/$hash{$1}$hash_m{"OY"}$hash_mod{$2}/g;		
	$_=~s/(lY)OY/$hash{$1}$hash_m{"OY"}/g;		
	$_=~s/(lY)([AiIuUeEoO])([MHz])/$hash{$1}$hash_m{$2}$hash_mod{$3}/g;	
	$_=~s/(lY)([AiIuUeEoO])/$hash{$1}$hash_m{$2}/g;	
	$_=~s/(lY)a([MHz])/$hash{$1}$hash_mod{$2}/g;	
	$_=~s/(lY)a/$hash{$1}/g;	
	$_=~s/(lY)/$hash{$1}$hash{"_"}/g;	

        #Added for tamil -by Rashid
	$_=~s/(nY)eV([MHz])/$hash{$1}$hash_m{"eV"}$hash_mod{$2}/g;		
	$_=~s/(nY)eV/$hash{$1}$hash_m{"eV"}/g;		
	$_=~s/(nY)EY([MHz])/$hash{$1}$hash_m{"EY"}$hash_mod{$2}/g;		
	$_=~s/(nY)EY/$hash{$1}$hash_m{"EY"}/g;		
	$_=~s/(nY)oV([MHz])/$hash{$1}$hash_m{"oV"}$hash_mod{$2}/g;		
	$_=~s/(nY)oV/$hash{$1}$hash_m{"oV"}/g;		
	$_=~s/(nY)OY([MHz])/$hash{$1}$hash_m{"OY"}$hash_mod{$2}/g;		
	$_=~s/(nY)OY/$hash{$1}$hash_m{"OY"}/g;		
	$_=~s/(nY)([AiIuUeEoO])([MHz])/$hash{$1}$hash_m{$2}$hash_mod{$3}/g;	
	$_=~s/(nY)([AiIuUeEoO])/$hash{$1}$hash_m{$2}/g;	
	$_=~s/(nY)a([MHz])/$hash{$1}$hash_mod{$2}/g;	
	$_=~s/(nY)a/$hash{$1}/g;	
	$_=~s/(nY)/$hash{$1}$hash{"_"}/g;	

        #Added for tamil -by Rashid
	$_=~s/(rY)eV([MHz])/$hash{$1}$hash_m{"eV"}$hash_mod{$2}/g;		
	$_=~s/(rY)eV/$hash{$1}$hash_m{"eV"}/g;		
	$_=~s/(rY)EY([MHz])/$hash{$1}$hash_m{"EY"}$hash_mod{$2}/g;		
	$_=~s/(rY)EY/$hash{$1}$hash_m{"EY"}/g;		
	$_=~s/(rY)oV([MHz])/$hash{$1}$hash_m{"oV"}$hash_mod{$2}/g;		
	$_=~s/(rY)oV/$hash{$1}$hash_m{"oV"}/g;		
	$_=~s/(rY)OY([MHz])/$hash{$1}$hash_m{"OY"}$hash_mod{$2}/g;		
	$_=~s/(rY)OY/$hash{$1}$hash_m{"OY"}/g;		
	$_=~s/(rY)([AiIuUeEoO])([MHz])/$hash{$1}$hash_m{$2}$hash_mod{$3}/g;	
	$_=~s/(rY)([AiIuUeEoO])/$hash{$1}$hash_m{$2}/g;	
	$_=~s/(rY)a([MHz])/$hash{$1}$hash_mod{$2}/g;	
	$_=~s/(rY)a/$hash{$1}/g;	
	$_=~s/(rY)/$hash{$1}$hash{"_"}/g;	

	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([AiIuUeEoO])([MHz])/$hash{$1}$hash_m{$2}$hash_mod{$3}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])([AiIuUeEoO])/$hash{$1}$hash_m{$2}/g;		
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])a([MHz])/$hash{$1}$hash_mod{$2}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])a/$hash{$1}/g;
	$_=~s/([kKgGfcCjJFtTdDNwWxXnpPbBmyrlvSsRh])/$hash{$1}$hash{"_"}/g;
	
	#Added for the case of U0946
	$_=~s/aeV([MHz])/$hash_v{"aeV"}$hash_mod{$1}/g;
	$_=~s/aeV/$hash_v{"aeV"}/g;
	$_=~s/eV([MHz])/$hash_v{"eV"}$hash_mod{$1}/g;
	$_=~s/eV/$hash_v{"eV"}/g;

	#Added for the case of U0945
	$_=~s/aEY([MHz])/$hash_v{"aEY"}$hash_mod{$1}/g;
	$_=~s/aEY/$hash_v{"aEY"}/g;
	$_=~s/EY([MHz])/$hash_v{"EY"}$hash_mod{$1}/g;
	$_=~s/EY/$hash_v{"EY"}/g;

	#Added for the case of U094A
	$_=~s/aoV([MHz])/$hash_v{"aoV"}$hash_mod{$1}/g;
	$_=~s/aoV/$hash_v{"aoV"}/g;
	$_=~s/oV([MHz])/$hash_v{"aoV"}$hash_mod{$1}/g;
	$_=~s/oV/$hash_v{"aoV"}/g;

	#Added for the case of U0949
	$_=~s/aOY([MHz])/$hash_v{"aOY"}$hash_mod{$1}/g;
	$_=~s/aOY/$hash_v{"aOY"}/g;
	$_=~s/OY([MHz])/$hash_v{"aOY"}$hash_mod{$1}/g;
	$_=~s/OY/$hash_v{"aOY"}/g;

	$_=~s/aA/$hash_v{"aA"}/g;
	$_=~s/ai/$hash_v{"ai"}/g;
	$_=~s/aI/$hash_v{"aI"}/g;
	$_=~s/au/$hash_v{"au"}/g;
	$_=~s/aU/$hash_v{"aU"}/g;
	$_=~s/ae/$hash_v{"ae"}/g;
	$_=~s/aE/$hash_v{"aE"}/g;
	$_=~s/ao/$hash_v{"ao"}/g;
	$_=~s/aO/$hash_v{"aO"}/g;

	$_=~s/([aAiIuUeEoO])([MHz])/$hash_v{$1}$hash_mod{$2}/g;
	$_=~s/([aAiIuUeEoO])/$hash_v{$1}/g;
	$_=~s/([\.])/$hash{$1}/g;
	return $_;
}		

sub iscii2unicode {
	my $string = $_[0];

	#print "LANG is: ", $_[1],"END";

	if ((lc($_[1]) eq "") || (lc($_[1]) eq "hin")) {
		$string = &iscii2unicode_hin($string);
	} elsif ($_[1] eq "tel") {
		$string = &iscii2unicode_tel($string);
	} elsif ($_[1] eq "ben") {
		$string = &iscii2unicode_ben($string);
	} elsif ($_[1] eq "kan") {
		$string = &iscii2unicode_kan($string);
	} elsif ($_[1] eq "pan") {
		$string = &iscii2unicode_pan($string);
	} elsif ($_[1] eq "mal") {
		$string = &iscii2unicode_mal($string);
	} elsif ($_[1] eq "tam") {
		$string = &iscii2unicode_tam($string);
	} elsif ($_[1] eq "ori") {
		$string = &iscii2unicode_ori($string);
	} else {
		$string = &iscii2unicode_hin($string);
	}

	return $string;
}

sub iscii2unicode_hin {
	my $string = $_[0];

	#print "ISCII INPUT String is: ", $string;

	my %hash = (
		"\x{A1}"=>"\x{0901}",	#Vowel-modifier CHANDRABINDU
		"\x{A2}"=>"\x{0902}",	#Vowel-modifier ANUSWAR
		"\x{A3}"=>"\x{0903}",	#Vowel-modifier VISARG
		"\x{A4}"=>"\x{0905}",	#Vowel A
		"\x{A5}"=>"\x{0906}",	#Vowel AA
		"\x{A6}"=>"\x{0907}",	#Vowel I
		"\x{A7}"=>"\x{0908}",	#Vowel II
		"\x{A8}"=>"\x{0909}",	#Vowel U
		"\x{A9}"=>"\x{090A}",	#Vowel UU
		"\x{AA}"=>"\x{090B}",	#Vowel RI
		"\x{AB}"=>"\x{090E}",	#Vowel E
		"\x{AC}"=>"\x{090F}",	#Vowel EY
		"\x{AD}"=>"\x{0910}",	#Vowel AI
		"\x{AE}"=>"\x{090D}",	#Vowel AI -Rashid added
		"\x{B2}"=>"\x{090D}",	#Vowel AYE (Devanagari Script)
		"\x{AF}"=>"\x{0912}",	#Vowel O
		"\x{B0}"=>"\x{0913}",	#Vowel OW
		"\x{B1}"=>"\x{0914}",	#Vowel AU
		"\x{B2}"=>"\x{0911}",	#Vowel AWE
		"\x{B3}"=>"\x{0915}",	#Consonant KA
		"\x{B4}"=>"\x{0916}",	#Consonant KHA
		"\x{B5}"=>"\x{0917}",	#Consonant GA
		"\x{B6}"=>"\x{0918}",	#Consonant GHA
		"\x{B7}"=>"\x{0919}",	#Consonant NGA
		"\x{B8}"=>"\x{091A}",	#Consonant CHA
		"\x{B9}"=>"\x{091B}",	#Consonant CHHA
		"\x{BA}"=>"\x{091C}",	#Consonant JA
		"\x{BB}"=>"\x{091D}",	#Consonant JHA
		"\x{BC}"=>"\x{091E}",	#Consonant JNA
		"\x{BD}"=>"\x{091F}",	#Consonant Hard TA
		"\x{BE}"=>"\x{0920}",	#Consonant Hard THA
		"\x{BF}"=>"\x{0921}",	#Consonant Hard DA
		"\x{C0}"=>"\x{0922}",	#Consonant Hard DHA
		"\x{C1}"=>"\x{0923}",	#Consonant Hard NA
		"\x{C2}"=>"\x{0924}",	#Consonant Soft TA
		"\x{C3}"=>"\x{0925}",	#Consonant Soft THA
		"\x{C4}"=>"\x{0926}",	#Consonant Soft DA
		"\x{C5}"=>"\x{0927}",	#Consonant Soft DHA
		"\x{C6}"=>"\x{0928}",	#Consonant Soft NA
		"\x{C7}"=>"\x{0929}",	#Consonant NA (Tamil)
		"\x{C8}"=>"\x{092A}",	#Consonant PA
		"\x{C9}"=>"\x{092B}",	#Consonant PHA
		"\x{CA}"=>"\x{092C}",	#Consonant BA
		"\x{CB}"=>"\x{092D}",	#Consonant BHA
		"\x{CC}"=>"\x{092E}",	#Consonant MA
		"\x{CD}"=>"\x{092F}",	#Consonant YA
		"\x{CE}"=>"",			#Consonant JYA (Bangla, Assamese & Orriya)
		"\x{CF}"=>"\x{0930}",	#Consonant RA
		"\x{D0}"=>"\x{0931}",	#Consonant Hard RA (Southern Script)
		"\x{D1}"=>"\x{0932}",	#Consonant LA
		"\x{D2}"=>"\x{0933}",	#Consonant Hard LA
		"\x{D3}"=>"\x{0934}",	#Consonant ZHA (Tamil & Malyalam)
		"\x{D4}"=>"\x{0935}",	#Consonant VA
		"\x{D5}"=>"\x{0936}",	#Consonant SHA
		"\x{D6}"=>"\x{0937}",	#Consonant Hard SHA
		"\x{D7}"=>"\x{0938}",	#Consonant SA
		"\x{D8}"=>"\x{0939}",	#Consonant HA
		"\x{D9}"=>"",			#Consonant INV
		"\x{DA}"=>"\x{093E}",	#Vowel Sign AA
		"\x{DB}"=>"\x{093F}",	#Vowel Sign I
		"\x{DC}"=>"\x{0940}",	#Vowel Sign II
		"\x{DD}"=>"\x{0941}",	#Vowel Sign U
		"\x{DE}"=>"\x{0942}",	#Vowel Sign UU
		"\x{DF}"=>"\x{0943}",	#Vowel Sign RI
		"\x{E0}"=>"\x{0946}",	#Vowel Sign E (Southern Scripts)
		"\x{E1}"=>"\x{0947}",	#Vowel Sign EY
		"\x{E2}"=>"\x{0948}",	#Vowel Sign AI
		"\x{E3}"=>"\x{0945}",	#Vowel Sign AYE (Devanagari Script)
		"\x{E4}"=>"\x{094A}",	#Vowel Sign O
		"\x{E5}"=>"\x{094B}",	#Vowel Sign OW
		"\x{E6}"=>"\x{094C}",	#Vowel Sign AU
		"\x{E7}"=>"\x{0949}",	#Vowel Sign AWE (Devanagari Script)
		"\x{E8}"=>"\x{094D}",	#Vowel Omission Sign (Halant)
		"\x{E9}"=>"\x{093C}",	#Diacritic Sign (Nukta)
		#"\x{EA}"=>"\x{0964}",	#Full Stop (Viram, Northern Scripts)
		"\x{EA}"=>".",	#Full Stop (Viram, Northern Scripts)
		"\x{F1}"=>"\x{0966}",	#Digit 0
		"\x{F2}"=>"\x{0967}",	#Digit 1
		"\x{F3}"=>"\x{0968}",	#Digit 2
		"\x{F4}"=>"\x{0969}",	#Digit 3
		"\x{F5}"=>"\x{096A}",	#Digit 4
		"\x{F6}"=>"\x{096B}",	#Digit 5
		"\x{F7}"=>"\x{096C}",	#Digit 6
		"\x{F8}"=>"\x{096D}",	#Digit 7
		"\x{F9}"=>"\x{096E}",	#Digit 8
		"\x{FA}"=>"\x{096F}",	#Digit 9 
		);     
                            
	$string=~s/([\x{A1}-\x{FA}])/$hash{$1}/g;

	# Return the converted Unicode $string
	return $string;
}

sub iscii2unicode_tel {
	my $string = $_[0];

	my %hash = (
		"\x{A1}"=>"\x{0C01}",	#Vowel-modifier CHANDRABINDU
		"\x{A2}"=>"\x{0C02}",	#Vowel-modifier ANUSWAR
		"\x{A3}"=>"\x{0C03}",	#Vowel-modifier VISARG
		"\x{A4}"=>"\x{0C05}",	#Vowel A
		"\x{A5}"=>"\x{0C06}",	#Vowel AA
		"\x{A6}"=>"\x{0C07}",	#Vowel I
		"\x{A7}"=>"\x{0C08}",	#Vowel II
		"\x{A8}"=>"\x{0C09}",	#Vowel U
		"\x{A9}"=>"\x{0C0A}",	#Vowel UU
		"\x{AA}"=>"\x{0C0B}",	#Vowel RI
		"\x{AB}"=>"\x{0C0E}",	#Vowel E
		"\x{AC}"=>"\x{0C0F}",	#Vowel EY
		"\x{AD}"=>"\x{0C10}",	#Vowel AI
		#"\x{B2}"=>"\x{090D}",	#Vowel AYE (Devanagari Script) 7-Mar-11 -Rashid
		"\x{B2}"=>"",		#Vowel AYE (Devanagari Script)
		"\x{AF}"=>"\x{0C12}",	#Vowel O
		"\x{B0}"=>"\x{0C13}",	#Vowel OW
		"\x{B1}"=>"\x{0C14}",	#Vowel AU
		#"\x{B2}"=>"\x{0911}",	#Vowel AWE 7-Mar-11 -Rashid
		"\x{B2}"=>"",		#Vowel AWE
		"\x{B3}"=>"\x{0C15}",	#Consonant KA
		"\x{B4}"=>"\x{0C16}",	#Consonant KHA
		"\x{B5}"=>"\x{0C17}",	#Consonant GA
		"\x{B6}"=>"\x{0C18}",	#Consonant GHA
		"\x{B7}"=>"\x{0C19}",	#Consonant NGA
		"\x{B8}"=>"\x{0C1A}",	#Consonant CHA
		"\x{B9}"=>"\x{0C1B}",	#Consonant CHHA
		"\x{BA}"=>"\x{0C1C}",	#Consonant JA
		"\x{BB}"=>"\x{0C1D}",	#Consonant JHA
		"\x{BC}"=>"\x{0C1E}",	#Consonant JNA
		"\x{BD}"=>"\x{0C1F}",	#Consonant Hard TA
		"\x{BE}"=>"\x{0C20}",	#Consonant Hard THA
		"\x{BF}"=>"\x{0C21}",	#Consonant Hard DA
		"\x{C0}"=>"\x{0C22}",	#Consonant Hard DHA
		"\x{C1}"=>"\x{0C23}",	#Consonant Hard NA
		"\x{C2}"=>"\x{0C24}",	#Consonant Soft TA
		"\x{C3}"=>"\x{0C25}",	#Consonant Soft THA
		"\x{C4}"=>"\x{0C26}",	#Consonant Soft DA
		"\x{C5}"=>"\x{0C27}",	#Consonant Soft DHA
		"\x{C6}"=>"\x{0C28}",	#Consonant Soft NA
		#"\x{C7}"=>"\x{0929}",	#Consonant NA (Tamil) 28-Feb-11 -Rashid
		"\x{C7}"=>"",		#Consonant NA (Tamil)
		"\x{C8}"=>"\x{0C2A}",	#Consonant PA
		"\x{C9}"=>"\x{0C2B}",	#Consonant PHA
		"\x{CA}"=>"\x{0C2C}",	#Consonant BA
		"\x{CB}"=>"\x{0C2D}",	#Consonant BHA
		"\x{CC}"=>"\x{0C2E}",	#Consonant MA
		"\x{CD}"=>"\x{0C2F}",	#Consonant YA
		"\x{CE}"=>"",		#Consonant JYA (Bangla, Assamese & Orriya)
		"\x{CF}"=>"\x{0C30}",	#Consonant RA
		"\x{D0}"=>"\x{0C31}",	#Consonant Hard RA (Southern Script)
		"\x{D1}"=>"\x{0C32}",	#Consonant LA
		"\x{D2}"=>"\x{0C33}",	#Consonant Hard LA
		#"\x{D3}"=>"\x{0934}",	#Consonant LLLA 7-Mar-11 -Rashid
		"\x{D3}"=>"",		#Consonant LLLA
		"\x{D4}"=>"\x{0C35}",	#Consonant VA
		"\x{D5}"=>"\x{0C36}",	#Consonant SHA
		"\x{D6}"=>"\x{0C37}",	#Consonant Hard SHA
		"\x{D7}"=>"\x{0C38}",	#Consonant SA
		"\x{D8}"=>"\x{0C39}",	#Consonant HA
		"\x{D9}"=>"",		#Consonant INV
		"\x{DA}"=>"\x{0C3E}",	#Vowel Sign AA
		"\x{DB}"=>"\x{0C3F}",	#Vowel Sign I
		"\x{DC}"=>"\x{0C40}",	#Vowel Sign II
		"\x{DD}"=>"\x{0C41}",	#Vowel Sign U
		"\x{DE}"=>"\x{0C42}",	#Vowel Sign UU
		"\x{DF}"=>"\x{0C43}",	#Vowel Sign RI
		"\x{E0}"=>"\x{0C46}",	#Vowel Sign E (Southern Scripts)
		"\x{E1}"=>"\x{0C47}",	#Vowel Sign EY
		"\x{E2}"=>"\x{0C48}",	#Vowel Sign AI
		#"\x{E3}"=>"\x{0945}",	#Vowel Sign AYE (Devanagari Script) 7-Mar-11 -Rashid
		"\x{E3}"=>"",		#Vowel Sign AYE (Devanagari Script)
		"\x{E4}"=>"\x{0C4A}",	#Vowel Sign O
		"\x{E5}"=>"\x{0C4B}",	#Vowel Sign OW
		"\x{E6}"=>"\x{0C4C}",	#Vowel Sign AU
		#"\x{E7}"=>"\x{0949}",	#Vowel Sign AWE (Devanagari Script) 7-Mar-11 -Rashid
		"\x{E7}"=>"",		#Vowel Sign AWE (Devanagari Script)
		"\x{E8}"=>"\x{0C4D}",	#Vowel Omission Sign (Halant)
		#"\x{E9}"=>"\x{093C}",	#Diacritic Sign (Nukta) 7-Mar-11 -Rashid
		"\x{E9}"=>"",		#Diacritic Sign (Nukta)
		"\x{EA}"=>".",		#Full Stop (Viram, Northern Scripts)
		"\x{F1}"=>"\x{0C66}",	#Digit 0
		"\x{F2}"=>"\x{0C67}",	#Digit 1
		"\x{F3}"=>"\x{0C68}",	#Digit 2
		"\x{F4}"=>"\x{0C69}",	#Digit 3
		"\x{F5}"=>"\x{0C6A}",	#Digit 4
		"\x{F6}"=>"\x{0C6B}",	#Digit 5
		"\x{F7}"=>"\x{0C6C}",	#Digit 6
		"\x{F8}"=>"\x{0C6D}",	#Digit 7
		"\x{F9}"=>"\x{0C6E}",	#Digit 8
		"\x{FA}"=>"\x{0C6F}",	#Digit 9 
		);     

	$string=~s/([\x{A1}-\x{FA}])/$hash{$1}/g;

	# Return the converted Unicode $string
	return $string;
                            
}

sub iscii2unicode_pan {
	my $string = $_[0];

    my %hash = (
            "\x{A1}"=>"\x{0A01}",	#Vowel-modifier CHANDRABINDU
            "\x{A2}"=>"\x{0A02}",	#Vowel-modifier ANUSWAR
            "\x{A3}"=>"\x{0A03}",	#Vowel-modifier VISARG
            "\x{A4}"=>"\x{0A05}",	#Vowel A
            "\x{A5}"=>"\x{0A06}",	#Vowel AA
            "\x{A6}"=>"\x{0A07}",	#Vowel I
            "\x{A7}"=>"\x{0A08}",	#Vowel II
            "\x{A8}"=>"\x{0A09}",	#Vowel U
            "\x{A9}"=>"\x{0A0A}",	#Vowel UU
            "\x{AA}"=>"\x{0A0B}",	#Vowel RI
            "\x{AB}"=>"\x{0A0E}",	#Vowel E
            "\x{AC}"=>"\x{0A0F}",	#Vowel EY
            "\x{AD}"=>"\x{0A10}",	#Vowel AI
            "\x{B2}"=>"\x{0A0D}",	#Vowel AYE (Devanagari Script)
            "\x{AF}"=>"\x{0A12}",	#Vowel O
            "\x{B0}"=>"\x{0A13}",	#Vowel OW
            "\x{B1}"=>"\x{0A14}",	#Vowel AU
            "\x{B2}"=>"\x{0A11}",	#Vowel AWE
            "\x{B3}"=>"\x{0A15}",	#Consonant KA
            "\x{B4}"=>"\x{0A16}",	#Consonant KHA
            "\x{B5}"=>"\x{0A17}",	#Consonant GA
            "\x{B6}"=>"\x{0A18}",	#Consonant GHA
            "\x{B7}"=>"\x{0A19}",	#Consonant NGA
            "\x{B8}"=>"\x{0A1A}",	#Consonant CHA
            "\x{B9}"=>"\x{0A1B}",	#Consonant CHHA
            "\x{BA}"=>"\x{0A1C}",	#Consonant JA
            "\x{BB}"=>"\x{0A1D}",	#Consonant JHA
            "\x{BC}"=>"\x{0A1E}",	#Consonant JNA
            "\x{BD}"=>"\x{0A1F}",	#Consonant Hard TA
            "\x{BE}"=>"\x{0A20}",	#Consonant Hard THA
            "\x{BF}"=>"\x{0A21}",	#Consonant Hard DA
            "\x{C0}"=>"\x{0A22}",	#Consonant Hard DHA
            "\x{C1}"=>"\x{0A23}",	#Consonant Hard NA
            "\x{C2}"=>"\x{0A24}",	#Consonant Soft TA
            "\x{C3}"=>"\x{0A25}",	#Consonant Soft THA
            "\x{C4}"=>"\x{0A26}",	#Consonant Soft DA
            "\x{C5}"=>"\x{0A27}",	#Consonant Soft DHA
            "\x{C6}"=>"\x{0A28}",	#Consonant Soft NA
            "\x{C7}"=>"\x{0A29}",	#Consonant NA (Tamil)
            "\x{C8}"=>"\x{0A2A}",	#Consonant PA
            "\x{C9}"=>"\x{0A2B}",	#Consonant PHA
            "\x{CA}"=>"\x{0A2C}",	#Consonant BA
            "\x{CB}"=>"\x{0A2D}",	#Consonant BHA
            "\x{CC}"=>"\x{0A2E}",	#Consonant MA
            "\x{CD}"=>"\x{0A2F}",	#Consonant YA
            "\x{CE}"=>"",		#Consonant JYA (Bangla, Assamese & Orriya)
            "\x{CF}"=>"\x{0A30}",	#Consonant RA
            "\x{D0}"=>"\x{0A31}",	#Consonant Hard RA (Southern Script)
            "\x{D1}"=>"\x{0A32}",	#Consonant LA
            "\x{D2}"=>"\x{0A33}",	#Consonant Hard LA
            "\x{D3}"=>"\x{0A34}",	#Consonant ZHA (Tamil & Malyalam)
            "\x{D4}"=>"\x{0A35}",	#Consonant VA
            "\x{D5}"=>"\x{0A36}",	#Consonant SHA
            "\x{D6}"=>"\x{0A37}",	#Consonant Hard SHA
            "\x{D7}"=>"\x{0A38}",	#Consonant SA
            "\x{D8}"=>"\x{0A39}",	#Consonant HA
            "\x{D9}"=>"",		#Consonant INV
            "\x{DA}"=>"\x{0A3E}",	#Vowel Sign AA
            "\x{DB}"=>"\x{0A3F}",	#Vowel Sign I
            "\x{DC}"=>"\x{0A40}",	#Vowel Sign II
            "\x{DD}"=>"\x{0A41}",	#Vowel Sign U
            "\x{DE}"=>"\x{0A42}",	#Vowel Sign UU
            "\x{DF}"=>"\x{0A43}",	#Vowel Sign RI
            "\x{E0}"=>"\x{0A46}",	#Vowel Sign E (Southern Scripts)
            "\x{E1}"=>"\x{0A47}",	#Vowel Sign EY
            "\x{E2}"=>"\x{0A48}",	#Vowel Sign AI
            "\x{E3}"=>"\x{0A45}",	#Vowel Sign AYE (Devanagari Script)
            "\x{E4}"=>"\x{0A4A}",	#Vowel Sign O
            "\x{E5}"=>"\x{0A4B}",	#Vowel Sign OW
            "\x{E6}"=>"\x{0A4C}",	#Vowel Sign AU
            "\x{E7}"=>"\x{0A49}",	#Vowel Sign AWE (Devanagari Script)
            "\x{E8}"=>"\x{0A4D}",	#Vowel Omission Sign (Halant)
            "\x{E9}"=>"\x{0A3C}",	#Diacritic Sign (Nukta)
            "\x{EA}"=>"\x{0964}",	#Full Stop (Viram, Northern Scripts)
            "\x{F1}"=>"\x{0A66}",	#Digit 0
            "\x{F2}"=>"\x{0A67}",	#Digit 1
            "\x{F3}"=>"\x{0A68}",	#Digit 2
            "\x{F4}"=>"\x{0A69}",	#Digit 3
            "\x{F5}"=>"\x{0A6A}",	#Digit 4
            "\x{F6}"=>"\x{0A6B}",	#Digit 5
            "\x{F7}"=>"\x{0A6C}",	#Digit 6
            "\x{F8}"=>"\x{0A6D}",	#Digit 7
            "\x{F9}"=>"\x{0A6E}",	#Digit 8
            "\x{FA}"=>"\x{0A6F}",	#Digit 9 
            );     



	$string=~s/([\x{A1}-\x{FA}])/$hash{$1}/g;

	# Return the converted Unicode $string
	return $string;

}

sub iscii2unicode_kan {
    my $string = $_[0];

    my %hash = (
            "\x{A2}"=>"\x{0C82}",	#Vowel-modifier ANUSWAR
            "\x{A3}"=>"\x{0C83}",	#Vowel-modifier VISARG
            "\x{A4}"=>"\x{0C85}",	#Vowel A
            "\x{A5}"=>"\x{0C86}",	#Vowel AA
            "\x{A6}"=>"\x{0C87}",	#Vowel I
            "\x{A7}"=>"\x{0C88}",	#Vowel II
            "\x{A8}"=>"\x{0C89}",	#Vowel U
            "\x{A9}"=>"\x{0C8A}",	#Vowel UU
            "\x{AA}"=>"\x{0C8B}",	#Vowel RI
            "\x{AB}"=>"\x{0C0E}",	#Vowel E
            "\x{AC}"=>"\x{0C0F}",	#Vowel EY
            "\x{AD}"=>"\x{0C10}",	#Vowel AI
            "\x{B2}"=>"\x{0C0D}",	#Vowel AYE (Devanagari Script)
            "\x{AF}"=>"\x{0C12}",	#Vowel O
            "\x{B0}"=>"\x{0C13}",	#Vowel OW
            "\x{B1}"=>"\x{0C14}",	#Vowel AU
            "\x{B2}"=>"\x{0C11}",	#Vowel AWE
            "\x{B3}"=>"\x{0C15}",	#Consonant KA
            "\x{B4}"=>"\x{0C16}",	#Consonant KHA
            "\x{B5}"=>"\x{0C17}",	#Consonant GA
            "\x{B6}"=>"\x{0C18}",	#Consonant GHA
            "\x{B7}"=>"\x{0C19}",	#Consonant NGA
            "\x{B8}"=>"\x{0C1A}",	#Consonant CHA
            "\x{B9}"=>"\x{0C1B}",	#Consonant CHHA
            "\x{BA}"=>"\x{0C1C}",	#Consonant JA
            "\x{BB}"=>"\x{0C1D}",	#Consonant JHA
            "\x{BC}"=>"\x{0C1E}",	#Consonant JNA
            "\x{BD}"=>"\x{0C1F}",	#Consonant Hard TA
            "\x{BE}"=>"\x{0C20}",	#Consonant Hard THA
            "\x{BF}"=>"\x{0C21}",	#Consonant Hard DA
            "\x{C0}"=>"\x{0C22}",	#Consonant Hard DHA
            "\x{C1}"=>"\x{0C23}",	#Consonant Hard NA
            "\x{C2}"=>"\x{0C24}",	#Consonant Soft TA
            "\x{C3}"=>"\x{0C25}",	#Consonant Soft THA
            "\x{C4}"=>"\x{0C26}",	#Consonant Soft DA
            "\x{C5}"=>"\x{0C27}",	#Consonant Soft DHA
            "\x{C6}"=>"\x{0C28}",	#Consonant Soft NA
            "\x{C7}"=>"\x{0C29}",	#Consonant NA (Tamil)
            "\x{C8}"=>"\x{0C2A}",	#Consonant PA
            "\x{C9}"=>"\x{0C2B}",	#Consonant PHA
            "\x{CA}"=>"\x{0C2C}",	#Consonant BA
            "\x{CB}"=>"\x{0C2D}",	#Consonant BHA
            "\x{CC}"=>"\x{0C2E}",	#Consonant MA
            "\x{CD}"=>"\x{0C2F}",	#Consonant YA
            "\x{CE}"=>"",			#Consonant JYA (Bangla, Assamese & Orriya)
            "\x{CF}"=>"\x{0C30}",	#Consonant RA
            "\x{D0}"=>"\x{0C31}",	#Consonant Hard RA (Southern Script)
            "\x{D1}"=>"\x{0C32}",	#Consonant LA
            "\x{D2}"=>"\x{0C33}",	#Consonant Hard LA
            "\x{D3}"=>"\x{0C34}",	#Consonant ZHA (Tamil & Malyalam)
            "\x{D4}"=>"\x{0C35}",	#Consonant VA
            "\x{D5}"=>"\x{0C36}",	#Consonant SHA
            "\x{D6}"=>"\x{0C37}",	#Consonant Hard SHA
            "\x{D7}"=>"\x{0C38}",	#Consonant SA
            "\x{D8}"=>"\x{0C39}",	#Consonant HA
            "\x{D9}"=>"",			#Consonant INV
            "\x{DA}"=>"\x{0C3E}",	#Vowel Sign AA
            "\x{DB}"=>"\x{0C3F}",	#Vowel Sign I
            "\x{DC}"=>"\x{0C40}",	#Vowel Sign II
            "\x{DD}"=>"\x{0C41}",	#Vowel Sign U
            "\x{DE}"=>"\x{0C42}",	#Vowel Sign UU
            "\x{DF}"=>"\x{0C43}",	#Vowel Sign RI
            "\x{E0}"=>"\x{0C46}",	#Vowel Sign E (Southern Scripts)
            "\x{E1}"=>"\x{0C47}",	#Vowel Sign EY
            "\x{E2}"=>"\x{0C48}",	#Vowel Sign AI
            "\x{E3}"=>"\x{0C45}",	#Vowel Sign AYE (Devanagari Script)
            "\x{E4}"=>"\x{0C4A}",	#Vowel Sign O
            "\x{E5}"=>"\x{0C4B}",	#Vowel Sign OW
            "\x{E6}"=>"\x{0C4C}",	#Vowel Sign AU
            "\x{E7}"=>"\x{0C49}",	#Vowel Sign AWE (Devanagari Script)
            "\x{E8}"=>"\x{0C4D}",	#Vowel Omission Sign (Halant)
            "\x{E9}"=>"\x{0C3C}",	#Diacritic Sign (Nukta)
            "\x{EA}"=>"\x{0C64}",	#Full Stop (Viram, Northern Scripts)
            "\x{F1}"=>"\x{0C66}",	#Digit 0
            "\x{F2}"=>"\x{0C67}",	#Digit 1
            "\x{F3}"=>"\x{0C68}",	#Digit 2
            "\x{F4}"=>"\x{0C69}",	#Digit 3
            "\x{F5}"=>"\x{0C6A}",	#Digit 4
            "\x{F6}"=>"\x{0C6B}",	#Digit 5
            "\x{F7}"=>"\x{0C6C}",	#Digit 6
            "\x{F8}"=>"\x{0C6D}",	#Digit 7
            "\x{F9}"=>"\x{0C6E}",	#Digit 8
            "\x{FA}"=>"\x{0C6F}",	#Digit 9 
            );     
                            
    $string=~s/([\x{A1}-\x{FA}])/$hash{$1}/g;

    # Return the converted Unicode $string 
    
    return $string;
}

sub iscii2unicode_mal {
    my $string = $_[0]; 
    
    my %hash = (
            "\x{A2}"=>"\x{0D02}",   #Vowel-modifier ANUSWAR
            "\x{A3}"=>"\x{0D03}",   #Vowel-modifier VISARG
            "\x{A4}"=>"\x{0D05}",   #Vowel A
            "\x{A5}"=>"\x{0D06}",   #Vowel AA
            "\x{A6}"=>"\x{0D07}",   #Vowel I
            "\x{A7}"=>"\x{0D08}",   #Vowel II
            "\x{A8}"=>"\x{0D09}",   #Vowel U
            "\x{A9}"=>"\x{0D0A}",   #Vowel UU
            "\x{AA}"=>"\x{0D0B}",   #Vowel RI
            "\x{AB}"=>"\x{0D0E}",   #Vowel E
            "\x{AC}"=>"\x{0D0F}",   #Vowel EY
            "\x{AD}"=>"\x{0D10}",   #Vowel AI
            "\x{AF}"=>"\x{0D12}",   #Vowel O
            "\x{B0}"=>"\x{0D13}",   #Vowel OW
            "\x{B1}"=>"\x{0D14}",   #Vowel AU
            "\x{B2}"=>"\x{0D11}",   #Vowel AWE
            "\x{B3}"=>"\x{0D15}",   #Consonant KA
            "\x{B4}"=>"\x{0D16}",   #Consonant KHA
            "\x{B5}"=>"\x{0D17}",   #Consonant GA
            "\x{B6}"=>"\x{0D18}",   #Consonant GHA
            "\x{B7}"=>"\x{0D19}",   #Consonant NGA
            "\x{B8}"=>"\x{0D1A}",   #Consonant CHA
            "\x{B9}"=>"\x{0D1B}",   #Consonant CHHA
            "\x{BA}"=>"\x{0D1C}",   #Consonant JA
            "\x{BB}"=>"\x{0D1D}",   #Consonant JHA
            "\x{BC}"=>"\x{0D1E}",   #Consonant JNA
            "\x{BD}"=>"\x{0D1F}",   #Consonant Hard TA
            "\x{BE}"=>"\x{0D20}",   #Consonant Hard THA
            "\x{BF}"=>"\x{0D21}",   #Consonant Hard DA
            "\x{C0}"=>"\x{0D22}",   #Consonant Hard DHA
            "\x{C1}"=>"\x{0D23}",   #Consonant Hard NA
            "\x{C2}"=>"\x{0D24}",   #Consonant Soft TA
            "\x{C3}"=>"\x{0D25}",   #Consonant Soft THA
            "\x{C4}"=>"\x{0D26}",   #Consonant Soft DA
            "\x{C5}"=>"\x{0D27}",   #Consonant Soft DHA
            "\x{C6}"=>"\x{0D28}",   #Consonant Soft NA
            "\x{C7}"=>"\x{0D29}",   #Consonant NA (Tamil)
            "\x{C8}"=>"\x{0D2A}",   #Consonant PA
            "\x{C9}"=>"\x{0D2B}",   #Consonant PHA
            "\x{CA}"=>"\x{0D2C}",   #Consonant BA
            "\x{CB}"=>"\x{0D2D}",   #Consonant BHA
            "\x{CC}"=>"\x{0D2E}",   #Consonant MA
            "\x{CD}"=>"\x{0D2F}",   #Consonant YA
            "\x{CE}"=>"",                   #Consonant JYA (Bangla, Assamese & Orriya)
            "\x{CF}"=>"\x{0D30}",   #Consonant RA
            "\x{D0}"=>"\x{0D31}",   #Consonant Hard RA (Southern Script)
            "\x{D1}"=>"\x{0D32}",   #Consonant LA
            "\x{D2}"=>"\x{0D33}",   #Consonant Hard LA
            "\x{D3}"=>"\x{0D34}",   #Consonant ZHA (Tamil & Malyalam)
            "\x{D4}"=>"\x{0D35}",   #Consonant VA
            "\x{D5}"=>"\x{0D36}",   #Consonant SHA
            "\x{D6}"=>"\x{0D37}",   #Consonant Hard SHA
            "\x{D7}"=>"\x{0D38}",   #Consonant SA
            "\x{D8}"=>"\x{0D39}",   #Consonant HA
            "\x{D9}"=>"",                   #Consonant INV
            "\x{DA}"=>"\x{0D3E}",   #Vowel Sign AA
            "\x{DB}"=>"\x{0D3F}",   #Vowel Sign I
            "\x{DC}"=>"\x{0D40}",   #Vowel Sign II
            "\x{DD}"=>"\x{0D41}",   #Vowel Sign U
            "\x{DE}"=>"\x{0D42}",   #Vowel Sign UU
            "\x{DF}"=>"\x{0D43}",   #Vowel Sign RI
            "\x{E0}"=>"\x{0D46}",   #Vowel Sign E (Southern Scripts)
            "\x{E1}"=>"\x{0D47}",   #Vowel Sign EY
            "\x{E2}"=>"\x{0D48}",   #Vowel Sign AI
            "\x{E3}"=>"",   #Vowel Sign AYE (Devanagari Script)
            "\x{E4}"=>"\x{0D4A}",   #Vowel Sign O
            "\x{E5}"=>"\x{0D4B}",   #Vowel Sign OW
            "\x{E6}"=>"\x{0D4C}",   #Vowel Sign AU
            "\x{E7}"=>"",   #Vowel Sign AWE (Devanagari Script)
            "\x{E8}"=>"\x{0D4D}",   #Vowel Omission Sign (Halant)
            "\x{EA}"=>"\x{0D64}",   #Full Stop (Viram, Northern Scripts)
            "\x{F1}"=>"\x{0D66}",   #Digit 0
            "\x{F2}"=>"\x{0D67}",   #Digit 1
            "\x{F3}"=>"\x{0D68}",   #Digit 2
            "\x{F4}"=>"\x{0D69}",   #Digit 3
            "\x{F5}"=>"\x{0D6A}",   #Digit 4
            "\x{F6}"=>"\x{0D6B}",   #Digit 5
            "\x{F7}"=>"\x{0D6C}",   #Digit 6
            "\x{F8}"=>"\x{0D6D}",   #Digit 7
            "\x{F9}"=>"\x{0D6E}",   #Digit 8
            "\x{FA}"=>"\x{0D6F}",   #Digit 9
            );     
                            
    $string=~s/([\x{A1}-\x{FA}])/$hash{$1}/g; 
    # Return the converted Unicode $string 
    
    return $string;
}

sub iscii2unicode_ben {
	my $string = $_[0];

	my %hash = (

			"\x{A1}"=>"\x{0981}",
			"\x{A2}"=>"\x{0982}",   #Vowel-modifier ANUSWAR
			"\x{A3}"=>"\x{0983}",   #Vowel-modifier VISARG
			"\x{A4}"=>"\x{0985}",   #Vowel A
			"\x{A5}"=>"\x{0986}",   #Vowel AA
			"\x{A6}"=>"\x{0987}",   #Vowel I
			"\x{A7}"=>"\x{0988}",   #Vowel II
			"\x{A8}"=>"\x{0989}",   #Vowel U
			"\x{A9}"=>"\x{098A}",   #Vowel UU
			"\x{AA}"=>"\x{098B}",   #Vowel RI
			"\x{AB}"=>"\x{098F}",   #Vowel 
			"\x{AD}"=>"\x{0990}",   #Vowel AI
			"\x{AF}"=>"\x{0993}",   #Vowel O
			"\x{B0}"=>"",   #Vowel OW
			"\x{B1}"=>"\x{0994}",   #Vowel AU
			"\x{B3}"=>"\x{0995}",   #Consonant KA
			"\x{B4}"=>"\x{0996}",   #Consonant KHA
			"\x{B5}"=>"\x{0997}",   #Consonant GA
			"\x{B6}"=>"\x{0998}",   #Consonant GHA
			"\x{B7}"=>"\x{0999}",   #Consonant NGA
			"\x{B8}"=>"\x{099A}",   #Consonant CHA
			"\x{B9}"=>"\x{099B}",   #Consonant CHHA
			"\x{BA}"=>"\x{099C}",   #Consonant JA
			"\x{BB}"=>"\x{099D}",   #Consonant JHA
			"\x{BC}"=>"\x{099E}",   #Consonant JNA
			"\x{BD}"=>"\x{099F}",   #Consonant Hard TA
			"\x{BE}"=>"\x{09A0}",   #Consonant Hard THA
			"\x{BF}"=>"\x{09A1}",   #Consonant Hard DA
			"\x{C0}"=>"\x{09A2}",   #Consonant Hard DHA
			"\x{C1}"=>"\x{09A3}",   #Consonant Hard NA
			"\x{C2}"=>"\x{09A4}",   #Consonant Soft TA
			"\x{C3}"=>"\x{09A5}",   #Consonant Soft THA
			"\x{C4}"=>"\x{09A6}",   #Consonant Soft DA
			"\x{C5}"=>"\x{09A7}",   #Consonant Soft DHA
			"\x{C6}"=>"\x{09A8}",   #Consonant Soft NA
			"\x{C7}"=>"",   #Consonant NA (Tamil)
			"\x{C8}"=>"\x{09AA}",   #Consonant PA
			"\x{C9}"=>"\x{09AB}",   #Consonant PHA
			"\x{CA}"=>"\x{09AC}",   #Consonant BA
			"\x{CB}"=>"\x{09AD}",   #Consonant BHA
			"\x{CC}"=>"\x{09AE}",   #Consonant MA
			"\x{CD}"=>"\x{09AF}",   #Consonant YA
			"\x{CE}"=>"",                   #Consonant JYA (Bangla, Assamese & Orriya)
			"\x{CF}"=>"\x{09B0}",   #Consonant RA
			"\x{D0}"=>"",   
		"\x{D1}"=>"\x{09B2}",   #Consonant LA
			"\x{D2}"=>"",   #Consonant Hard LA
			"\x{D3}"=>"",   #Consonant ZHA (Tamil & Malyalam)
			"\x{D4}"=>"",   #Consonant VA
			"\x{D5}"=>"\x{09B6}",   #Consonant SHA
			"\x{D6}"=>"\x{09B7}",   #Consonant Hard SHA
			"\x{D7}"=>"\x{09B8}",   #Consonant SA
			"\x{D8}"=>"\x{09B9}",   #Consonant HA
			"\x{D9}"=>"",                   #Consonant INV
			"\x{DA}"=>"\x{09BE}",   #Vowel Sign AA
			"\x{DB}"=>"\x{09BF}",   #Vowel Sign I
			"\x{DC}"=>"\x{09C0}",   #Vowel Sign II
			"\x{DD}"=>"\x{09C1}",   #Vowel Sign U
			"\x{DE}"=>"\x{09C2}",   #Vowel Sign UU
			"\x{DF}"=>"\x{09C3}",   #Vowel Sign RI
			"\x{E0}"=>"\x{09C7}",   #Vowel Sign E (Southern Scripts)
			"\x{E1}"=>"",   #Vowel Sign EY
			"\x{E2}"=>"\x{09C8}",   #Vowel Sign AI
			"\x{E3}"=>"",   #Vowel Sign AYE (Devanagari Script)
			"\x{E4}"=>"\x{09CB}",   #Vowel Sign O
			"\x{E5}"=>"",   #Vowel Sign OW
			"\x{E6}"=>"\x{09CC}",   #Vowel Sign AU
			"\x{E7}"=>"",   #Vowel Sign AWE (Devanagari Script)
			"\x{E8}"=>"\x{09CD}",   #Vowel Omission Sign (Halant)
			"\x{E9}"=>"\x{09BC}",
		"\x{EA}"=>"\x{09E4}",   #Full Stop (Viram, Northern Scripts)
			"\x{F1}"=>"\x{09E6}",   #Digit 0
			"\x{F2}"=>"\x{09E7}",   #Digit 1
			"\x{F3}"=>"\x{09E8}",   #Digit 2
			"\x{F4}"=>"\x{09E9}",   #Digit 3
			"\x{F5}"=>"\x{09EA}",   #Digit 4
			"\x{F6}"=>"\x{09EB}",   #Digit 5
			"\x{F7}"=>"\x{09EC}",   #Digit 6
			"\x{F8}"=>"\x{09ED}",   #Digit 7
			"\x{F9}"=>"\x{09EE}",   #Digit 8
			"\x{FA}"=>"\x{09EF}",   #Digit 9
		);     
                            
	$string=~s/([\x{A1}-\x{FA}])/$hash{$1}/g;

	# Return the converted Unicode $string
	return $string;
}

sub iscii2unicode_tam {
	my $string = $_[0];

	my %hash = (
			#"\x{A2}"=>"\x{0B82}",   #Vowel-modifier ANUSWAR commented 14-March-11 -Rashid
			"\x{A2}"=>"\x{0BAE}\x{0BCD}",   #Vowel-modifier ANUSWAR is m + halant
			"\x{A3}"=>"\x{0B83}",   #Vowel-modifier VISARG
			"\x{A4}"=>"\x{0B85}",   #Vowel A
			"\x{A5}"=>"\x{0B86}",   #Vowel AA
			"\x{A6}"=>"\x{0B87}",   #Vowel I
			"\x{A7}"=>"\x{0B88}",   #Vowel II
			"\x{A8}"=>"\x{0B89}",   #Vowel U
			"\x{A9}"=>"\x{0B8A}",   #Vowel UU
			"\x{AB}"=>"\x{0B8E}",   #Vowel 
			"\x{AC}"=>"\x{0B8F}",
			"\x{AD}"=>"\x{0B90}",   #Vowel AI
			"\x{AF}"=>"\x{0B92}",   #Vowel O
			"\x{B0}"=>"\x{0B93}",   #Vowel OW
			"\x{B1}"=>"\x{0B94}",   #Vowel AU
			"\x{B3}"=>"\x{0B95}",   #Consonant KA
			"\x{B4}"=>"",   	#Consonant KHA
			"\x{B5}"=>"",   	#Consonant GA
			"\x{B6}"=>"",   	#Consonant GHA
			"\x{B7}"=>"\x{0B99}",   #Consonant NGA
			"\x{B8}"=>"\x{0B9A}",   #Consonant CHA
			"\x{B9}"=>"",   	#Consonant CHHA
			"\x{BA}"=>"\x{0B9C}",   #Consonant JA
			"\x{BB}"=>"",   	#Consonant JHA
			"\x{BC}"=>"\x{0B9E}",   #Consonant JNA
			"\x{BD}"=>"\x{0B9F}",   #Consonant Hard TA
			"\x{BE}"=>"",   	#Consonant Hard THA
			"\x{BF}"=>"",   	#Consonant Hard DA
			"\x{C0}"=>"",   	#Consonant Hard DHA
			"\x{C1}"=>"\x{0BA3}",   #Consonant Hard NA
			"\x{C2}"=>"\x{0BA4}",   #Consonant Soft TA
			"\x{C3}"=>"",   	#Consonant Soft THA
			"\x{C4}"=>"",   	#Consonant Soft DA
			"\x{C5}"=>"",   	#Consonant Soft DHA
			"\x{C6}"=>"\x{0BA8}",   #Consonant Soft NA
			"\x{C7}"=>"\x{0BA9}",   #Consonant NA (Tamil)
			"\x{C8}"=>"\x{0BAA}",   #Consonant PA
			"\x{C9}"=>"",   	#Consonant PHA
			"\x{CA}"=>"",   	#Consonant BA
			"\x{CB}"=>"",   	#Consonant BHA
			"\x{CC}"=>"\x{0BAE}",   #Consonant MA
			"\x{CD}"=>"\x{0BAF}",   #Consonant YA
			"\x{CE}"=>"",           #Consonant JYA (Bangla, Assamese & Orriya)
			"\x{CF}"=>"\x{0BB0}",   #Consonant RA
			"\x{D0}"=>"\x{0BB1}",   
		        "\x{D1}"=>"\x{0BB2}",   #Consonant LA
			"\x{D2}"=>"\x{0BB3}",   #Consonant Hard LA
			"\x{D3}"=>"\x{0BB4}",   #Consonant ZHA (Tamil & Malyalam)
			"\x{D4}"=>"\x{0BB5}",   #Consonant VA
			#"\x{D5}"=>"\x{0BB6}",  #Consonant SHA commented because it have same sence of 0BB7 14-Mar-11
			"\x{D5}"=>"\x{0BB7}",   #Consonant SHA is nomore use in tamil
			"\x{D6}"=>"\x{0BB7}",   #Consonant Hard SHA
			"\x{D7}"=>"\x{0BB8}",   #Consonant SA
			"\x{D8}"=>"\x{0BB9}",   #Consonant HA
			"\x{D9}"=>"",           #Consonant INV
			"\x{DA}"=>"\x{0BBE}",   #Vowel Sign AA
			"\x{DB}"=>"\x{0BBF}",   #Vowel Sign I
			"\x{DC}"=>"\x{0BC0}",   #Vowel Sign II
			"\x{DD}"=>"\x{0BC1}",   #Vowel Sign U
			"\x{DE}"=>"\x{0BC2}",   #Vowel Sign UU
			"\x{DF}"=>"",   	#Vowel Sign RI
			"\x{E0}"=>"\x{0BC6}",   #Vowel Sign E (Southern Scripts)
			"\x{E1}"=>"\x{0BC7}",   #Vowel Sign EY
			"\x{E2}"=>"\x{0BC8}",   #Vowel Sign AI
			"\x{E3}"=>"",   	#Vowel Sign AYE (Devanagari Script)
			"\x{E4}"=>"\x{0BCA}",   #Vowel Sign O
			"\x{E5}"=>"\x{0BCB}",   #Vowel Sign OW
			"\x{E6}"=>"\x{0BCC}",   #Vowel Sign AU
			"\x{E7}"=>"",   	#Vowel Sign AWE (Devanagari Script)
			"\x{E8}"=>"\x{0BCD}",   #Vowel Omission Sign (Halant)
			"\x{E9}"=>"",
        		#"\x{EA}"=>"\x{0BE4}",   #Full Stop (Viram, Northern Scripts)
        		"\x{EA}"=>".",   	#Full Stop (Viram, Northern Scripts)
			"\x{F1}"=>"\x{0BE6}",   #Digit 0
			"\x{F2}"=>"\x{0BE7}",   #Digit 1
			"\x{F3}"=>"\x{0BE8}",   #Digit 2
			"\x{F4}"=>"\x{0BE9}",   #Digit 3
			"\x{F5}"=>"\x{0BEA}",   #Digit 4
			"\x{F6}"=>"\x{0BEB}",   #Digit 5
			"\x{F7}"=>"\x{0BEC}",   #Digit 6
			"\x{F8}"=>"\x{0BED}",   #Digit 7
			"\x{F9}"=>"\x{0BEE}",   #Digit 8
			"\x{FA}"=>"\x{0BEF}",   #Digit 9
		);     
                            
	$string=~s/([\x{A1}-\x{FA}])/$hash{$1}/g;

	# Return the converted Unicode $string
	return $string;
}

sub iscii2unicode_ori {
	my $string = $_[0];

	#print "ISCII INPUT String is: ", $string;

	my %hash = (
		"\x{A1}"=>"\x{0B01}",	#Vowel-modifier CHANDRABINDU
		"\x{A2}"=>"\x{0B02}",	#Vowel-modifier ANUSWAR
		"\x{A3}"=>"\x{0B03}",	#Vowel-modifier VISARG
		"\x{A4}"=>"\x{0B05}",	#Vowel A
		"\x{A5}"=>"\x{0B06}",	#Vowel AA
		"\x{A6}"=>"\x{0B07}",	#Vowel I
		"\x{A7}"=>"\x{0B08}",	#Vowel II
		"\x{A8}"=>"\x{0B09}",	#Vowel U
		"\x{A9}"=>"\x{0B0A}",	#Vowel UU
		"\x{AA}"=>"\x{0B0B}",	#Vowel RI
		#"\x{AB}"=>"\x{090E}",	#Vowel E
		"\x{AC}"=>"\x{0B0F}",	#Vowel EY
		"\x{AD}"=>"\x{0B10}",	#Vowel AI
		#"\x{B2}"=>"\x{0911}",	#Vowel AWE
		#"\x{AE}"=>"\x{090D}",	#Vowel AI -Rashid added
		#"\x{B2}"=>"\x{090D}",	#Vowel AYE (Devanagari Script)
		#"\x{AF}"=>"\x{0912}",	#Vowel O
		"\x{B0}"=>"\x{0B13}",	#Vowel OW
		"\x{B1}"=>"\x{0B14}",	#Vowel AU
		"\x{B3}"=>"\x{0B15}",	#Consonant KA
		"\x{B4}"=>"\x{0B16}",	#Consonant KHA
		"\x{B5}"=>"\x{0B17}",	#Consonant GA
		"\x{B6}"=>"\x{0B18}",	#Consonant GHA
		"\x{B7}"=>"\x{0B19}",	#Consonant NGA
		"\x{B8}"=>"\x{0B1A}",	#Consonant CHA
		"\x{B9}"=>"\x{0B1B}",	#Consonant CHHA
		"\x{BA}"=>"\x{0B1C}",	#Consonant JA
		"\x{BB}"=>"\x{0B1D}",	#Consonant JHA
		"\x{BC}"=>"\x{0B1E}",	#Consonant JNA
		"\x{BD}"=>"\x{0B1F}",	#Consonant Hard TA
		"\x{BE}"=>"\x{0B20}",	#Consonant Hard THA
		"\x{BF}"=>"\x{0B21}",	#Consonant Hard DA
		"\x{C0}"=>"\x{0B22}",	#Consonant Hard DHA
		"\x{C1}"=>"\x{0B23}",	#Consonant Hard NA
		"\x{C2}"=>"\x{0B24}",	#Consonant Soft TA
		"\x{C3}"=>"\x{0B25}",	#Consonant Soft THA
		"\x{C4}"=>"\x{0B26}",	#Consonant Soft DA
		"\x{C5}"=>"\x{0B27}",	#Consonant Soft DHA
		"\x{C6}"=>"\x{0B28}",	#Consonant Soft NA
		"\x{C7}"=>"",	#Consonant NA (Tamil)
		"\x{C8}"=>"\x{0B2A}",	#Consonant PA
		"\x{C9}"=>"\x{0B2B}",	#Consonant PHA
		"\x{CA}"=>"\x{0B2C}",	#Consonant BA
		"\x{CB}"=>"\x{0B2D}",	#Consonant BHA
		"\x{CC}"=>"\x{0B2E}",	#Consonant MA
		"\x{CD}"=>"\x{0B2F}",	#Consonant YA
		"\x{CE}"=>"",			#Consonant JYA (Bangla, Assamese & Orriya)
		"\x{CF}"=>"\x{0B30}",	#Consonant RA
		"\x{D0}"=>"",	#Consonant Hard RA (Southern Script)
		"\x{D1}"=>"\x{0B32}",	#Consonant LA
		"\x{D2}"=>"\x{0B33}",	#Consonant Hard LA
		"\x{D3}"=>"",	#Consonant ZHA (Tamil & Malyalam)
		"\x{D4}"=>"\x{0B35}",	#Consonant VA
		"\x{D5}"=>"\x{0B36}",	#Consonant SHA
		"\x{D6}"=>"\x{0B37}",	#Consonant Hard SHA
		"\x{D7}"=>"\x{0B38}",	#Consonant SA
		"\x{D8}"=>"\x{0B39}",	#Consonant HA
		"\x{D9}"=>"",			#Consonant INV
		"\x{DA}"=>"\x{0B3E}",	#Vowel Sign AA
		"\x{DB}"=>"\x{0B3F}",	#Vowel Sign I
		"\x{DC}"=>"\x{0B40}",	#Vowel Sign II
		"\x{DD}"=>"\x{0B41}",	#Vowel Sign U
		"\x{DE}"=>"\x{0B42}",	#Vowel Sign UU
		"\x{DF}"=>"\x{0B43}",	#Vowel Sign RI
		"\x{E0}"=>"",	#Vowel Sign E (Southern Scripts)
		"\x{E1}"=>"\x{0B47}",	#Vowel Sign EY
		"\x{E2}"=>"\x{0B48}",	#Vowel Sign AI
		"\x{E3}"=>"",	#Vowel Sign AYE (Devanagari Script)
		"\x{E4}"=>"",	#Vowel Sign O
		"\x{E5}"=>"\x{0B4B}",	#Vowel Sign OW
		"\x{E6}"=>"\x{0B4C}",	#Vowel Sign AU
		"\x{E7}"=>"",	#Vowel Sign AWE (Devanagari Script)
		"\x{E8}"=>"\x{0B4D}",	#Vowel Omission Sign (Halant)
		"\x{E9}"=>"\x{0B3C}",	#Diacritic Sign (Nukta)
		#"\x{EA}"=>"\x{0964}",	#Full Stop (Viram, Northern Scripts)
		"\x{EA}"=>".",	#Full Stop (Viram, Northern Scripts)
		"\x{F1}"=>"\x{0B66}",	#Digit 0
		"\x{F2}"=>"\x{0B67}",	#Digit 1
		"\x{F3}"=>"\x{0B68}",	#Digit 2
		"\x{F4}"=>"\x{0B69}",	#Digit 3
		"\x{F5}"=>"\x{0B6A}",	#Digit 4
		"\x{F6}"=>"\x{0B6B}",	#Digit 5
		"\x{F7}"=>"\x{0B6C}",	#Digit 6
		"\x{F8}"=>"\x{0B6D}",	#Digit 7
		"\x{F9}"=>"\x{0B6E}",	#Digit 8
		"\x{FA}"=>"\x{0B6F}",	#Digit 9 
		);     
                            
	$string=~s/([\x{A1}-\x{FA}])/$hash{$1}/g;

	# Return the converted Unicode $string
	return $string;
}
#Convert Unicode to ISCII

sub unicode2iscii {
	my $string = $_[0];
	if ((lc($_[1]) eq "hin") || (lc($_[1]) eq "")) {
		$string = &unicode2iscii_hin($string);
	} elsif (lc($_[1]) eq "tel") {
		$string = &unicode2iscii_tel($string);
	} elsif (lc($_[1]) eq "pan") {
		$string = &unicode2iscii_pan($string);
	} elsif (lc($_[1]) eq "kan") {
		$string=&unicode2iscii_kan($string);
	} elsif (lc($_[1]) eq "mal") {
		$string=&unicode2iscii_mal($string);
	} elsif (lc($_[1]) eq "ben") {
		$string=&unicode2iscii_ben($string);
	} elsif (lc($_[1]) eq "tam") {
		$string=&unicode2iscii_tam($string);
	} elsif (lc($_[1]) eq "ori") {
		$string=&unicode2iscii_ori($string);
	} else {
		;
	}
	return $string;
}


sub iscii2wx {
	
	my $string = $_[0];

	my %hash_c = (
		"\x{B3}"=>"k",
		"\x{B4}"=>"K",
		"\x{B5}"=>"g",
		"\x{B6}"=>"G",
		"\x{B7}"=>"f",
		"\x{B8}"=>"c",
		"\x{B9}"=>"C",
		"\x{BA}"=>"j",
		"\x{BB}"=>"J",
		"\x{BC}"=>"F",
		"\x{BD}"=>"t",
		"\x{BE}"=>"T",
		"\x{BF}"=>"d",
		"\x{C0}"=>"D",
		"\x{C1}"=>"N",
		"\x{C2}"=>"w",
		"\x{C3}"=>"W",
		"\x{C4}"=>"x",
		"\x{C5}"=>"X",
		"\x{C6}"=>"n",
		"\x{C7}"=>"nY",      #Representation for Consonant NA (Tamil) ??? Refer to ISCII-91.pdf page-16 -Rashid
		"\x{C8}"=>"p",
		"\x{C9}"=>"P",
		"\x{CA}"=>"b",
		"\x{CB}"=>"B",
		"\x{CC}"=>"m",
		"\x{CD}"=>"y",
		"\x{CE}"=>"",      #Representation for Consonant JYA in Bangla & Oriya??
		"\x{CF}"=>"r",
		"\x{D0}"=>"rY",      #Representation for Consonant HARD RA (Southern Script) -Rashid
		"\x{D1}"=>"l",
		"\x{D2}"=>"lY",
		"\x{D3}"=>"lYY",      #Representation for Consonant ZHA (Tamil & Malyalam) - Rashid
		"\x{D4}"=>"v",
		"\x{D5}"=>"S",
		"\x{D6}"=>"R",
		"\x{D7}"=>"s",
		"\x{D8}"=>"h",
		"\x{E9}"=>"Z",    #NUKTA
	);


	my %hash_v = (
		"\x{A4}"=>"a",
		"\x{A5}"=>"A", 
		"\x{A6}"=>"i", 
		"\x{A7}"=>"I", 
		"\x{A8}"=>"u",
		"\x{A9}"=>"U",
		"\x{AA}"=>"q",
		"\x{AB}"=>"eV",
		"\x{AC}"=>"e",
		"\x{AD}"=>"E",
		"\x{AE}"=>"EY",
		"\x{AF}"=>"oV",
		"\x{B0}"=>"o",
		"\x{B1}"=>"O",
		"\x{B2}"=>"OY",
	);

	my %hash_m = (
		"\x{DA}"=>"A",
		"\x{DB}"=>"i",
		"\x{DC}"=>"I",
		"\x{DD}"=>"u",
		"\x{DE}"=>"U",
		"\x{DF}"=>"q",
		"\x{E0}"=>"eV",
		"\x{E1}"=>"e",
		"\x{E2}"=>"E",
		"\x{E3}"=>"EY",
		"\x{E4}"=>"oV",
		"\x{E5}"=>"o",
		"\x{E6}"=>"O",
		"\x{E7}"=>"OY",
	);

	my %hash_mod = (
		"\x{A1}"=>"z",
		"\x{A2}"=>"M",
		"\x{A3}"=>"H",
	);

	my %digits = (
		"\x{F1}"=>0,
		"\x{F2}"=>1,
		"\x{F3}"=>2,
		"\x{F4}"=>3,
		"\x{F5}"=>4,
		"\x{F6}"=>5,
		"\x{F7}"=>6,
		"\x{F8}"=>7,
		"\x{F9}"=>8,
		"\x{FA}"=>9,
	);

    # CONSONANT+HALANT
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D8}])\x{E8}/$hash_c{$1}/g; 
    $string =~ s/([\x{B3}-\x{D8}])\x{E8}/$hash_c{$1}/g;

    # CONSONANT+NUKTA+MATRA+MODIFIER 
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D3}\x{D4}-\x{D8}])(\x{E9})([\x{DA}-\x{E7}])([\x{A1}-\x{A3}])/$hash_c{$1}$hash_c{$2}$hash_m{$3}$hash_mod{$4}/g; 
    $string =~ s/([\x{B3}-\x{D8}])(\x{E9})([\x{DA}-\x{E7}])([\x{A1}-\x{A3}])/$hash_c{$1}$hash_c{$2}$hash_m{$3}$hash_mod{$4}/g;

    # CONSONANT+NUKTA+MATRA 
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D3}\x{D4}-\x{D8}])(\x{E9})([\x{DA}-\x{E7}])/$hash_c{$1}$hash_c{$2}$hash_m{$3}/g;
    $string =~ s/([\x{B3}-\x{D8}])(\x{E9})([\x{DA}-\x{E7}])/$hash_c{$1}$hash_c{$2}$hash_m{$3}/g; 
    
    # CONSONANT+NUKTA+MODIFIER 
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D3}\x{D4}-\x{D8}])(\x{E9})([\x{A1}-\x{A3}])/$hash_c{$1}$hash_c{$2}$hash_mod{$3}/g;
    $string =~ s/([\x{B3}-\x{D8}])(\x{E9})([\x{A1}-\x{A3}])/$hash_c{$1}$hash_c{$2}$hash_mod{$3}/g; 
    
	# CONSONANT+NUKTA+HALANT (added -Rashid 29-December-11 wanaKZvaxara)
	$string =~ s/([\x{B3}-\x{D8}])(\x{E9})(\x{E8})/$hash_c{$1}$hash_c{$2}/g; 
    
    # CONSONANT+NUKTA 
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D3}\x{D4}-\x{D8}])(\x{E9})/$hash_c{$1}$hash_c{$2}a/g;
    $string =~ s/([\x{B3}-\x{D8}])(\x{E9})/$hash_c{$1}$hash_c{$2}a/g;

    # CONSONANT+MATRA+MODIFIER 
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D3}\x{D4}-\x{D8}])([\x{DA}-\x{E7}])([\x{A1}-\x{A3}])/$hash_c{$1}$hash_m{$2}$hash_mod{$3}/g;
    $string =~ s/([\x{B3}-\x{D8}])([\x{DA}-\x{E7}])([\x{A1}-\x{A3}])/$hash_c{$1}$hash_m{$2}$hash_mod{$3}/g; 
    
    # CONSONANT+MATRA 
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D3}\x{D4}-\x{D8}])([\x{DA}-\x{E7}])/$hash_c{$1}$hash_m{$2}/g;
    $string =~ s/([\x{B3}-\x{D8}])([\x{DA}-\x{E7}])/$hash_c{$1}$hash_m{$2}/g; 
    
    #CONSONANT+MODIFIER 
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D3}\x{D4}-\x{D8}])([\x{A1}-\x{A3}])/$hash_c{$1}a$hash_mod{$2}/g;
    $string =~ s/([\x{B3}-\x{D8}])([\x{A1}-\x{A3}])/$hash_c{$1}a$hash_mod{$2}/g;

    #CONSONANT 
    #$string=~s/([\x{B3}-\x{C7}\x{C8}-\x{CD}\x{CF}\x{D0}-\x{D3}\x{D4}-\x{D8}])/$hash_c{$1}a/g;
    $string =~ s/([\x{B3}-\x{D8}])/$hash_c{$1}a/g; 
    
    #VOWEL+MODIFIER, VOWEL 
    $string =~ s/([\x{A5}-\x{B2}])([\x{A1}-\x{A3}])/$hash_v{$1}$hash_mod{$2}/g; 
    $string =~ s/[\x{A4}]([\x{A1}-\x{A3}])/a$hash_mod{$1}/g; 
    $string =~ s/([\x{A5}-\x{B2}])/$hash_v{$1}/g;

    #VOWEL A, FULL STOP or VIRAM Northern Scripts 
    $string =~ s/\x{A4}/a/g; 
    $string =~ s/\x{EA}/\./g;

    #For PUNJABI ADDAK 
    $string =~ s/\x{FB}/Y/g;

    #Replace ISCII Digits with Roman
    $string =~ s/([\x{F1}-\x{FA}])/$digits{$1}/g;

    #print "WX String is: ", $string, "\n"; 
    return $string;

}	

				
sub unicode2iscii_hin {
	my $string = $_[0];
	my %hash = ( 
		"\x{0901}"=>"\x{A1}",		#Vowel-modifier CHANDRABINDU
		"\x{0902}"=>"\x{A2}",       #Vowel-modifier ANUSWAR
		"\x{0903}"=>"\x{A3}",       #Vowel-modifier VISARG
		"\x{0904}"=>"",
		"\x{0905}"=>"\x{A4}",		#Vowel A
		"\x{0906}"=>"\x{A5}",       #Vowel AA
		"\x{0907}"=>"\x{A6}",       #Vowel I
		"\x{0908}"=>"\x{A7}",       #Vowel II
		"\x{0909}"=>"\x{A8}",       #Vowel U
		"\x{090A}"=>"\x{A9}",       #Vowel UU
		"\x{090B}"=>"\x{AA}",       #Vowel RI
		"\x{090C}"=>"",
		"\x{090D}"=>"\x{AE}",
		"\x{090E}"=>"\x{AB}",
		"\x{090F}"=>"\x{AC}",
		"\x{0910}"=>"\x{AD}",
		"\x{0911}"=>"\x{B2}",
		"\x{0912}"=>"\x{AF}",
		"\x{0913}"=>"\x{B0}",
		"\x{0914}"=>"\x{B1}",
		"\x{0915}"=>"\x{B3}",		#Consonant KA
		"\x{0916}"=>"\x{B4}",		#Consonant
		"\x{0917}"=>"\x{B5}",		#Consonant
		"\x{0918}"=>"\x{B6}",       #Consonant
		"\x{0919}"=>"\x{B7}",		#Consonant NGA
		"\x{091A}"=>"\x{B8}",       #Consonant
		"\x{091B}"=>"\x{B9}",       #Consonant
		"\x{091C}"=>"\x{BA}",       #Consonant
		"\x{091D}"=>"\x{BB}",		#Consonant
		"\x{091E}"=>"\x{BC}",       #Consonant JNA
		"\x{091F}"=>"\x{BD}",       #Consonant
		"\x{0920}"=>"\x{BE}",       #Consonant
		"\x{0921}"=>"\x{BF}",       #Consonant
		"\x{0922}"=>"\x{C0}",       #Consonant
		"\x{0923}"=>"\x{C1}",       #Consonant NA
		"\x{0924}"=>"\x{C2}",       #Consonant
		"\x{0925}"=>"\x{C3}",		#Consonant
		"\x{0926}"=>"\x{C4}",       #Consonant
		"\x{0927}"=>"\x{C5}",       #Consonant
		"\x{0928}"=>"\x{C6}",       #Consonant NA
		"\x{0929}"=>"\x{C7}",       #Consonant NNNA
		"\x{092A}"=>"\x{C8}",       #Consonant PA
		"\x{092B}"=>"\x{C9}",       #Consonant PHA
		"\x{092C}"=>"\x{CA}",       #Consonant BA
		"\x{092D}"=>"\x{CB}",       #Consonant BHA
		"\x{092E}"=>"\x{CC}",       #Consonant MA
		"\x{092F}"=>"\x{CD}",       #Consonant YA
		"\x{0930}"=>"\x{CF}",       #Consonant RA
		"\x{0931}"=>"\x{D0}",       #Consonant RRA
		"\x{0932}"=>"\x{D1}",       #Consonant LA
		"\x{0933}"=>"\x{D2}",       #Consonant LLA
		"\x{0934}"=>"\x{D3}",       #Consonant LLLA
		"\x{0935}"=>"\x{D4}",		#Consonant VA
		"\x{0936}"=>"\x{D5}",       #Consonant SHA
		"\x{0937}"=>"\x{D6}",       #Consonant SSA
		"\x{0938}"=>"\x{D7}",       #Consonant SA
		"\x{0939}"=>"\x{D8}",       #Consonant HA
		"\x{093A}"=>"",             #Consonant
		"\x{093B}"=>"",             #Consonant
		"\x{093C}"=>"\x{E9}",       #Consonant NUKTA
		"\x{093D}"=>"",             #Consonant AVAGRAHA
		"\x{093E}"=>"\x{DA}",       #Vowel Sign AA
		"\x{093F}"=>"\x{DB}",       #Vowel Sign I
		"\x{0940}"=>"\x{DC}",       #Vowel Sign II
		"\x{0941}"=>"\x{DD}",       #Vowel Sign U
		"\x{0942}"=>"\x{DE}",       #Vowel 
		"\x{0943}"=>"\x{DF}",       #Vowel
		"\x{0944}"=>"",             #Vowel
		"\x{0945}"=>"",             #Vowel
		"\x{0946}"=>"\x{E0}",       #Vowel
		"\x{0947}"=>"\x{E1}",       #Vowel
		"\x{0948}"=>"\x{E2}",       #Vowel
		"\x{0949}"=>"\x{E7}",       #Vowel
		"\x{094A}"=>"\x{E4}",       #Vowel
		"\x{094B}"=>"\x{E5}",       #Vowel
		"\x{094C}"=>"\x{E6}",       #Vowel
		"\x{094D}"=>"\x{E8}",       # Halant
		"\x{0950}"=>"",             #Consonant
		"\x{0964}"=>"\x{EA}",       #Consonant
		"\x{0966}"=>"\x{F1}",       #Devanagari Digit 0
		"\x{0967}"=>"\x{F2}",       #Devanagari Digit 1
		"\x{0968}"=>"\x{F3}",       #Devanagari Digit 2
		"\x{0969}"=>"\x{F4}",       #Devanagari Digit 3
		"\x{096A}"=>"\x{F5}",       #Devanagari Digit 4
		"\x{096B}"=>"\x{F6}",		#Devanagari Digit 5
		"\x{096C}"=>"\x{F7}",		#Devanagari Digit 6
		"\x{096D}"=>"\x{F8}",		#Devanagari Digit 7
		"\x{096E}"=>"\x{F9}",		#Devanagari Digit 8
		"\x{096F}"=>"\x{FA}",		#Devanagari Digit 9
	);

	my %unicode_norm_hash = (
		"\x{0958}"=>"\x{0915}",
		"\x{0959}"=>"\x{0916}",
		"\x{095A}"=>"\x{0917}",
		"\x{095B}"=>"\x{091C}",
		"\x{095C}"=>"\x{0921}",
		"\x{095D}"=>"\x{0922}",
		"\x{095E}"=>"\x{092B}",
		"\x{095F}"=>"\x{092F}",
	);
	# Normalize Unicode values (NUKTA variations)
	$string=~s/([\x{0958}-\x{095F}])/$unicode_norm_hash{$1}\x{093C}/g;
	# Convert Unicode values to ISCII values
	$string=~s/([\x{0900}-\x{097F}])/$hash{$1}/g;
	return $string;

}


sub unicode2iscii_tel {
	my $string = $_[0];
	my %hash = ( 
		"\x{0C01}"=>"\x{A1}",
		"\x{0C02}"=>"\x{A2}",
		"\x{0C03}"=>"\x{A3}",
		"\x{0C04}"=>"",
		"\x{0C05}"=>"\x{A4}",
		"\x{0C06}"=>"\x{A5}",
		"\x{0C07}"=>"\x{A6}",
		"\x{0C08}"=>"\x{A7}",
		"\x{0C09}"=>"\x{A8}",
		"\x{0C0A}"=>"\x{A9}",
		"\x{0C0B}"=>"\x{AA}",
		"\x{0C0C}"=>"",
		"\x{0C0D}"=>"\x{AE}",
		"\x{0C0E}"=>"\x{AB}",
		"\x{0C0F}"=>"\x{AC}",
		"\x{0C10}"=>"\x{AD}",
		"\x{0C11}"=>"\x{B2}",
		"\x{0C12}"=>"\x{AF}",
		"\x{0C13}"=>"\x{B0}",
		"\x{0C14}"=>"\x{B1}",
		"\x{0C15}"=>"\x{B3}",
		"\x{0C16}"=>"\x{B4}",
		"\x{0C17}"=>"\x{B5}",
		"\x{0C18}"=>"\x{B6}",
		"\x{0C19}"=>"\x{B7}",
		"\x{0C1A}"=>"\x{B8}",
		"\x{0C1B}"=>"\x{B9}",
		"\x{0C1C}"=>"\x{BA}",
		"\x{0C1D}"=>"\x{BB}",
		"\x{0C1E}"=>"\x{BC}",
		"\x{0C1F}"=>"\x{BD}",
		"\x{0C20}"=>"\x{BE}",
		"\x{0C21}"=>"\x{BF}",
		"\x{0C22}"=>"\x{C0}",
		"\x{0C23}"=>"\x{C1}",
		"\x{0C24}"=>"\x{C2}",
		"\x{0C25}"=>"\x{C3}",
		"\x{0C26}"=>"\x{C4}",
		"\x{0C27}"=>"\x{C5}",
		"\x{0C28}"=>"\x{C6}",
		"\x{0C29}"=>"\x{C7}",
		"\x{0C2A}"=>"\x{C8}",
		"\x{0C2B}"=>"\x{C9}",
		"\x{0C2C}"=>"\x{CA}",
		"\x{0C2D}"=>"\x{CB}",
		"\x{0C2E}"=>"\x{CC}",
		"\x{0C2F}"=>"\x{CD}",
		"\x{0C30}"=>"\x{CF}",
		"\x{0C31}"=>"\x{D0}",
		"\x{0C32}"=>"\x{D1}",
		"\x{0C33}"=>"\x{D2}",
		"\x{0C34}"=>"\x{D3}",
		"\x{0C35}"=>"\x{D4}",
		"\x{0C36}"=>"\x{D5}",
		"\x{0C37}"=>"\x{D6}",
		"\x{0C38}"=>"\x{D7}",
		"\x{0C39}"=>"\x{D8}",
		"\x{0C3A}"=>"",
		"\x{0C3B}"=>"",
		"\x{0C3C}"=>"",
		"\x{0C3D}"=>"",
		"\x{0C3E}"=>"\x{DA}",
		"\x{0C3F}"=>"\x{DB}",
		"\x{0C40}"=>"\x{DC}",
		"\x{0C41}"=>"\x{DD}",
		"\x{0C42}"=>"\x{DE}",
		"\x{0C43}"=>"\x{DF}",
		"\x{0C44}"=>"",
		"\x{0C45}"=>"",
		"\x{0C46}"=>"\x{E0}",
		"\x{0C47}"=>"\x{E1}",
		"\x{0C48}"=>"\x{E2}",
		"\x{0C49}"=>"",
		"\x{0C4A}"=>"\x{E4}",
		"\x{0C4B}"=>"\x{E5}",
		"\x{0C4C}"=>"\x{E6}",
		"\x{0C4D}"=>"\x{E8}",
		"\x{0C50}"=>"",
		"\x{0C64}"=>"\x{EA}",
		"\x{0C66}"=>"\x{F1}",
		"\x{0C67}"=>"\x{F2}",
		"\x{0C68}"=>"\x{F3}",
		"\x{0C69}"=>"\x{F4}",
		"\x{0C6A}"=>"\x{F5}",
		"\x{0C6B}"=>"\x{F6}",
		"\x{0C6C}"=>"\x{F7}",
		"\x{0C6D}"=>"\x{F8}",
		"\x{0C6E}"=>"\x{F9}",
		"\x{0C6F}"=>"\x{FA}",
	);
	# Convert Telugu Unicode values to ISCII values
	#my $string=~s/([\x{0C00}-\x{0C7f}])/$hash{$1}/g; // asked the harika why this statement is changed?
	$string=~s/([\x{0C01}-\x{0C6F}])/$hash{$1}/g;
	return $string;

}


sub unicode2iscii_pan {
	my $string = $_[0];
	my %hash = ( 
		#"\x{0A01}"=>"\x{A1}",       #Vowel-modifier CHANDRABINDU -Rashid
		"\x{0A02}"=>"\x{A2}",       #Vowel-modifier ANUSWAR
		"\x{0A04}"=>"",
		"\x{0A05}"=>"\x{A4}",		#Vowel A
		"\x{0A06}"=>"\x{A5}",       #Vowel AA
		"\x{0A07}"=>"\x{A6}",       #Vowel I
		"\x{0A08}"=>"\x{A7}",       #Vowel II
		"\x{0A09}"=>"\x{A8}",       #Vowel U
		"\x{0A0A}"=>"\x{A9}",       #Vowel UU
		"\x{0A0B}"=>"\x{AA}",       #Vowel RI
		"\x{0A0C}"=>"",
		"\x{0A0D}"=>"\x{AE}",
		"\x{0A0E}"=>"\x{AB}",
		"\x{0A0F}"=>"\x{AC}",
		"\x{0A10}"=>"\x{AD}",
		"\x{0A11}"=>"\x{B2}",
		"\x{0A12}"=>"\x{AF}",
		"\x{0A13}"=>"\x{B0}",
		"\x{0A14}"=>"\x{B1}",
		"\x{0A15}"=>"\x{B3}",		#Consonant KA
		"\x{0A16}"=>"\x{B4}",		#Consonant
		"\x{0A17}"=>"\x{B5}",		#Consonant
		"\x{0A18}"=>"\x{B6}",       #Consonant
		"\x{0A19}"=>"\x{B7}",		#Consonant NGA
		"\x{0A1A}"=>"\x{B8}",       #Consonant
		"\x{0A1B}"=>"\x{B9}",       #Consonant
		"\x{0A1C}"=>"\x{BA}",       #Consonant
		"\x{0A1D}"=>"\x{BB}",		#Consonant
		"\x{0A1E}"=>"\x{BC}",       #Consonant JNA
		"\x{0A1F}"=>"\x{BD}",       #Consonant
		"\x{0A20}"=>"\x{BE}",       #Consonant
		"\x{0A21}"=>"\x{BF}",       #Consonant
		"\x{0A22}"=>"\x{C0}",       #Consonant
		"\x{0A23}"=>"\x{C1}",       #Consonant NA
		"\x{0A24}"=>"\x{C2}",       #Consonant
		"\x{0A25}"=>"\x{C3}",		#Consonant
		"\x{0A26}"=>"\x{C4}",       #Consonant
		"\x{0A27}"=>"\x{C5}",       #Consonant
		"\x{0A28}"=>"\x{C6}",       #Consonant NA
		"\x{0A29}"=>"\x{C7}",       #Consonant NNNA
		"\x{0A2A}"=>"\x{C8}",       #Consonant PA
		"\x{0A2B}"=>"\x{C9}",       #Consonant PHA
		"\x{0A2C}"=>"\x{CA}",       #Consonant BA
		"\x{0A2D}"=>"\x{CB}",       #Consonant BHA
		"\x{0A2E}"=>"\x{CC}",       #Consonant MA
		"\x{0A2F}"=>"\x{CD}",       #Consonant YA
		"\x{0A30}"=>"\x{CF}",       #Consonant RA
		"\x{0A31}"=>"\x{D0}",       #Consonant RRA
		"\x{0A32}"=>"\x{D1}",       #Consonant LA
		"\x{0A33}"=>"\x{D2}",       #Consonant LLA
		"\x{0A34}"=>"\x{D3}",       #Consonant LLLA
		"\x{0A35}"=>"\x{D4}",		#Consonant VA
		"\x{0A36}"=>"\x{D5}",       #Consonant SHA
		"\x{0A37}"=>"\x{D6}",       #Consonant SSA
		"\x{0A38}"=>"\x{D7}",       #Consonant SA
		"\x{0A39}"=>"\x{D8}",       #Consonant HA
		"\x{0A3A}"=>"",             #Consonant
		"\x{0A3B}"=>"",             #Consonant
		"\x{0A3C}"=>"\x{E9}",       #Consonant NUKTA
		"\x{0A3D}"=>"",             #Consonant AVAGRAHA
		"\x{0A3E}"=>"\x{DA}",       #Vowel Sign AA
		"\x{0A3F}"=>"\x{DB}",       #Vowel Sign I
		"\x{0A40}"=>"\x{DC}",       #Vowel Sign II
		"\x{0A41}"=>"\x{DD}",       #Vowel Sign U
		"\x{0A42}"=>"\x{DE}",       #Vowel 
		"\x{0A43}"=>"\x{DF}",       #Vowel
		"\x{0A44}"=>"",             #Vowel
		"\x{0A45}"=>"",             #Vowel
		"\x{0A46}"=>"\x{E0}",       #Vowel
		"\x{0A47}"=>"\x{E1}",       #Vowel
		"\x{0A48}"=>"\x{E2}",       #Vowel
		"\x{0A49}"=>"\x{E7}",       #Vowel
		"\x{0A4A}"=>"\x{E4}",       #Vowel
		"\x{0A4B}"=>"\x{E5}",       #Vowel
		"\x{0A4C}"=>"\x{E6}",       #Vowel
		"\x{0A4D}"=>"\x{E8}",       #Vowel Omission Sign Halant
		"\x{0A5C}"=>"\x{E8}",       #Vowel Omission Sign Halant
		"\x{0A64}"=>"\x{EA}",       #PURNA VIRAM has to be handled separately
		"\x{0A66}"=>"\x{F1}",       #Consonant
		"\x{0A67}"=>"\x{F2}",       #Consonant
		"\x{0A68}"=>"\x{F3}",       #Consonant
		"\x{0A69}"=>"\x{F4}",       #Consonant
		"\x{0A6A}"=>"\x{F5}",       #Consonant
		"\x{0A6B}"=>"\x{F6}",
		"\x{0A6C}"=>"\x{F7}",
		"\x{0A6D}"=>"\x{F8}",
		"\x{0A6E}"=>"\x{F9}",
		"\x{0A6F}"=>"\x{FA}",
		"\x{0A70}"=>"\x{A1}",		#Vowel-modifier GURMUKHI TIPPI
		"\x{0A71}"=>"\x{FB}",		#GURMUKHI ADDAK
	);

	my %unicode_norm_hash = (
		"\x{0A59}"=>"\x{0A16}",
		"\x{0A5A}"=>"\x{0A17}",
		"\x{0A5B}"=>"\x{0A1C}",
		"\x{0A5E}"=>"\x{0A2B}",
	);

	# Normalize Unicode values (NUKTA variations)
	$string=~s/([\x{0A59}-\x{0A5B}\x{0A5E}])/$unicode_norm_hash{$1}\x{0A3C}/g;

	#Convert Unicode values 0x0A5C to ISCII 
	$string=~s/\x{0A5C}/\x{BF}\x{E9}/g;

	#Convert Unicode Devanagari VIRAM to ISCII
	$string=~s/\x{0964}/\x{EA}/g;

	#Convert Unicode Punjabi values to ISCII values
	$string=~s/([\x{0A01}-\x{0A75}])/$hash{$1}/g;

	return $string;

}


sub unicode2iscii_kan {
	my $string = $_[0];
	my %hash = ( 
		"\x{0C82}"=>"\x{A2}",       #Vowel-modifier ANUSWAR
		"\x{0C83}"=>"\x{A3}",       #Vowel-modifier VISARG
		"\x{0C84}"=>"",
		"\x{0C85}"=>"\x{A4}",		#Vowel A
		"\x{0C86}"=>"\x{A5}",       #Vowel AA
		"\x{0C87}"=>"\x{A6}",       #Vowel I
		"\x{0C88}"=>"\x{A7}",       #Vowel II
		"\x{0C89}"=>"\x{A8}",       #Vowel U
		"\x{0C8A}"=>"\x{A9}",       #Vowel UU
		"\x{0C8B}"=>"\x{AA}",       #Vowel RI
		"\x{0C8C}"=>"",
		"\x{0C8D}"=>"\x{AE}",
		"\x{0C8E}"=>"\x{AB}",
		"\x{0C8F}"=>"\x{AC}",
		"\x{0C90}"=>"\x{AD}",
		"\x{0C91}"=>"\x{B2}",
		"\x{0C92}"=>"\x{AF}",
		"\x{0C93}"=>"\x{B0}",
		"\x{0C94}"=>"\x{B1}",
		"\x{0C95}"=>"\x{B3}",		#Consonant KA
		"\x{0C96}"=>"\x{B4}",		#Consonant
		"\x{0C97}"=>"\x{B5}",		#Consonant
		"\x{0C98}"=>"\x{B6}",       #Consonant
		"\x{0C99}"=>"\x{B7}",		#Consonant NGA
		"\x{0C9A}"=>"\x{B8}",       #Consonant
		"\x{0C9B}"=>"\x{B9}",       #Consonant
		"\x{0C9C}"=>"\x{BA}",       #Consonant
		"\x{0C9D}"=>"\x{BB}",		#Consonant
		"\x{0C9E}"=>"\x{BC}",       #Consonant JNA
		"\x{0C9F}"=>"\x{BD}",       #Consonant
		"\x{0CA0}"=>"\x{BE}",       #Consonant
		"\x{0CA1}"=>"\x{BF}",       #Consonant
		"\x{0CA2}"=>"\x{C0}",       #Consonant
		"\x{0CA3}"=>"\x{C1}",       #Consonant NA
		"\x{0CA4}"=>"\x{C2}",       #Consonant
		"\x{0CA5}"=>"\x{C3}",		#Consonant
		"\x{0CA6}"=>"\x{C4}",       #Consonant
		"\x{0CA7}"=>"\x{C5}",       #Consonant
		"\x{0CA8}"=>"\x{C6}",       #Consonant NA
		"\x{0CA9}"=>"\x{C7}",       #Consonant NNNA
		"\x{0CAA}"=>"\x{C8}",       #Consonant PA
		"\x{0CAB}"=>"\x{C9}",       #Consonant PHA
		"\x{0CAC}"=>"\x{CA}",       #Consonant BA
		"\x{0CAD}"=>"\x{CB}",       #Consonant BHA
		"\x{0CAE}"=>"\x{CC}",       #Consonant MA
		"\x{0CAF}"=>"\x{CD}",       #Consonant YA
		"\x{0CB0}"=>"\x{CF}",       #Consonant RA
		"\x{0CB1}"=>"\x{D0}",       #Consonant RRA
		"\x{0CB2}"=>"\x{D1}",       #Consonant LA
		"\x{0CB3}"=>"\x{D2}",       #Consonant LLA
		"\x{0CB4}"=>"\x{D3}",       #Consonant LLLA
		"\x{0CB5}"=>"\x{D4}",		#Consonant VA
		"\x{0CB6}"=>"\x{D5}",       #Consonant SHA
		"\x{0CB7}"=>"\x{D6}",       #Consonant SSA
		"\x{0CB8}"=>"\x{D7}",       #Consonant SA
		"\x{0CB9}"=>"\x{D8}",       #Consonant HA
		"\x{0CBC}"=>"\x{E9}",       #Consonant NUKTA
		"\x{0CBD}"=>"",             #Consonant AVAGRAHA
		"\x{0CBE}"=>"\x{DA}",       #Vowel Sign AA
		"\x{0CBF}"=>"\x{DB}",       #Vowel Sign I
		"\x{0CC0}"=>"\x{DC}",       #Vowel Sign II
		"\x{0CC1}"=>"\x{DD}",       #Vowel Sign U
		"\x{0CC2}"=>"\x{DE}",       #Vowel 
		"\x{0CC3}"=>"\x{DF}",       #Vowel
		"\x{0CC4}"=>"",             #Vowel
		"\x{0CC5}"=>"",             #Vowel
		"\x{0CC6}"=>"\x{E0}",       #Vowel
		"\x{0CC7}"=>"\x{E1}",       #Vowel
		"\x{0CC8}"=>"\x{E2}",       #Vowel
		"\x{0CC9}"=>"\x{E7}",       #Vowel
		"\x{0CCA}"=>"\x{E4}",       #Vowel
		"\x{0CCB}"=>"\x{E5}",       #Vowel
		"\x{0CCC}"=>"\x{E6}",       #Vowel
		"\x{0CCD}"=>"\x{E8}",       #Consonant
		"\x{0CD0}"=>"",             #Consonant
		"\x{0CE4}"=>"\x{EA}",       #Consonant
		"\x{0CE6}"=>"\x{F1}",       #Consonant
		"\x{0CE7}"=>"\x{F2}",       #Consonant
		"\x{0CE8}"=>"\x{F3}",       #Consonant
		"\x{0CE9}"=>"\x{F4}",       #Consonant
		"\x{0CEA}"=>"\x{F5}",       #Consonant
		"\x{0CEB}"=>"\x{F6}",
		"\x{0CEC}"=>"\x{F7}",
		"\x{0CED}"=>"\x{F8}",
		"\x{0CEE}"=>"\x{F9}",
		"\x{0CEF}"=>"\x{FA}",
	);

	my %unicode_norm_hash = (
		"\x{0958}"=>"\x{0915}",
		"\x{0959}"=>"\x{0916}",
		"\x{095A}"=>"\x{0917}",
		"\x{095B}"=>"\x{091C}",
		"\x{095C}"=>"\x{0921}",
		"\x{095D}"=>"\x{0922}",
		"\x{095E}"=>"\x{092B}",
		"\x{095F}"=>"\x{092F}",
	);
	# Normalize Unicode values (NUKTA variations), needs to be modified yet, PAWAN
	$string=~s/([\x{0958}-\x{095F}])/$unicode_norm_hash{$1}\x{093C}/g;

	# Convert Unicode values to ISCII values
	$string=~s/([\x{0C80}-\x{0CFF}])/$hash{$1}/g;
	return $string;

}
sub unicode2iscii_mal {
	my $string = $_[0];
	my %hash = ( 
			"\x{0D02}"=>"\x{A2}",       #Vowel-modifier ANUSWAR
			"\x{0D03}"=>"\x{A3}",       #Vowel-modifier VISARG
			"\x{0D04}"=>"",
			"\x{0D05}"=>"\x{A4}",           #Vowel A
			"\x{0D06}"=>"\x{A5}",       #Vowel AA
			"\x{0D07}"=>"\x{A6}",       #Vowel I
			"\x{0D08}"=>"\x{A7}",       #Vowel II
			"\x{0D09}"=>"\x{A8}",       #Vowel U
			"\x{0D0A}"=>"\x{A9}",       #Vowel UU
			"\x{0D0B}"=>"\x{AA}",       #Vowel RI
			"\x{0D0C}"=>"",
			"\x{0D0D}"=>"",
			"\x{0D0E}"=>"\x{AB}",
			"\x{0D0F}"=>"\x{AC}",
			"\x{0D10}"=>"\x{AD}",
			"\x{0D11}"=>"\x{B2}",
			"\x{0D12}"=>"\x{AF}",
			"\x{0D13}"=>"\x{B0}",
			"\x{0D14}"=>"\x{B1}",
			"\x{0D15}"=>"\x{B3}",           #Consonant KA
				"\x{0D16}"=>"\x{B4}",           #Consonant
				"\x{0D17}"=>"\x{B5}",           #Consonant
				"\x{0D18}"=>"\x{B6}",       #Consonant
				"\x{0D19}"=>"\x{B7}",           #Consonant NGA
				"\x{0D1A}"=>"\x{B8}",       #Consonant
				"\x{0D1B}"=>"\x{B9}",       #Consonant
				"\x{0D1C}"=>"\x{BA}",       #Consonant
				"\x{0D1D}"=>"\x{BB}",           #Consonant
				"\x{0D1E}"=>"\x{BC}",       #Consonant JNA
				"\x{0D1F}"=>"\x{BD}",       #Consonant
				"\x{0D20}"=>"\x{BE}",       #Consonant
				"\x{0D21}"=>"\x{BF}",       #Consonant
				"\x{0D22}"=>"\x{C0}",       #Consonant
				"\x{0D23}"=>"\x{C1}",       #Consonant NNA
				"\x{0D24}"=>"\x{C2}",       #Consonant
				"\x{0D25}"=>"\x{C3}",           #Consonant
				"\x{0D26}"=>"\x{C4}",       #Consonant
				"\x{0D27}"=>"\x{C5}",       #Consonant
				"\x{0D28}"=>"\x{C6}",       #Consonant NA
				"\x{0D29}"=>"\x{C7}",       #Consonant NNNA
				"\x{0D2A}"=>"\x{C8}",       #Consonant PA
				"\x{0D2B}"=>"\x{C9}",       #Consonant PHA
				"\x{0D2C}"=>"\x{CA}",       #Consonant BA
				"\x{0D2D}"=>"\x{CB}",       #Consonant BHA
				"\x{0D2E}"=>"\x{CC}",       #Consonant MA
				"\x{0D2F}"=>"\x{CD}",       #Consonant YA
				"\x{0D30}"=>"\x{CF}",       #Consonant RA
				"\x{0D31}"=>"\x{D0}",       #Consonant RRA
				"\x{0D32}"=>"\x{D1}",       #Consonant LA
				"\x{0D33}"=>"\x{D2}",       #Consonant LLA
				"\x{0D34}"=>"\x{D3}",       #Consonant LLLA
				"\x{0D35}"=>"\x{D4}",           #Consonant VA
				"\x{0D36}"=>"\x{D5}",       #Consonant SHA
				"\x{0D37}"=>"\x{D6}",       #Consonant SSA
				"\x{0D38}"=>"\x{D7}",       #Consonant SA
				"\x{0D39}"=>"\x{D8}",       #Consonant HA
				"\x{0D3D}"=>"",             #Consonant AVAGRAHA
				"\x{0D3E}"=>"\x{DA}",       #Vowel Sign AA
				"\x{0D3F}"=>"\x{DB}",       #Vowel Sign I
				"\x{0D40}"=>"\x{DC}",       #Vowel Sign II
				"\x{0D41}"=>"\x{DD}",       #Vowel Sign U
				"\x{0D42}"=>"\x{DE}",       #Vowel
				"\x{0D43}"=>"\x{DF}",       #Vowel
				"\x{0D44}"=>"",             #Vowel
				"\x{0D45}"=>"",             #Vowel
				"\x{0D46}"=>"\x{E0}",       #Vowel
				"\x{0D47}"=>"\x{E1}",       #Vowel
				"\x{0D48}"=>"\x{E2}",       #Vowel
				"\x{0D4A}"=>"\x{E4}",       #Vowel
				"\x{0D4B}"=>"\x{E5}",       #Vowel
				"\x{0D4C}"=>"\x{E6}",       #Vowel
				"\x{0D4D}"=>"\x{E8}",       #Consonant
				"\x{0D64}"=>"\x{EA}",       #Consonant
				"\x{0D66}"=>"\x{F1}",       #Consonant
				"\x{0D67}"=>"\x{F2}",       #Consonant
				"\x{0D68}"=>"\x{F3}",       #Consonant
				"\x{0D69}"=>"\x{F4}",       #Consonant
				"\x{0D6A}"=>"\x{F5}",       #Consonant
				"\x{0D6B}"=>"\x{F6}",
		"\x{0D6C}"=>"\x{F7}",
		"\x{0D6D}"=>"\x{F8}",
		"\x{0D6E}"=>"\x{F9}",
		"\x{0D6F}"=>"\x{FA}",

		);
	# Convert Unicode values to ISCII values
	$string=~s/([\x{0D00}-\x{0D6F}])/$hash{$1}/g;
	return $string;
}

sub unicode2iscii_ben {
	my $string = $_[0];
	my %hash = ( 
			"\x{0981}"=>"\x{A1}",       #vowel-modifier CHANDRABINDU 
			"\x{0982}"=>"\x{A2}",       #Vowel-modifier ANUSWAR
			"\x{0983}"=>"\x{A3}",       #Vowel-modifier VISARG
			"\x{0985}"=>"\x{A4}",       #Vowel A
			"\x{0986}"=>"\x{A5}",       #Vowel AA
			"\x{0987}"=>"\x{A6}",       #Vowel I
			"\x{0988}"=>"\x{A7}",       #Vowel II
			"\x{0989}"=>"\x{A8}",       #Vowel U
			"\x{098A}"=>"\x{A9}",       #Vowel UU
			"\x{098B}"=>"\x{AA}",       #Vowel RI
			"\x{098C}"=>"",
			"\x{098D}"=>"",
			"\x{098E}"=>"",
			"\x{098F}"=>"\x{AB}",
			"\x{0990}"=>"\x{AD}",
			"\x{0991}"=>"",
			"\x{0992}"=>"",
			"\x{0993}"=>"\x{AF}",
			"\x{0994}"=>"\x{B1}",
			"\x{0995}"=>"\x{B3}",           #Consonant KA
				"\x{0996}"=>"\x{B4}",           #Consonant
				"\x{0997}"=>"\x{B5}",           #Consonant
				"\x{0998}"=>"\x{B6}",       #Consonant
				"\x{0999}"=>"\x{B7}",           #Consonant NGA
				"\x{099A}"=>"\x{B8}",       #Consonant
				"\x{099B}"=>"\x{B9}",       #Consonant
				"\x{099C}"=>"\x{BA}",       #Consonant
				"\x{099D}"=>"\x{BB}",           #Consonant
				"\x{099E}"=>"\x{BC}",       #Consonant JNA
				"\x{099F}"=>"\x{BD}",       #Consonant
				"\x{09A0}"=>"\x{BE}",       #Consonant
				"\x{09A1}"=>"\x{BF}",       #Consonant
				"\x{09A2}"=>"\x{C0}",       #Consonant
				"\x{09A3}"=>"\x{C1}",       #Consonant NA
				"\x{09A4}"=>"\x{C2}",       #Consonant
				"\x{09A5}"=>"\x{C3}",           #Consonant
				"\x{09A6}"=>"\x{C4}",       #Consonant
				"\x{09A7}"=>"\x{C5}",       #Consonant
				"\x{09A8}"=>"\x{C6}",       #Consonant NA
				"\x{09A9}"=>"",      
		"\x{09AA}"=>"\x{C8}",       #Consonant PA
			"\x{09AB}"=>"\x{C9}",       #Consonant PHA
			"\x{09AC}"=>"\x{CA}",       #Consonant BA
			"\x{09AD}"=>"\x{CB}",       #Consonant BHA
			"\x{09AE}"=>"\x{CC}",       #Consonant MA
			"\x{09AF}"=>"\x{CD}",       #Consonant YA
			"\x{09B0}"=>"\x{CF}",       #Consonant RA
			"\x{09B1}"=>"",       
		"\x{09B2}"=>"\x{D1}",       #Consonant LA
			"\x{09B3}"=>"",       
		"\x{09B4}"=>"",     
		"\x{09B5}"=>"",           
		"\x{09B6}"=>"\x{D5}",       #Consonant SHA
			"\x{09B7}"=>"\x{D6}",       #Consonant SSA
			"\x{09B8}"=>"\x{D7}",       #Consonant SA
			"\x{09B9}"=>"\x{D8}",       #Consonant HA
			"\x{09BC}"=>"\x{E9}",       #Consonant NUKTA
			"\x{09BD}"=>"",             #Consonant AVAGRAHA
			"\x{09BE}"=>"\x{DA}",       #Vowel Sign AA
			"\x{09BF}"=>"\x{DB}",       #Vowel Sign I
			"\x{09C0}"=>"\x{DC}",       #Vowel Sign II
			"\x{09C1}"=>"\x{DD}",       #Vowel Sign U
			"\x{09C2}"=>"\x{DE}",       #Vowel
			"\x{09C3}"=>"\x{DF}",       #Vowel
			"\x{09C4}"=>"",             #Vowel
			"\x{09C5}"=>"",             #Vowel
			"\x{09C6}"=>"",       #Vowel
			"\x{09C7}"=>"\x{E0}",       #Vowel
			"\x{09C8}"=>"\x{E2}",       #Vowel
			"\x{09CB}"=>"\x{E4}",       #Vowel
			"\x{09CC}"=>"\x{E6}",       #Vowel
			"\x{09CD}"=>"\x{E8}",       #Consonant
			"\x{09CE}"=>"",             #Consonant
			"\x{09E4}"=>"\x{EA}",       #Consonant
			"\x{09E6}"=>"\x{F1}",       #Consonant
			"\x{09E7}"=>"\x{F2}",       #Consonant
			"\x{09E8}"=>"\x{F3}",       #Consonant
			"\x{09E9}"=>"\x{F4}",       #Consonant
			"\x{09EA}"=>"\x{F5}",       #Consonant
			"\x{09EB}"=>"\x{F6}",
		"\x{09EC}"=>"\x{F7}",
		"\x{09ED}"=>"\x{F8}",
		"\x{09EE}"=>"\x{F9}",
		"\x{09EF}"=>"\x{FA}",
		);
	# Convert Unicode values to ISCII values
	$string=~s/([\x{0980}-\x{09EF}])/$hash{$1}/g;
	return $string;
}
sub unicode2iscii_tam {
	my $string = $_[0];
	my %hash = ( 
			"\x{0B82}"=>"\x{A2}",       #Vowel-modifier ANUSWAR
			"\x{0B83}"=>"\x{A3}",       #Vowel-modifier VISARG
			"\x{0B85}"=>"\x{A4}",       #Vowel A
			"\x{0B86}"=>"\x{A5}",       #Vowel AA
			"\x{0B87}"=>"\x{A6}",       #Vowel I
			"\x{0B88}"=>"\x{A7}",       #Vowel II
			"\x{0B89}"=>"\x{A8}",       #Vowel U
			"\x{0B8A}"=>"\x{A9}",       #Vowel UU
			"\x{0B8B}"=>"",             #Vowel RI
			"\x{0B8C}"=>"",
			"\x{0B8D}"=>"",
			"\x{0B8E}"=>"\x{AB}",
			"\x{0B8F}"=>"\x{AC}",
			"\x{0B90}"=>"\x{AD}",
			"\x{0B91}"=>"",
			"\x{0B92}"=>"\x{AF}",   #check here
			"\x{0B93}"=>"\x{B0}",
			"\x{0B94}"=>"\x{B1}",
			"\x{0B95}"=>"\x{B3}",           #Consonant KA
			"\x{0B96}"=>"",           #Consonant
			"\x{0B97}"=>"",           #Consonant
			"\x{0B98}"=>"",       #Consonant
			"\x{0B99}"=>"\x{B7}",           #Consonant NGA
			"\x{0B9A}"=>"\x{B8}",       #Consonant
			"\x{0B9B}"=>"",       #Consonant
			"\x{0B9C}"=>"\x{BA}",       #Consonant
			"\x{0B9D}"=>"",           #Consonant
			"\x{0B9E}"=>"\x{BC}",       #Consonant JNA
			"\x{0B9F}"=>"\x{BD}",       #Consonant
			"\x{0BA0}"=>"",       #Consonant
			"\x{0BA1}"=>"",       #Consonant
			"\x{0BA2}"=>"",       #Consonant
			"\x{0BA3}"=>"\x{C1}",       #Consonant NA
			"\x{0BA4}"=>"\x{C2}",       #Consonant
			"\x{0BA5}"=>"",           #Consonant
			"\x{0BA6}"=>"",       #Consonant
			"\x{0BA7}"=>"",       #Consonant
			"\x{0BA8}"=>"\x{C6}",       #Consonant NA
			"\x{0BA9}"=>"\x{C7}",       #Consonant NNNA
			"\x{0BAA}"=>"\x{C8}",       #Consonant PA
			"\x{0BAB}"=>"",       #Consonant PHA
			"\x{0BAC}"=>"",       #Consonant BA
			"\x{0BAD}"=>"",       #Consonant BHA
			"\x{0BAE}"=>"\x{CC}",       #Consonant MA
			"\x{0BAF}"=>"\x{CD}",       #Consonant YA
			"\x{0BB0}"=>"\x{CF}",       #Consonant RA
			"\x{0BB1}"=>"\x{D0}",       #Consonant RRA
			"\x{0BB2}"=>"\x{D1}",       #Consonant LA
			"\x{0BB3}"=>"\x{D2}",       #Consonant LLA
			"\x{0BB4}"=>"\x{D3}",       #Consonant LLLA
			"\x{0BB5}"=>"\x{D4}",       #Consonant VA
			"\x{0BB6}"=>"\x{D5}",       #Consonant SHA
			"\x{0BB7}"=>"\x{D6}",       #Consonant SSA
			"\x{0BB8}"=>"\x{D7}",       #Consonant SA
			"\x{0BB9}"=>"\x{D8}",       #Consonant HA
			"\x{0BBE}"=>"\x{DA}",       #Vowel Sign AA
			"\x{0BBF}"=>"\x{DB}",       #Vowel Sign I
			"\x{0BC0}"=>"\x{DC}",       #Vowel Sign II
			"\x{0BC1}"=>"\x{DD}",       #Vowel Sign U
			"\x{0BC2}"=>"\x{DE}",       #Vowel
			"\x{0BC3}"=>"",             #Vowel
			"\x{0BC4}"=>"",             #Vowel
			"\x{0BC5}"=>"",             #Vowel
			"\x{0BC6}"=>"\x{E0}",       #Vowel
			"\x{0BC7}"=>"\x{E1}",       #Vowel
			"\x{0BC8}"=>"\x{E2}",       #Vowel
			"\x{0BCA}"=>"\x{E4}",       #Vowel ொ
			"\x{0BCB}"=>"\x{E5}",       #Vowel ோ
			"\x{0BCC}"=>"\x{E6}",       #Vowel ௌ
			"\x{0BCD}"=>"\x{E8}",       #Halant
			"\x{0BD0}"=>"",             #Consonant
			"\x{0BD1}"=>"",
			"\x{0BD2}"=>"",
			"\x{0BD3}"=>"",
			"\x{0BD4}"=>"",
			"\x{0BD5}"=>"",
			"\x{0BD6}"=>"",
			"\x{0BD7}"=>"",
			"\x{0BE4}"=>"\x{EA}",       #Consonant
			"\x{0BE5}"=>"\x{EA}", 
			"\x{0BE6}"=>"\x{F1}",       #Consonant
			"\x{0BE7}"=>"\x{F2}",       #Consonant
			"\x{0BE8}"=>"\x{F3}",       #Consonant
			"\x{0BE9}"=>"\x{F4}",       #Consonant
			"\x{0BEA}"=>"\x{F5}",       #Consonant
			"\x{0BEB}"=>"\x{F6}",
		        "\x{0BEC}"=>"\x{F7}",
		        "\x{0BED}"=>"\x{F8}",
		        "\x{0BEE}"=>"\x{F9}",
		        "\x{0BEF}"=>"\x{FA}",
		);
	# Convert Unicode values to ISCII values
	#$string=~s/([\x{0B80}-\x{0BEF}])/$hash{$1}/g;

	# Rashid is added normalize case for tamil as per feedback
	# normalize two-part dependent vowel sign o ொ 
	$string=~s/\x{0BC6}\x{0BBE}/\x{E4}/g;
	# normalize two-part dependent vowel sign oo ோ 
	$string=~s/\x{0BC7}\x{0BBE}/\x{E5}/g;
	
	$string=~s/([\x{0B82}-\x{0BEF}])/$hash{$1}/g;
	return $string;
}
sub unicode2iscii_ori {
	my $string = $_[0];
	my %hash = ( 
		"\x{0B01}"=>"\x{A1}",		#Vowel-modifier CHANDRABINDU
		"\x{0B02}"=>"\x{A2}",       #Vowel-modifier ANUSWAR
		"\x{0B03}"=>"\x{A3}",       #Vowel-modifier VISARG
		"\x{0904}"=>"",
		"\x{0B05}"=>"\x{A4}",		#Vowel A
		"\x{0B06}"=>"\x{A5}",       #Vowel AA
		"\x{0B07}"=>"\x{A6}",       #Vowel I
		"\x{0B08}"=>"\x{A7}",       #Vowel II
		"\x{0B09}"=>"\x{A8}",       #Vowel U
		"\x{0B0A}"=>"\x{A9}",       #Vowel UU
		"\x{0B0B}"=>"\x{AA}",       #Vowel RI
		"\x{0B0C}"=>"",
		"\x{0B0D}"=>"",
		"\x{0B0E}"=>"",
		"\x{0B0F}"=>"\x{AC}",
		"\x{0910}"=>"\x{AD}",
		"\x{0B11}"=>"",
		"\x{0B12}"=>"",
		"\x{0B13}"=>"\x{B0}",
		"\x{0B14}"=>"\x{B1}",
		"\x{0B15}"=>"\x{B3}",		#Consonant KA
		"\x{0B16}"=>"\x{B4}",		#Consonant
		"\x{0B17}"=>"\x{B5}",		#Consonant
		"\x{0B18}"=>"\x{B6}",       #Consonant
		"\x{0B19}"=>"\x{B7}",		#Consonant NGA
		"\x{0B1A}"=>"\x{B8}",       #Consonant
		"\x{0B1B}"=>"\x{B9}",       #Consonant
		"\x{0B1C}"=>"\x{BA}",       #Consonant
		"\x{0B1D}"=>"\x{BB}",		#Consonant
		"\x{0B1E}"=>"\x{BC}",       #Consonant JNA
		"\x{0B1F}"=>"\x{BD}",       #Consonant
		"\x{0B20}"=>"\x{BE}",       #Consonant
		"\x{0B21}"=>"\x{BF}",       #Consonant
		"\x{0B22}"=>"\x{C0}",       #Consonant
		"\x{0B23}"=>"\x{C1}",       #Consonant NA
		"\x{0B24}"=>"\x{C2}",       #Consonant
		"\x{0B25}"=>"\x{C3}",		#Consonant
		"\x{0B26}"=>"\x{C4}",       #Consonant
		"\x{0B27}"=>"\x{C5}",       #Consonant
		"\x{0B28}"=>"\x{C6}",       #Consonant NA
		"\x{0929}"=>"",       #Consonant NNNA
		"\x{0B2A}"=>"\x{C8}",       #Consonant PA
		"\x{0B2B}"=>"\x{C9}",       #Consonant PHA
		"\x{0B2C}"=>"\x{CA}",       #Consonant BA
		"\x{0B2D}"=>"\x{CB}",       #Consonant BHA
		"\x{0B2E}"=>"\x{CC}",       #Consonant MA
		"\x{0B2F}"=>"\x{CD}",       #Consonant YA
		"\x{0B30}"=>"\x{CF}",       #Consonant RA
		"\x{0931}"=>"",       #Consonant RRA
		"\x{0B32}"=>"\x{D1}",       #Consonant LA
		"\x{0B33}"=>"\x{D2}",       #Consonant LLA
		"\x{0934}"=>"",       #Consonant LLLA
		"\x{0935}"=>"\x{D4}",		#Consonant VA
		"\x{0B36}"=>"\x{D5}",       #Consonant SHA
		"\x{0B37}"=>"\x{D6}",       #Consonant SSA
		"\x{0B38}"=>"\x{D7}",       #Consonant SA
		"\x{0B39}"=>"\x{D8}",       #Consonant HA
		"\x{0B3A}"=>"",             #Consonant
		"\x{0B3B}"=>"",             #Consonant
		"\x{0B3C}"=>"\x{E9}",       #Consonant NUKTA
		"\x{0B3D}"=>"",             #Consonant AVAGRAHA
		"\x{0B3E}"=>"\x{DA}",       #Vowel Sign AA
		"\x{0B3F}"=>"\x{DB}",       #Vowel Sign I
		"\x{0B40}"=>"\x{DC}",       #Vowel Sign II
		"\x{0B41}"=>"\x{DD}",       #Vowel Sign U
		"\x{0B42}"=>"\x{DE}",       #Vowel 
		"\x{0B43}"=>"\x{DF}",       #Vowel
		"\x{0B44}"=>"",             #Vowel
		"\x{0B45}"=>"",             #Vowel
		"\x{0B46}"=>"",       #Vowel
		"\x{0B47}"=>"\x{E1}",       #Vowel
		"\x{0B48}"=>"\x{E2}",       #Vowel
		"\x{0B49}"=>"",       #Vowel
		"\x{0B4A}"=>"",       #Vowel
		"\x{0B4B}"=>"\x{E5}",       #Vowel O
		"\x{0B4C}"=>"\x{E6}",       #Vowel OU
		"\x{0B4D}"=>"\x{E8}",       # Halant
		"\x{0B50}"=>"",             #Consonant
		"\x{0964}"=>"\x{EA}",       #Full stop use Devanagri
		"\x{0B66}"=>"\x{F1}",       # Digit 0
		"\x{0B67}"=>"\x{F2}",       # Digit 1
		"\x{0B68}"=>"\x{F3}",       # Digit 2
		"\x{0B69}"=>"\x{F4}",       # Digit 3
		"\x{0B6A}"=>"\x{F5}",       # Digit 4
		"\x{0B6B}"=>"\x{F6}",		# Digit 5
		"\x{0B6C}"=>"\x{F7}",		# Digit 6
		"\x{0B6D}"=>"\x{F8}",		# Digit 7
		"\x{0B6E}"=>"\x{F9}",		# Digit 8
		"\x{0B6F}"=>"\x{FA}",		# Digit 9
	);

	#my %unicode_norm_hash = (
	#	"\x{0958}"=>"\x{0915}",
	#	"\x{0959}"=>"\x{0916}",
	#	"\x{095A}"=>"\x{0917}",
	#	"\x{095B}"=>"\x{091C}",
	#	"\x{095C}"=>"\x{0921}",
	#	"\x{095D}"=>"\x{0922}",
	#	"\x{095E}"=>"\x{092B}",
	#	"\x{095F}"=>"\x{092F}",
	#);
	# Normalize Unicode values (NUKTA variations)
	#$string=~s/([\x{0958}-\x{095F}])/$unicode_norm_hash{$1}\x{093C}/g;

	# Convert Unicode values to ISCII values
	$string=~s/([\x{0B00}-\x{0B7F}])/$hash{$1}/g;
	return $string;

}

sub utf2wx {
	my $string = $_[0];
	my $lang = $_[1];
        # don't convert string precede by @
        #if ($string =~ /^\@.*/)
        #{
        #    return $string;
        #}
        #Convert UTF-8 string to Unicode
        $flag = utf8::decode($string);
        #Convert Unicode values with ISCII values
        $string = &unicode2iscii($string, $lang);
        #print "ISCII string: $string\n";
        #Convert ISCII to WX-Roman
        $string = &iscii2wx($string);
        #print "Wx string : $string\n";
        return $string;
}

sub wx2utf {
	my $string = $_[0];
	my $lang = $_[1];
        #binmode (STDOUT, ":utf8");
	# don't convert string precede by @
	#if ($string =~ /^\@.*/) 
	#{
	#	return $string;
	#}
        
        # escape the other language only consider wx notation.
        utf8::decode($string);
        $firstchar = substr($string, 0, 1);
        $val = ord($firstchar);
        if ($val >= 255)
        {
            #$octet = encode("utf8",$string);
            return $string;
        } # end escape
        
	# Convert WX-Roman to ISCII
	$string = &wx2iscii($string);
        #print "ISCII string $string\n";
	# Convert ISCII to Unicode
	$string = &iscii2unicode($string, $lang);
        #print "unicode string $string\n";
	#Convert Unicode to utf-8
	$octet = encode("utf8", $string);
	#print "UTF-8 string is: ", $string, "\n";
	return $string;	
}


sub findlang
{
        $string = $_[0];
	#if($string =~/([0-9]+\_)(.*)/)
	#{
	#	$string = $2;
	#}
        
        #@letter = split(//,$string);
        utf8::decode($string);
        $firstchar = substr($string, 0, 1);
        $val = ord($firstchar);
        #print "$val\n";
        if($val >= 2304 and $val <= 2431)
        {
                $result = "hin";
        }
        elsif($val >= 2432 and $val <= 2559)
        {
                $result = "ben";
        }
        elsif($val >= 2560 and $val <= 2659)
        {
                $result = "pan";
        }
        elsif($val >= 2944 and $val <= 3071)
        {
                $result = "tam";
        }
        elsif($val >= 3072 and $val <= 3199)
        {
                $result = "tel";
        }
        elsif($val >= 3200 and $val <= 3327)
	{
                $result = "kan";
        }
        elsif($val >= 3328 and $val <= 3455)
        {
                $result = "mal";
        }
        elsif($val >= 1536 and $val <= 1791)
        {
                $result = "urd";
        }
        else
        {
                $result = "eng";
        }
        return $result;
}

1;

