#!/usr/bin/env ruby

require 'set'

PROJECTS_DIR = '/Users/nick/Projects/'

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

options = Set.new(tmux_sessions + project_directories)

project = `echo "#{options.to_a.join("\n")}" | fzf`.chomp

if project_already_running?(project)
  switch_to(project)
else
  start_session(project)
end
