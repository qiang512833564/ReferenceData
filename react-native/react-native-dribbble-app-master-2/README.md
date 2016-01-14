[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=55ef475161152d01001dac10&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/55ef475161152d01001dac10/build/latest)

###Dribbble app built with React Native

A [Dribbble](http://dribbble.com) app build with [React Native](https://github.com/facebook/react-native).

![dribbble_app_screenshot](https://cloud.githubusercontent.com/assets/2805320/8113463/db61b072-1076-11e5-8aa2-52417f019ea0.jpg)

####Preview
![dribbble_app_flow](https://cloud.githubusercontent.com/assets/2805320/8127634/25311eb0-1101-11e5-83aa-06dcc2d69da3.gif)


__Updated version__

![dribbble-app-update](https://cloud.githubusercontent.com/assets/2805320/9274780/1ca63a6a-42a1-11e5-8570-2c2781ec721f.gif)



Plugins used:
- [HTML parser](https://github.com/jsdf/react-native-htmlview)
- [React native Parallax view](https://github.com/lelandrichardson/react-native-parallax-view)
- [React native vector icons](https://github.com/oblador/react-native-vector-icons)

####How to run it locally

- Clone this repo `git clone git@github.com:catalinmiron/react-native-dribbble-app.git`
- `cd react-native-dribbble-app`
- run `npm install`
- Open `DribbbleApp.xcodeproj` in `XCode`
- Press `cmd+r` to build it


####Improvements
- [x] add icons in TabBar
- [ ] refactor 'facebook-movies' fetching logic
- [x] add author view
- [x] fetch comments in shot details
- [ ] switch to `ES6`