# Setup Guide

## Android Setup

### Required Files

1. **google-services.json**
   - Location: `irl-link\android\app\google-services.json`
   - Description: Firebase configuration file for Android

2. **key.properties**
   - Location: `irl-link\android\app\key.properties`
   - Content:
     ```
     storePassword=placeholder
     keyPassword=placeholder
     keyAlias=placeholder
     storeFile=upload-keystore.jks
     ```

3. **upload-keystore.jks**
   - Location: `irl-link\android\app\upload-keystore.jks`
   - Description: Android signing keystore file

## Apple Setup

   - Just login to Xcode

## FireBase
   - Install Firebase CLI (https://firebase.google.com/docs/cli?hl=fr&_gl=1*gv35js*_up*MQ..*_ga*NjMzMzc5MjgwLjE3NjIyNTY2MTg.*_ga_CW55HF8NVT*czE3NjIyNTY2MTckbzEkZzAkdDE3NjIyNTY2MTckajYwJGwwJGgw#setup_update_cli)[Firebase CLI]
   - `firebase login`
   - `dart pub global activate flutterfire_cli`
   - `flutterfire configure`