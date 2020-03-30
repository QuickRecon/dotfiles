#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# pretty ls colors
alias ls='ls --color=auto'

# bash prompt setup
set_prompt () {
    	Last_Command=$? # Must come first!
    	Blue='\[\e[01;34m\]'
    	White='\[\e[01;37m\]'
    	Red='\[\e[01;31m\]'
    	Green='\[\e[01;32m\]'
    	Reset='\[\e[00m\]'
    	FancyX='\342\234\227'
    	Checkmark='\342\234\223'

    	# Add a bright white exit status for the last command
    	PS1="\[\033[s\]\[\033[1;\$((COLUMNS-10))f\]\$(date +%F)\[\033[u\]"
    	
	# If it was successful, print a green check mark. Otherwise, print a red X.
    	if [[ $Last_Command == 0 ]]; then
    	    	PS1+="$Green$Checkmark "
		paplay /usr/share/sounds/freedesktop/stereo/complete.oga 
    	else
    		PS1+="$Red$FancyX "
		paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
    	fi

	# Put date and time at start of prompt.
	PS1+="$White\\D{%r} "

    	# If root, just print the host in red. Otherwise, print the current user and host in green.
    	if [[ $EUID == 0 ]]; then
    	    	PS1+="$Red\\h "
        elif [ -n "$SSH_CLIENT" ]; then
                PS1+="$Red\\u@\\h "
    	else
    	    	PS1+="$Green\\u@\\h "
    	fi

    	# Print the working directory and prompt marker in blue, and reset the text color to the default.
    	PS1+="$Blue\\w \\\$$Reset "
}
PROMPT_COMMAND='set_prompt'

# path for sdk tools
export PATH=${PATH}:~/Data/android-sdk/tools

# run screenfetch on startup
if [ -f /usr/bin/screenfetch ]; then screenfetch -D 'ARCH'; fi
