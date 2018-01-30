dir=$(dirname "$(readlink -f "$0")") # root dotfiles directory
files="latexmkrc vimrc gitconfig hgrc config/i3/config" # dotfiles to symlink
folders="vim emacs.d mutt" #dotfolders to symlink
olddir=$dir/dotfiles_old


# create dotfiles_old to backup
echo "Creating backup location in $olddir"
mkdir -p $olddir

# move existing dotfiles in home to dotfiles_old directory
# and create symlinks 
for file in $files; do
    mv ~/.$file $dir/dotfiles_old/$file
    ln -s $dir/$file ~/.$file
done

for folder in $folders; do
    mv ~/.$folder $dir/dotfiles_old/$folder
    ln -s $dir/$folder ~/.$folder
done

echo "...dotfile install process complete"

#source ~/.bashrc (to be added)
