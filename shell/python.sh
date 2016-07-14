# shell/python.sh
#
# uses vars from shell/vars and functions from shell/functions
#

export DKO_SOURCE="${DKO_SOURCE} -> shell/python.sh"

# Let python guess where to `import` packages, or use pip instead
unset PYTHONPATH

# ==============================================================================
# Pylint
# ==============================================================================

export PYLINTHOME="${XDG_CONFIG_HOME}/pylint"

# ==============================================================================
# pyenv for multiple Python binaries
# ==============================================================================

export PYENV_ROOT="${HOME}/.local/pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

dko::has "pyenv" && {
  eval "$(pyenv init -)"

  # Don't try to auto-init venv
  #eval "$(pyenv virtualenv init -)"
}

# ==============================================================================
# VirtualEnv for python package isolation
# ==============================================================================

# VirtualEnvWrapper is still in play for easier mgmt of py2 virtualenvs

# Safety -- only allow pip installs in a virtualenv
#export PIP_REQUIRE_VIRTUALENV=true

# Default virtualenv
export WORKON_HOME="${HOME}/.local/virtualenv"

# Disable auto-add virtualenv name to prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Assign global var to virtualenv name
virtualenv_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
      # Strip out the path and just leave the env name
      venv="${VIRTUAL_ENV##*/}"
  else
      venv=''
  fi
  [[ -n "$venv" ]] && echo "$venv"
}

# Auto-init default virtualenv
dko_virtualenv_wrapper="$(which virtualenvwrapper_lazy.sh)"
source_if_exists "$dko_virtualenv_wrapper"
# || source_if_exists /usr/bin/virtualenvwrapper_lazy.sh \
# || source_if_exists /usr/bin/virtualenvwrapper.sh

# ==============================================================================
# pip
# ==============================================================================

dko::has "pip" && {
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(pip completion --zsh)"
  elif [ -n "$BASH" ]; then
    eval "$(pip completion --bash)"
  fi
}

# vim: ft=sh :