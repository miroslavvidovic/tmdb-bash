#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	tmdb.sh
# 	06.10.2016.-13:29:29
# -----------------------------------------------------------------------------
# Description:
#
# Usage:
#
# -----------------------------------------------------------------------------
# Script:

APIKEY=$(cat apikey.txt)

get_movie_info(){
  curl --request GET \
    --url "https://api.themoviedb.org/3/search/movie?year=$2&query=$1&language=en-US&api_key=$APIKEY" \
    --header 'content-type: application/json' \
    --data '{}'
}

show_poster(){
 eog http://image.tmdb.org/t/p/w1000/$1
}

help(){
  echo "Usage :  $0 [options] [--]

    Options:
    -t|title
    -y|year
    -i|image
    -h|help       Display this message
    "
}

main(){
  image=false

  while getopts "t:y:ih" flag; do
    case "${flag}" in
      t|title)
        title="${OPTARG}"
          ;;
      y|year)
        year=${OPTARG}
          ;;
      i|image)
        image=true
          ;;
      h|help) help
        help
          ;;
      *)
        echo -e "\n Option does not exist : $OPTARG\n"
        help
        exit 1
          ;;
    esac
  done

  formated_title=$(echo $title | sed 's/ /%20/g')
  echo $formated_title

  data=$(get_movie_info $formated_title $year)
  echo $data | jq

  if $image; then
    image_url=$(echo $data | jq '.results[0] .poster_path')
    filtered_url=$(echo $image_url | tr -d "\"")
    echo $filtered_url
    show_poster $filtered_url
  fi
}

main "$@"

exit 0
