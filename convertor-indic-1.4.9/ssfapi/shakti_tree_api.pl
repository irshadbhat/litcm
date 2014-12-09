#			P.NIRUPAM PRATAP REDDY
#				   UG3
#		     		200101050
# Modified by Samar Husain
# email: samar@research.iiit.net
#

#!/usr/bin/perl

#$SSF_API = $ENV{'SSF_API'};
#require "$SSF_API/feature_filter.pl";

# SSF is represented using a 2D-Array . 
# The entire tree is loaded into @_TREE_
# Rows of array = Lines of the textual format
# Columns of array = Field Numbers ( Field-0 to Field-4)
# $tree = Memory Structure
# $node = Index of a node
#-----------------------------------------------------------------------------

#% Reads the entire story into the data structure @_Story_
#% This @_Story_ in turn consists of an array reference 
#% hich corresponds to paragraph; this paragraph
#% will have various sentences (for this we call the basic read())
#% Each of these arrays' zeroth element contains the total element count in the array.
#% &read_story($filename)
#%

sub read_story()
{
	my $line_count = 0;
        my $storyname;
	my $first_l,$second_l,$third_l,$last_line,$meta;

	$storyname = $_[0];

        open(IN, "$storyname") or die ("Could not open the file $storyname to read\n");

	my @all_lines = <IN>;

	for(my $i = 0; $i < scalar(@all_lines); $i++)
        {
		chomp($all_lines[$i]);
		
		# Litha Changes upto end of for loop
		# All if loop can be change to if else and some 
		#variables(like visible,flags etc) are used

		if($all_lines[$i] =~ /xml\sversion/)
		{
			$first_l = $all_lines[$i]."\n\n";
			$count++;	
		}
		elsif($all_lines[$i] =~ /DOCTYPE\sdocument/)
                {
                        $second_l = $all_lines[$i]."\n\n";
			$count++;	
                }
		elsif($all_lines[$i] =~ /<document\sdocid/)
                {
                        $third_l = $all_lines[$i]."\n\n";
			$count++;	
                }
		elsif($all_lines[$i] =~ /<\/document/)
                {
                        $last_line = $all_lines[$i]."\n";
                }
		elsif($all_lines[$i] eq "<head>")
		{
			$metaf = 1;
			$meta = "";
			$meta = $meta."$all_lines[$i]\n";
			$count++;	
		}
		elsif($all_lines[$i] eq "</head>")
                {
			$meta = $meta."$all_lines[$i]\n\n";
                        $metaf = 0;
                }
		elsif($metaf == 1)
		{
			$meta = $meta."$all_lines[$i]\n";
		}
		elsif($all_lines[$i] eq "<body>")
		{
			$bodyf = 1;
			$body_num++;
			$_Story_[$body_num]->[0]->{'body_visible'}=1;
			$count++;	
		}
		elsif($all_lines[$i] eq "</body>")
                {
			$_Story_[$body_num]->[0]->{'num_para'} = $pnum;
                        $bodyf = 0;
			$pnum = 0;
                }
		elsif($all_lines[$i]=~m/\<tb[ ]+number=\"([0-9][0-9]*)\"[ ]+segment=\"([a-zA-Z]+)\"[ ]+bullet=\"([a-zA-Z]+)\">/)
                {
			if($bodyf==0)
                        {
                                $bodyf =1;
                                $body_num++;
                                $_Story_[$body_num]->[0]->{'body_visible'}=0;
                        }

                        $pnum++;
			$_Story_[$body_num]->[$pnum]->[0]->{'para_visible'}=1;
			# Sriram Changes
			$_Story_[$body_num]->[$pnum]->[0]->{'number'} = $1;
			$_Story_[$body_num]->[$pnum]->[0]->{'segment'} = $2;
			$_Story_[$body_num]->[$pnum]->[0]->{'bullet'} = $3;
			$count++;	
#print STDERR "TB Number $pnum \n";


			$pf=1;
                }
                elsif($all_lines[$i] eq "</tb>")
                {
			# Original Statement
			# $_Story_[$body_num][$pnum]->[0] = $sentnum;   
			# Sriram Changes
			$_Story_[$body_num][$pnum]->[0]->{'numSens'} = $sentnum;   

                        $pf = 0;
			$sentnum = 0;

                }
		elsif($input=~m/<foreign language=\"([a-zA-Z]+)\"[ ]+writingsystem=\"(LTR)|(RTL)\"\>[ ]+\<\/foreign\>/){
			# Sriram Changes
			$_Story_[$body_num][$pnum]->[0]->{'language'} = $1;   
			$_Story_[$body_num][$pnum]->[0]->{'writingsystem'} = $2;   
			$count++;	
			$pnum++
		} 
		elsif($all_lines[$i] =~ /<text>/)
                {
                        if($pf == 0)
                        {
                                $bodyf=1;
                                $body_num++;
                                $_Story_[$body_num]->[0]->{'body_visible'}=0;
                                $pf=1;
                                $pnum++;
                                $_Story_[$body_num]->[$pnum]->[0]->{'para_visible'}=0;
                        }
                        $_Story_[$body_num]->[$pnum]->[0]->{'text_visible'}=1;
                        $textf=1;
			$count++;	
                }
		elsif($all_lines[$i] =~ /<Sentence id="(\d+)"/)
                {
			if($textf == 0)
                        {
                                $bodyf=1;
                                $body_num++;
                                $_Story_[$body_num]->[0]->{'body_visible'}=0;
                                $pf=1;
                                $pnum++;
                                $_Story_[$body_num]->[$pnum]->[0]->{'para_visible'}=0;
                                $textf =1;
                                $_Story_[$body_num]->[$pnum]->[0]->{'text_visible'}=0;
                        }
                        $sentf = 1;
			$cur_sent_id = $1;
                        $sentnum++;
			$count++;	
			$_Story_[$body_num]->[$pnum]->[0]->{'sent_visible'}=1;

			$_Story_[$body_num]->[$pnum]->[0]->{'sent_Ids'}->[$sentnum] = $cur_sent_id;

			# Litha Changes
			# Orignal Statement
		#	open(OUT, ">tmp/sentSSF.$$") or die("could not open to write\n");
			delete @sent[0..$#sent];
			my @sent;
			my $j = 0;
                }
                elsif($all_lines[$i] =~ /<\/Sentence>/)
                {
			# Litha Changes
			# Orignal Statement
			#close(OUT);

			my($tRee);
			# Litha Changes
			# Orignal Statement
			#$tRee = &read("tmp/sentSSF.$$");
			$tRee = &read(\@sent);
			my $dub_tree = &copy_tree($tRee);
			$_Story_[$body_num]->[$pnum]->[$sentnum] = $dub_tree;
			$_Story_[$body_num]->[$pnum]->[0]->{'numSens'} = $sentnum;
                }
		elsif($all_lines[$i] =~ /<\/text>/)
                {
			$_Story_[$body_num]->[$pnum]->[0]->{'numSens'} = $sentnum;
			$textf=0;
                }
		else
		{
		       if(($sentf == 0) && ($count == 0) && ($all_lines[$i] ne "")) 
                       {
                               $bodyf = 1;
                               $body_num++;
                               $_Story_[$body_num]->[0]->{'body_visible'}=0;
                               $pf=1;
                               $pnum++;
                               $_Story_[$body_num]->[$pnum]->[0]->{'para_visible'}=0;
                               $sentf =1;
                               $sentnum++;
                               $_Story_[$body_num]->[$pnum]->[0]->{'sent_visible'}=0;
                               $_Story_[$body_num]->[$pnum]->[0]->{'text_visible'}=0;
		       	       $textf=1;
			       # Litha Changes
                               # Orignal Statement
                               # open(OUT, ">tmp/sentSSF.$$") or die("could not open to write\n");
				delete @sent[0..$#sent];
                               my @sent;
                               my $j = 0;
			       $sentflag = 1;
			       $count++;	
                       }
			#$all_lines[$i]=~s/([\t]+)$/$1<>/g;
			# Litha Changes
                        # Orignal Statement
			# print OUT "$all_lines[$i]\n";
			@sent[$j++]= "$all_lines[$i]\n";
		}

	}
	# Litha Changes

	if($sentflag)
	{
		# Litha Changes
                # Orignal Statement
		# close(OUT);

                my($tRee);
		# Litha Changes
                # Orignal Statement
                # $tRee = &read("tmp/sentSSF.$$");
                $tRee = &read(\@sent);
                my $dub_tree = &copy_tree($tRee);
                $_Story_[$body_num]->[$pnum]->[$sentnum] = $dub_tree;
                $sentf = 0;
                $_Story_[$body_num]->[$pnum]->[0]->{'numSens'} = $sentnum;
	}
	$_Story_[0]->{"body_count"} = $body_num;
	$_Story_[0]->{"first_line"} = $first_l;
	$_Story_[0]->{"second_line"} = $second_l;
	$_Story_[0]->{"third_line"} = $third_l;
	$_Story_[0]->{"last_line"} = $last_line;
	$_Story_[0]->{"meta"} = $meta;

	return \@_Story_;
}

# Litha Changes
# To print the sentence with given tb_no: and sent_id 
sub printsentence()
{
	my $pnum = $_[0];
	my $sent_id = $_[1];
	my $StoryRef=\@_Story_;
	my $p_counter = 0;
	my $sent_counter =0;
	my $reach = 0;

	for(my $i = 1;($i<=$StoryRef->[0]->{"body_count"}) && ($reach == 0);$i++)
	{
		my $paras = $StoryRef->[$i];
                my $paracount = &get_paracount($paras);

		if($pnum <= $paracount)
		{
			for(my $j = 1;($j<=$paracount) && ($reach == 0);$j++)
			{
				$para = &get_para($j);
				my($numSent) = &get_sentcount($para);
				$paraf = 1;
				if(($j == $pnum) || ($pnum == 0))
				{
					for(my $k = 1;($k<=$numSent) && ($reach == 0);$k++)
					{
						$curr_sent=$para->[0]->{'sent_Ids'}->[$k];
						$sentf = 1;
						if($sent_id == $curr_sent)
						{
							$reach =1;
							$tb_no = $j;
							$sent_counter = $k;
						}
					}
				}
			}
		}
	}
	if(($reach == 1))
	{
		if($pnum == 0)
		{
			print "\ntb_num is available.But user is not providing the tb_num: $tb_no\n";
			print "sentence_id: $sent_id is present in the tb_num: $tb_no \n";
		}
		print "\nSentence: \n";
		print "\ntb_ num: $tb_no\tSentence_id: $sent_id"."\n\n";

		my($sent) = &get_sent($para,$sent_counter);
		&print_tree($sent);
		print "\n";
	}
	else{
		if(!$paraf)
		{
			print "\nError : tb_num is not available.But user is providing the tb_num:\n\n";
		}
		elsif(($paraf) && ($pnum == 0))
		{
			print "\nError : tb_num is available.But user is not providing the tb_num.\n";
			print "Sentence_id: $sent_id is not present in the all tb_nums: \n\n"
		}
		else
		{
			print "\nSentence_id: $sent_id is not present in the tb_num : $pnum\n\n";
		}
	}
}

sub get_paracount()
{
	my $paras = $_[0];

	return $#{$paras};
}

sub get_bodycount()
{
	my $StoryRef = $_[0];

        if(not(defined($StoryRef)))
        {$StoryRef=\@_Story_;}

	return $StoryRef->[0]->{'body_count'};

}

sub get_body()
{
	my($bodyNum) = $_[0];
	my($StoryRef) = $_[1];

	if(!defined($StoryRef)) {
		$StoryRef=\@_Story_;
	}

	return $StoryRef->[$bodyNum];
}


sub get_para()
{
        my $paranum = $_[0];
        my $StoryRef = $_[1];

        if(not(defined($_[1])))
        {$StoryRef=\@_Story_;}

        return $StoryRef->[1]->[$paranum];
}

sub get_sentcount()
{
	 my $ParaRef = $_[0];

	# Sriram Changes
        return $ParaRef->[0]->{'numSens'};
}

sub get_sent()
{
        my $ParaRef = $_[0];
        my $sentnum = $_[1];

        return $ParaRef->[$sentnum];
}

sub print_para()
{
        my $paranum = $_[0];
	my $StoryRef = $_[1];

        if(not(defined($_[1])))
        {$StoryRef=\@_Story_;}
	
	my $sentences = $StoryRef->[1]->[$paranum];

	# INformation is there in  $StoryRef->[1]->[$paranum]->[0]->
	my $segment = $StoryRef->[1]->[$paranum]->[0]->{'segment'};
	my $bullet = $StoryRef->[1]->[$paranum]->[0]->{'bullet'};

#	print "<p>\n";
	print "<tb number=\"$paranum\" segment=\"$segment\" bullet=\"bullet\">\n";
	#print "<tb number=\"$sentcount\" segment=\"yes\" bullet=\"yes\">\n";
	print "<text>\n";
	#print "<tb\n";

	for(my $k = 1; $k <= @$sentences[0]->{'numSens'}; $k++)
	{
		$sentcount++;
		print "<Sentence id=\"$sentcount\">\n";
		&print_tree($sentences->[$k]);
		print "</Sentence>\n";
	}
	#print "</p>\n\n";
	print "</text>\n";
	print "<foreign language=\"\" writingsystem=\"\"></foreign>\n";
	print "</tb>\n";

}

sub print_pararef()
{
        my $sentences = $_[0];
	
	#print "<tb number=\"$sentcount\" segment=\"yes\" bullet=\"yes\">\n";
	#print "<text>\n";
        #print "<p>\n";
        #print "<tb>\n";

        for(my $k = 1; $k <= $sentences->[0]->{'numSens'}; $k++)
        {
        	$sentcount++;
                print "<Sentence id=\"$sentcount\">\n";
                &print_tree($sentences->[$k]);
                print "</Sentence>\n";
	}
	
	print "</text>\n";
	#print "<foreign language=\"\" writingsystem=\"\"></foreign>\n";
        #print "</tb>\n";
        #print "</tb>\n\n";
}


sub printstory()
{
	my $StoryRef = $_[0];

        if(not(defined($_[0])))
        {$StoryRef=\@_Story_;}
	
	# Litha Changes up to end of this function	
	print "$StoryRef->[0]->{\"first_line\"}$StoryRef->[0]->{\"second_line\"}$StoryRef->[0]->{\"third_line\"}$StoryRef->[0]->{\"meta\"}";
	my $sentcount = 0;

	for(my $i = 1; $i <= $StoryRef->[0]->{"body_count"}; $i++)
	{
		my $paras = $StoryRef->[$i];
		if($paras->[0]->{'body_visible'} == 1)
                {
			print "<body>\n\n";
		}
		my $paracount = &get_paracount($paras);

		for(my $j = 1; $j <= $paracount; $j++)
		{
			my $para = $paras->[$j];

			# INformation is there in  $StoryRef->[1]->[$paranum]->[0]->
			my $segment = $para->[0]->{'segment'};
			my $bullet =  $para->[0]->{'bullet'};

			if($para->[0]->{'para_visible'} == 1)
                        {
				print "<tb number=\"$para->[0]->{'number'}\" segment=\"$segment\" bullet=\"$bullet\">\n";
			}
			if($para->[0]->{'text_visible'} == 1)
                        {
				print "<text>\n";
			}

			for(my $k = 1; $k <= $para->[0]->{'numSens'}; $k++)
			{
				$sentcount++;
				if($para->[0]->{'sent_visible'} == 1)
                                {
					# Sriram change
					print "<Sentence id=\"".$para->[0]->{'sent_Ids'}->[$k]."\">\n";
				}
				&print_tree($para->[$k]);
				if($para->[0]->{'sent_visible'} == 1)
                                {
					print "</Sentence>\n";
				}
			}
			if($para->[0]->{'text_visible'} == 1)
                        {
				print "</text>\n";	
				print "<foreign language=\"select\" writingsystem=\"LTR\"></foreign>\n";
			}
			if($para->[0]->{'para_visible'} == 1)
                        {
				print "</tb>\n";
			}
		}
		if($paras->[0]->{'body_visible'} == 1)
                {
			print "</body>\n";
		}
	}

	print "$StoryRef->[0]->{\"last_line\"}";
}

sub printstory_file()
{
        my $outfile = $_[0];
        my $StoryRef = $_[1];

        if(not(defined($_[1])))
        {$StoryRef=\@_Story_;}

	open(OUT, ">$outfile") or die("could not open the file $outfile to write\n");
	# Litha Changes upto end of the program
        print OUT "$StoryRef->[0]->{\"first_line\"}$StoryRef->[0]->{\"second_line\"}$StoryRef->[0]->{\"third_line\"}$StoryRef->[0]->{\"meta\"}";
        my $sentcount = 0;

        for(my $i = 1; $i <= $StoryRef->[0]->{"body_count"}; $i++)
        {
                my $paras = $StoryRef->[$i];
		if($paras->[0]->{'body_visible'} == 1)
                {
                	print OUT "<body>\n\n";
		}
		my $paracount = &get_paracount($paras);
		for(my $j = 1; $j <= $paracount; $j++)
                {
                        my $para = $paras->[$j];
			my $segment = $para->[0]->{'segment'};
			my $bullet =  $para->[0]->{'bullet'};
			my $lang =  $para->[0]->{'language'};
			if($para->[0]->{'para_visible'} == 1)
                        {
				print OUT "<tb number=\"$j\" segment=\"$segment\" bullet=\"$bullet\">\n";
			}
			if($para->[0]->{'text_visible'} == 1)
                        {
				print OUT "<text>\n";
			}
			for(my $k = 1; $k <= $para->[0]->{'numSens'}; $k++)
                        {
                                $sentcount++;
                                if($para->[0]->{'sent_visible'} == 1)
                                {
					 print OUT "<Sentence id=\"".$para->[0]->{'sent_Ids'}->[$k]."\">\n";
					close(OUT);
				}
                                &print_tree_file(">>$outfile", $para->[$k]);
			        open(OUT, ">>$outfile") or die("could not open the file $outfile to write\n");
				if($para->[0]->{'sent_visible'} == 1)
                                {
                                	print OUT "</Sentence>\n";
				}
                        }
			if($para->[0]->{'text_visible'} == 1)
                        {
				print OUT "</text>\n";
				print OUT "<foreign language=\"select\" writingsystem=\"LTR\"></foreign>\n";
			}
			if($para->[0]->{'para_visible'} == 1)
                        {
                        	print OUT "</tb>\n";
			}
                }
		if($paras->[0]->{'body_visible'} == 1)
                {
        		print OUT "</body>\n";
		}
        }
	print OUT "$StoryRef->[0]->{\"last_line\"}";
	close(OUT);
}


sub copy_story()         # This will copy the entire story and return a reference to that story.
{
        my @copyStory;
        my $StoryRef=$_[0];

        if(not(defined($_[0])))
        {
                $StoryRef=\@_Story_;
        }

	$copyStory[0]->{"body_count"} = $StoryRef->[0]->{"body_count"};
        $copyStory[0]->{"first_line"} = $StoryRef->[0]->{"first_line"};
        $copyStory[0]->{"second_line"} = $StoryRef->[0]->{"second_line"};
        $copyStory[0]->{"third_line"} = $StoryRef->[0]->{"third_line"};
        $copyStory[0]->{"meta"} = $StoryRef->[0]->{"meta"};

	

	my $sentcount = 0;

        for(my $i = 1; $i <= $StoryRef->[0]->{"body_count"}; $i++)
        {
		$copyStory[$i] = $StoryRef->[$i];
                my $para = $StoryRef->[$i];
		$copyStory[$i]->[0] = $para->[0];

                for(my $j = 1; $j <= $para->[0]; $j++)
                {
			$copyStory[$i]->[$j] = $para->[$j];
			$copyStory[$i]->[$j]->[0] = $para->[$j]->[0];
                }
        }


        return \@copyStory;      # Return a reference to the copied version of the story.
}

#% Reads the file into the data-structure @_TREE_
#% &read ([$filename])
#% 
sub read()
{
	my @Load;
	# Litha Changes
	# Orignal Statement
	# my $filename;
	# $filename=$_[0];
	# if($filename)
	# {
	#	open(stdin,$filename) or die $!."\n";
	# }
	my $sent_ref;
	$sent_ref=shift;
	

	undef(@_TREE_);

	$_TREE_[0][1]="0";
	$_TREE_[0][2]="((";
	$_TREE_[0][3]="SSF";
	$_TREE_[0][4]="";

	my $nElements=1;
	# Litha Changes
        # Orignal Statement
	#while(<stdin>)
	foreach (@$sent_ref)
	{
		chomp;
		if(/(^\#)|(^\<\S+\>)/  or /^\s*$/ or /^\s*\<\/S\>/)
		{	next;	}
		
		($_TREE_[$nElements][1],$_TREE_[$nElements][2],$_TREE_[$nElements][3],$_TREE_[$nElements][4])=split(/\t/,$_);
		$_TREE_[$nElements][4]=~s/\/>/>/g;
		$_TREE_[$nElements][4]=~s/\/\/>/\//g;
		$nElements++;
	}

	$_TREE_[$nElements][2]="))";
	&assign_reach(\@_TREE_);
}

# Assign the zeroth and the first field
# &assign_reach( [$tree] )
#
sub assign_reach()			
{
	my $TreeRef=$_[0];		# Reference to the tree structure.
	my @markerArray;
	my $i=0;

	if(not(defined($_[0])))
	{       $TreeRef=\@_TREE_;      }
	
	for(my $i=0;$i<@$TreeRef;$i++)
	{
		if($$TreeRef[$i][2]=~/\)\)/)
		{
			for(my $j=$i;$j>=0;$j--)
			{
				if($markerArray[$j][0] eq "Open")	# Closing the last opened node.
				{
					$markerArray[$j][0]="Closed";
					$$TreeRef[$j][0]=($markerArray[$j][1]+1);

					last;
				}
			}
		}
		elsif($$TreeRef[$i][2]=~/\(\(/)	# Marking the open of a starting node.
		{
			$markerArray[$i][0]="Open";
			$markerArray[$i][1]=0;
		}
		else				# Marking the general nodes.
		{
			$$TreeRef[$i][0]=1;
		}

		for(my $j=$i;$j>=0;$j--)	# Incrementing the reach of each open node.
		{
			if($markerArray[$j][0] eq "Open")
			{
				$markerArray[$j][1]++;
			}
		}
	}

	return;
}

#% Prints the data-structure
#% &print_tree( [$tree] )	-nil-
#%

sub print_tree()
{
	my $TreeRef=$_[0];
	my ($zeroth,$first,$second,$third,$fourth);

	if(not(defined($_[0])))
	{	$TreeRef=\@_TREE_;	}
	&assign_reach($TreeRef);
	&assign_readable_numbers($TreeRef);
	for(my $i=1;$i<scalar(@$TreeRef)-1;$i++)
	{
		$first=$$TreeRef[$i][1];
		$second=$$TreeRef[$i][2];
		$third=$$TreeRef[$i][3];
		$fourth=$$TreeRef[$i][4];
		binmode STDOUT, ":utf8"; # added by Rashid to fix wild char STDERR
		print "$first\t$second\t$third\t$fourth\n";
	}
	
	return;
}

#% Prints the data structure to a file
#% &print_tree_file($filename,[$tree])	-nil-
#	$filename can be ">>abc.tmp" for appending to a file
#% Added by Aseem - 12/9/04

sub print_tree_file()
{

	my $FileRef=$_[0];
        my $TreeRef=$_[1];
        my ($zeroth,$first,$second,$third,$fourth);

	if(not(defined($_[0])))
        {       die("File not given!\n");      }
        if(not(defined($_[1])))
        {       $TreeRef=\@_TREE_;      }

	if ($_[0] =~ /\>\>/) {
		open(FILE,"$FileRef");
	}
	else {
		open(FILE,">$FileRef");
	}
        &assign_reach($TreeRef);
        &assign_readable_numbers($TreeRef);
        for(my $i=1;$i<@$TreeRef-1;$i++)
        {
                $first=$$TreeRef[$i][1];
                $second=$$TreeRef[$i][2];
                $third=$$TreeRef[$i][3];
                $fourth=$$TreeRef[$i][4];
		binmode FILE, ":utf8"; # added by Rashid to fix wild char STDERR
                print FILE "$first\t$second\t$third\t$fourth\n";
        }
	close(FILE);
        return;
}

#% Changes the numbers in the first field 
#% &assign_readable_numbers([$tree])	-> -nil-
#% Nothing is returned
#%

sub assign_readable_numbers()
{
	my $TreeRef=$_[0];
	if(not(defined($_[0])))
	{	$TreeRef=\@_TREE_;	}


	my @childNodes=&get_children(0,$TreeRef);

	for(my $i=1;$i<=@childNodes;$i++)
	{
		&modify_field($childNodes[$i-1],1,$i,$TreeRef);	
		&reorder_numbers($childNodes[$i-1],$i,$TreeRef);
	}

	return;
}

#% Changes the numbers in the first field 
#% &assign_readable_numbers($node,$parentNumber,[$tree])	-> -nil-
#% Nothing is returned
#%

sub reorder_numbers()
{
	my $index=$_[0];
	my $parent=$_[1];
	my $TreeRef=$_[2];

	if(not(defined($_[2])))
	{	$TreeRef=\@_TREE_; 	}
	
	my @childNodes=&get_children($index,$TreeRef);

	if(@childNodes==0)
	{	return; 	}

	for(my $i=1;$i<=@childNodes;$i++)
	{
		&modify_field($childNodes[$i-1],1,$parent.".".$i,$TreeRef);
		&reorder_numbers($childNodes[$i-1],$parent.".".$i,$TreeRef);
	}
	
	return;
}


#% &print_node($index,[$tree])
#% 

sub print_node()
{
	my ($zeroth,$first,$second,$third,$fourth);
	my $index=$_[0];
	my $TreeRef=$_[1];
	
	if(not(defined($_[0])))
	{	$TreeRef=\@_TREE_;	}

	my $nextPosition=&get_next_node($index,$TreeRef);

	for(my $i=$index;$i<$nextPosition;$i++)
	{
		$first=$$TreeRef[$i][1];
		$second=$$TreeRef[$i][2];
		$third=$$TreeRef[$i][3];
		$fourth=$$TreeRef[$i][4];
		
		print "$first\t$second\t$third\t$fourth\n";
	}
}

#% Gets the children nodes
#% &get_children( $node , [$tree] )  -> @children_nodes;
#% To get children of root, $node = 0;
#%
sub get_children()
{
	my $node=$_[0];			# Passing the node number is compulsory.
	my $TreeRef=$_[1];		# This is a reference to the tree array.
	my @childIndexArray;
	
	if(not(defined($_[1])))
	{	$TreeRef=\@_TREE_;	}
	
	for(my $i=$node+1;$i<$node+$$TreeRef[$node][0];)
	{
		if(not($$TreeRef[$i][2]=~/\)\)/))	# Get only the children at the next layer
                {
		       push(@childIndexArray,$i);     
		       $i+=$$TreeRef[$i][0];	# This will get all the children in that tree passed to the function.
		}	# We do not get the grand children
		else
		{
			$i+=1;
		}
	}

	return @childIndexArray;	# Return a reference to the child array.
}

#% Gets the Leaf nodes
#% &get_leaves( [$tree] )  -> @leaf_nodes;
#%
sub get_leaves()
{
	my $TreeRef=$_[0];
	my @leafArray;
	
	if(not(defined($_[0])))
	{	$TreeRef=\@_TREE_;	}

	for(my $i=0;$i<@$TreeRef;$i++)
	{
		if(not($$TreeRef[$i][2]=~/\)\)/))	# We do not pass those nodes that have ))
		{
			if($$TreeRef[$i][0]==1)		# If it is a leaf node then..
			{	push(@leafArray,$i);	}
		}
	}

	return @leafArray;		# Return the reference to the leaf array.
}

sub get_leaves_child()
{
	my $TreeRef=$_[1];
	my $index=$_[0];
	my @leafArray;

	if(not(defined($_[1])))
	{	$TreeRef=\@_TREE_;	}

	for(my $i=$index+1;$i<$index+$$TreeRef[$index][0];$i++)
	{
		if(not($$TreeRef[$i][2]=~/\)\)/))
		{
			if($$TreeRef[$i][0]==1)
			{
				push(@leafArray,$i);
			}
		}
	}
	return @leafArray;
}

