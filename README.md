# Project 1 - Flicks

Flicks is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 4 hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [X] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [X] User can search for a movie.
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

<img src='http://i.imgur.com/wcPYeSP.gif' title='Flicks Video Walkthrough' width='' alt='Video Walkthrough' />


GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

- I had difficulty implementing the search bar. I've always had trouble using a search bar when implementing it was API's since it requires grabbing the data and then storing it in the tableview.

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



# Project 2 - Flicks

Flicks is a movies app displaying box office and top rental DVDs using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 5 hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can view movie details by tapping on a cell.
- [X] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [X] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [X] Customize the navigation bar.

The following **additional** features are implemented:

- [X] Modified the table view so that it doesn't show the overview for a cleaner look since the overview can be seen in the detail.
- [X] Added a popular tab alongside the top rated and now playing tabs.
- [X] Added an icon for the list view(table view) and collection view

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. There should be a tutorial or mention about how the tab bar image icons will need to be resized to fit properly.
2. How to show detail controller from the collection view

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/MdGTACa.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Only challenge I faced for part 2 was looking for a way to set the back bar image to the image I wanted and the correct size.

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