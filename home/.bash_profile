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

    if [[ -f "$(command -v xcode-select)" ]]; then
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
}

__set_prompt () {

    # Only display username if it's not what I assume
    if [[ "$USER" == 'daxelrod' ]]; then
        local username=''
    else
        local username='\u@'
    fi

    # Set variables for before and after the git prompt separately.
    # This lets us use __git_ps1 as the PROMPT_COMMAND (the only supported way to get color)
    # and also lets us fall back to just the prompt if __git_ps1 isn't available.
    local before_git="${username}\h:\w" # user @ host : full_directory
    local after_git=' \$ '

    __source_git_extras
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
