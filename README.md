# dotfiles
My configuration files.

## latexmkrc
tested on Linux, incorporates SageTeX to latexmk

## vimrc
tested on Linux, to pull all submodules easily, utilize 
```
git pullall 
```
to pull all submodules

## gitconfig
One needs to add in a local config file with user info for git
### .gitconfig.local
```
[user]
	name = First Last
	email = example@example.edu
``` 

## hgrc
One needs to do the same as git for mercurial.
### .hgrc.local
```
[ui]
username = First Last <example@example.edu>

```

## muttrc
you need to add in user info, such as email, etc.,
and any aliases you might wish to use

### user
```
# User config
set my_realname="First Last"
set my_username="example"
set my_domain="example.edu"
```

### aliases
```
alias name First Last <example@example.edu>
```
