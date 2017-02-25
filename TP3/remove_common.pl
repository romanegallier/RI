#pour lancer ce fichier 
#perl remove_common.pl ./Files/Collection  ./Files_flt ./File_stp
#depuis le repertoire TP3

sub creation_hash ($)
{
	my($FileName)=@_;
	open(FA,$FileName) || die "Erreur d'ouverture du fchier $FileName\n";
	my $str="";
	my %ha;
	
	while(!eof(FA)){
		chop($str=<FA>);
		$ha{$str}=1;
	}
	
	return %ha;
}


sub retrait ($$$)
{
	my($FileName,$Path,$Path2)=@_;
	open(FF,"$Path/$FileName.flt") || die "Erreur d'ouverture du fichier $Path/$FileName.flt\n";
	my $str="";
	open(NF,">$Path2/$FileName.stp");
	print "$collection";
	%h =creation_hash("./TP1/Sources/common_words");
	while(chop($str=<FF>)){
		@tab=split(/ /,$str);

		#foreach my $k (keys(%h)) {
   		#	print "Clef=$k Valeur=$h{$k}\n";
		#}


		foreach $v (@tab){
			if( !exists( $h{$v})){
				print NF $v;
			#	print "$v\n";
				print NF " ";
			}
		}
	} 
	close(NF); 
	close (FF);
}




sub toutFichier ($$$){
	my($FileName,$Path,$Path2)=@_;
	open(F,$FileName) || die "Erreur d'ouverture du fichier $FileName\n";
        while(chop($nom_fichier=<F>)){

		print "Processing $nom_fichier ...\n";
		retrait ($nom_fichier,$Path,$Path2);    
       }
	close (F);
}		

toutFichier (@ARGV[0],@ARGV[1],@ARGV[2]);
