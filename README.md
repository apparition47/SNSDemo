# SNS Demo

A SNS demo based on Firebase.

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