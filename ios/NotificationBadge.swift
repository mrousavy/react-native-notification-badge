//
//  NotificationBadge.swift
//  NotificationBadge
//
//  Created by Marc Rousavy on 25.07.20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

@objc(NotificationBadge)
class NotificationBadge: NSObject {
	///	Request for notification permissions and run the given executor function on the main thread if permissions have been granted, otherwise callback to onPermissionError.
	func runWithNotificationPermissions(execute: @escaping () -> Void, onPermissionError: @escaping (_ error: Error) -> Void) -> Void {
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			center.requestAuthorization(options: [.badge]) { granted, error in
				if let error = error {
					onPermissionError(error)
					return
				}
				if granted {
					DispatchQueue.main.async {
						execute()
					}
					return
				}
			}
		} else {
			DispatchQueue.main.async {
				execute()
			}
		}
	}
	
	@objc(setBadgeCount:resolver:rejecter:)
	func setBadgeCount(_ badgeCount: NSNumber, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
		runWithNotificationPermissions(
			execute: {
				UIApplication.shared.applicationIconBadgeNumber = badgeCount.intValue
				resolve(nil)
			},
			onPermissionError: { (error) in
				reject("PERMISSION-ERROR", error.localizedDescription, error)
			})
	}

	@objc(getBadgeCount:rejecter:)
	func getBadgeCount(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
		runWithNotificationPermissions(
			execute: {
				let badgeCount = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber)
				resolve(badgeCount)
			},
			onPermissionError: { (error) in
				reject("PERMISSION-ERROR", error.localizedDescription, error)
			})
	}

	@objc
	func getBadgeCountSync() -> NSNumber {
		if !Thread.isMainThread {
			NSLog("Error! getBadgeCountSync() has to be called from the main Thread!")
		}
		return NSNumber(value: UIApplication.shared.applicationIconBadgeNumber)
	}
	
	@objc
	static func requiresMainQueueSetup() -> Bool {
		return true
	}
}
