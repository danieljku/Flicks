# Project 1 - Flicker

Flicker is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 4 hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [X] User sees an error message when there's a networking error.
- [ ] Movies are displayed using a CollectionView instead of a TableView.
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [X] Customize the UI.

The following **additional** features are implemented:

- [X] Each cell shows the rating, popularity as well as the release date.
- [X] Remember the sort order the user wanted after app restarts.
- [X] There is a settings page:
	- You can change the ordering of the movies by popularity, now playing or top rated.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I wanted to discuss the use of auto layout. I noticed auto layout wasn't enforced during this app and was wondering if that was on purpose or if it will be taught in later stages.
2. Search bar functionality and how to implement it in different situations. Such as grabbing the information from the table view to re sort it upon searching.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/pEknqOU.gifv' title='Walkthrough of Flicker' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2017] [Daniel Ku]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.