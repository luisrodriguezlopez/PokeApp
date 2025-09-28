//
//  main.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 27/09/25.
//

import Foundation
import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self
UIApplicationMain(
CommandLine.argc,
CommandLine.unsafeArgv,
nil,
NSStringFromClass(appDelegateClass))