#% Get the nodes which have a particular field-value.
#% &get_nodes( $fieldnumber , $value , [$tree] ) -> @required_nodes
#%
sub get_nodes()
{
	my $index=$_[0];
	my $value=$_[1];
	my $TreeRef=$_[2];
	my @nodeArray;

	if(not(defined($_[2])))
	{	$TreeRef=\@_TREE_;	}

	for(my $i=0;$i<@$TreeRef;$i++)
	{
		if($$TreeRef[$i][$index] eq $value)
		{	push(@nodeArray,$i);	}
	}

	return @nodeArray;		# Return a reference to the node array.
}

#% Get the nodes which have a particular field-value.
#% &get_nodes_pattern( $fieldnumber , $value , [$tree] ) -> @required_nodes
#%

sub get_nodes_pattern()
{
	my $index=$_[0];
	my $value=$_[1];
	my $TreeRef=$_[2];
	my @nodeArray;

	if(not(defined($_[2])))
	{	$TreeRef=\@_TREE_;	}

	for(my $i=0;$i<@$TreeRef;$i++)
	{
		if($$TreeRef[$i][$index]=~/$value/)
		{	push(@nodeArray,$i);	}
	}

	return @nodeArray;		# Return a reference to the node array.
}

#% Deletes a node
#% &delete_node( $node , [$tree] )
#%
sub delete_node()
{
	# We delete a node from the referred tree itself 
	# We do not give a copy of the tree.

	my $node=$_[0];		# First Arg is the index in the array from where the node has to be deleted.
	my $TreeRef=$_[1];		# Reference to the tree to which the function has to be applied.
	my $j=0;

	if(not(defined($_[1])))	# If reference is not specified then take the default reference.
	{	$TreeRef=\@_TREE_;	}

	my $numEle=@$TreeRef;

	for(my $i=0;$i<$numEle;)
	{
		if($i==$node)
		{
			if(not($$TreeRef[$i][0]=~/\)\)/))
			{
				$i+=$$TreeRef[$i][0];	# This means that we have abandoned that node.	<Deleted it>
			}
			else
			{
				$i+=1;
			}
		}

		if($j!=$i)
		{
			undef($$TreeRef[$j]);
			$$TreeRef[$j]=$$TreeRef[$i];	# copy the values in one part to the other.
		}
			
		$i++;$j++;
	}
	
	for(;$j<$numEle;$j++)
	{	pop(@$TreeRef);		}


	&assign_reach($TreeRef);
	return;					# We return nothing.
}

