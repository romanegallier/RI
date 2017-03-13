# Construit a partie des fichier .stp la liste du vocabulaire present dans la collection.

sub ajout_voc ($$$$)
{
	my($FileName,$Path,%ha,$F2)=@_;
	open(FF,"$Path/$FileName.stp") || die "Erreur d'ouverture du fichier $Path/$FileName.stp\n";
	my $str="";
	
	while(chop($str=<FF>)){
		@tab=split(/ /,$str);

		foreach my $k (keys(%ha)) {
   			print "Clef=$k Valeur=$h{$k}\n";
		}


		foreach $v (@tab){
			if( !exists( $ha{$v})){
				
					$ha{$v}=1;
					print F2 "$v\n";
				
			}
		}
		return %ha;
	} 
	close (FF);
}




sub toutFichier ($$$){


	my($FileName,$Path,$FileName2)=@_;
	my %ha;
	open(F,$FileName) || die "Erreur d'ouverture du fichier $FileName\n";
	open(F2,">$FileName2") || die "Erreur d'ouverture du fichier $FileName2\n";
        while(chop($nom_fichier=<F>)){

		print "Processing $nom_fichier ...\n";
		#ajout_voc ($nom_fichier,$Path,%ha,F2); 


		open(FF,"$Path/$nom_fichier.stp") || die "Erreur d'ouverture du fichier $Path/$nom_fichier.stp\n";
		my $str="";
	
		while(chop($str=<FF>)){
			@tab=split(/ /,$str);

			#foreach my $k (keys(%ha)) {
   			#	print "Clef=$k Valeur=$h{$k}\n";
			#}


			foreach $v (@tab){
				if( !exists( $ha{$v})){
					if ($v!~m/[0-9]/){
						$ha{$v}=1;
						print F2 "$v\n";
					}
				}
			}	
			
		} 
		close (FF);
       }
	close (F);
}		

toutFichier (@ARGV[0],@ARGV[1],@ARGV[2]);
#prend en parametre le fichier collection, l'emplacement des fichiers .stp , le nom du fichier de destination
