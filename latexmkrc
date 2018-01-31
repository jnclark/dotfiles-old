$pdf_mode = 1;
$pdf_previewer = 'start zathura';
$preview_continuous_mode = 1;
#$out_dir = 'build';

push @extra_pdflatex_options, '-synctex=1' ;

# Set aliases for latexmkrc so it can handle running SageTeX if neccesary
$latex = "$latex ; python /usr/lib/sagemath/local/share/texmf/tex/latex/sagetex/run-sagetex-if-necessary.py %B";
$pdflatex = "$pdflatex ; python /usr/lib/sagemath/local/share/texmf/tex/latex/sagetex/run-sagetex-if-necessary.py %B";

add_cus_dep( 'sage', 'sout', 0, 'makesout' );
$hash_calc_ignore_pattern{'sage'} = '^( _st_.goboom|print .SageT)';
sub makesout {
   system( "sage \"$_[0].sage\"" );
}
