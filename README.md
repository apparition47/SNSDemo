# SNS Demo

A SNS POC based on Firebase. Written in Swift for iOS. Clean architecture.

<p align="center">
	<img height="400" src="https://user-images.githubusercontent.com/47551890/92100669-0d1ec400-ee17-11ea-9cf9-b56f2b1d2698.png">
	<img height="400" src="https://user-images.githubusercontent.com/47551890/92101196-b960aa80-ee17-11ea-8cf0-b3b216d74a5e.png">
</p>


## Features

* Sign up, Sign In, and Sign Out
* User can post to a timeline
* User can delete their own post (swipe to delete)
* Post/Timeline view page


## Setup

```bash
################################
# input pw into env var here
OPENSSL_KEY=ENTER_PASSWORD_HERE
################################
git clone https://github.com/apparition47/SNSDemo.git
cd SNSDemo
openssl aes-256-cbc -d -md sha256 -in TDM/GoogleService-Info.plist.enc -out TDM/GoogleService-Info.plist -k ${OPENSSL_KEY}
pod install
open TDM.xcworkspace
```