# feitian-mobile-readers-issue-61-reproducable-example

A demo app used to reproduce [issue 61](https://github.com/FeitianSmartcardReader/FEITIAN_MOBILE_READERS/issues/61) in version 3.5.71 of Feitian's iOS SDK for mobile readers.


## Setup

1. clone this repository
2. open the project in Xcode
3. select a provisioning profile
4. change the hardcoded name of the reader to connect to, in the `ViewController.m` file


## Reproducing the issue

When reproducing the issue, keep the following in mind:

- check the console logs in Xcode
- make sure that you've changed the hardcoded name of the reader to connect to
- make sure that the app has permission to use Bluetooth
- close the app fully after each demonstration


### demonstration: first context without connection breaks functionality

To demonstrate that functionality breaks after establishing and releasing the first context without connecting to a reader,
follow these instructions:

1. run the app on a device through Xcode
2. turn on the reader
3. click the "create interface"-button
4. click the "establish context"-button
5. observe that the following are present in the console logs:
    - a message indicating that the reader has been detected
    - a message indicating that the delegate's `findPeripheralReader` method has been called
6. click the "release context"-button
7. observe that the following are present in the console logs:
    - an "UnRegisterAccessoryConnectNotification----->001" message
    - a message indicating that the delegate's `readerInterfaceDidChange` method has been called
8. click the "establish context"-button
9. observe that the following are **NOT** present in the console logs:
    - a message indicating that the reader has been detected
    - a message indicating that the delegate's `findPeripheralReader` method has been called
10. click the "connect to reader"-button
11. observe that the app does not connect to the reader

The functionality to detect and connect to a reader is broken for the rest of the app's lifetime.


### demonstration: later contexts without connections do not break functionality

To demonstrate that functionality does not break after establishing and releasing later contexts without connecting to a reader (as long as a connection was made while the first context was established),
follow these instructions:

1. run the app on a device through Xcode
2. turn on the reader
3. click the "create interface"-button
4. click the "establish context"-button
5. observe that the following are present in the console logs:
    - a message indicating that the reader has been detected
    - a message indicating that the delegate's `findPeripheralReader` method has been called
6. click the "connect to reader"-button
7. observe that the app connects to the reader
8. click the "disconnect from reader"-button
9. observe that the app disconnects from the reader
10. click the "release context"-button
11. observe that the following messages are **NOT** present in the console logs:
    - an "UnRegisterAccessoryConnectNotification----->001" message
    - a message indicating that the delegate's `readerInterfaceDidChange` method has been called
12. turn on the reader again
13. click the "establish context"-button
14. observe that the following are present in the console logs:
    - a message indicating that the reader has been detected
    - a message indicating that the delegate's `findPeripheralReader` method has been called
15. click the "connect to reader"-button
16. observe that the app connects to the reader

You can establish and release later contexts without having to connect to a reader.
