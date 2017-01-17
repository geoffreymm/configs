PROMPT='%{$fg_bold[red]%}● %{$reset_color%}%{$fg_no_bold[white]%}%*%{$reset_color%} %{$fg_bold[red]%}●%{$reset_color%} %{$fg_no_bold[cyan]%}%c%{$reset_color%} %{$fg_bold[red]%}➜%{$reset_color%} '

RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}(branch:%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✱%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✔%{$reset_color%} "
