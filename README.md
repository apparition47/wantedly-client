# PhotoViewer

An [Unsplash](https://unsplash.com) photo viewer written in Swift.

![Demo](https://user-images.githubusercontent.com/3298414/32414948-7c924f36-c274-11e7-9524-6237b8eccc1a.gif)


## Features

* [Clean architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html).
* Implemented Unsplash API functions: [get latest photos, search for photos by keywords](https://unsplash.com/documentation#list-photos).
* Uses the [Inception Core ML Model (94.7MB 😨)](https://developer.apple.com/machine-learning/) to detect the dominant object in the photo. Tap on the keyword to search for even more photos.

## Usage

Tested with Xcode 9.1, Swift 4, iOS 11.

1. All dependencies and pods included in the zip. Build and run.


### 403 Errors?

The included [Unsplash API key](https://unsplash.com/oauth/applications) is rate limited to 50 requests per hour 😔
