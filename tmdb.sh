#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      tmdb.sh
#   created:   06.10.2016.-13:29:29
#   revision:  26.01.2018.
#   version:   1.2
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
    -y|year      Optional year for better search results
    -i|image     Display the movie poster as an image
    -h|help      Display this help message
    "
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
  image=false

  while getopts "y:ih" flag; do
    case "${flag}" in
      y|year)
        year=${OPTARG}
          ;;
      i|image)
        image=true
          ;;
      h|help)
        help
        exit 0
          ;;
      *)
        echo -e "\n Option does not exist : $OPTARG\n"
        help
        exit 1
          ;;
    esac
  done
  shift $((OPTIND-1))

  title="$1"

  # If no movie title is supplied display help and exit
  if [[ ! $title ]]; then
    echo -e "Error: A movie title is required\n"
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