#% Create a parent for a sequence of nodes 
#% &create_parent( $node_start , $node_end , $tag , [$tree] );
#%
sub create_parent()
{
	my $startIndex=$_[0];
	my $endIndex=$_[1];	# Specify the ending index
	my $tag=$_[2];
	my $TreeRef=$_[3];
	my $specifier=0;

	if(not(defined($_[3])))
	{
		$TreeRef=\@_TREE_;
	}
	my @temp;
	my @temp2;
	my $nElements=@$TreeRef;

	for(my $i=$nElements-1;$i>=$startIndex;$i--)
	{
		for(my $j=0;$j<5;$j++)
		{	$$TreeRef[$i+1][$j]=$$TreeRef[$i][$j];	}
	}

	undef($$TreeRef[$startIndex]);
	$$TreeRef[$startIndex][0]="";
	$$TreeRef[$startIndex][1]="";
	$$TreeRef[$startIndex][2]="((";
	$$TreeRef[$startIndex][3]=$tag;

	$endIndex+=$$TreeRef[$endIndex+1][0]+1;	
	$nElements=@$TreeRef;

	for(my $i=$nElements-1;$i>=$endIndex;$i--)
	{
		for(my $j=0;$j<5;$j++)
		{	$$TreeRef[$i+1][$j]=$$TreeRef[$i][$j];	}
	}
	undef($$TreeRef[$endIndex]);	
	$$TreeRef[$endIndex][0]="";
	$$TreeRef[$endIndex][1]="";
	$$TreeRef[$endIndex][2]="))";

	&assign_reach($TreeRef);	# Modify the Reach values in the tree.
	return $startIndex;
}

