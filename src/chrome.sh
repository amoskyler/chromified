#!/bin/sh

__CHROME="exec /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome" #Your chrome executible

# Register specific profiles here -- (have to map from google name to user names)
# me (Default)/Personal
# ch Profile\ 1 (work)
# nojs Profile\ 2 (No logins/no javascript)


# Custimize this stuff for your own machine
resolve_user_profile_id() {
  local result=""
  case $1 in

    me)
      echo "Default"
    ;;

    ch)
      echo "Profile\ 1"
    ;;

    nojs)
      echo "Profile\ 2"
    ;;

    *)
      echo "Default"
    ;;
  esac
}

process () {
  # Bash function to launch google chrome with specific users + some additional options

  incognito=false
  user="Default"
  website_url=""
  incognito_commnand=""
  profile_id=""
  url_command=""

  __NO_ARGUMENT_COMMANDS=("-n" "--incognito" "-a" "--arbitrary") #TODO find a better way to do this
  # Assume if first element is not a no argument op then the first param is Default
  #TODO: Normalize arguments
  if [[ $# = 1 ]]
  then
    if [[ " ${__NO_ARGUMENT_COMMANDS[@]} " =~ " $1 " ]]; then
      user="Default"
    else
      user=$1
    fi
  fi

  while [[ $# > 0 ]]
  do
  key="$1"

  case $key in
    -u | user)
      user=$2
      shift
    ;;

    -w | --website)
      website_url=$2
      shift
    ;;

    -n | --incognito)
      incognito=true
    ;;

    -a | --arbitrary)
      shift # clear current args 
      eval "$__CHROME $@"
      return 0
    ;;
  esac
  shift
  done
  profile_id=$(resolve_user_profile_id "$user")
  [[ $incognito = true ]] && incognito_commnand="--incognito" || incognito_commnand=""
  [[ $website_url# > 0 ]] && url_command="$website_url" || url_command=""
  printf "%0.s-" {1..30}
  printf "\n%s" "$user"
  printf "%s" " | "
  [[ "${website_url}" == *"://"* ]] ||  result="http://" printf "%s" $result
  printf "%s" $website_url
  [[ $incognito == true ]] && printf "%s" " | incognito"
  printf '\n'
  printf "%0.s-" {1..30}
  echo "" #cause I don't know what I'm doing 

  eval "${__CHROME} --profile-directory=$profile_id $incognito_commnand $website_url </dev/null &>/dev/null &"

  return
}

# exit with status of last command.
process "$@"