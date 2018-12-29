# Default programs
export EDITOR=vim

# History
shopt -s histappend # Add to history file instead of overwriting
HISTCONTROL=ignorespace # Don't save lines starting with space
HISTSIZE=65536 # Lines
HISTFILESIZE=65536 # Lines

# Update LINES and COLUMNS after a process completes
shopt -s checkwinsize

# Prompt
__source_git_extras () {
    # Find git completion and git prompt for this OS and source them if available

    if command -v 'xcode-select' >/dev/null; then
        # macOS git via Xcode Tools

        # Find path where currently active XCode command line tools are installed
        local xcode_path
        xcode_path=$(xcode-select -p)

        local git_completion_path="${xcode_path}/usr/share/git-core/git-completion.bash"
        local git_prompt_path="${xcode_path}/usr/share/git-core/git-prompt.sh"
    fi

    # shellcheck source=/dev/null
    if [[ -f "${git_completion_path}" ]]; then source "${git_completion_path}"; fi
    # shellcheck source=/dev/null
    if [[ -f "${git_prompt_path}" ]]; then source "${git_prompt_path}"; fi

    local shorten_directory_path="$HOME/bash-shorten-directory/share/shorten-directory.bash"
    if [[ -f "${shorten_directory_path}" ]]; then source "${shorten_directory_path}"; fi
}

__set_prompt () {
    __source_git_extras

    # Only display username if it's not what I assume
    if [[ "$USER" == 'daxelrod' ]]; then
        local username=''
    else
        local username='\u@'
    fi

    # Display abbreviated hostname on machine I'm physically using
    if [[ -f ~/.homebox ]]; then
        if [[ "$(uname -s)" == 'Darwin' ]]; then
            local hostname=$'\xEF\xA3\xBF'; # Apple logo, in Apple fonts only
        elif command -v lsb_release >/dev/null; then
            case "$(lsb_release --id --short)" in
            'Ubuntu')
                local hostname=$'\xEF\x88\x80' # Ubuntu logo, in Ubuntu fonts only
                ;;
            'Fedora')
                local hostname='ƒ'
                ;;
            'RedHatEnterpriseServer')
                local hostname='🎩'
                ;;
            'CentOS')
                local hostname='¢'
                ;;
            'Debian')
                local hostname='꩜'
                ;;
             *)
                local hostname='🐧' # It's some kind of Linux, or it wouldn't have lsb_release
            esac
        fi
    else
        local hostname='\h'
    fi

    if declare -f __shorten_directory >/dev/null; then
        local directory='$(__shorten_directory)' # evaluated at each prompt, not now
    else
        local directory='\w'
    fi

    # Set variables for before and after the git prompt separately.
    # This lets us use __git_ps1 as the PROMPT_COMMAND (the only supported way to get color)
    # and also lets us fall back to just the prompt if __git_ps1 isn't available.
    local before_git="${username}${hostname}:${directory}" # user @ host : directory
    local after_git=' \$ '

    # Check whether __source_git_extras succeeded in finding a git prompt function
    if declare -f __git_ps1 >/dev/null; then
        # shellcheck disable=SC2034  # Used by git-prompt.sh
        GIT_PS1_SHOWDIRTYSTATE=true # Show * and + next to the branch name for unstaged and staged changes, respectively

        # shellcheck disable=SC2034  # Used by git-prompt.sh
        GIT_PS1_SHOWCOLORHINTS=true # Only works with PROMPT_COMMAND

        PROMPT_COMMAND="__git_ps1 '${before_git}' '${after_git}'"
    else
        PS1="${before_git}${after_git}"
    fi
}

__set_prompt
