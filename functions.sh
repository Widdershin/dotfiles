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
