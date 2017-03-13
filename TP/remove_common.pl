#Enleve les mots communs des fichier .flt et genere des fichiers .stp
#prend en parametre le fichier Collection , l'emplacement des fichiers d'entree, la destination des fichier de sortie, et le fichier contenant les mots commun.
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


sub retrait ($$$$)
{
	my($FileName,$Path,$Path2,$Common)=@_;
	open(FF,"$Path/$FileName.flt") || die "Erreur d'ouverture du fichier $Path/$FileName.flt\n";
	my $str="";
	open(NF,">$Path2/$FileName.stp");
	print "$collection";
	%h =creation_hash($Common);
	while(chop($str=<FF>)){
		@tab=split(/ /,$str);

		#foreach my $k (keys(%h)) {
   		#	print "Clef=$k Valeur=$h{$k}\n";
		#}


		foreach $v (@tab){
			if( !exists( $h{$v})){
				if ($v!~m/[0-9]/){
					print NF $v;
				#	print "$v\n";
					print NF " ";
				}
			}
		}
	} 
	close(NF); 
	close (FF);
}




sub toutFichier ($$$$){
	my($FileName,$Path,$Path2,$Common)=@_;
	open(F,$FileName) || die "Erreur d'ouverture du fichier $FileName\n";
        while(chop($nom_fichier=<F>)){

		print "Processing $nom_fichier ...\n";
		retrait ($nom_fichier,$Path,$Path2,$Common);    
       }
	close (F);
}		

toutFichier (@ARGV[0],@ARGV[1],@ARGV[2],@ARGV[3]);
