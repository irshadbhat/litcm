#!usr/bin/perl

# P.NIRUPAM PRATAP REDDY
#	200101050 (UG3)
# MODIFIED BY: Samar Husain (samar@research.iiit.ac.in)
# NOTE: Feature Path from the beginning has to specified as follows, a1.a2.a3.a4 (etc)

#% read_FS($string)  --> reference to an or array.
#% Pass a string which is the feature structure to be loaded and 
#% a reference to an or array is returned.
#
#
my $ref_to_fs = &read_FS("<  fs    af='xe,v,f,s,any,,ne,yA' drel=k1:1|k2    vibh=ne|ko|se  >");
my @fff = &get_values("lex", $ref_to_fs);

#print stderr $fff[0]."\n";
my $new_fs = &make_string($ref_to_fs);
#print stderr "NEW=$new_fs\n";


sub read_FS()
{
	local (@_STRING_,$_INDEX_);
	my $featureString=$_[0];
	
	#temporary
	$featureString = &convert_to_old($featureString);

	$featureString=~s/af=(.*?),(.*?),(.*?),(.*?),(.*?),(.*?),(.*?),(.*?)([\/>])/lex=$1\/cat=$2\/gen=$3\/num=$4\/per=$5\/cas=$6\/vib=$7\/tam=$8$9/g;
	
	$featureString="< ROOT = ".$featureString." >";
	@_STRING_= split(//,$featureString);

	$_INDEX_=0;
	my %hashRef;
	$hashRef=&load_hash();
	return $$hashRef{'ROOT'};
}

#the module takes the new xml format and converts it to the old one,
#this seems to be a temporary solution,
#like this only the printer needs to be modified, everything remains same.
sub convert_to_old()
{
	my $col_fs = $_[0];
#	print stderr "Original: $col_fs\n";
	
	#remove 'fs '
	$col_fs =~ s/\s*fs\s+//g;
	#remove single quotes
	$col_fs =~ s/'//g;
	#take care of any spaces before the closing angular brace, if any
	$col_fs =~ s/\s*>/>/g;
	#convert all the spaces into backspaces, this assumes that there can
	#be no space between attribute=value pair.
	$col_fs =~ s/\s+/\//g;
#	print stderr "Converted: $col_fs\n\n\n";
	return $col_fs;
}

#% read_FS($string)  --> reference to an array
#% Pass a string which is the feature structure to be loaded and 
#% 

sub read_FS_old()
{
	local (@_STRING_,$_INDEX_);
	my $featureString=$_[0];
	my $featureStructure;

	@array=split(/\/\//,$featureString);

	for($i=0;$i<@array;$i++)
	{
	    $array[$i]=~s/(.*?),(.*?),(.*?),(.*?),(.*?),(.*?),(.*?),(.*?)(\|.*)/af=$1,$2,$3,$4,$5,$6,$7,$8$9/;
	    $array[$i]=~s/\|/\//g;
	    $array[$i]=~s/\/$/>/g;
	    $array[$i]="<".$array[$i];
	    $array[$i]=~s/[\'\"]//g;
	    $featureStructure.="|".$array[$i];
	}
	$featureStructure=~s/^\|<\|//g;
	$featureStructure=~s/\/\s*$/>/g;
	my $ref=&read_FS($featureStructure);
	my $newString="";
	return $ref;
}

#% get_values($featurePath,$FSreference)	--> An array containg the matched values.
#% $FSreference is the OR containing an or node with a collection of a number of possible Feature Structures.
#% The array that is returned can contain both values as well as reference to other featurestructures.
#% The returned array is an OR array.

sub get_values()
{
	my $featurePath=$_[0];
	my $arrayRef=$_[1];
	$featurePath="ROOT.".$featurePath;
	my %hash;
	$hash{'ROOT'}=$arrayRef;

	my @ReturnedArray;
	#@ReturnedArray=&get_values_hash($featurePath,\%hash);
	return &get_values_2($featurePath,\%hash);
	#return @ReturnedArray;
}

#% get_values_2($featurePath,$FSreference)	--> An array containg the matched values.
#% $FSreference is the reference to a single feature structure.
#% The array that is returned can contain both values as well as reference to other featurestructures.
#% The returned array is an OR array.

sub get_values_2()
{
	#Feature path is given as follows:
	#a1.a2.a3.....
	
	my $featurePath=$_[0];
	my $hashRef=$_[1];
	my ($presAttr,$nextPath);

	if($featurePath=~/\./)
	{
		$presAttr=$`;
		$nextPath=$';
	}
	else
	{	$presAttr=$featurePath;		}

	
	if($nextPath eq "")
	{
		my $arrayRef=$$hashRef{$presAttr};
		my @newReturnArray;

		for(my $i=0;$i<@$arrayRef;$i++)
		{
			if(ref($$arrayRef[$i]) eq "HASH")
			{
				$newReturnArray[$i]=&copyFS($$arrayRef[$i]);
			}
			else
			{
				$newReturnArray[$i]=$$arrayRef[$i];
			}
		}
		return @newReturnArray;
		#return @$arrayRef;				# Return the array <Not the reference>
	}
	else
	{
		my $arrayRef=$$hashRef{$presAttr};
		my @RetArray;

		for(my $i=0;$i<@$arrayRef;$i++)
		{
			if(ref($$arrayRef[$i]) eq "HASH")
			{
				push(@RetArray,&get_values_2($nextPath,$$arrayRef[$i]));
			}
		}

		return @RetArray;
	}
}

#% get_attributes($FSReference)		-> array containing the attributes for that feature structure
#% $FSReference is the reference to a hash (that is that of a single feature structue) NOT of a or node (i.e a collection)
#% of feature structures.
#%

sub get_attributes()
{
	my $hashRef=$_[0];
	my @attributes=keys(%$hashRef);
	my @differentArray,$j=0;
	my $numberOfAttributes=@attributes;
	for(my $i=0;$i<$numberOfAttributes;$i++)
	{
		if(defined($$hashRef{$attributes[$i]}))
		{
			$differentArray[$j]=$attributes[$i];
			$j++;
		}
	}
	return @differentArray;
}

#% get_path_values($attr,$fs)	--> 2D array of values and paths.
#% $fs is the reference to an or node with more than one Feature Structures in it.
#% field 0 contains the path 
#% field 1 contains the value.	<This is the copied value>

sub get_path_values()
{
	my $attr=$_[0];
	my $arrayRef=$_[1];
	
	my %hash;
	$hash{'ROOT'}=$arrayRef;
	my @retArray;
	@retArray=&get_path_values_2($attr,\%hash);

	for(my $i=0;$i<@retArray;$i++)
	{
		$retArray[$i][0]=~s/^\.ROOT\.//g;
	}
	return @retArray;
}

#% get_path_values_2($attr,$fs)	--> 2D array of values and paths.
#% $fs is the reference to a single feature structure.
#% field 0 contains the path 
#% field 1 contains the value.	<This is the copied value>

sub get_path_values_2()
{
	my $attr=$_[0];
	my $hashRef=$_[1];
	my $path=$_[2];
	my $key;
	my @keys=keys(%$hashRef);
	my @RetArray;
	my $count=0;
	

	foreach $key(@keys)
	{
		my $newPath=$path.".".$key;

		if($key eq $attr)
		{
			my $arrayRef=$$hashRef{$key};
			my @newArray;

			for(my $i=0;$i<@$arrayRef;$i++)
			{
				if(ref($$arrayRef[$i]) eq "HASH")
				{
					$newArray[$i]=&copyFS($$arrayRef[$i]);
					my @toPushArray;
					@toPushArray=&get_path_values_2($attr,$$arrayRef[$i],$newPath);
					for(my $i=0;$i<@toPushArray;$i++)
					{
						$RetArray[$count][0]=$toPushArray[$i][0];
						$RetArray[$count][1]=$toPushArray[$i][1];
						$count++;
					}
				}
				else
				{
					$newArray[$i]=$$arrayRef[$i];
				}
			}

			$RetArray[$count][0]=$newPath;
			$RetArray[$count][1]=\@newArray;
			$count++;
		}
		else
		{
			my $arrayRef=$$hashRef{$key};
			for(my $i=0;$i<@$arrayRef;$i++)
			{
				if(ref($$arrayRef[$i]) eq "HASH")
				{
					$newArray[$i]=&copyFS($$arrayRef[$i]);
					my @toPushArray;
					@toPushArray=&get_path_values_2($attr,$$arrayRef[$i],$newPath);
					for(my $i=0;$i<@toPushArray;$i++)
					{
						$RetArray[$count][0]=$toPushArray[$i][0];
						$RetArray[$count][1]=$toPushArray[$i][1];
						$count++;
					}
				}
			}
		}
	}

	return @RetArray;
}

#% copyFS($fs) --> Reference of a new FS
#% Copies fs into a new fs and returns that.

sub copyFS()
{
	my $hashRef=$_[0];
	my %newHash;
	my @referenceKeys=keys(%$hashRef);
	my $key;

	foreach $key(@referenceKeys)
	{
		my $arrayRef=$$hashRef{$key};
		my @newArray;

		for(my $i=0;$i<@$arrayRef;$i++)
		{
			if(ref($$arrayRef[$i]) eq "HASH")
			{
				$newArray[$i]=&copyFS($$arrayRef[$i]);
			}
			else
			{
				$newArray[$i]=$$arrayRef[$i];
			}
		}

		$newHash{$key}=\@newArray;
	}

	return \%newHash;
}

#% add_attr_val($featurePath,$value,$FSReference)	--> -nil-
#% FSReference is an or node containing multiple possible feature structures.
#%	$value is a reference to an OR array. The values in the array will be either normal strings or references to other
#%	featurestructures (hashes)

sub add_attr_val()
{
	my $featurePath=$_[0];
	my $val=$_[1];
	my $arrayRef=$_[2];
	my %hash;
	$featurePath="ROOT.".$featurePath;
	$hash{'ROOT'}=$arrayRef;
	&add_attr_val_2($featurePath,$val,\%hash);

	return;
}

#% add_attr_val_2($featurePath,$value,$FSReference)	--> -nil-
#%	$value is a reference to an OR array. The values in the array will be either normal strings or references to other
#%	featurestructures (hashes)

sub add_attr_val_2()
{
	my $featurePath=$_[0];
	my $val=$_[1];						# This value has to be a reference to an array.
	my $hashRef=$_[2];					# That array will contain either the references to other
	my ($presAttr,$nextPath);

	if($featurePath=~/\./)
	{
		$presAttr=$`;
		$nextPath=$';
	}
	else
	{	$presAttr=$featurePath;		}

	
	if($nextPath eq "")
	{
		my $arrayRef=$$hashRef{$presAttr};
		if(defined($arrayRef))
		{
			my $prevNumber=@$arrayRef;
			for(my $i=0;$i<@$val;$i++)
			{
				if(ref($$val[$i]) eq "HASH")
				{
					$$arrayRef[$i+$prevNumber]=&copyFS($$val[$i]);
				}
				else
				{
					$$arrayRef[$i+$prevNumber]=$$val[$i];
				}
			}
		}
		else
		{
			my @arrayAdd;

			for(my $i=0;$i<@$val;$i++)
			{
				if(ref($$val[$i]) eq "HASH")
				{
					$$arrayAdd[$i]=&copyFS($$val[$i]);
				}
				else
				{
					$arrayAdd[$i]=$$val[$i];
				}
			}
			$$hashRef{$presAttr}=\@arrayAdd;
		}
		return;
	}
	else
	{
		my $arrayRef=$$hashRef{$presAttr};
		if(defined($arrayRef))
		{
			my $entered=0;
			for(my $i=0;$i<@$arrayRef;$i++)
			{
				if(ref($$arrayRef[$i]) eq "HASH")
				{
					$entered=1;
					$arrayRef[$i]=&add_attr_val_2($nextPath,$val,$$arrayRef[$i]);
				}
			}

			if($entered==0)
			{
				my %hash;
				my @arrayAdd;
				$arrayAdd[0]=\%hash;
				push(@$arrayRef,@arrayAdd);
				&add_attr_val_2($nextPath,$val,$arrayAdd[0]);
			}
			return;
		}
		else
		{
			my %hash;
			my @arrayAdd;
			$arrayAdd[0]=\%hash;
			$$hashRef{$presAttr}=\@arrayAdd;
			&add_attr_val_2($nextPath,$val,\%hash);
		}
	}
}

#% update_attr_val($featurePath,$val,$FSReference)	--> -nil-
#%      FSReference is the OR Node reference
#% 	The value in the featurepath specified will be changed to the new val.
#%	If that val is not present then it is added.

sub update_attr_val()
{
	my $featurePath=$_[0];
	my $val=$_[1];						# This value has to be a reference to an array.
	my $arrayRef=$_[2];					# That array will contain either the references to other
	$featurePath="ROOT.".$featurePath;
	my %hash;
	$hash{'ROOT'}=$arrayRef;
	&update_attr_val_2($featurePath,$val,\%hash);
	return;
}

#% update_attr_val_2($featurePath,$val,$FSReference)	--> -nil-
#% 	The value in the featurepath specified will be changed to the new val.
#%	If that val is not present then it is added.

sub update_attr_val_2()
{
	my $featurePath=$_[0];
	my $val=$_[1];						# This value has to be a reference to an array.
	my $hashRef=$_[2];					# That array will contain either the references to other
	my ($presAttr,$nextPath);

	if($featurePath=~/\./)
	{
		$presAttr=$`;
		$nextPath=$';
	}
	else
	{	$presAttr=$featurePath;		}

	
	if($nextPath eq "")
	{
		if(defined($$hashRef{$presAttr}))		# Update an existing value.
		{
			my @arrayAdd;
			
			for(my $i=0;$i<@$val;$i++)
			{
				if(ref($$val[$i]) eq "HASH")
				{
					$arrayAdd[$i]=&copyFS($$val[$i]);
				}
				else
				{
					$arrayAdd[$i]=$$val[$i];
				}
			}

			$$hashRef{$presAttr}=\@arrayAdd;
		}
	}
	else
	{
		my $arrayRef=$$hashRef{$presAttr};
		my @RetArray;

		for(my $i=0;$i<@$arrayRef;$i++)
		{
			if(ref($$arrayRef[$i]) eq "HASH")
			{
				&update_attr_val_2($nextPath,$val,$$arrayRef[$i]);
			}
		}
		return;
	}
}

#% del_attr_val($featurePath,$FSReference)
#% FSReference is the OR node reference
#% Deletes the value in the attribute specified by the path.

sub del_attr_val()
{
	my $featurePath=$_[0];
	my $arrayRef=$_[1];
	$featurePath="ROOT.".$featurePath;
	my %hash;
	$hash{'ROOT'}=$arrayRef;
	&del_attr_val_2($featurePath,\%hash);
return;
}

#% del_attr_val_2($featurePath,$FSReference)
#% Deletes the value in the attribute specified by the path.

sub del_attr_val_2()	
{
	my $featurePath=$_[0];
	my $hashRef=$_[1];
	my ($presAttr,$nextPath);

	if($featurePath=~/\./)
	{
		$presAttr=$`;
		$nextPath=$';
	}
	else
	{	$presAttr=$featurePath;		
	}
	
	if($nextPath eq "")
	{
		if(defined($$hashRef{$presAttr}))		# Undefine an already existing value.
		{
			delete $$hashRef{$presAttr}; #changed from undef to delete 15th Dec 2004
			#undef($$hashRef{$presAttr});
		}

		######### Changed 19th Feb 2004 03:05
		if($$hashRef{$presAttr}=~/^\s*$/)
		{
			delete $$hashRef{$presAttr}; #changed from undef to delete 15th Dec 2004
			#undef($$hashRef{$presAttr});
		}
	}
	else
	{
		my $arrayRef=$$hashRef{$presAttr};
		#my @RetArray;
		for(my $i=0;$i<@$arrayRef;$i++)
		{
			if(ref($$arrayRef[$i]) eq "HASH")
			{
				&del_attr_val_2($nextPath,$$arrayRef[$i]);
			}
		}

		return;
	}
}

#% unify($fs1,$fs2)	--> $fs3;
#% $fs1 and $fs2 are references to two or nodes possibly containing one or more feature structures,
#% But there should not be multiple possible feature Structures given to it. That or node should contain only one possible 
#% feature structure.
#% $fs3 is either -1 or a reference to a new or node of feature structures.
#% -1 is returned in the case that the featurestructures cannot be unified.

sub unify()
{
	my $firstRef=$_[0];
	my $secondRef=$_[1];
	my (%hash1,%hash2,$hashRef);

	$hash1{'ROOT'}=$firstRef;
	$hash2{'ROOT'}=$secondRef;

	$hashRef=&unify_2(\%hash1,\%hash2);
	if($hashRef!=-1)
	{
		return $$hashRef{'ROOT'};
	}
	else
	{
		return -1;
	}
}

#% unify_2($fs1,$fs2)	--> $fs3;
#% $fs1 and $fs2 are references to two feature structures
#% $fs3 is either -1 or a reference to a new feature structure.
#% -1 is returned in the case that the featurestructures cannot be unified.

sub unify_2()	
{
	my $firstRef=$_[0];
	my $secondRef=$_[1];
	my @keys1=keys(%$firstRef);
	my @keys2=keys(%$secondRef);
	my $key;
	my %hash;

	foreach $key(@keys1)
	{
		my $valArrayRef1=$$firstRef{$key};
		my $valArrayRef2=$$secondRef{$key};
		my $retVal;

		if(@$valArrayRef1>1 or @$valArrayRef2>1)
		{
			print "#RULE NOT DEFINED TO MERGE THE VALUES\n";
			return -1;
		}
		else
		{
			if(ref($$valArrayRef1[0]) eq "HASH" and ref($$valArrayRef2[0]) eq "HASH")
			{
				$retVal=&unify_2($$valArrayRef1[0],$$valArrayRef2[0]);

				if($retVal!=-1)
				{
					my @array;
					$array[0]=$retVal;
					$hash{$key}=\@array;
				}
				else
				{
					return -1;
				}
			}
			elsif((not(ref($$valArrayRef1[0]) eq "HASH")) and (not(ref($$valArrayRef2[0]) eq "HASH")))
			{
				if(defined($$valArrayRef1[0]) and defined($$valArrayRef2[0]))
				{
					if($$valArrayRef1[0] eq $$valArrayRef2[0])
					{
						my @array;
						$array[0]=$$valArrayRef1[0];
						$hash{$key}=\@array;
					}
					else
					{
						return -1;
					}
				}
				else
				{	
					# If anything is not defined here it will be $$valArrayRef2[0]
					# Because we are considering the keys of ref1
					my @array;
					$array[0]=$$valArrayRef1[0];
					$hash{$key}=\@array;
				}
			}
			elsif(not(defined($$varArrayRef2[0])))
			{
				my @array;
				$array[0]=$$valArrayRef1[0];
				$hash{$key}=\@array;
			}
			else
			{
				return -1;
			}
		}
	}

	foreach $key(@keys2)
	{
		my $valArrayRef2=$$secondRef{$key};

		if(not(defined($$firstRef{$key})))
		{
			my $arrayRef=$$secondRef{$key};
			my @arrayAdd;
			for(my $i=0;$i<@$arrayRef;$i++)
			{
				if(not(ref($$arrayRef[$i]) eq "HASH"))
				{	$arrayAdd[$i]=$$arrayRef[$i];	}
				else
				{
					$arrayAdd[$i]=&copyFS($$arrayRef[$i]);
				}
			}
			$hash{$key}=\@arrayAdd;
		}
	}

	return \%hash;
}

#% merge($fs1,$fs2)	-->	-nil-
#% $fs1 and $fs2 are or nodes containing multiple possible feature structures.
#% Changes all the values of fs1 to that of fs2 for all the common attributes in fs1 and fs2
#% Rest of the values are left untouched.

sub merge()
{
	my $firstRef=$_[0];
	my $secondRef=$_[1];
	my (%hash1,%hash2);

	&merge_2($$firstRef[0],$$secondRef[0]);
	return;
}

#% merge_2($fs1,$fs2)	-->	-nil-
#% Changes all the values of fs1 to that of fs2 for all the common attributes in fs1 and fs2
#% Rest of the values are left untouched.

sub merge_2()
{
	my $firstRef=$_[0];
	my $secondRef=$_[1];
	my $key;
	my @keys2=keys(%$secondRef);

	foreach $key(@keys2)
	{
		undef($$firstRef{$key});
		my $arrayRef=$$secondRef{$key};
		my @newArray;

		for(my $i=0;$i<@$arrayRef;$i++)
		{
			if(ref($$arrayRef[$i]) eq "HASH")
			{
				$newArray[$i]=&copyFS($$arrayRef[$i]);	# Change the value of one to that in two.
			}
			else
			{
				$newArray[$i]=$$arrayRef[$i];
			}
		}

		$$firstRef{$key}=\@newArray;
	
# But the users have to be careful here as there is just a swap of references and not a complete copy of the values.
	}

	return;
}

#% load_hash()
#% Loads the string passed to a hash and the reference to that hash is returned.

sub load_hash()
{
	if($_STRING_[$_INDEX_] ne "<")
	{
		my $value;

		while($_STRING_[$_INDEX_] ne "|" and $_STRING_[$_INDEX_] ne "/" and $_STRING_[$_INDEX_] ne ">")	# Go on till you find a / or |
		{
			$value.=$_STRING_[$_INDEX_];
			$_INDEX_++;

			while($_STRING_[$_INDEX_]=~/\s+/)	#Ignore all the spaces.
			{	$_INDEX_++;	}
		}
		# Stop at the / or the final position. Do not go beyond that.
		return $value;	# Return the final value.
	}
	else
	{
		my %hash;
		$_INDEX_++;	# Leave the { behind.

		while($_STRING_[$_INDEX_] ne ">")
		{
			my $attr;
			my @arrayVal;
			my $arrayMarker=0;

			if($_STRING_[$_INDEX_] eq "/")
			{	$_INDEX_++;	}

			while($_STRING_[$_INDEX_]=~/\s+/)
			{	$_INDEX_++;	}


			while($_STRING_[$_INDEX_] ne "=")
			{
				$attr.=$_STRING_[$_INDEX_];
				$_INDEX_++;

				while($_STRING_[$_INDEX_]=~/\s+/)	#Ignore all the spaces.
				{	$_INDEX_++;	}

			}
			$_INDEX_++;					# This is to throw out the =
				
			while($_STRING_[$_INDEX_]=~/\s+/)		#Ignore all the spaces.
			{	$_INDEX_++;	}

			while(1)					# Continue until the loop breaks.
			{
				$arrayVal[$arrayMarker]=&load_hash();

				while($_STRING_[$_INDEX_]=~/\s+/)
				{
					$_INDEX_++;			# Remove any spaces following the ending of a pair.
				}

				$arrayMarker++;

				if($_STRING_[$_INDEX_] eq "/" or $_STRING_[$_INDEX_] eq ">")
				{	last;	}
				elsif($_STRING_[$_INDEX_] eq "|")
				{
					$_INDEX_+=1;			#Get beyond that mark.
				
					while($_STRING_[$_INDEX_]=~/\s+/)	#Ignore all the spaces.
					{	$_INDEX_++;	}
				}
				else
				{	print "ERROR: $_STRING_[$_INDEX_]";	}
			}
			$hash{$attr}=\@arrayVal;
		}
		$_INDEX_++;
		return \%hash;
	}
}

#% printFS_SSF($fs)	--> -nil-
#% $fs is a reference to an or node containing multiple possible feature structures.
#% prints the attributes and values present in the hash in the standard format.

sub printFS_SSF()
{
	my $arrayRef=$_[0];
	my $finalString;

	$finalString=&make_string($arrayRef);
	print "$finalString\n";
}

#% printFS_SSF_2($fs)	--> -nil-
#% $fs is a reference to a single possible feature structure.
#% prints the attributes and values present in the hash in the standard format.

sub printFS_SSF_2()
{
	my $finalString;
	my $FSRef=$_[0];
	$finalString=&make_string_2($FSRef);
	print "$finalString \n";
}

#% make_string($FSReference)	--> 	-$string-
#% $FSReference is the array reference returned by the read_FS function.
#% $stringRef is reference to a string into which you want to get the string.

sub make_string()
{
	my $arrayRef=$_[0];
	my $string;


	for(my $i=0;$i<@$arrayRef;$i++)
	{
		$string.=&make_string_2($$arrayRef[$i])."|";
	}

	$string=~s/\|$//g;
	$string=~s/\'\"/\"/g;	# Litha Changes
        $string=~s/\"\'/\"/g;	# Litha Changes
#	if($string eq "<>")
	if($string eq "<'>")
	{
		undef($string);
	}
	return $string;
}

sub make_string_2()
{
	my $hashRef=$_[0];
	my @keyValues;
	my $key;
#	my $refString=$_[1];
	my $String;
	my ($string,@array);
	@array=('lex','cat','gen','num','per','cas','vib','tam');

	my $present=1;

	foreach $string(@array)
	{
		if(not(defined($$hashRef{$string})))
		{	$present=0;last;	}
	}
	
	@keyValues=keys(%$hashRef);
	if($present eq 1)
	{
		#$String.="<af=";	# When we see lex we add this and then continue.
		$String.="<fs af='";	# When we see lex we add this and then continue.

		for(my $i=0;$i<8;$i++)
		{
			my $arrayRef;
			$arrayRef=$$hashRef{$array[$i]};
			for(my $j=0;$j<@$arrayRef;$j++)
			{
				if(ref($$arrayRef[$j]) eq "HASH")
				{
					$String.=&make_string_2($$arrayRef[$j]);
				}
				else
				{
					$String.=$$arrayRef[$j];
				}	
	
				if($i+1<@$arrayRef)
				{
					$String.="|";
				}
			}
			if($i!=7)
			{	$String.=",";	}
			else
			{
				if(@keyValues>8)	
				{	
					#$String.="/";	
					$String.="' ";	
				}
			}
		}
	}
	else
	{
		$String.="<";
	}

	my $count=0;

	for($key=0;$key<@keyValues;$key++)
	{
		my $arrayRef;
		$arrayRef=$$hashRef{$keyValues[$key]};

		if($keyValues[$key] ne "ROOT")
		{
			my $attr=$keyValues[$key];

			if($attr eq "lex" or $attr eq "cat" or $attr eq "gen" or $attr eq "num" or $attr eq "per" or $attr eq "cas" or $attr eq "vib" or $attr eq "tam")
			{
				$count++;
				next;
			}
			
			if(defined($$hashRef{$keyValues[$key]}))
			{
				$String.=$keyValues[$key]."='";		# Litha Changes
			}
			else
			{
				next;
			}
		}

		for(my $i=0;$i<@$arrayRef;$i++)
		{
			if(ref($$arrayRef[$i]) eq "HASH")
			{
				$String.=&make_string_2($$arrayRef[$i]);
			}
			else
			{
				$String.=$$arrayRef[$i];
			}

			if($i+1<@$arrayRef)
			{
				$String.="|";
			}
		}


		if($key+1<@keyValues && 8-$count!=@keyValues-$key-1)
		{
			my $num=@keyValues;
			#$String.="/";
			$String.="'  ";		# Litha Changes
		}
	}

	#if($String[@String]=='/') {
	#	chop($String);
	#	print "\nY\n";
	#}
	if($String =~ /'.*'/) # If the FS has more than 8 default fields then no need of "'" else add it.
	{
		$String.="'>";		# Litha Changes
	}
	else
	{
		$String.="'>";
	}
	return $String;
}

#% prune_FS($featurePath,$fieldNumber,$FSReference)	--> +1/-1
#% Deletes the value in the attribute specified by the path.
#% +1 indicates successful completion of the function
#% -1 indicates that such a feature path does not exist.

sub prune_FS()
{
	my $featurePath=$_[0];
	my $fieldNumber=$_[1];
	my $arrayRef=$_[2];

	$featurePath="ROOT.".$featurePath;
	my %hash;
	$hash{'ROOT'}=$arrayRef;
	return &prune_FS_2($featurePath,$fieldNumber,\%hash);
}


#% prune_FS_2($featurePath,$fieldNumber,$FSReference)	--> +1/-1
#% Deletes the value in the attribute specified by the path.
#% +1 indicates successful completion of the function
#% -1 indicates that such a feature path does not exist.

sub prune_FS_2()	
{
	my $featurePath=$_[0];
	my $fieldNumber=$_[1];
	my $hashRef=$_[2];
	my ($presAttr,$nextPath);

	if($featurePath=~/\./)
	{
		$presAttr=$`;
		$nextPath=$';
	}
	else
	{	$presAttr=$featurePath;		}

	
	if($nextPath eq "")
	{
=s
		if(defined($$hashRef{$presAttr}))		# Undefine an already existing value.
		{	undef($$hashRef{$presAttr});	}
=cut
		my $hashValue=$$hashRef{$presAttr};
		if($hashValue ne "")
		{
			my $numEle,$arrayRef;
			$arrayRef=$$hashRef{$presAttr};
			$numEle=@$arrayRef;
			for(my $i=$fieldNumber;$i<$numEle-1;$i++)
			{
				$$arrayRef[$i]=$$arrayRef[$i+1];
			}
			pop(@$arrayRef);	# pop the final one which is left out.
			
			$numEle=@$arrayRef;
			if($numEle==0)
			{
				undef($$hashRef{$presAttr});
			}
			
			return 1;
		}
		else
		{
			return -1;
		}
	}
	else
	{
		my $arrayRef=$$hashRef{$presAttr};
		my @RetArray;

		if(not(defined($$hashRef{$presAttr})))
		{
			return -1;
		}

		for(my $i=0;$i<@$arrayRef;$i++)
		{
			if(ref($$arrayRef[$i]) eq "HASH")
			{
				&prune_FS_2($nextPath,$fieldNumber,$$arrayRef[$i]);
			}
		}

		return 1;
	}
	
}

#% get_fs_reference($ref_to_array,$index_feature_structure)
#% $ref_to_array is the reference to an OR array
#% $index_... is field you want from the array.
#%

sub get_fs_reference()
{
	my $refArray=$_[0];
	my $index=$_[1];
	
	return $$refArray[$index];
}

#% get_num_fs($ref_to_array)  --> number of feature structures (Or values also)
#% 

sub get_num_fs()
{
	my $refArray=$_[0];
	my $number=@$refArray;

	return $number;
}
#% printFS_SSF($fs)	--> -nil-
#% $fs is a reference to an or node containing multiple possible feature structures.
#% prints the attributes and values present in the hash in the standard format.

sub printFS_SSF_old()
{
	my $arrayRef=$_[0];
	my $finalString;
	# In the old format we do not have nested feature structures inside the bigger feature structures.

	$finalString=&make_string($arrayRef);
	my $featureStructure;


	my @array=split(/\|/,$finalString);

	for(my $i=0;$i<@array;$i++)
	{
		$array[$i]=~s/^<//g;
		$array[$i]=~s/>$/\|/g;
		$array[$i]=~s/\//\|/g;
		$array[$i]=~s/af=(.*?),(.*?),(.*?),(.*?),(.*?),(.*?),(.*?),(.*?)([\|>])/\/\/$1,$2,$3,$4,$5,$6,$7,$8$9/;
		$array[$i]=~s/=(.*?)\|/=$1\|/g;
		$featureStructure.=$array[$i];
	}
	print "$featureStructure\n";
}

sub make_string_old()
{
	my $arrayRef=$_[0];
	my $finalString;
	# In the old format we do not have nested feature structures inside the bigger feature structures.

	$finalString=&make_string($arrayRef);
	my $featureStructure;


	my @array=split(/\|/,$finalString);

	for(my $i=0;$i<@array;$i++)
	{
		$array[$i]=~s/^<//g;
		$array[$i]=~s/>$/\|/g;
		$array[$i]=~s/\//\|/g;
		$array[$i]=~s/af=(.*?),(.*?),(.*?),(.*?),(.*?),(.*?),(.*?),(.*?)([\|>])/\/\/$1,$2,$3,$4,$5,$6,$7,$8$9/;
		$array[$i]=~s/=(.*?)\|/=$1\|/g;
		$featureStructure.=$array[$i];
	}

	return $featureStructure;
}

# Report any bugs to 
# p_nirupam@students.iiit.net
# (or)	sriram@students.iiit.net

1;
