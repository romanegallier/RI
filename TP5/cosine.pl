sub creation_hash_norme ($$)
{
	my($FileName,$Path,$Path2)=@_;
	open(FA,$FileName) || die "Erreur d'ouverture du fchier $FileName\n";
	
	my $file ="";
	my $str="";
	my %ha;
	
	while(!eof(FA)){
		chop($file=<FA>);
		open(FO,"$path/$File.bin") || die "Erreur d'ouverture du fchier $path/$FileName\n";
		while
		while( my $str = <> ) {
  		my $weight = (split m/\s+/, $str)[-1];

		$ha{$weight}=1;
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
