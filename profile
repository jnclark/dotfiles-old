#SageTex
export TEXINPUTS="/usr/lib/sagemath/local/share/texmf//:"

#ssh daemon paswd to get seahorse sshd capabilities in xfce, i3
export $(gnome-keyring-daemon --daemonize --start)

#map caps lock to ctrl
setxkbmap -option 'caps:ctrl_modifier'

#default editor for quick edits
export EDITOR="emacsclient -t"
export VISUAL="emacsclient"

#emacsclient
export ALTERNATE_EDITOR=""