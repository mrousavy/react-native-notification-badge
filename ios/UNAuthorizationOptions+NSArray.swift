//
//  UNAuthorizationOptions+NSArray.swift
//  NotificationBadge
//
//  Created by Marc Rousavy on 25.07.20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation
import UserNotifications

@available(iOS 10.0, *)
func mapPermissionsArray(array: NSArray) -> UNAuthorizationOptions {
	var permissions: UNAuthorizationOptions = []
	for item in array {
		if let string = item as? String {
			switch (string.lowercased()) {
			case "badge":
				permissions.insert(.badge)
				break
			case "alert":
				permissions.insert(.alert)
				break
			case "sound":
				permissions.insert(.sound)
				break
			case "carPlay":
				permissions.insert(.carPlay)
				break
			case "criticalAlert":
				if #available(iOS 12.0, *) {
					permissions.insert(.criticalAlert)
				} else {
					NSLog("Permission option \(string) is not available on the current iOS version!")
				}
				break
			case "providesAppNotificationSettings":
				if #available(iOS 12.0, *) {
					permissions.insert(.providesAppNotificationSettings)
				} else {
					NSLog("Permission option \(string) is not available on the current iOS version!")
				}
				break
			case "provisional":
				if #available(iOS 12.0, *) {
					permissions.insert(.provisional)
				} else {
					NSLog("Permission option \(string) is not available on the current iOS version!")
				}
				break
			case "announcement":
				if #available(iOS 13.0, *) {
					permissions.insert(.announcement)
				} else {
					NSLog("Permission option \(string) is not available on the current iOS version!")
				}
				break
			default:
				NSLog("Invalid Permission option: \(string)")
				break
			}
		}
	}
	return permissions
}