#% Delete the parent but keep the children
#% &delete_layer ( $node , [$tree] )
#%
sub delete_layer()
{
	my $index=$_[0];
	my $TreeRef=$_[1];
	my $final;

	if(not(defined($_[1])))
	{
		$TreeRef=\@_TREE_;
	}

	$final=$$TreeRef[$index][0]+$index;
	my $numEle=@$TreeRef;

	for(my $i=$index;$i<$numEle-1;$i++)	# First you remove the node<index> that was passed to you.
	{
		$$TreeRef[$i]=$$TreeRef[$i+1];
	}

	pop(@$TreeRef);				# Decrease the tree<array> size, saying that we have deleted a node.
# Now if index!=final-1 then we need to delete the node at final-1 also.

	$numEle=@$TreeRef;

	if($index!=$final-1)			# If that node we deleted happened to be a parent node then...
	{
		for(my $i=$final-2;$i<$numEle;$i++)	# Delete it's corresponding closing brace )) 
		{					# Which will be at $final-2 because we have already deleted one 
			$$TreeRef[$i]=$$TreeRef[$i+1];	# node from the tree.
		}

		pop(@$TreeRef);
	}

#	$nElements=@$TreeRef;
	&assign_reach($TreeRef);		# Modify the reach values.

	return;
}

