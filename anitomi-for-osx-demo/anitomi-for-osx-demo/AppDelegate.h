//
//  AppDelegate.h
//  anitomy-for-osx-demo
//
//  Created by Tail Red on 2/6/15.
//  Copyright (c) 2015 Atelier Shiori. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <anitomy-osx/anitomy-objc-wrapper.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>{
        IBOutlet NSTextView * output;
}


@end

