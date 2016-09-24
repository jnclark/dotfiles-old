dir=$(dirname "$(readlink -f "$0")") # root dotfiles directory
files="latexmkrc" # dotfiles to symlink
olddir=$dir/dotfiles_old


# create dotfiles_old to backup
echo "Creating backup location in $olddir"
mkdir -p $olddir
echo "...process complete"

# move existing dotfiles in home to dotfiles_old directory
# and create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles for $file to backup location."
    mv ~/.$file $dir/dotfiles_old/$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo "...dotfile install process complete"

#source ~/.bashrc (to be added)
#source ~/.vimrc
