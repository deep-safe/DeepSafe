# Mobile Build & Distribution Guide

This guide explains how to build the Android APK for your landing page and how to run the iOS app for testing.

## 🤖 Android Build (Direct Download)

Since you want to offer a direct download (`.apk`) from your landing page, follow these steps to generate the file.

### 1. Prerequisites
Ensure you have the following installed on your machine:
- **Java Development Kit (JDK 17+)**: Required for Gradle.
- **Android Studio**: Contains the Android SDK and tools.

### 2. Generate the APK
Open your terminal in the project root and run:

```bash
cd android
./gradlew assembleDebug
```

*   **Note**: `assembleDebug` creates a testing APK. It allows installation from unknown sources but isn't optimized for the Play Store.
*   **Troubleshooting**: If you get a "Permission denied" error, run `chmod +x gradlew` first.

### 3. Locate the File
Once the build finishes successfully, your APK will be located here:
`android/app/build/outputs/apk/debug/app-debug.apk`

### 4. Deploy to Landing Page
To make the "Scarica APK" button work:
1.  **Copy** the `app-debug.apk` file.
2.  **Paste** it into your landing page assets folder:
    `/Users/simo/Library/Mobile Documents/com~apple~CloudDocs/DeepSafe 2/LANDING PAGE/assets/`
3.  **Rename** it to `deepsafe.apk`.

Now, the link `<a href="assets/deepsafe.apk">` on your landing pages will work!

---

## 🍎 iOS Build (Testing)

Apple does **not** allow direct file downloads for app installation like Android. You must use Xcode.

### 1. Prerequisites
- A Mac computer.
- **Xcode** (installed from the Mac App Store).
- **CocoaPods** (install via `sudo gem install cocoapods`).

### 2. Open the Project
Run this command in your project root:

```bash
npx cap open ios
```

This will open Xcode.

### 3. Run on Device
1.  Connect your iPhone to your Mac via USB.
2.  In Xcode, look at the top toolbar. Select your iPhone from the device list (instead of a Simulator).
3.  **Signing**: You need to select a "Team" to sign the app.
    - Go to the project navigator (left sidebar) -> Click "App" (blue icon).
    - Go to "Signing & Capabilities".
    - Under "Team", select your personal account (or add one).
4.  Click the **Play (Run)** button.

### 4. Trust the App
On your iPhone, the app might not open immediately. Go to:
**Settings -> General -> VPN & Device Management -> [Your Email] -> Trust**.

### 5. Distributing to Others (TestFlight)
To share the iOS app with others without their phone connected to your Mac, you must use **TestFlight**.
1.  Enroll in the Apple Developer Program ($99/year).
2.  In Xcode, go to **Product -> Archive**.
3.  Follow the prompts to upload to **App Store Connect**.
4.  Invite users via email in App Store Connect.

---

## 🌐 PWA Fallback (Web App)

Remember, you also have the **Web App** fallback configured.
- Users can simply click "Web App" on the landing page.
- This opens `/dashboard`.
- They can tap "Share" -> "Add to Home Screen" on iOS/Android to install it without any store or APK file.
