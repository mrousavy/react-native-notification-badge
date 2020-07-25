# react-native-notification-badge

> For when you don't want to use a fully featured notification manager

A very simple notification badge count manager for React Native that just works.

## API

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


