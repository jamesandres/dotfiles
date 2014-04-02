# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jamesandres"
setopt PROMPT_SUBST
setopt promptsubst

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git happymarkers golang)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH="/sbin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/Users/james/.rvm/bin:$PATH"
export PATH="/Users/james/bin:$PATH"
# # export PATH="/Applications/MAMP/Library/bin:$PATH"
# # export PATH="/Applications/MAMP/bin/php5.3/bin:$PATH"
# export PATH="/Applications/MNPP/init:$PATH"
# export PATH="/Applications/MNPP/Library/php53/bin:$PATH"
# export PATH="/Applications/MNPP/Library/mysql/bin:$PATH"
# export PATH="/usr/local/cuda/bin:$PATH"

# Python shell tab complete
export PYTHONSTARTUP=~/.pythonrc

# # For MNPP support
# export DYLD_LIBRARY_PATH=/Applications/MNPP/init:/Applications/MNPP/Library/lib:$DYLD_LIBRARY_PATH
# alias mysql='/Applications/MNPP/Library/mysql/bin/mysql --socket=/Applications/MNPP/tmp/mysql/mysql.sock'

# # Fix annoying 10.8 bug, see: http://stackoverflow.com/questions/12064725/dyld-dyld-environment-variables-being-ignored-because-main-executable-usr-bi
# sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }

# Yep, I mean '~/bin/memp'
alias memp='nocorrect memp'

# Google translate from CLI
translate() { wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'; }

# Holy fuck fix my slow ZSH!
function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}${ZSH_THEME_GIT_PROMPT_CLEAN}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}
__git_files () {
    _wanted files expl 'local files' _files
}


# ....... aliases
dotscmd=''
dotscd=''
for numdots in {1..20}; do
  dotscmd=$dotscmd'.'
  [[ "$(( $numdots % 2 ))" = "0" ]] && dotscd="../"$dotscd
  alias $dotscmd="cd $dotscd"
done

# Less with colour
alias less='less -R'
# Open in Sublime Text
alias st='open -a "Sublime Text"'
alias st2='open -a "Sublime Text"'
# Fat fingers
alias gitst='git st'
# Diff with colour
alias diff='colordiff -u'
# Rrrg, wget STFU!
alias wget='wget --no-check-certificate'
# Trash it, FUCK this thing sucks.
# alias rm='/Users/james/bin/trash'

# Rrrg Drush frustration
alias drush='drush -u 1'

# Rrrg find frustration!
alias find='find -E'

# Mou.
alias mou='open -a Mou'

# An elephant never forgets
HISTSIZE=10000

# Multiple move
autoload -U zmv
alias mmv='noglob zmv -W'

# Virtualenwrapper
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=~/.virtualenvs

# Go
export GOPATH=$HOME/.go