#% Creates a new tree
#% &create_tree;  -> $empty_tree;
#%
sub create_tree()
{
	# The 3 fields of a node are sent by the user.

	my @Tree;
	$$Tree[0][0]="3";
	$Tree[0][1]="0";
	$Tree[0][2]="((";
	$Tree[0][3]="SSF";
	#$Tree[1][0]=1;		# This is the reach value
	#$Tree[1][1]="1 "; 	# This will be assigned by a seperate function.
	##$Tree[1][2]=$_[0];
	#$Tree[1][3]=$_[1];
	#$Tree[1][4]=$_[2];
	$Tree[1][0]="";
	$Tree[1][1]="";
	$Tree[1][2]="))";

	return \@Tree;		# Return a reference to the tree.
}

#%
#% &add_tree
#%
sub add_tree()			# Found a bug on 29th Oct 2003 and fixed on the same day.
{
	my $addNodeRef=$_[0];	# This is the reference array from which the values are added into the present tree
	my $position=$_[1];
	my $direction=$_[2];
	my $TreeRef=$_[3];

	if(not(defined($_[3])))
	{
		$TreeRef=\@_TREE_;
	}
	
	if($direction eq "1")
	{
		$position+=$$TreeRef[$position][0];
	}

	my $numEle=@$TreeRef;	# Number of elements in the array before it was modified.
	my $offset=$$addNodeRef[0][0];
	

	for(my $i=$numEle-1;$i>=$position;$i--)	# Start from the position where you have to add the new node.
	{
		for(my $j=0;$j<5;$j++)
		{
			$$TreeRef[$i+$offset-2][$j]=$$TreeRef[$i][$j];	# Make space for the coming new node, -2 is for the elimination
		}
							# of the first and last parantheses.
	}

	for(my $i=$position;$i<$position+$offset-2;$i++)	# Copy the new node in the space created previously.
	{
		undef($$TreeRef[$i]);
		$$TreeRef[$i]=$$addNodeRef[$i-$position+1];	# The reason we add 1 to the index id because 
	}							# The tree has A starting (( SSF and closing )) which 
								# are to be left out.
	&assign_reach($TreeRef);	# Modify the Reach values in the tree.
}

