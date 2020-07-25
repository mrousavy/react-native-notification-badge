//
//  NotificationBadge.swift
//  NotificationBadge
//
//  Created by Marc Rousavy on 25.07.20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation
import UIKit

@objc(NearbyMessages)
class NotificationBadge: NSObject {
	@objc(setBadgeCount:)
	func setBadgeCount(_ badgeCount: NSNumber) -> Void {
		UIApplication.shared.applicationIconBadgeNumber = badgeCount.intValue
	}

	@objc(getBadgeCount:rejecter:)
	func getBadgeCount(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
		let badgeCount = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber)
		resolve(badgeCount)
	}

	@objc
	func getBadgeCountSync() -> NSNumber {
		return NSNumber(value: UIApplication.shared.applicationIconBadgeNumber)
	}
}
