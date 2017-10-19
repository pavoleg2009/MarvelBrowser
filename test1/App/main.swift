// for fake UIAppDelegate in test target

import UIKit

let testTargetName = "test1Tests"

let appDelegateClass: AnyClass? = NSClassFromString("\(testTargetName).TestingAppDelegate") ?? AppDelegate.self

let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(to: UnsafeMutablePointer<Int8>.self,
                capacity: Int(CommandLine.argc))

UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass!))
