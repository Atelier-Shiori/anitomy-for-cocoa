//
//  AppDelegate.m
//  anitomy-for-osx-demo
//
//  Created by Tail Red on 2/6/15.
//  Copyright (c) 2015 Atelier Shiori. All rights reserved.
//

#import "AppDelegate.h"
#import <anitomy-osx/anitomy-objc-wrapper.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
-(void)windowWillClose:(NSNotification *)notification{
    //Temrminate Application
    [[NSApplication sharedApplication] terminate:nil];
    
}
-(IBAction)recognize:(id)sender{
    //Obtain Detected Title from Media File
    NSOpenPanel * op = [NSOpenPanel openPanel];
    [op setAllowedFileTypes:[NSArray arrayWithObjects:@"mkv", @"mp4", @"avi", @"ogm", nil]];
    [op setTitle:@"Select Media File"];
    [op setMessage:@"Select a media file to test."];
    NSInteger result = [op runModal];
    if (result == NSFileHandlingPanelCancelButton) {
        return;
    }
    NSDictionary * d = [[anitomy_bridge alloc] tokenize:[[[op URL] path] lastPathComponent]];
    [output setString:[NSString stringWithFormat:@"%@",d]];
}
@end
