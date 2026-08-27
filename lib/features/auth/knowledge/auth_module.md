# Auth Module Knowledge

## Overview
This module handles rider authentication, consisting of a Splash screen for session restoration, a Phone Entry screen, and an OTP Verification screen. It strictly follows the "Flikk" design system (Electric Blue primary actions, Inter font, bottom-anchored CTA buttons).

## Files
- `auth_provider.dart` — Riverpod `StateNotifier` managing all auth state
- `splash_screen.dart` — Session check + animated Flikk logo
- `phone_entry_screen.dart` — Custom numeric keypad, hardcoded +91 country code
- `otp_verify_screen.dart` — 6-box OTP input with inline error states

## Endpoints Consumed
| Endpoint | When Called | Status |
|---|---|---|
| `POST /refresh_session` | Splash screen — silently restores existing session | ⚠️ **Not yet wired** |
| `POST /verify_and_create_session` | After Firebase OTP validated — exchanges Firebase ID token for backend JWT | ⚠️ **Not yet wired** |
| `POST /register_device_token` | Immediately after session creation — registers FCM token for push notifications | ⚠️ **Not yet wired** |

## Required Before Going Live
- [ ] **Firebase Auth setup**: Replace mock `sendOtp()` flow in `auth_provider.dart` with real `FirebaseAuth.instance.verifyPhoneNumber()` call
- [ ] **Firebase ID Token**: Replace `mock_firebase_id_token` in `verifyOtp()` with `await user.getIdToken()`
- [ ] **FCM token**: Replace `mock_device_token_for_push` with `await FirebaseMessaging.instance.getToken()`
- [ ] **Backend base URL**: Update `baseUrl` in `lib/core/api/api_client.dart` from `https://api.example.com` to the real backend URL

## Test Mode Bypass
| Phone Number | OTP | Behaviour |
|---|---|---|
| `9999999999` | `000000` | Skips Firebase entirely, logs in with a local test JWT |
| `1234567890` | `000000` | Same as above |

> Remove `_testNumbers` and `_testOtp` constants from `auth_provider.dart` before production release.

## State Management
- `authProvider` — `StateNotifierProvider<AuthNotifier, AuthState>`
- Tokens stored via `flutter_secure_storage` (never plain SharedPreferences)
- Global 401 handling + silent refresh is in `ApiClient` Dio interceptor, not here
