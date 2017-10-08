# Unsplash Viewer

![Demo](https://user-images.githubusercontent.com/3298414/30434179-8a489c26-99a1-11e7-8fdb-7fd93e2ac829.gif)

## Description

[Unsplash](https://unsplash.com) photo viewer using [Clean architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html). Uses Core ML, Vision and [Inception Core ML Model](https://developer.apple.com/machine-learning/) to detect the dominant object in the photo.

## Usage

Tested with Xcode 9, iOS 11.

1. [CocoaPods](https://cocoapods.org) `$ pod install`
2. Download *Inception v3* `$ curl https://docs-assets.developer.apple.com/coreml/models/Inceptionv3.mlmodel > PhotoViewer/Inceptionv3.mlmodel`
3. In `Constants.swift`, enter your [Unsplash Application ID](https://unsplash.com/oauth/applications).

```Swift
let unsplashAppId = "Unsplash Application ID Here"
```

## Credits

* Based on a Clean Architecture demo by [@FortechRomania](https://github.com/FortechRomania)

## License

MIT
