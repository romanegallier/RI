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
	print "\n parcours documents\n";
	while(chop($str=<F_D>)){
		@tab=split(/: /,$str);
		$doc{$tab[0]}=$tab[1];
		$normeDoc+=$tab[1]**2;
	}
	print " norme doc :$normeDoc";

	while(chop($str=<F_Q>)){
		@tab=split(/:/,$str);
		$req{$tab[0]}=$tab[1];
		$normeReq+=$tab[1]**2;
	}
	print "norme re :$normeReq";

	my $produit_scalaire =0;
	foreach my $k (keys(%req)){
		if(exists( $doc{$k})){
			$produit_scalaire= $produit_scalaire+$doc{$k}*$req{$k};
		}
	}
	
	my $cosine = $produit_scalaire/ sqrt ($normeDoc* $normeReq);
	
	print "\n Cosine $File_doc, $File_query = $cosine\n";
	return $cosine;
}


sub k_similaire($$$){
	my($K,$Path,$File_query)=@_;
	my %ha=();
	open(F,"CACM/Collection") || die "Erreur d'ouverture du fichier CACM/Collection\n";
        while(chop($nom_fichier=<F>)){

		print "Processing $nom_fichier ...\n";
		
		my $c = calcul_cosine("$Path/$nom_fichier.bin",$File_query);
		$ha{$nom_fichier}=$c;
       }
	close (F);
	
	foreach my $k ( sort ({ $ha{$a} <=> $ha{$b} } keys %ha)){
	print "$k\t$ha{$k}\n";
}

	
		
}		

k_similaire (@ARGV[0],@ARGV[1],@ARGV[2]);

 
