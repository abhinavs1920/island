# Core Module Knowledge

## Overview
Shared infrastructure used across all features — API client, secure storage, routing, and the design system theme.

## Files
- `api/api_client.dart` — Central Dio client with JWT injection + 401 silent refresh
- `storage/secure_storage.dart` — `flutter_secure_storage` wrapper for JWT tokens
- `router/app_router.dart` — GoRouter config, all named routes
- `theme/app_theme.dart` — Flikk design system (colors, typography, button styles)

## ⚠️ Required Before Going Live

### 1. Set Real Backend URL
In `lib/core/api/api_client.dart`, replace:
```dart
baseUrl: 'https://api.example.com',
```
with the actual FastAPI backend URL.

### 2. Initialize Firebase
In `lib/main.dart`, uncomment:
```dart
await Firebase.initializeApp();
```
And add `google-services.json` to `android/app/`.

### 3. Initialize Supabase
In `lib/main.dart`, add before `runApp`:
```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

### 4. Wire FCM Push
In `lib/main.dart`, add after initialization:
```dart
FirebaseMessaging.onMessage.listen((message) {
  // Invalidate gigs provider to refresh task list
});
FirebaseMessaging.onMessageOpenedApp.listen((message) {
  final taskId = message.data['task_id'];
  if (taskId != null) router.push('/task/$taskId');
});
```

## API Client — How It Works
```
Every request
  │
  ├─ Interceptor reads JWT from flutter_secure_storage
  ├─ Attaches: Authorization: Bearer <token>
  │
  └─ On 401 response:
       ├─ Calls /refresh_session with refresh_token
       ├─ On success → saves new tokens, retries original request
       └─ On failure → clears tokens, routes to /phone
```

## Routes
| Path | Screen | Notes |
|---|---|---|
| `/` | `SplashScreen` | Session check on app launch |
| `/phone` | `PhoneEntryScreen` | OTP entry point |
| `/otp` | `OtpVerifyScreen` | Pushed onto stack (back = /phone) |
| `/home` | `HomeScreen` | Main hub |
| `/task/:id` | `TaskDetailScreen` | Task detail |
| `/matched` | `MatchedConfirmationScreen` | Post-accept success |
| `/race_lost` | `RaceLostScreen` | Post-accept race lost |
| `/chat/:id` | `ChatScreen` | Supabase Realtime chat |

## Design System (Flikk)
| Token | Value | Usage |
|---|---|---|
| `primary` | `#003EC7` | AppBar text, links, nav icons |
| `primaryContainer` | `#0052FF` | Active nav pill, CTA buttons |
| `surface` | `#FBF8FF` | Screen backgrounds |
| `onSurface` | `#191B25` | Body text |
| `outline` | `#737688` | Borders, placeholder text |
| `error` | `#BA1A1A` | Inline validation errors |
| `success` | `#10B981` | Online toggle green |
| Font | **Inter** (via `google_fonts`) | All text |
