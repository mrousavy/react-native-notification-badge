# react-native-notification-badge

> For when you don't want to use a fully featured notification manager

A very simple notification badge count manager for React Native that just works.

[![react-native-notification-badge](https://badge.fury.io/js/react-native-notification-badge.svg)](https://badge.fury.io/js/react-native-notification-badge)
[![GitHub stars](https://img.shields.io/github/stars/mrousavy/react-native-notification-badge.svg?style=social&label=Star&maxAge=259000)](https://github.com/mrousavy/react-native-notification-badge/stargazers/)
[![GitHub followers](https://img.shields.io/github/followers/mrousavy.svg?style=social&label=Follow&maxAge=259000)](https://github.com/mrousavy?tab=followers)

<a href='https://ko-fi.com/F1F8CLXG' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi2.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>

## Installation

1. `npm install react-native-notification-badge` or `yarn add react-native-notification-badge`
2. `cd ios && pod install`

## API

**Note: All APIs throw if `Platform.OS !== 'ios'`!**. So wrap your calls with a `Platform.OS` check first.

### `getBadgeCount`

**Asynchronously returns the current Badge count.**

Note: If no notification permissions have been granted yet, this will also ask the user for notification permissions (only `[.badge]`), so request permissions before calling this using a library like [react-native-permissions](https://github.com/react-native-community/react-native-permissions)

```ts
const badgeCount = await getBadgeCount()
```

### `getBadgeCountSync`

Same as [`getBadgeCount`](#getbadgecount), but synchronously.

```ts
const badgeCount = getBadgeCountSync()
```

### `setBadgeCount`

**Asynchronously sets the Badge count.**

Note: If no notification permissions have been granted yet, this will also ask the user for notification permissions (only `[.badge]`), so request permissions before calling this using a library like [react-native-permissions](https://github.com/react-native-community/react-native-permissions)

```ts
await setBadgeCount(2)
```

### `getNotificationBadgeSetting`

**Asynchronously gets the current state of the "Notification Badge" permission setting.**

Possible values are: `'enabled' | 'disabled' | 'notSupported' | 'unknown'`

```ts
const permission = await getNotificationBadgeSetting()
if (permission === 'enabled') {
  await setBadgeCount(5)
} else {
  console.log("Badge permission has not yet been granted. I'll ask the user later")
}
```

### `requestNotificationPermissions`

**Asynchronously request the user to grant the specified permissions.**

Possible parameter values are: `['badge' | 'alert' | 'sound' | 'carPlay' | 'criticalAlert' | 'providesAppNotificationSettings' | 'provisional' | 'announcement']`

```ts
const granted = await requestNotificationPermissions(['badge', 'alert', 'sound'])
```

### `removeNotificationsWithThreadId`

**Remove all notification with the given Thread ID from the User's Notification Center.**

> The Thread ID is a property in the APNS payload which can be used to group notifications in **iOS 10.0** or higher.

Returns the count of notifications that were removed.

```ts
const removed = await removeNotificationsWithThreadId('group-chat-2')
```


## Other

Check out my other react-native libraries:

* [react-native-blurhash](https://github.com/mrousavy/react-native-blurhash): 🖼️ Give your users the loading experience they want.
* [react-native-google-nearby-messages](https://github.com/mrousavy/react-native-google-nearby-messages): 📲 Communicate with nearby devices using Bluetooth, BLE, WiFi and near-ultrasonic audio. Broadcast and receive small payloads (like strings) using the easy-to-use React Native API!
* [react-native-sectioned-slider](https://github.com/mrousavy/react-native-sectioned-slider): An iOS 11 Control Center inspired Slider for React Native
