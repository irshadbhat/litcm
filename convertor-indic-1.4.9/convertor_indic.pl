#!/usr/bin/perl

use Getopt::Long;
#use Encode;
use File::Basename;

GetOptions('help!'=>\$help, 'format=s'=>\$type, 'lang=s'=>\$lang, 'input=s'=>\$input, 'output:s'=>\$output, 'src_encoding=s'=>\$src, 'tgt_encoding=s'=>\$tgt, 'version'=>\$ver);

print "Unprocessed by Getopt::Long\n" if $ARGV[0];
foreach (@ARGV) {
       print "$_\n";
       exit(0);
}

if($help eq 1)
{
	#print "convertor-indic version 1.4.4 \n";
	print "usage :\nperl  convertor_indic.pl -f=ssf -l=hin -s=utf -t=wx -i=input_file \n\n";
	print " -f, --format=[ssf|text]	: select output format\n";
	print " -l, --lang=[hin|tel|...]	: select the language 3 letter code (ISO-639)\n";
	print " -s, --src_encoding=[utf|wx]	: select the encoding of input_file\n";
	print " -t, --tgt_encoding=[utf|wx]	: select the encoding of output_file\n";
	print " -i, --input=<input-file>	: give input file name\n";
	print " -o, --output=<output-file>	: give output file name\n\n";
	print "Report bugs to <rashid101b\@gmail.com>\n";
        exit(0);
}

if($ver eq 1)
{
        print "convertor-indic version 1.4.4 \n";
        exit(0);
}


if($type eq "" and $lang eq "" and $src eq "" and $tgt eq "")
{
	print "$0: missing argument\n";
        print "Try $0 --help for more information\n";
        exit(0);
}

if($type eq "")
{
        #print "Please Specify the Source Language type in ssf/text as defined in --help\n";
        #exit(0);
	$type = "ssf"
}

if($lang eq "")
{
	$lang = "hin";
}

if($src eq "")
{
	$src = "utf";
}

if($tgt eq "")
{
	$tgt = "wx";
}

# for ~/Desktop/ or ~/myinput/ directory issue fix
$home = $ENV{"HOME"};
$input =~ s/^~/$home/;
$output =~ s/^~/$home/;

$path = dirname($0);
#print "$path\n";

# SSF API
require "$path/ssfapi/shakti_tree_api.pl";
require "$path/ssfapi/feature_filter.pl";

# convertor-indic lib
require "$path/lib/IndicCC.pl";

# convertor-indic
#require "$path/utf2wx.pl";
#require "$path/wx2utf.pl";

if ($input eq "")
{
        #print "input:$input\n";
        $input="/dev/stdin";
}

#binmode (STDOUT, ":utf8");
#binmode (STDIN, ":utf8");

