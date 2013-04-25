# System-wide .bashrc file for interactive bash(1) shells.
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

# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi
								   
. /opt/local/etc/bash_completion/git-completion.bash 

export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin:/Users/jakoblind/Documents/dev/scripts:/Users/jakoblind/play-2.0.4/ 

function gite() { (git "$@" && echo $'\e[32m' "Success") || echo $'\e[31m' "Error"; }
alias git=gite

export -f gite