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
				} else {
					onPermissionError(NSError(domain: "", code: 0, userInfo: ["message": "No error was thrown, but permission has not been granted."]))
					return
				}
			}
		} else {
			DispatchQueue.main.async {
				execute()
			}
		}
	}
	
	@objc(removeNotificationsWithThreadId:resolver:rejecter:)
	func removeNotificationsWithThreadId(_ threadId: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			center.getDeliveredNotifications { (notifications) in
				let notificationsInThread = notifications.filter { $0.request.content.threadIdentifier == threadId }.map { $0.request.identifier }
				center.removeDeliveredNotifications(withIdentifiers: notificationsInThread)
				resolve(nil)
			}
		} else {
			reject("UNSUPPORTED", "Notification Thread ID is only supported in iOS 10.0 or higher!", nil)
		}
	}
	
	@objc(getNotificationBadgeSetting:rejecter:)
	func getNotificationBadgeSetting(resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			center.getNotificationSettings { (settings) in
				switch (settings.badgeSetting) {
				case .enabled:
					resolve("enabled")
					break
				case .disabled:
					resolve("disabled")
					break
				case .notSupported:
					resolve("notSupported")
					break
				default:
					resolve("unknown")
					break
				}
			}
		} else {
			resolve("enabled")
		}
	}
	
	@objc(requestNotificationPermissions:resolver:rejecter:)
	func requestNotificationPermissions(_ permissions: NSArray, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			let permissions = mapPermissionsArray(array: permissions)
			center.requestAuthorization(options: permissions) { granted, error in
				if let error = error {
					reject("PERMISSION-ERROR", error.localizedDescription, error)
					return
				}
				resolve(granted)
			}
		} else {
			resolve(nil)
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
