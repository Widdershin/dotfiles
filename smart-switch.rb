#!/usr/bin/env ruby

require 'set'

PROJECTS_DIR = '/Users/nickj/Projects/'

# catppuccino fzf theme
ENV["FZF_DEFAULT_OPTS"] = <<~FZF_OPTS
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
FZF_OPTS

def tmux_is_running?
  ENV.include? 'TMUX'
end

def project_directories
  # http://stackoverflow.com/a/1899164/1404996
  Dir
    .entries(PROJECTS_DIR)
    .select {|entry| File.directory?(File.join(PROJECTS_DIR, entry)) && !(entry =='.' || entry == '..') }
end

def project_already_running?(project)
  `tmux has-session -t #{project}`

  $?.success?
end

def start_session(project)
  project_path = File.join(PROJECTS_DIR, project)

  if project === "dotfiles"
    project_path = "/Users/nickj/dotfiles"
  end

  if tmux_is_running?
    `tmux switch-client -t "$(TMUX= tmux -S "${TMUX%,*,*}" new-session -dP -s "#{project}" -c #{project_path})"`
  else
    `tmux new-session -s "#{project}" -c #{project_path}`
  end
end

def switch_to(project)
  `tmux switch -t #{project}`
end

tmux_sessions = `tmux list-sessions | cut -d: -f1`.split("\n")

options = Set.new(tmux_sessions + project_directories + ["dotfiles"])

project = `echo "#{options.to_a.join("\n")}" | fzf --preview 'tmux list-windows -t {} && tmux capture-pane -ep -t {} || ls -la ~/Projects/{}' --preview-window=70%`.chomp

exit unless $? == 0

if project_already_running?(project)
  switch_to(project)
else
  start_session(project)
end
