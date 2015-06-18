//
//  ViewController.swift
//  Swift3
//
//  Created by Andrius K on 2015-01-17.
//  Copyright (c) 2015 Andrius K. All rights reserved.
//

import Cocoa
import WebKit
import Foundation

class ViewController: NSViewController {
    
    @IBOutlet weak var combo1: NSComboBox!
   
    @IBOutlet weak var cmdGo: NSButton!
    
    @IBOutlet weak var web1: WebView!
    
    @IBOutlet weak var bottomWeb: NSLayoutConstraint!
    @IBOutlet weak var leadingRightWeb: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // let webView = WebView(frame: self._window.contentView.frame)
        // self._window.contentView.addSubview(webView)
        
        var str = "https://www.google.com/"
        combo1.insertText(str)
        
        let url = NSURL(string: str)
        var req = NSURLRequest(URL: url!)
      
        web1.mainFrame.loadRequest(req)
      
    
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

/* resizable

ou should add content to the contentView of NSWindow.

let textField =. NSTextView()
textView.stringvalue = "Some string"
textView.frame = CGRectMake(10,20,50,400)
mywindow.contentView.addSubview(textView)


This is an amazing tutorial. Need to mention that I have to add
#!/usr/bin/env xcrun -sdk /Applications/Xcode6-Beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk swift -i
#!/usr/bin/env xcrun swift -i

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

*/