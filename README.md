# feitian-mobile-readers-issue-61-reproducable-example

A demo app used to reproduce [issue 61](https://github.com/FeitianSmartcardReader/FEITIAN_MOBILE_READERS/issues/61) in version 3.5.71 of Feitian's iOS SDK for mobile readers.


## Installation and running app

1. clone this repository
2. open the project in Xcode
3. select a provisioning profile
4. change the hardcoded name of reader in the `ViewController.m` file
5. run the app on a device


## Reproducing the issue

When reproducing the issue, keep the following in mind:

- keep your eye on the console logs in Xcode
- make sure that you changed the hardcoded name of your reader
- make sure that the app has permission to use Bluetooth

When the app is open, follow these instructions to demonstrate that the app cannot connect to the reader anymore, if the first context is established and then released without connecting to a reader.

1. turn on the reader
2. click the "create interface"-button
3. click the "establish context"-button
3. click the "destroy context"-button
4. click the "establish context"-button
5. click the "connect to reader"-button
6. observe that the app does not connect to the app

