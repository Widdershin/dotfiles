peek () {
	tmux split-window "cd $* && nvim ."
}
tcpf () {
	lsof -i TCP:$1
}
killtcp () {
	local pid=$(tcpf $2 | tail -n 1 | tr -s ' ' | cut -d' ' -f2)
	kill $1 $pid
}
reexec-tmux () {
	unset __NIX_DARWIN_SET_ENVIRONMENT_DONE
	unset __ETC_ZPROFILE_SOURCED __ETC_ZSHENV_SOURCED __ETC_ZSHRC_SOURCED
	exec tmux new-session -A -s _ "$@"
}
tcpkill () {
	tcpf $1 | tail -n 1 | cut -d' ' -f5 | xargs kill
}
'using!' () {
	NIX_PACKAGES="$NIX_PACKAGES $2" nix-shell -I nixpkgs=$1 -p $2 --run zsh
}
sp () {
	RSPEC_RERUN=t bundle exec rspec $*
}
nix-search () {
	nix search --extra-experimental-features nix-command nixpkgs $*
}
ns () {
	nix-search $*
}
