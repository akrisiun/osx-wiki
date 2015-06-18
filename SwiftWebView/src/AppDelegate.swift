//
//  AppDelegate.swift
//  Swift3
//
//  Created by Andrius K on 2015-01-17.
//  Copyright (c) 2015 Andrius K. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

/*

#!/usr/bin/env xcrun swift -i
import WebKit

let application = NSApplication.sharedApplication()
application.setActivationPolicy(NSApplicationActivationPolicy.Regular)
let window = NSWindow(contentRect: NSMakeRect(0, 0, 800, 600), styleMask: NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask, backing: .Buffered, defer: false)
window.center()
window.title = "Minimal Swift WebKit Browser"
window.makeKeyAndOrderFront(window)

class WindowDelegate: NSObject, NSWindowDelegate {
    func windowWillClose(notification: NSNotification?) {
        NSApplication.sharedApplication().terminate(0)
    }
}
let windowDelegate = WindowDelegate()
window.delegate = windowDelegate

class ApplicationDelegate: NSObject, NSApplicationDelegate {
    var _window: NSWindow
    init(window: NSWindow) {
        self._window = window
    }
    func applicationDidFinishLaunching(notification: NSNotification?) {
        let webView = WebView(frame: self._window.contentView.frame)
        self._window.contentView.addSubview(webView)
        webView.mainFrame.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.google.com/ncr")))
    }
}
let applicationDelegate = ApplicationDelegate(window: window)
application.delegate = applicationDelegate
application.activateIgnoringOtherApps(true)
application.run()

*/