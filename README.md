# reelrover-ios

This was an app I made for an interview in less than a day. It roughly follows an MVVM architecture, was built with SwiftUI, and has a min version of iOS 17. I tried to dive into some new technologies such as SwiftData, and the @Observable macro, but I ended up reverting to using ObservableObject to reflect the type of work that I have been doing. 

Given more time, there's several changes I would make. I have noted these proposed changes in the code. Primarily, I would've liked to create a repository layer to manage polling, and data distribution to different view models.

## Setup Instructions

### 1. Download the Latest Xcode from the App Store
#### Please Note: The minimum version must be Xcode 15 with support for iOS 17
Use this link: https://apps.apple.com/us/app/xcode/id497799835?mt=12

### 2. Open Xcode, and Click `Clone Git Repository...`
#### Copy this repo's URL into the box and click clone
URL: https://github.com/galenqq/reelrover-ios.git

### 3. Choose a build destination, and run!
##### Please Note: I've primarily tested this on the `iPhone 15` simulator, as well as my personal `iPhone 14 Pro`.

