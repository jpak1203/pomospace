//
//  AppDelegate.swift
//  pomospace
//
//  Created by Justin Pak on 11/26/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import Cocoa 
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover = NSPopover.init()
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        // Randomizes meditation tracks everytime you open the app
        shuffleMeditationTracks()
        
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentViewController = MainViewController()
        popover.contentSize = NSSize(width: 300, height: 450)
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        statusBar = StatusBarController.init(popover)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

