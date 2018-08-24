# generated by Git for Windows
test -f ~/.profile && . ~/.profile
test -f ~/.bashrc && . ~/.bashrc

alias ..="cd .."

Bashrc() {
	cd ~/Code/Bash/win;
	vim .bash_profile;
	cp ./.bash_profile ~/.bash_profile;
	Bash;
	cd -;
}

Bash() {
	source ~/.bash_profile;
	echo "Bash refreshed!";
}

l() {
	ls;
}

Dk() {
	cd ~/Code/Docker/"$@";
}

Proj() {
	Dk projects;
	cd $(find . -maxdepth 2 -type d -name "$@");
	l;
}


laradk() {
	Dk laradock;
}

dc() {
	laradk;
	winpty docker-compose "$@";
	cd -;
}

godir() {
	cd ~/go/"$@";
	l;
}