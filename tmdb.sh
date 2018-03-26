#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      tmdb.sh
#   created:   06.10.2016.-13:29:29
#   revision:  26.03.2018.
#   version:   1.4
# -----------------------------------------------------------------------------
# Requirements:
#   curl, xdg-open, jq
# Description:
#   Get some basic movie information from the moviedb website api.
# Usage:
#   Detailed usage description in the help function.
# -----------------------------------------------------------------------------
# Script:

# Get the api key and insert it here
APIKEY="your api key"

SCRIPTNAME=$(basename "$0")

help(){
  echo "Usage :  $SCRIPTNAME [options] title 

    title        Title of the movie

    Options:
    -y    Optional year for better search results
    -i    Display the movie poster as an image
    -h    Display this help message
    "
}

check_requirements(){
  local requirements=("$@")
  for app in "${requirements[@]}"; do
    type "$app" >/dev/null 2>&1 || \
      { echo >&2 "$app is required but it's not installed. Aborting."; exit 1; }
  done
}

# Curl request on the tmdb api
get_movie_info(){
  curl -s --request GET \
    --url "https://api.themoviedb.org/3/search/movie?year=$2&query=$1&language=en-US&api_key=$APIKEY" \
    --header 'content-type: application/json' \
    --data '{}'
}

show_poster(){
 xdg-open https://image.tmdb.org/t/p/w500"$1"
}

main(){
  # Check for required packages
  check_requirements jq xdg-open

  image=false

  while getopts ":yih" flag; do
    case "${flag}" in
      y)
        year=${OPTARG}
          ;;
      i)
        image=true
          ;;
      h)
        help
        exit 0
          ;;
      *)
        echo -e "\\n \\033[1;31m Option does not exist : $OPTARG \\033[0m \\n"
        help
        exit 1
          ;;
    esac
  done
  shift $((OPTIND-1))

  title="$1"

  # If no movie title is supplied display help and exit
  if [[ ! $title ]]; then
    echo -e "\\n"
    echo -e "\\033[1;31m Error: A movie title is required \\033[0m \\n"
    help
    exit 1
  fi

  # Change all spaces in the title to "%20" for the URL
  formated_title=${title// /%20}

  data=$(get_movie_info "$formated_title" "$year")
  echo "$data" | jq '.'

  # If the image option is requested
  if "$image"; then
    image_url=$(echo "$data" | jq '.results[0] .poster_path')
    filtered_url=$(echo "$image_url" | tr -d "\"")
    echo "$filtered_url"
    show_poster "$filtered_url"
  fi
}

main "$@"

exit 0