#%
#% &add_node ( $tree , $sibling_node , $direction (0/1) ,[$tree]) -> $index_node
#%
sub add_node()
{
	my $addNodeRef=$_[0];		# This is the reference array from which the values are added into the present tree
	my $position=$_[1];
	my $direction=$_[2];
	my $TreeRef=$_[3];

	
	if(not(defined($_[3])))
	{
		$TreeRef=\@_TREE_;
	}


	if($direction eq "1")
	{
		$position+=$$TreeRef[$position][0];
	}

	my $numEle=@$TreeRef;			# Number of elements in the array before it was modified.
	my $offset=$$addNodeRef[0][0];

	for(my $i=$numEle-1;$i>=$position;$i--)	# Start from the position where you have to add the new node.
	{
		for(my $j=0;$j<5;$j++)
		{
			$$TreeRef[$i+$offset][$j]=$$TreeRef[$i][$j];	# Make space for the coming new node.
		}
		undef($$TreeRef[$i]);
	}

	for(my $i=$position;$i<$position+$offset;$i++)	# Copy the new node in the space created previously.
	{
		for(my $j=0;$j<5;$j++)
		{	
			$$TreeRef[$i][$j]=$$addNodeRef[$i-$position][$j];	
		}
	}						
							
	&assign_reach($TreeRef);	# Modify the Reach values in the tree.
}

