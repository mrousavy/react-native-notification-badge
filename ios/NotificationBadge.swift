//
//  NotificationBadge.swift
//  NotificationBadge
//
//  Created by Marc Rousavy on 25.07.20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation
import UIKit

@objc(NotificationBadge)
class NotificationBadge: NSObject {
	@objc(setBadgeCount:)
	func setBadgeCount(_ badgeCount: NSNumber) -> Void {
		DispatchQueue.main.async {
			UIApplication.shared.applicationIconBadgeNumber = badgeCount.intValue
		}
	}

	@objc(getBadgeCount:rejecter:)
	func getBadgeCount(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
		DispatchQueue.main.async {
			let badgeCount = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber)
			resolve(badgeCount)
		}
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
