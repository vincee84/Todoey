//
//  AppDelegate.swift
//  Todoey
//
//  Created by Vince Ng on 9/9/18.
//  Copyright © 2018 kindebean. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do {
            let _ = try Realm()
        } catch {
            print("Error initializing new realm, \(error)")
        }
        
        return true
    }

}