#% Get's all the fields of a given leaf/node
#% &get_fields ( $node , [$tree] ) -> ($zeroth,$first,$second,$third,$fourth)
#%
sub get_fields()
{
	my $node=$_[0];
	my $TreeRef=$_[1];

	if(not(defined($_[1])))
	{
		$TreeRef=\@_TREE_;
	}

	return ($$TreeRef[$node][0],$$TreeRef[$node][1],$$TreeRef[$node][2],$$TreeRef[$node][3],$$TreeRef[$node][4]);
	#return $$TreeRef[$node];	# Return that array to the user. <As a double dimensional array>
}

#% Get a particular field of a leaf/node
#% &get_field ( $node , $fieldnumber , [$tree] ) -> $value_of_field
#%
sub get_field()
{
	my $node=$_[0];
	my $index=$_[1];
	my $TreeRef=$_[2];

	if(not(defined($_[2])))
	{
		$TreeRef=\@_TREE_;
	}

	return $$TreeRef[$node][$index];	# Return the required index
}

#% Modify a particular field of a leaf/node
#% &modify_field( $node , $fieldnumber , $value , [$tree] )
#%
sub modify_field()
{
	my $node = $_[0];
	my $index = $_[1];
	my $value = $_[2];
	my $TreeRef=$_[3];

	if(not(defined($_[3])))
	{
		$TreeRef=\@_TREE_;
	}
	$$TreeRef[$node][$index] = $value;
}

sub modify_field_check()
{
	my $node = $_[0];
	my $index = $_[1];
	my $value = $_[2];
	my $TreeRef=$_[3];
	my $check = $_[4];

	print STDERR "NODE:$node\n";
	print STDERR "INDEX:$index\n";
	print STDERR "VALUE:$value\n";
	print STDERR "TREEREF:$TreeRef\n";
	print STDERR "ChHECK:$check\n";
	if(($check != $index) && ($check != ""))
	{
		
		print STDERR "\nThe program plans to change another field. Do you want your specification only ?(Y/N):";
		$response = <STDIN>;
		if($response =~ /.*Y.*/)
		{
			print STDERR "modifying with your choice:$check\n";
			&modify_field($node,$check,$value,$TreeRef);
		}
		else
		{
			print STDERR "modifying with programs choice:$index\n";
			&modify_field($node,$index,$value,$TreeRef);
		}
	}
	else
	{
			print STDERR "no check\n";
			&modify_field($node,$index,$value,$TreeRef);
	}
}
#% Copy a node as another tree
#% &copy ( $node ) -> $tree
#% If entire tree has to be copied, $node = 0
#%
sub copy()			# This creates a copy of the node specified and returns the corresponding
{					# Two dimensional array.
	my $nodeIndex=$_[0];
	my $TreeRef=$_[1];
	my @nodeCopy;

	if(not(defined($_[1])))
	{
		$TreeRef=\@_TREE_;
	}

	if(not($$TreeRef[$nodeIndex][2]=~/\)\)/))
	{
		for(my $i=$nodeIndex;$i<$nodeIndex+$$TreeRef[$nodeIndex][0];$i++)# Make a copy of that node and return it.
		{
			for(my $j=0;$j<5;$j++)	# copy field by field and return a reference to that array.
			{
				$nodeCopy[$i-$nodeIndex][$j]=$$TreeRef[$i][$j];
			}
		}
	}
	else
	{
		return -1;	# That is not a node.
	}

	return \@nodeCopy;		# Returning a reference to the node array created.
}

#% Move a node to a particular place
#% &move_node( $node , $node2 , $direction , [$tree] )
#% $direction = 0 if before the sibiling, 1 if after ths sibling
#%
sub move_node()
{
	my $nodeIndex=$_[0];
	my $node2=$_[1];
	my $direction=$_[2];		# The direction is either "up" or "down"
	my $TreeRef=$_[3];
	my $nodeCopy=&copy($nodeIndex);
	$tempCopy=$nodeCopy;

	if(not(defined($_[3])))
	{
		$TreeRef=\@_TREE_;
	}

	if($direction eq "0")		# Since we are deleting an element below position to where it has to be moved 
	{				# It will be moved to the position above the specified number of positions.	
		if($node2 > $nodeIndex)
		{
			$node2=$node2-$$TreeRef[$nodeIndex][0];
		}
		&delete_node($nodeIndex,$TreeRef);	# the new position is $nodeIndex-$numberOfPositions.
		&add_node($nodeCopy,$node2,"0",$TreeRef);
# e.g. if numberOfPositions is 3 then node will be inserted above the third position. from the present node.
	}
	elsif($direction eq "1")
	{			# It will be moved to the position below the specified number of positions.
		my $reachValue=$$TreeRef[$nodeIndex][0];
		&add_node($nodeCopy,$node2,"1",$TreeRef);

		if($node2<$nodeIndex)
		{
			&delete_node($nodeIndex+$reachValue,$TreeRef);
		}
		else
		{
			&delete_node($nodeIndex,$TreeRef);
		}
# e.g. if numberOfPositions is 3 then node will be inserted below the third position. from the present node.
	}
	else
	{
		print "ERROR IN SPECIFYING THE DIRECTION\n";
	}
	# There is no need of calling the modifyReachValues function here because the functions that we have called earlier 
	# Will take care of that.
}

