![Icon](https://github.com/teressaeid/ThunderSnap/blob/master/Icon/Icon.png) 
# ThunderSnap

## Installation

This project uses [CocoaPods][1] to manage 3rd party libraries

```
$ pod install
```
```
$ open ThunderSnap.xcworkspace
```
## Design Choices
This project does NOT use storyboard and uses [SnapKit] [3] to programmatically create elements.

The chat room is represent using a [JSQMessageViewController] [4].

[ALACameraViewController] [5] is used for prompting the user to chose a profile picture.

## Extensions
I created a ```UIColor``` extension to allow me to used hex values.

I also created a ```UIIMageView``` extensions to support caching.

Also note that I could've create an ```NSDate``` extension to convery the [Firebase] [2] server timestamp to an ```NSDate``` object but I chose to do it in the ```ChatViewController```

## Sample Use
Users can signup or login at launch. Switch to "choose users" tab to select another registered user.

## Design
For this app, I used [Firebase] [2] as a backend service. The profile images and photo/video media messages are stored in [Firebase] [2] storage.
Upon loading a chat the images and media are downloaded *asynchronoulsy* to prevent the app from blocking, The messages are then reordered using a ```in-place``` sort on their ```date``` property.

##Work in progress
- [x] Allow users to send and recieves media (videos/images)
- [x] Asynchronously load images and videos and sort them in place.
- [ ] Push notifications
- [ ] Reorder code strucutre

[1]: http://www.cocoapods.org
[2]: https://firebase.google.com/
[3]: https://github.com/SnapKit/SnapKit
[4]: https://github.com/jessesquires/JSQMessagesViewController
[5]: https://github.com/AlexLittlejohn/ALCameraViewController
[6]: https://github.com/SwiftKickMobile/SwiftMessages

