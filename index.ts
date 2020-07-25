import { NativeModules, Platform } from 'react-native';

const { NotificationBadge } = NativeModules;

export type BadgeSetting = 'enabled' | 'disabled' | 'notSupported' | 'unknown';
export type NotificationPermission = 'badge' | 'alert' | 'sound' | 'carPlay' | 'criticalAlert' | 'providesAppNotificationSettings' | 'provisional' | 'announcement';

/**
 * **Asynchronously sets the Badge count.**
 *
 * Note: If no notification permissions have been granted yet, this will also ask the user for notification permissions (only `[.badge]`), so request permissions before calling this using a library like [react-native-permissions](https://github.com/react-native-community/react-native-permissions)
 * @param badgeCount The new badge count to set
 * @example
 * await setBadgeCount(2)
 */
export function setBadgeCount(badgeCount: number): Promise<void> {
  if (Platform.OS === 'ios') {
    return NotificationBadge.setBadgeCount(badgeCount);
  } else {
    throw new Error(`setBadgeCount is not supported on ${Platform.OS}!`)
  }
}

/**
 * **Asynchronously returns the current Badge count.**
 *
 * Note: If no notification permissions have been granted yet, this will also ask the user for notification permissions (only `[.badge]`), so request permissions before calling this using a library like [react-native-permissions](https://github.com/react-native-community/react-native-permissions)
 * @example
 * const badgeCount = await getBadgeCount()
 */
export function getBadgeCount(): Promise<number> {
  if (Platform.OS === 'ios') {
    return NotificationBadge.getBadgeCount();
  } else {
    throw new Error(`getBadgeCount is not supported on ${Platform.OS}!`)
  }
}

/**
 * Same as [`getBadgeCount`](#getbadgecount), but synchronously.
 * @example
 * const badgeCount = getBadgeCountSync()
 */
export function getBadgeCountSync(): number {
  if (Platform.OS === 'ios') {
    return NotificationBadge.getBadgeCountSync();
  } else {
    throw new Error(`getBadgeCountSync is not supported on ${Platform.OS}!`)
  }
}

/**
 * Asynchronously gets the current state of the "Notification Badge" permission setting.
 * @example
 * const permission = await getNotificationBadgeSetting()
 * if (permission === 'enabled') {
 *     await setBadgeCount(5)
 * } else {
 *     console.log("Badge permission has not yet been granted. I'll ask the user later")
 * }
 */
export function getNotificationBadgeSetting(): Promise<BadgeSetting> {
  if (Platform.OS === 'ios') {
    return NotificationBadge.getNotificationBadgeSetting();
  } else {
    throw new Error(`getNotificationBadgeSetting is not supported on ${Platform.OS}!`)
  }
}

/**
 * Asynchronously request the user to grant the specified permissions.
 * @param permissions The array of permissions to grant
 * @example
 * const granted = await requestNotificationPermissions(['alert', 'badge', 'sound'])
 */
export function requestNotificationPermissions(permissions: NotificationPermission[]): Promise<boolean> {
  if (Platform.OS === 'ios') {
    return NotificationBadge.requestNotificationPermissions(permissions);
  } else {
    throw new Error(`requestNotificationPermissions is not supported on ${Platform.OS}!`)
  }
}
