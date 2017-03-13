#premiere veriosn pour la representation binaire / frequentielle / tf-idf  frequentielle * frequence 
#PROBLEME parce que les chiffres ne sont pas enlevée dans le stp.

#faire en sorte que le format de sortie soit a choisir 
sub Fichier_binaire  ($$$){
		my(%voc,$F_S,$F_E)=@_;
		print "\ncreation du fichier binaire\n";
		
		#parcours du fichiers pour creer l'index.
		my %parcours=();
	    my $str="";
			
		# creation d'une table de haschage par fichier
		while(chop($str=<F_E>)){
			@tab=split(/ /,$str);
			foreach $v (@tab){
				#si le mots n'a pas encore ete rencontres on le met dans l'index.
				if( !exists( $parcours{$v})){
					$parcours{$v}=1;
					#et on note que il a deja ete rencontr dans la table de haschage
					
					print F_S "$voc{$v}: 1\n";
				}
			}	
		
		}
}		

sub Fichier_freq ($$$){	
	my($voc,$F_S,$F_E)=@_;
	#parcours du fichiers pour creer l'index.
	my %parcours=();
	my $str="";
		
	# creation d'une table de haschage par fichier
	while(chop($str=<F_E>)){
		@tab=split(/ /,$str);
		foreach $v (@tab){
			#si le mots n'a pas encore ete rencontres on le met dans l'index.
			if( !exists( $parcours{$v})){
				$parcours{$v}=1;
			}
			else {$parcours{$v}= $parcours{v}+1;}
		}
	}
	foreach my $k (keys(%parcours)) {
   		print F_S "$voc{$k} :$parcours{$k}\n ";
	}
}


sub Fichier_tf_idf ($$$$){
	my($voc,$F_S,$F_E,$tf)=@_;
	
	#parcours du fichiers pour creer l'index.
	my %parcours=();
	my $str="";
		
	# creation d'une table de haschage par fichier
	while(chop($str=<F_E>)){
		@tab=split(/ /,$str);
		foreach $v (@tab){
			#si le mots n'a pas encore ete rencontres on le met dans l'index.
			if( !exists( $parcours{$v})){
				$parcours{$v}=1;
			}
			else {$parcours{$v}= $parcours{v}+1;}
		}	
	
	}
	foreach my $k (keys(%parcours)) {
		$temp= $parcours{$k}*$tf{$k};
   		print F_S "$voc{$k} :$temp \n ";
	}
}		

#Fichier(@ARGV[0],@ARGV[1],@ARGV[2],@ARGV[3],@ARGV[4]);

#argv2 -> nom du fichier a transformer 
#argv 1 -> nom du fichier ou ont ecrit 
#argv0 -> fichier contenant le vocabulaire 
#argv3 -> document frequency

# document avec le voc , chemin des fichier en entree, chemin des fichier en sortie, document frequency, doc collection. 
sub toutFichier ($$$$$$){
	my($File_voc,$path1,$path2,$freq,$collection,$choix)=@_;
	print "voc:$File_voc,path1:$path1,path2:$path2,freq:$freq,collection:$collection,choix:$choix\n";
	
	########
	my %voc;
	#filesortie
	#file entree
	
	#ouverture du fichier de vocabulaire.
	open(F_voc,$File_voc) || die "Erreur d'ouverture du fichier $File_voc\n";
	#ouverture des documents frequency
	open(F_df,$freq) || die "Erreur d'ouverture du fichier $freq\n ";
	
	#creation d'une hastable contenant les mots du vocabulaire, et leur indice dans le vocabulaire.
	my %voc;
	my $i=1;
	while(chop($mot=<F_voc>)){
		$voc{$mot}=$i;
		$i=$i+1;
	}
	close (F_voc);
	
	
	if ($choix eq "tf"){
		#creation d'une hastable contenant les mots du vocabulaire, et leur freqence.
		print "je cree la hastable des frequences";
		my %tf_idf=();
		my $ligne="";
		while(chop($ligne=<F_df>)){
			@tab=split(/ /,$ligne);
			$tf_idf{@tab[1]}=@tab[0];
			print "@tab[0]=@tab[1]\n";
		}
		close (F_df);
	}
	
	##problemme la table tf est vide a la fin ...
	
	
	
	##########
	
	open(F,"$collection") || die "Erreur d'ouverture du fichier $FileName\n";
    while(chop($nom_fichier=<F>)){
		#print "Processing $nom_fichier ...\n";
		######
		$FileSortie= "$nom_fichier.bin";
		$FileSortie= "$path2/$FileSortie";
		#print "fichier sortie = $FileSortie\n";
		$FileEntree= "$nom_fichier.stp";
		#ouverture du fichier pour ecrire
		open(F_S,">$FileSortie") || die "Erreur d'ouverture du fichier $FileSortie\n";
		#ouverture du fichier a transformer
		open(F_E,"$path1$FileEntree") || die "Erreur d'ouverture du fichier $FileEntree\n ";
		
		#################################################################################
		#cas binaire
		#################################################################################
		if ($choix eq "b"){
			print "binaire";
			#Fichier_binaire($voc,F_S,F_E);
			print "\ncreation du fichier binaire\n";
		
		   	#parcours du fichiers pour creer l'index.
			my %parcours=();
			my $str="";
				
			# creation d'une table de haschage par fichier
			while(chop($str=<F_E>)){
				@tab=split(/ /,$str);
				foreach $v (@tab){
					#si le mots n'a pas encore ete rencontres on le met dans l'index.
					if( !exists( $parcours{$v})){
						$parcours{$v}=1;
						#et on note que il a deja ete rencontr dans la table de haschage
						
						print F_S "$voc{$v}: 1\n";
					}
				}	
			
			}
		}
		#################################################################################
		#cas freq
		#################################################################################
		
		else {
			if  ($choix eq "f"){
				print "freq";
				#Fichier_freq(%voc,F_S,F_E);
				#parcours du fichiers pour creer l'index.
				my %parcours=();
				my $str="";
					
				# creation d'une table de haschage par fichier
				while(chop($str=<F_E>)){
					@tab=split(/ /,$str);
					foreach $v (@tab){
						#si le mots n'a pas encore ete rencontres on le met dans l'index.
						if( !exists( $parcours{$v})){
							$parcours{$v}=1;
						}
						else {$parcours{$v}= $parcours{v}+1;}
					}
				}
				foreach my $k (keys(%parcours)) {
					print F_S "$voc{$k} :$parcours{$k}\n ";
				}
			}
		#################################################################################
		#cas tf
		#################################################################################
		
			
			else{
				#print "tf";
				#Fichier_tf_idf(%voc,F_S,F_E,%tf);
				
				#parcours du fichiers pour creer l'index.
				my %parcours=();
				my $str="";
					
				# creation d'une table de haschage par fichier
				while(chop($str=<F_E>)){
					@tab=split(/ /,$str);
					foreach $v (@tab){
						#si le mots n'a pas encore ete rencontres on le met dans l'index.
						if( !exists( $parcours{$v})){
							$parcours{$v}=1;
						}
						else {$parcours{$v}= $parcours{v}+1;}
					}	
				
				}
				foreach my $k (keys(%parcours)) {
					$temp= $parcours{$k}*$tf_idf{$k};
					print F_S "$voc{$k} :$temp: $parcours{$k}:$tf{$k} \n ";
				}
			}
		}


		close(F_S);
		close(F_E);
		######
	}   
	close (F);
}		
toutFichier(@ARGV[0],@ARGV[1],@ARGV[2],@ARGV[3],@ARGV[4],@ARGV[5]);

