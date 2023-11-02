{ pkgs, ... }:

{
  programs.tmux.enable = true;
  programs.tmux.enableFzf = true;
  programs.tmux.enableMouse = true;
  programs.tmux.enableSensible = true;
  programs.tmux.enableVim = true;

  programs.tmux.defaultCommand = "zsh";

  programs.tmux.extraConfig = ''
    set -g default-terminal "screen-256color"
    set-option -sa terminal-overrides ',xterm-256color:RGB'
    set -g focus-events

    set-option -sg escape-time 10
    set -g history-limit 100000

    set -g prefix C-Space
    unbind-key C-b

    # auto rename windows based on current dir
    set-option -g status-interval 2
    set-option -g automatic-rename on
    set-option -g automatic-rename-format '#{b:pane_current_path} (#{pane_current_command})'

    # Setup 'v' to begin selection as in Vim
    bind-key -Tcopy-mode-vi 'v' send -X begin-selection
    bind-key -Tcopy-mode-vi 'y' send -X copy-pipe-and-cancel "pbcopy"
    bind-key -Tcopy-mode-vi 'Enter' send -X copy-pipe-and-cancel "pbcopy"
    bind-key -Tcopy-mode-vi Escape send -X cancel
    bind-key -Tcopy-mode-vi V send -X rectangle-toggle
    bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

    # smart pane switching with awareness of vim splits
    bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
    bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
    bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
    bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"

    bind -n C-S-H resize-pane -L 10
    bind -n C-S-J resize-pane -D 10
    bind -n C-S-K resize-pane -U 10
    bind -n C-S-L resize-pane -R 10

    bind-key c  new-window -c "#{pane_current_path}"
    bind-key % split-window -h -c "#{pane_current_path}"
    bind-key '"' split-window -c "#{pane_current_path}"

    bind-key o resize-pane -Z
    unbind s
    bind-key n split-window "nvim -c 'normal Go' -c 'r!date' -c 'normal o' -c 'normal o' -c 'startinsert' ~/notes.txt"
    bind-key s split-window "~/smart-switch.rb"
    bind-key v split-window -hc "#{pane_current_path}" nvim
    bind-key t split-window -l 10 "nvim ~/TODO"

    set -g @catppuccin_flavour 'latte'
    set -g @catppuccin_flavour 'frappe'
    set -g @catppuccin_flavour 'machiatto'

    run-shell ${pkgs.tmuxPlugins.catppuccin.rtp}

    # Theme
    # source-file ~/.tmux.theme
  '';
}
