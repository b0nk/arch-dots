### Set/unset ZSH options
#########################
# setopt NOHUP
# setopt NOTIFY
# setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME
unsetopt BG_NICE
setopt CORRECT
setopt EXTENDED_HISTORY
# setopt HASH_CMDS
setopt MENUCOMPLETE
setopt ALL_EXPORT

### Set/unset  shell options
############################
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

### Autoload zsh modules when they are referenced
#################################################
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

### Set variables
#################
PATH="/usr/local/bin:/usr/local/sbin/:$PATH"
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
EDITOR=nano

DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
XDG_RUNTIME_DIR=/run/user/1000

### Load colors
###############
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
done

### Source plugins
##################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/git/completion/git-prompt.sh

### Set prompt
##############
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="[%(!.${PR_RED}%n.$PR_LIGHT_YELLOW%n)%(!.${PR_LIGHT_YELLOW}@.$PR_RED@)$PR_NO_COLOR%(!.${PR_LIGHT_RED}%U%m%u.${PR_LIGHT_GREEN}%U%m%u)$PR_NO_COLOR:%(!.${PR_RED}%2c.${PR_BLUE}%2c)$PR_NO_COLOR]%(?..[${PR_LIGHT_RED}%?$PR_NO_COLOR])%(!.${PR_LIGHT_RED}#.${PR_LIGHT_GREEN}$) "
RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
unsetopt ALL_EXPORT

### Bind keys
#############
autoload -U compinit
compinit
bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

### Set my vars
#############
PLAYER=mpv

### Set my aliaseseses
#############
alias grep='grep --color=always'
alias ls='ls --color=auto -NGh --group-directories-first'
alias rm='rm -I'
alias mv='mv -i'
alias diff='diff --color=auto'
alias sudo='doas'
alias ll='ls -alh --group-directories-first'
alias cd..='cd ..'
alias mp4box='MP4Box'
alias ytdl='youtube-dl --prefer-ffmpeg'
alias ytpc='youtube-dl -x -f bestaudio --audio-format opus --audio-quality 64k --prefer-ffmpeg'
alias ytmp3='youtube-dl -x -f bestaudio --audio-format mp3 --audio-quality 128k --prefer-ffmpeg'
alias ytsub='youtube-dl --write-sub --sub-lang en --convert-subs srt --prefer-ffmpeg'
alias ythd='youtube-dl -f bestvideo+bestaudio --prefer-ffmpeg'
alias gldl='gallery-dl'
alias pacbloat='trizen -Rsn $(trizen -Qqdt)'
alias ffprobe='ffprobe -hide_banner'
alias ffplay='ffplay -hide_banner'
alias weather='curl "http://wttr.in/~Lisbon"'
alias hm='cd ~'
alias ta='tmux attach'
alias refreshenv='source ~/.zshrc'
alias myip='curl "https://ipinfo.io/ip"'
# alias terry='$PLAYER "http://templeos.org/hls/templeos.m3u8"' # RIP
alias trunc='truncate'
alias clrhist='truncate -s 0 ~/.zhistory'
alias rcp='rsync -ah -P --append-verify --stats'
alias md5='rhash --md5'
alias sha1='rhash --sha1'
alias sha256='rhash --sha256'
alias sha512='rhash --sha512'
alias crc='rhash --crc32'
alias newdns='curl -s "https://api.opennic.org/geoip/?jsonp&res=4&ipv=4" | grep -Po "\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\b"'
alias newdns6='curl -s "https://api.opennic.org/geoip/?jsonp&res=4&ipv=6" | grep -Po "(?:[a-f0-9]{1,4}:){6}(?::[a-f0-9]{1,4})|(?:[a-f0-9]{1,4}:){5}(?::[a-f0-9]{1,4}){1,2}|(?:[a-f0-9]{1,4}:){4}(?::[a-f0-9]{1,4}){1,3}|(?:[a-f0-9]{1,4}:){3}(?::[a-f0-9]{1,4}){1,4}|(?:[a-f0-9]{1,4}:){2}(?::[a-f0-9]{1,4}){1,5}|(?:[a-f0-9]{1,4}:)(?::[a-f0-9]{1,4}){1,6}|(?:[a-f0-9]{1,4}:){1,6}:|:(?::[a-f0-9]{1,4}){1,6}|[a-f0-9]{0,4}::|(?:[a-f0-9]{1,4}:){7}[a-f0-9]{1,4}"'
alias radioptnet='$PLAYER "https://radio.ptnet.org/shout/listen.pls"'

### Set my functions
#############
function ytpipe() { $PLAYER ytdl://"$1" }
function lstream() { streamlink -O "$1" "$2" | $PLAYER - }
function rstream() { streamlink -o $(date +%s).ts "$1" "$2" }
function dstream() { wget "$1" -O - | $PLAYER - }
function war() { streamlink -O "$1" "$2" | tee $(date +%s).ts | $PLAYER -}
function dwar() { wget "$1" -O - | tee $(date +%s).ts | $PLAYER - }
function oFile() { curl -F"file=@$1" https://0x0.st }
function oURL() { curl -F"url=$1" https://0x0.st }
function oSHRT() { curl -F"shorten=$1" https://0x0.st }
function c() { curl "http://cheat.sh/$1" }
function mkcd() { mkdir "$1" && cd "$1" }
function cuesplit() { shnsplit -f "$1" -o "flac flac -8 -e -p -V --ignore-chunk-sizes -o %f -" -t "%n-%p-%t" "$2" ; rm *pregap.flac ; cuetag.sh "$1" *.flac }

# PuTTY + pscp
function sshget() {
  printf "\033]0;__pw:"`pwd`"\007" ;
  for file in ${*} ; do printf "\033]0;__rv:"${file}"\007" ; done ;
  printf "\033]0;__ti\007" ;
}

# EAC
function eac {
  local wineprefix="$HOME/.eac-prefix"
  local eacdir="${wineprefix}/drive_c/EAC"
  pushd "${eacdir}/Microsoft.VC80.CRT"
    WINEARCH=win32 WINEPREFIX=$wineprefix WINEDEBUG=-all wine "${eacdir}/EAC.exe"
  popd
}

man() {
 env \
 LESS_TERMCAP_mb=$(printf "\e[1;31m") \
 LESS_TERMCAP_md=$(printf "\e[1;31m") \
 LESS_TERMCAP_me=$(printf "\e[0m") \
 LESS_TERMCAP_se=$(printf "\e[0m") \
 LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
 LESS_TERMCAP_ue=$(printf "\e[0m") \
 LESS_TERMCAP_us=$(printf "\e[1;32m") \
 man "$@"
}

if [ -f /usr/bin/neofetch ]; then neofetch; fi
