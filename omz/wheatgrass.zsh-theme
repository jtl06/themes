# Wheatgrass-inspired Oh My Zsh theme.
# Copy to ~/.oh-my-zsh/custom/themes and set ZSH_THEME="wheatgrass".

setopt prompt_subst

_wheatgrass_color_wheat="%F{#f5deb3}"
_wheatgrass_color_green="%F{#00cd66}"
_wheatgrass_color_yellow="%F{#bdb76b}"
_wheatgrass_color_cyan="%F{#40e0d0}"
_wheatgrass_color_red="%F{#ff8c69}"
_wheatgrass_color_muted="%F{#676b5d}"
_wheatgrass_reset="%f"
_wheatgrass_user="${WHEATGRASS_USER:-$USER}"
_wheatgrass_host="${WHEATGRASS_HOST:-${${HOST%%.*}:l}}"
_wheatgrass_cmd_start=0
_wheatgrass_cmd_duration=""
_wheatgrass_duration_threshold="${WHEATGRASS_DURATION_THRESHOLD:-3}"
_wheatgrass_last_status=0

ZSH_THEME_GIT_PROMPT_PREFIX=" %{${_wheatgrass_color_muted}%}(%{${_wheatgrass_color_cyan}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${_wheatgrass_color_muted}%})%{${_wheatgrass_reset}%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{${_wheatgrass_color_yellow}%}*%{${_wheatgrass_reset}%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{${_wheatgrass_color_green}%}+%{${_wheatgrass_reset}%}"
ZSH_THEME_GIT_PROMPT_ADDED=" %{${_wheatgrass_color_green}%}+%{${_wheatgrass_reset}%}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{${_wheatgrass_color_yellow}%}!%{${_wheatgrass_reset}%}"
ZSH_THEME_GIT_PROMPT_DELETED=" %{${_wheatgrass_color_red}%}-%{${_wheatgrass_reset}%}"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{${_wheatgrass_color_cyan}%}>%{${_wheatgrass_reset}%}"
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{${_wheatgrass_color_red}%}x%{${_wheatgrass_reset}%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{${_wheatgrass_color_yellow}%}?%{${_wheatgrass_reset}%}"

_wheatgrass_preexec() {
  _wheatgrass_cmd_start=$EPOCHSECONDS
}

_wheatgrass_precmd() {
  local code=$?
  _wheatgrass_last_status=$code
  if [[ $_wheatgrass_cmd_start -gt 0 ]]; then
    local elapsed=$(( EPOCHSECONDS - _wheatgrass_cmd_start ))
    if [[ $elapsed -ge $_wheatgrass_duration_threshold ]]; then
      _wheatgrass_cmd_duration="${elapsed}s"
    else
      _wheatgrass_cmd_duration=""
    fi
  fi
  _wheatgrass_cmd_start=0
  return $code
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _wheatgrass_preexec
add-zsh-hook precmd _wheatgrass_precmd

_wheatgrass_ssh() {
  [[ -n "$SSH_CONNECTION$SSH_CLIENT$SSH_TTY" ]] && print -n "%{${_wheatgrass_color_yellow}%}ssh %{${_wheatgrass_reset}%}"
}

_wheatgrass_venv() {
  local env_name=""
  if [[ -n "$VIRTUAL_ENV" ]]; then
    env_name="${VIRTUAL_ENV:t}"
  elif [[ -n "$CONDA_DEFAULT_ENV" && -n "$WHEATGRASS_SHOW_CONDA" ]]; then
    env_name="$CONDA_DEFAULT_ENV"
  fi

  [[ -n "$env_name" ]] && print -n " %{${_wheatgrass_color_muted}%}[%{${_wheatgrass_color_yellow}%}${env_name}%{${_wheatgrass_color_muted}%}]%{${_wheatgrass_reset}%}"
}

_wheatgrass_duration() {
  [[ -n "$_wheatgrass_cmd_duration" ]] && print -n " %{${_wheatgrass_color_muted}%}${_wheatgrass_cmd_duration}%{${_wheatgrass_reset}%}"
}

_wheatgrass_git() {
  command git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch upstream counts ahead behind staged modified deleted untracked stashed
  branch=$(command git symbolic-ref --short HEAD 2>/dev/null)
  [[ -z "$branch" ]] && branch=$(command git rev-parse --short HEAD 2>/dev/null)

  upstream=$(command git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
  if [[ -n "$upstream" ]]; then
    counts=(${(z)$(command git rev-list --left-right --count HEAD..."$upstream" 2>/dev/null)})
    ahead=${counts[1]:-0}
    behind=${counts[2]:-0}
  else
    ahead=0
    behind=0
  fi

  command git diff --cached --quiet --ignore-submodules -- 2>/dev/null; staged=$?
  command git diff --quiet --ignore-submodules -- 2>/dev/null; modified=$?
  if [[ -n "$(command git ls-files --deleted 2>/dev/null)" ]]; then
    deleted=0
  else
    deleted=1
  fi

  if [[ -n "$(command git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
    untracked=0
  else
    untracked=1
  fi
  command git rev-parse --verify refs/stash &>/dev/null; stashed=$?

  print -n " %{${_wheatgrass_color_muted}%}(%{${_wheatgrass_color_cyan}%}${branch}"
  [[ $ahead -gt 0 ]] && print -n "%{${_wheatgrass_color_green}%}+${ahead}"
  [[ $behind -gt 0 ]] && print -n "%{${_wheatgrass_color_red}%}-${behind}"
  [[ $staged -ne 0 ]] && print -n " %{${_wheatgrass_color_green}%}+"
  [[ $modified -ne 0 ]] && print -n " %{${_wheatgrass_color_yellow}%}!"
  [[ $deleted -eq 0 ]] && print -n " %{${_wheatgrass_color_red}%}-"
  [[ $untracked -eq 0 ]] && print -n " %{${_wheatgrass_color_yellow}%}?"
  [[ $stashed -eq 0 ]] && print -n " %{${_wheatgrass_color_cyan}%}$"
  print -n "%{${_wheatgrass_color_muted}%})%{${_wheatgrass_reset}%}"
}

_wheatgrass_status() {
  local code=$_wheatgrass_last_status
  if [[ $EUID -eq 0 ]]; then
    print -n "%{${_wheatgrass_color_red}%}#%{${_wheatgrass_reset}%}"
  elif [[ $code -eq 0 ]]; then
    print -n "%{${_wheatgrass_color_green}%}>%{${_wheatgrass_reset}%}"
  else
    print -n "%{${_wheatgrass_color_red}%}${code}>%{${_wheatgrass_reset}%}"
  fi
}

PROMPT='$(_wheatgrass_ssh)%{${_wheatgrass_color_cyan}%}${_wheatgrass_user}@${_wheatgrass_host}%{${_wheatgrass_reset}%} %{${_wheatgrass_color_wheat}%}%~/%{${_wheatgrass_reset}%}$(_wheatgrass_git)$(_wheatgrass_venv)$(_wheatgrass_duration)
$(_wheatgrass_status) '
RPROMPT=''
