# Minimal Theme        
PROMPT='$(git_prompt_info)$fg_bold[white]%}%n:%{$fg_bold[cyan]%}%c '
PROMPT+="%(?:%{$fg_bold[green]%}λ %{$reset_color%}:%{$fg_bold[red]%}λ %{$reset_color%})"

ZSH_THEME_GIT_PROMPT_PREFIX="\uE0A0%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