sub convertor_indic {
    my ($type, $src, $tgt, $lang, $input, $output) = @_;

if( lc($src) eq "wx" and lc($tgt) eq "utf")
{
	#open(STDIN,"<:utf8");
	open (INFILE, $input) or die "$!";
        if ($output ne "")
        {
            open (OUTFILE, ">$output") or die "$!";
        }
	if( lc($type) eq "ssf" )
        {
		#while($line=<STDIN>)
		while($line=<INFILE>)
        	{
                	chomp ($line);
                	($num, $tkn, $pos, $fs) = split(/\t/,$line);
			if ($tkn !~ /^\^?\@.*/)
			{
			    $lex_out = &wx2utf($tkn, $lang);
			}
                        else
                        {
                            $lex_out = $tkn;
                        }
        	        if($fs ne "")
                	{
	                        @fss = split(/\|/, $fs);
        	                my $len = @fss;
                	        @string  = "";
                        	$newfs = "";
	                        my $i=0;
        	                foreach $af (@fss)
                	        {
	                                my $FSreference = &read_FS($af, $line);
        	                        my @lex_root = &get_values("lex", $FSreference);
        	                        my @cat_root = &get_values("cat", $FSreference);
                	                my @fs_vib = &get_values("vib", $FSreference);
                        	        #my @fs_head = &get_values("head", $FSreference);
                                	#my @fs_name = &get_values("name", $FSreference);
	                                foreach $field (@lex_root)
        	                        {
						# if lcat is punc then don't convert it
                                                if ($cat_root[0] ne "punc" and $lex_root[0] !~ /^\^?\@.*/)
                                                {
						$val_out = &wx2utf($field, $lang);
                                        	my @lex_arr=();
	                                        push @lex_arr,$val_out;
        	                                &update_attr_val("lex", \@lex_arr,$FSreference,$af);
                	                        $string[$i]=&make_string($FSreference,$af);
						}
                        	        }
                                	foreach $field1 (@fs_vib)
	                                {
						if ($field1 !~ /^\^?\@.*/)
                                                {
						$vib_out = &wx2utf($field1, $lang);
                                        	my @fs_vib_arr=();
	                                        push @fs_vib_arr,$vib_out;
        	                                &update_attr_val("vib", \@fs_vib_arr,$FSreference,$af);
                	                        $string[$i]=&make_string($FSreference,$af);
						}
                        	        }
                                	#foreach $field (@fs_head)
	                                #{
					#	if ($field !~ /^\^?\@.*/)
                                         #       {
					#	$val_out = &wx2utf($field, $lang);
        	                         #       my @head_arr=();
                	                  #      push @head_arr,$val_out;
                        	           #     &update_attr_val("head", \@head_arr, $FSreference, $af);
                                	    #    $string[$i] = &make_string($FSreference, $af);
					#	}
	                                #}	
        	                       # foreach $field (@fs_name)
                	               # {
				#		if ($field !~ /^\^?\@.*/)
                                 #               {
				#		$val_out = &wx2utf($field, $lang);
                	         #               my @name_arr=();
                        	  #              push @name_arr,$val_out;
                                #	        &update_attr_val("name", \@name_arr,$FSreference,$af);
                                 #       	$string[$i]=&make_string($FSreference,$af);
				#		}
                                #	}
	                                $i++;
        	                }
				foreach $string (@string)
				{	
					if(--$len)
					{	
        	                       		$newfs=$newfs.$string."|";
					}
					else
					{
						$newfs=$newfs.$string;
					}
				}
				delete @string[0..$#string];
				delete @lex_root[0..$#lex_root];
				delete @fss[0..$#fss];
				if($line =~ /\(\(/ or $line =~ /\)\)/)
				{
					($num,$lex,$pos,$fs) = split(/\t/,$line);
                                        if ($output ne "")
                                        {
					#print OUTFILE $num,"\t",$lex,"\t",$pos,"\t",$newfs,"\n";
					print OUTFILE "$num\t$lex\t$pos\t$newfs\n";
                                        }
                                        else
                                        {
					print $num,"\t",$lex,"\t",$pos,"\t",$newfs,"\n";
                                        }
				}
				else
				{
                                        if ($output ne "")
                                        {
					print OUTFILE $num,"\t",$lex_out,"\t",$pos,"\t",$newfs,"\n";
                                        }
                                        else
                                        {
					print $num,"\t",$lex_out,"\t",$pos,"\t",$newfs,"\n";
                                        }
				}
			} # end if fs ne "" 
			else {  # try to understand this else block
				
				if($lex ne "((" and $lex ne "))")
				{
                                        if ($output ne "")
                                        {
					print OUTFILE $num,"\t",$lex_out,"\t",$pos,"\t",$fs,"\n";
                                        }
                                        else
                                        {
					print $num,"\t",$lex_out,"\t",$pos,"\t",$fs,"\n";
                                        }
				}
				else {
                                        if ($output ne "")
                                        {
					    print OUTFILE $line."\n";
                                        }
                                        else
                                        {
					    print $line."\n";
                                        }
				}
			}


        	} # end while loop
	} # if format SSF end
	#elsif(($type eq "TEXT") or ($type eq "text"))
	elsif( lc($type) eq "text" )
        {
		while($line=<INFILE>)
        	{
                	#chomp ($line);
			$text_out = &wx2utf($line, $lang);
                        if ($output ne "")
                        {
			print OUTFILE $text_out;
                        }
                        else
                        {
			print $text_out;
			#print "under construction\n";
			}
		}
	} # type text end
	else
	{
		#print "type mismatch\n";
		print "format type $type is NOT supported.\n";
        	print "Try $0 --help for more information\n";
        	exit(0);
	}
    close(INFILE);
    close(OUTFILE);
} # end if statement src=wx tgt=utf

elsif( lc($src) eq "utf" and lc($tgt) eq "wx")
{
	#open(STDIN,"<:utf8");
	open INFILE, $input or die  $!;
        if ($output ne "")
        {
            open (OUTFILE, ">$output") or die $!;
        }
	if( lc($type) eq "ssf" )
        {
		#print "ssf conversion start\n";
		while($line=<INFILE>)
        	{
                	chomp ($line);
                	($num, $tkn, $pos, $fs) = split(/\t/,$line);
			$lex_out = &utf2wx($tkn, $lang);

        	        if($fs ne "")
                	{
	                        @fss = split(/\|/, $fs);
        	                my $len = @fss;
                	        @string  = "";
                        	$newfs = "";
	                        my $i=0;
        	                foreach $af (@fss)
                	        {
	                                my $FSreference = &read_FS($af, $line);
        	                        my @lex_root = &get_values("lex", $FSreference);
        	                        my @cat_root = &get_values("cat", $FSreference);
                	                my @fs_vib = &get_values("vib", $FSreference);
                        	        #my @fs_head = &get_values("head", $FSreference);
                                	#my @fs_name = &get_values("name", $FSreference);
	                                foreach $field (@lex_root)
        	                        {
						# if lcat is punc then don't convert it
                                                if ($cat_root[0] ne "punc" )
                                                {
						$val_out = &utf2wx($field, $lang);
                                        	my @lex_arr=();
	                                        push @lex_arr,$val_out;
        	                                &update_attr_val("lex", \@lex_arr,$FSreference,$af);
                	                        $string[$i]=&make_string($FSreference,$af);
						}
                        	        }
                                	foreach $field1 (@fs_vib)
	                                {
						$vib_out = &utf2wx($field1, $lang);
                                        	my @fs_vib_arr=();
	                                        push @fs_vib_arr,$vib_out;
        	                                &update_attr_val("vib", \@fs_vib_arr,$FSreference,$af);
                	                        $string[$i]=&make_string($FSreference,$af);
                        	        }
                                	#foreach $field (@fs_head)
	                                #{
					#	$val_out = &utf2wx($field, $lang);
        	                        #        my @head_arr=();
                	                #        push @head_arr,$val_out;
                        	        #        &update_attr_val("head", \@head_arr, $FSreference, $af);
                                	#        $string[$i] = &make_string($FSreference, $af);
	                                #}	
        	                        #foreach $field (@fs_name)
                	                #{
					#	$val_out = &utf2wx($field, $lang);
                	                #        my @name_arr=();
                        	        #        push @name_arr,$val_out;
                                	#        &update_attr_val("name", \@name_arr,$FSreference,$af);
                                        #	$string[$i]=&make_string($FSreference,$af);
                                	#}
	                                $i++;
        	                }
				foreach $string (@string)
				{	
					if(--$len)
					{	
        	                       		$newfs=$newfs.$string."|";
					}
					else
					{
						$newfs=$newfs.$string;
					}
				}
				delete @string[0..$#string];
				delete @lex_root[0..$#lex_root];
				delete @fss[0..$#fss];
				if($line =~ /\(\(/ or $line =~ /\)\)/)
				{
					($num,$lex,$pos,$fs) = split(/\t/,$line);
					#print $num,"\t",$lex,"\t",$pos,"\t",$newfs,"\n";
                                        if ($output ne "")
                                        {
					    print OUTFILE $num,"\t",$lex,"\t",$pos,"\t",$newfs,"\n";
                                        }
                                        else
                                        {
					    print $num,"\t",$lex,"\t",$pos,"\t",$newfs,"\n";
                                        }
				}
				else
				{
                                        if ($output ne "")
                                        {
					print OUTFILE $num,"\t",$lex_out,"\t",$pos,"\t",$newfs,"\n";
                                        }
                                        else
                                        {
					print $num,"\t",$lex_out,"\t",$pos,"\t",$newfs,"\n";
                                        }
					#print $num,"\t",$lex_out,"\t",$pos,"\t",$newfs,"\n";
				}
			} # end if fs ne "" 
			else {  # try to understand this else block
				if($lex ne "((" and $lex ne "))")
				{
                                        if ($output ne "")
                                        {
					print OUTFILE $num,"\t",$lex_out,"\t",$pos,"\t",$fs,"\n";
                                        }
                                        else
                                        {
					print $num,"\t",$lex_out,"\t",$pos,"\t",$fs,"\n";
                                        }
					#print $num,"\t",$lex_out,"\t",$pos,"\t",$fs,"\n";
				}
				else{
                                        if ($output ne "")
                                        {
                                            print OUTFILE $line."\n";
                                        }
                                        else
                                        {
					    print $line."\n";
                                        }
				}
			}


        	} # end while loop

	} # type SSF end
	elsif( lc($type) eq "text")
        {
		#print "text conversion block called\n";
		while($line=<INFILE>)
        	{
                	#chomp ($line);
			#print "before convert call $line\n";
			$text_out = &utf2wx($line, $lang);
                        if ($output ne "")
                        {
                            print OUTFILE $text_out;
                        }
                        else
                        {
			    print $text_out;
                        }
			#print "under construction\n";
		}	
	} # end format type text
	else
	{
		print "format type $type is NOT supported.\n";
        	print "Try $0 --help for more information\n";
        	exit(0);
	}
    close(INFILE);
    close(OUTFILE);
} # end elsif statement src=utf tgt=wx
else
{
	print "$0: source and target encoding mismatch\n";
        print "Try $0 --help for more information\n";
        exit(0);
}

} # end of sub convertor_indic

&convertor_indic($type, $src, $tgt, $lang, $input, $output);
