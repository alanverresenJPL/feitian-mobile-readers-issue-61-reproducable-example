//
//  ViewController.m
//  ft-issue60-reproducable-example
//
//  Created by Alan Verresen on 04/07/2026.
//

#import "ViewController.h"
#import "winscard.h"
#import "ReaderInterface.h"


@interface ViewController ()

@end


@interface MyReaderInterfaceDelegate: NSObject <ReaderInterfaceDelegate>

@end


@implementation ViewController {
    SCARDCONTEXT _contextHandle;
    ReaderInterface * _interface;
    MyReaderInterfaceDelegate * _delegate;
    NSString * _readerName;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _contextHandle = 0;
    _interface = nil;
    _delegate = nil;
    _readerName = @"FT_1234567890AB";  // Change to the name of your reader!
}

- (IBAction)createInterfaceButtonClick:(id)sender {
    NSLog(@"clicked CREATE INTERFACE button");

    if (_interface != nil) {
        return;
    }
    
    _delegate = [[MyReaderInterfaceDelegate alloc] init];
    
    _interface = [[ReaderInterface alloc] init];
    [_interface setAutoPair: false];
    [_interface setDelegate: _delegate];
}

- (IBAction)destroyInterfaceButtonClick:(id)sender {
    NSLog(@"clicked DESTROY INTERFACE button");

    if (_interface == nil) {
        return;
    }
    
    _interface = nil;
    
    _delegate = nil;
}

- (IBAction)establishContextButtonClick:(id)sender {
    NSLog(@"clicked ESTABLISH CONTEXT button");
    
    if (_contextHandle != 0) {
        return;
    }
    
    ULONG ret = SCardEstablishContext(SCARD_SCOPE_SYSTEM,NULL,NULL, &_contextHandle);
    NSLog(@"clicked SCardEstablishContext returned %d.", ret);
}

- (IBAction)releaseContextButtonClick:(id)sender {
    NSLog(@"clicked RELEASE CONTEXT button");

    if (_contextHandle == 0) {
        return;
    }
    
    ULONG ret = SCardReleaseContext(_contextHandle);
    NSLog(@"SCardReleaseContext returned %d.", ret);

    _contextHandle = 0;
}


- (IBAction)connectToReaderButtonClick:(id)sender {
    NSLog(@"clicked CONNECT TO READER button");
        
    [_interface connectPeripheralReader:_readerName timeout:5];
}


- (IBAction)disconnectFromReaderButtonClick:(id)sender {
    NSLog(@"clicked DISCONNECT FROM READER button");
    
    [_interface disConnectCurrentPeripheralReader];
}

@end


@implementation MyReaderInterfaceDelegate

// connected to/disconnected from card
- (void) cardInterfaceDidDetach:(BOOL)attached slotname:(NSString *)slotname {
    NSLog(@"[DELEGATE] cardInterfaceDidDetach attached:%d slotname:%@", attached, slotname);
}

// battery report
- (void) didGetBattery:(NSInteger)battery {
    NSLog(@"[DELEGATE] didGetBattery battery:%ld", (long)battery);
}

//
- (void) findPeripheralReader:(NSString *)readerName {
    NSLog(@"[DELEGATE] findPeripheralReader readerName:%@", readerName);
}

- (void) readerInterfaceDidChange:(BOOL)attached bluetoothID:(NSString *)bluetoothID andslotnameArray:(NSArray *)slotArray {
    NSLog(@"[DELEGATE] readerInterfaceDidChange attached:%d bluetoothID:%@ slotArray:%@", attached, bluetoothID, slotArray);
}

@end

