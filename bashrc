# A bashrc template, use copy past to complement the existing bashrc
if [ -z "$PS1" ]; then
   return
fi

PS1='\u@\h:\w\$ '

parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
display_git_branch() {
	GB=$(parse_git_branch); test -z "$GB" || echo "[$GB] "
}
export PS1="\[\e[0;33;49m\]\$(display_git_branch)\[\e[0;31m\]\[\e[0;0m\]$PS1"


export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin:/Users/jakoblind/Documents/dev/scripts:/Users/jakoblind/play-2.0.4/

function gite() { (git "$@" && echo $'\e[32m' "Success") || echo $'\e[31m' "Error"; }
alias git=gite

alias e='open -a Emacs'

export -f gite