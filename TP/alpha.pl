
# prend un fichier CACM-* et produit un fichiers  CACM-*.flt
# Enleve les caracteres non alpha numerique 
# prend en parametre un nom de fichier , l'emplacement des fichier en entree et l'emplacement des fichier en sortie.

sub AlphaNum ($$$)
{
	my($FileName,$Path,$Path2)=@_;
	open(FF,"$Path/$FileName") || die "Erreur d'ouverture du fichier $FileName\n";
	my $str="";
	open(NF,">$Path2/$FileName.flt");	
	while(chop($str=<FF>)){
		#chop($str=<F>);
                
		$str =~ s/(\`|\"|\,|\=|\/|\.|\?|\'|\(|\)|\_|\$|\%|\+|\[|\]|\{|\}|\&|\;|\:|\~|\!|\@|\#|\^|\*|\||\<|\>|\-|\\s|\\)//g;
		$str=lc($str);
		print NF "$str "; # On écrit le contenu dans le fichier CACM-XX

	} 
	close(NF); 
	close (FF);
}


# prend tout les fichiers CACM-* et produit des fichiers  CACM-*.flt
# Enleve les caracteres non alpha numerique 
# prend en parametre le fichier colection, l'emplacement des fichier en entree et l'emplacement des fichier en sortie.

sub toutFichier ($$$){
	my($FileName,$Path,$Path2)=@_;
	open(F,"$FileName") || die "Erreur d'ouverture du fichier $FileName\n";
	#while(!eof(F)){
        while(chop($nom_fichier=<F>)){

	print "Processing $nom_fichier ...\n";
	AlphaNum ($nom_fichier,$Path,$Path2);    
       }
	close (F);
}		





 
toutFichier(@ARGV[0],@ARGV[1],@ARGV[2]);


