//
//  AppDelegate.swift
//  anitomy-swift-demo
//
//  Created by 桐間紗路 on 2016/12/24.
//  Copyright © 2016年 Atelier Shiori. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var output: NSTextView!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    @objc func windowWillClose(_ aNotification: Notification) {
        // Close Application if window is closed
        NSApplication.shared.terminate(nil)
    }
    @IBAction func recognize(sender : NSButton){
        let op = NSOpenPanel()
        op.allowedFileTypes = Array(arrayLiteral: "mkv","mp4", "avi","ogm")
        op.title = "Select Media File"
        op.message = "Select a media file to test."
        let result = op.runModal()
        if result.rawValue == NSFileHandlingPanelCancelButton{
            return;
        }
        let d = anitomy_bridge().tokenize(op.url?.lastPathComponent)
        output.string = String(format: "%@", d!)
    }


}