#% Copy the entire tree
#% copy_tree ( [$tree] ) -> $tree2
#%
sub copy_tree()		# This will copy the entire tree and return a reference to that tree.
{
	my @copyTree;
	my $TreeRef=$_[0];

	if(not(defined($_[0])))
	{
		$TreeRef=\@_TREE_;
	}

	for(my $i=0;$i<@$TreeRef;$i++)
	{
		for(my $j=0;$j<5;$j++)		# copy all the elements of the tree and return a reference to the copy.
		{
			$copyTree[$i][$j]=$$TreeRef[$i][$j];
		}
	}

	return \@copyTree;	# Return a reference to the copied version of the tree.
}

#% Gets the parent of a node
#% &get_parent( $node , [$tree] ) -> $parent_node
#%
sub get_parent()			# Gets the index of the parent to the node specified.
{
	my $nodeIndex=$_[0];
	my $TreeRef=$_[1];
	my $matchBraces=0;

	if(not(defined($_[1])))
	{
		$TreeRef=\@_TREE_;
	}

	my $parent=-1;

	for(my $i=$nodeIndex-1;$i>=0;$i--)
	{
		if($$TreeRef[$i][2]=~/\(\(/)# Search until you reach the node with the opening paranthesis;
		{
			if($matchBraces eq 0)	# If that is an opening paranthesis and not a sibling
			{
				$parent=$i;
				last;
			}
			else
			{
				$matchBraces--;
			}
		}

		if($$TreeRef[$i][2]=~/\)\)/)
		{
			$matchBraces++;
		}
	}

	return $parent;		# A node will have atleast one parent. which is the SSF node introduced in the beginning.
}

#% Gets the next sibling
#% &get_next_node( $node , [$tree] ) -> $next_node
#%
sub get_next_node()		# Gets the index of the sibling (of the node specified) present below the present one.
{
	my $nodeIndex=$_[0];
	my $TreeRef=$_[1];

	if(not(defined($_[1])))
	{
		$TreeRef=\@_TREE_;
	}

	if($$TreeRef[$nodeIndex][2]=~/\)\)/)
	{	return -1;	}

	if(not($$TreeRef[$nodeIndex+$$TreeRef[$nodeIndex][0]][2]=~/\)\)/))		# Return the index of the next node.
	{	return ($nodeIndex+$$TreeRef[$nodeIndex][0]);	}
	else
	{	return -1;	}		# This indicates that it has no sibling.

}


#% Gets the previous sibling
#% &get_previous_node( $node , [$tree] ) -> $previous_node
#%
sub get_previous_node()
{
	my $nodeIndex=$_[0];
	my $TreeRef=$_[1];

	if(not(defined($_[1])))
	{
		$TreeRef=\@_TREE_;
	}

	if($$TreeRef[$nodeIndex-1][2]=~/\(\(/)	# This means that it has a parent immediately before it 
	{	return -1;	}	# And hence does not have a sibling before it .So we return -1.

	if(not($$TreeRef[$nodeIndex-1][2]=~/\)\)/)) # If its previous node is not a closing bracket then just return that
	{
		return $nodeIndex-1;		 # A minus one is returned in case of $nodeIndex of 0.
	}

	my $parent=&get_parent($nodeIndex);	 # If its previous node happens to be a more complicated node then.

	if($parent eq -1)
	{	return -1;	}

#	print "$parent\n\n";

	for(my $i=$nodeIndex-1;$i>$parent;$i--)
	{
		if($$TreeRef[$i][2]=~/\(\(/)
		{
			return $i;	# Incase you encounter a closing Bracket then just return the first bracket you see.
		}
	}

	return -1;
}

#% Adds a leaf before/after a node
#% &add_leaf( $node , $direction[0/1] , $f2 , $f3, $f4)
#%
sub add_leaf()
{
	my $position=$_[0];
	my $direction=$_[1];
	my $f2=$_[2];
	my $f3=$_[3];
	my $f4=$_[4];
	my $TreeRef;
	$TreeRef=$_[5];

	
		
	if(not(defined($_[5])))
	{
		$TreeRef=\@_TREE_;
	}
	
	if($direction eq "1")
	{
		$position+=$$TreeRef[$position][0];
	}

	my $numEle;
	$numEle=@$TreeRef;	# Number of elements in the array before it was modified.

	# Since this is the leaf node it is assumed that the offset required is 1.

	for(my $i=$numEle-1;$i>=$position;$i--)	# Start from the position where you have to add the new node.
	{
		for(my $j=0;$j<5;$j++)
		{
			$$TreeRef[$i+1][$j]=$$TreeRef[$i][$j];	# Make space for the coming new node.
		}
		undef($$TreeRef[$i]);
	}

	$$TreeRef[$position][2]=$f2;	
	$$TreeRef[$position][3]=$f3;	
	$$TreeRef[$position][4]=$f4;	

	&assign_reach($TreeRef);
}

sub change_old_new()
{
	my $TreeRef=$_[0];
	if(not(defined($_[0])))
	{
		$TreeRef=\@_TREE_;
	}

	for(my $i=0;$i<@$TreeRef;$i++)
	{
		my $featureStructure=$$TreeRef[$i][4];
		my $reference=&read_FS_old($featureStructure);
		my $convertedFeature=&make_string($reference);
		$$TreeRef[$i][4]=$convertedFeature;
	}
	
	return;
}

sub change_new_old()
{
	my $TreeRef=$_[0];
	if(not(defined($_[0])))
	{
		$TreeRef=\@_TREE_;
	}

	for(my $i=0;$i<@$TreeRef;$i++)
	{
		my $featureStructure=$$TreeRef[$i][4];
		my $reference=&read_FS($featureStructure);
		my $convertedFeature=&make_string_old($reference);
		$$TreeRef[$i][4]=$convertedFeature;
	}

	return;
}

sub delete_tree() {
	undef(@_TREE_);
}


#	REPORT BUGS TO ANY ONE OF THE ID's GIVEN BELOW
#		p_nirupam@students.iiit.net
#	(or)	sriram@students.iiit.net

1;
