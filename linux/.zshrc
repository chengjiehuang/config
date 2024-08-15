# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="bira"
#ZSH_THEME="avit"
#ZSH_THEME="af-magic"
#ZSH_THEME="amuse"
#ZSH_THEME="afowler"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# zplug init
export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias python_update="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | cut -d ' ' -f 1 | xargs -n1 pip3 install -U"
alias python_update1="pip list | sed -e '1,2d'| cut -d ' ' -f 1 | xargs -n1 pip3 install -U"

alias s='less -i'
alias vim='/usr/bin/nvim'
alias vi='/usr/bin/nvim'
alias v='/usr/bin/nvim'

# shadows
alias alice='cd ~/shadows/alice'
alias billy='cd ~/shadows/billy'
alias cathy='cd ~/shadows/cathy'
alias diana='cd ~/shadows/diana'

# extracts a given file out of the head commit (file is still staged, changes will not be lost)
function extract() {
  H=`git rev-parse HEAD`
  git checkout HEAD^ "$@"
  git commit -a --amend
  git checkout $H $@
}
# shows git branch name in your terminal prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# shows name of current commit and conflicting files during rebase
function rebs() {
  git show $(more $(git rev-parse --git-path REBASE_HEAD)) --name-only
}

# shows the current branch and status (e.g. rebase, bisect etc) in the command line header
#export PS1="\[\e[92m\e[1m\]\u@\h \[\e[94m\]\w \[\e[32m\]\$(parse_git_branch)\[\e[00m\]$ "

alias s3='aws s3'
alias ec2='aws ec2'
alias show_instances="ec2 describe-instances --query 'Reservations[*].Instances[*].{Instance:InstanceId,InstanceType:InstanceType,Job:Tags[?Key==\`Job\`]|[0].Value,LaunchTime:LaunchTime,PublicIP:PublicIpAddress,State:State.Name}' --output table"
alias show_s3_jobs="aws s3control list-jobs --account-id 326412704776 --output table --query 'Jobs[*].{JobId:JobId,OP:Operation,CreationTime:CreationTime,Status:Status,Succeeded:ProgressSummary.NumberOfTasksSucceeded,Failed:ProgressSummary.NumberOfTasksFailed,Total:ProgressSummary.TotalNumberOfTasks}'  --job-statuses 'Ready' 'Active'"
alias cancel_all_s3_jobs="aws s3control list-jobs --account-id=326412704776 --job-statuses 'Ready' 'Active' | jq '.Jobs[] | .JobId' | xargs -I{} aws s3control update-job-status --account-id=326412704776 --requested-job-status 'Cancelled' --job-id {}"

# >>> lazygit 
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
# <<< lazygit 

#export TF_XLA_FLAGS="--tf_xla_cpu_global_jit"

function compressvid() {
   time ffmpeg -i "$1" -vcodec h264 -acodec aac -crf 35 "$2"
}

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
set rtp+=/home/chengjie/.fzf/bin/fzf


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/chengjie/.local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/chengjie/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/chengjie/.local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/chengjie/.local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
