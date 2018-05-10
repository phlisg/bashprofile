source ~/Code/Bash/oh-my-git/prompt.sh

alias ..="cd .."

alias Code="cd ~/Code"
#alias Docker="cd ~/Code/Docker"
unset dockr
alias laradk="cd ~/Code/Docker/laradock"
alias dc="sudo docker-compose"

function Bash() {
	source ~/.bashrc;
	echo "Bash refreshed!";
}

function Bashrc() {
	nano ~/Code/Bash/.bash_profile;
	Bash;
}
unset Docker
function Dk() {
	cd ~/Code/Docker;
	cd "$1";
	l;
}

function ComposerInstall() {
	laradk;
	dc exec workspace bash -c "cd projects/symfony/$1/; composer install";
	cd -;
}

function NpmInstall() {
	laradk;
	dc exec workspace bash -c "cd projects/symfony/$1/; npm i";
	cd -;
}

function Setup() {
	ComposerInstall $1;
	NpmInstall $1;
}

function SysInit() {
	echo "Enabling dnsmasq..."
	sudo dnsmasq;
	echo "Dnsmasq done.";
	echo "Opening resolv.conf for special editing...";
	sudo nano /etc/resolv.conf;
	echo "Restarting NetworkManager...";
	sudo service NetworkManager restart;
	echo "All done! Happy coding";
}

function ShutUp() {
	echo "Oh sorry :-8 thought you didn't hear me...";
	sudo service systemd-resolved restart;
	echo "systemd-resolved shut up.";
}

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
export PATH=/home/phlisg/.npm-global/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
