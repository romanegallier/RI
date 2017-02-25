#pour lancer ce fichier 
#perl remove_common.pl ./Files/Collection  ./Files_flt ./File_stp
#depuis le repertoire TP3
# enlever les chiffres :
# if ($ mot ! ~n/[0-9]/)
# ne pas faire le 5


	sub toutFichier ($$$){


		my($FileName,$Path,$FileName2)=@_;
		my %voc;

		open(F,$FileName) || die "Erreur d'ouverture du fichier $FileName\n";
		#ouverture du fichier pour ecrire
		open(F2,">$FileName2") || die "Erreur d'ouverture du fichier $FileName2\n";
		#ouverture du fichier collection



        while(chop($nom_fichier=<F>)){
			%doc=();
			print "Processing $nom_fichier ...\n";

			open(FF,"$Path/$nom_fichier.stp") || die "Erreur d'ouverture du fichier $Path/$nom_fichier.stp\n";
			my $str="";
			
			# creation d'une table de haschage par fichier
			while(chop($str=<FF>)){
				@tab=split(/ /,$str);

				foreach $v (@tab){
					if( !exists( $doc{$v})){
						$doc{$v}=1;
					}
				}	
			}
			
			
			
			close (FF);

			# il faut faire quelque chose avec la table de hash doc elle contient les mots present dans le documents.
		
			#parcourir doc est pour tout les mots present dedans faire +1 dans voc 

			foreach my $k (keys(%doc)) {
				if( ! exists ($voc{$k})){
					$voc{$k}=1;
				}
				else {
					$voc{$k}=$voc{$k}+1;
				}
			}
		}
		
		foreach my $l (keys(%voc)){
			print F2 "$l $voc{$l} \n";
		
		}

		close (F);
		close(F2);
	}		

toutFichier (@ARGV[0],@ARGV[1],@ARGV[2]);
