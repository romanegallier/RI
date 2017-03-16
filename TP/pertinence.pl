sub calcul_cosine ($$){
	
	my($File_doc,$File_query)=@_;
	my $normeDoc;
	my $normeReq;
	open(F_D,$File_doc) || die "Erreur d'ouverture du fichier $File_doc\n";
	open(F_Q,$File_query) || die "Erreur d'ouverture du fichier $File_query\n";
	
	my %doc=();
	my %req=();
	
	my $str="";
	$normeDoc=0;
	$normeReq=0;
	#print "\n parcours documents\n";
	while(chop($str=<F_D>)){
		@tab=split(/: /,$str);
		$doc{$tab[0]}=$tab[1];
		$normeDoc+=$tab[1]**2;
	}
	#print " norme doc :$normeDoc";

	while(chop($str=<F_Q>)){
		@tab=split(/:/,$str);
		$req{$tab[0]}=$tab[1];
		$normeReq+=$tab[1]**2;
	}
	#print "norme re :$normeReq";

	my $produit_scalaire =0;
	foreach my $k (keys(%req)){
		if(exists( $doc{$k})){
			$produit_scalaire= $produit_scalaire+$doc{$k}*$req{$k};
		}
	}
	
	my $cosine = $produit_scalaire/ sqrt ($normeDoc* $normeReq);
	
	#print "\n Cosine $File_doc, $File_query = $cosine\n";
	return $cosine;
}


sub k_similaire($$$){
	my($K,$Path,$File_query)=@_;
	my %ha=();
	open(F,"CACM/Collection") || die "Erreur d'ouverture du fichier CACM/Collection\n";
        while(chop($nom_fichier=<F>)){

		#print "Processing $nom_fichier ...\n";
		
		my $c = calcul_cosine("$Path/$nom_fichier.bin",$File_query);
		$ha{$nom_fichier}=$c;
       }
	close (F);
	
	 my %pertinent= ();
	for ($i=0;$i<$K;$i++){
		my $max =0;
		my $key_max;
		foreach my $j (keys(%ha)){
			if (%ha{$j}>$max){ 
				$max= %ha{$j};
				$key_max= $j;
			}
		}
		$pertinent{$key_max}=$max;
		#$ha{$key_max}=0;
		delete $ha{$key_max};
	}
	
	foreach my $k (keys(%pertinent)){
		#print " $pertinent{$k}: $k\n";
	}
	
	return %pertinent;
	
}
#retourne la precision
#prend en parametre combien de fichier on veut l'emplacement des fichiers a regarder, la requete et son numero 
sub pertinent ($$$$){
	my($K,$Path,$File_query,$num)=@_;
	open(F_qrels,"Sources/qrels.text") || die "Erreur d'ouverture du fichier Sources/qrels.text\n";
	my %qrels=();
	while(chop($str=<F_qrels>)){
		@tab=split(/ /,$str);
		if ($tab[0]=$num){
			$qrels{"CACM-$tab[1]"}=1;
		}
	}
	 
	
	
	###precision = nombre de doc renvoyes/ nombre de doc pertinent 
	
	### nombre de doc renvoyes :
	%rep=k_similaire($K,$Path,$File_query);
	my $nb_doc_pertinent=0;
	
	foreach my $k (keys(%rep)){
		if (exists ($rep{$k})){
			$nb_doc_pertinent++;
		}
	}
	return ($nb_doc_pertinent/$K);
}

#retourne le rappel
#prend en parametre combien de fichier on veut l'emplacement des fichiers a regarder, la requete et son numero 
sub fct_rappel ($$$$){
	my($K,$Path,$File_query,$num)=@_;
	open(F_qrels,"Sources/qrels.text") || die "Erreur d'ouverture du fichier Sources/qrels.text\n";
	my %qrels=();
	my %nb_pert=0;
	while(chop($str=<F_qrels>)){
		@tab=split(/ /,$str);
		if ($tab[0]=$num){
			$qrels{"CACM-$tab[1]"}=1;
			$nb_pert++;
		}
	}
	 
	
	
	###precision = nombre de doc renvoyes/ nombre de doc pertinent 
	
	### nombre de doc renvoyes :
	%rep=k_similaire($K,$Path,$File_query);
	my $nb_doc_pertinent=0;
	
	foreach my $k (keys(%rep)){
		if (exists ($rep{$k})){
			$nb_doc_pertinent++;
		}
	}
	return ($nb_doc_pertinent/$nb_pert);
}


sub moyenne_precision ($$$){
	my($Path,$File_query,$num)=@_;
	my $moyenne=0;
	for ($i=1;$i<3204;$i++){
		print "$i.../3024\n";
		$moyenne +=pertinent($i,$Path,$File_query,$num);
	}
	$moyenne=$moyenne/3204;
	return $moyenne;
}

sub MAP ($$){
	##pas compris la question
}

sub ecriture_rappel_precision($$$){
	my($Path,$File_query,$num)=@_;
	open(F232,">Rappel_pertinence.txt") || die "Erreur d'ouverture du fichier Rappel_pertinence.txt\n";
	print F232 "petit fichier";
	for ($i=1;$i<10;$i++){ # faire jusua 3204
		print "$i  ";
		print "precision  ";
		$precision=pertinent($i,$Path,$File_query,$num);
		print "rappel\n";
		$rappel=fct_rappel($i,$Path,$File_query,$num);
		print F232 "$rappel $precision\n";
		
	}
	close (F232);
}
	
#precision : nombre de document pertinent retournes /nombre de document retournes 
#rappel : nom de documents pertinents retournes / nombre de document pertinents 


#k_similaire (@ARGV[0],@ARGV[1],@ARGV[2]);
#ecriture_rappel_precision (@ARGV[0],@ARGV[1],@ARGV[2]);
moyenne_precision (@ARGV[0],@ARGV[1],@ARGV[2]);
