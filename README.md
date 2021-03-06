# tmdb-bash

> Shell script for The Movie DB API

# Movie DB CLI

Obtain some basic information about a movie in json format

## Requirements

- cURL
- xdg-open (View the Movie Poster)

```
sudo apt-get install xdg-utils
```

- jq 

```
sudo apt install jq
```

## Setup
- Go to The Movie DB website and create an account
- Obtain an API key by following the [instructions](https://www.themoviedb.org/faq/api)
- Copy your API key to the correct place in the tmdb.sh script 
```shell
    APIKEY="your api key"
```
- Run the script


## How to use it

```
Usage :  tmdb.sh [options] title

    title        Title of the movie

    Options:
    -y     Optional year for better search results
    -i     Display the movie poster
    -h     Display this help message
```

## Examples

- Normal Search using title

```shell
tmdb.sh "The Mummy"
```

- Search with year

```shell
tmdb.sh -y 2017 "The Mummy"    
```

```json
    {
        "page": 1,
        "total_results": 1,
        "total_pages": 1,
        "results": [
        {
            "vote_count": 1169,
            "id": 282035,
            "video": false,
            "vote_average": 5.3,
            "title": "The Mummy",
            "popularity": 33.808368,
            "poster_path": "/zxkY8byBnCsXodEYpK8tmwEGXBI.jpg",
            "original_language": "en",
            "original_title": "The Mummy",
            "genre_ids": [
                28,
                12,
                14,
                27,
                53
            ],
            "backdrop_path": "/qedJJ2z9oBYKxxO4Pp8qAkfgPst.jpg",
            "adult": false,
            "overview": "Though safely entombed in a crypt deep beneath the unforgiving desert, an ancient queen whose destiny was unjustly taken from he is awakened in our current day, bringing with her malevolence grown over millennia, and terrors that defy human comprehension.",
            "release_date": "2017-06-06"
        }
        ]
    }
```

- Open Movie Poster on Browser

```shell
tmdb.sh -i "The Mummy"
```

## The Movie DB CLI for Android Using Termux

- Download Termux Android Emulator from Google Playstore
- put `tmdb.sh` file in any location on your Android device (Don't forget to add your themoviedb API in the Bash File)
- open the file location via Termux (Give Storage Permission for Termux - https://termux.com/storage.html)
- it requires cURL & jq pack 

```
pkg install curl
````

```
pkg install jq
```

## License

MIT License

Copyright (c) 2016 Miroslav Vidović

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
