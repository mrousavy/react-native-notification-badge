import { NativeModules, Platform } from 'react-native';

const { NotificationBadge } = NativeModules;

export function setBadgeCount(badgeCount: number): Promise<void> {
  if (Platform.OS === 'ios') {
    return NotificationBadge.setBadgeCount(badgeCount);
  } else {
    throw new Error(`setBadgeCount is not supported on ${Platform.OS}!`)
  }
}

export function getBadgeCount(): Promise<number> {
  if (Platform.OS === 'ios') {
    return NotificationBadge.getBadgeCount();
  } else {
    throw new Error(`getBadgeCount is not supported on ${Platform.OS}!`)
  }
}

export function getBadgeCountSync(): number {
  if (Platform.OS === 'ios') {
    return NotificationBadge.getBadgeCountSync();
  } else {
    throw new Error(`getBadgeCountSync is not supported on ${Platform.OS}!`)
  }
}
