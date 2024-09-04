
# GetStarted

## React Native 프로젝트 설정
React Native 프로젝트를 생성하고 브릿지를 설정하는 과정에 대한 설명입니다.

이미 프로젝트에 다른 Native 기능을 사용하고 있다면, 기존에 설정된 내용과 중복되는 내용이 있을 수 있습니다.

이 git 프로젝트에 샘플 코드가 포함되어있으니 참고하시기 바랍니다.

### 1. React Native 프로젝트 생성
React Native 프로젝트를 생성합니다.

콘솔창에 다음과 같이 입력하여 프로젝트를 생성합니다.
```bash
npx react-native init tnk_rwd_rn 
```

프로젝트가 생성되었다면 android는 Android Studio, iOS는 Xcode를 이용하여 프로젝트를 열고 편집합니다.

### 2. Tnkfactory SDK 설치

#### 2.1. android 

Android Studio, 또는 IntelliJ IDEA를 이용하여 android 폴더의 프로젝트를 열고 편집합니다.

android 폴더의 build.gradle 다음과 같이 maven repository를 추가합니다.

```gradle
allprojects {
    repositories {
        maven { url 'https://repository.tnkad.net:8443/repository/public/' }
    }
}
```

android/app 폴더의 build.gradle에 다음과 같이 dependency를 추가합니다.
```gradle
dependencies {
    implementation 'com.tnkfactory:rwd:8.06.15'
}
```

androidManefest.xml에 다음과 같이 권한을 추가합니다.
#### 권한 설정

아래와 같이 권한 사용을 추가합니다.
```xml
<!-- 인터넷 -->
<uses-permission android:name="android.permission.INTERNET" />
<!-- 동영상 광고 재생을 위한 wifi접근 -->
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<!-- 광고 아이디 획득 -->
<uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
```

#### Application ID 설정하기

Tnk 사이트에서 앱 등록하면 상단에 App ID 가 나타납니다. 이를 AndroidMenifest.xml 파일의 application tag 안에 아래와 같이 설정합니다.
(*your-application-id-from-tnk-site* 부분을 실제 App ID 값으로 변경하세요.)


```xml
<application>

    <meta-data android:name="tnkad_app_id" android:value="your-application-id-from-tnk-site" />

</application>
```



#### Activity tag 추가하기

광고 목록을 띄우기 위한 Activity를 <activity/>로 아래와 같이 설정합니다. 

```xml
<activity android:name="com.tnkfactory.ad.AdWallActivity" android:exported="true" android:screenOrientation="portrait"/>
```

AndroidManifest.xml의 내용 예시 
```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.tnkfactory.tnkofferer">

    // 인터넷
    <uses-permission android:name="android.permission.INTERNET" />
    // 동영상 광고 재생을 위한 wifi접근
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    // 광고 아이디 획득
    <uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
    // 기타 앱에서 사용하는 권한
    //...
    //...
    
    
    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">

        ...
        ...
        <activity android:name="com.tnkfactory.ad.AdWallActivity" android:exported="true" android:screenOrientation="portrait"/>
        ...
        ...
        <!-- App ID -->
        <meta-data
            android:name="tnkad_app_id"
            android:value="30408070-4051-9322-2239-15040708030f" />
        ...
        ...
    </application>
</manifest>
```
	

#### Proguard 사용

Proguard를 사용하실 경우 Proguard 설정내에 아래 내용을 반드시 넣어주세요.

```
-keep class com.tnkfactory.** { *;}
```


####  ReactWrapperModule 추가하기

android/app/src/ 하위 폴더에 ReactWrapperModule.kt, ReactWrapperPackage.kt 파일을 추가합니다.

[ReactWrapperModule.kt](android%2Fapp%2Fsrc%2Fmain%2Fjava%2Fcom%2Ftnk_rwd_rn%2FReactWrapperModule.kt)

[ReactWrapperPackage.kt](android%2Fapp%2Fsrc%2Fmain%2Fjava%2Fcom%2Ftnk_rwd_rn%2FReactWrapperPackage.kt)

MainApplication에 다음과 같이 'ReactWrapperPackage'패키지를 추가합니다.
```kotlin   
// Packages that cannot be autolinked yet can be added manually here, for example:
// add(MyReactNativePackage())
add(ReactWrapperPackage())
```

#### 실행 및 테스트 
테스트를 위해 [테스트 기기 등록](https://github.com/tnkfactory/android-sdk-rwd/blob/master/reg_test_device.md)이 필요합니다.

다음과 같이 입력해서 앱을 실행합니다.
(실행 후 'a'를 입력해서 안드로이드로 실행 하도록 합니다.)
```bash
npm start
``` 


---

#### 2.2. iOS

xcode 또는 appCode를 사용하여 ios 폴더의 프로젝트를 열고 편집합니다.

### 2.2.1 라이브러리 다운로드

**[[iOS Reward SDK2 Download v5.36](https://github.com/tnkfactory/ios-sdk-rwd2/blob/main/sdk/TnkRwdSdk2.v5.36.zip)]**

### 2.2.2 라이브러리 등록

다운로드 받은 SDK 압축파일을 풀면 TnkRwdSdk2.xcframework 폴더가 생성됩니다. TnkRwdSdk2.xcframework 폴더를 XCode 내에 마우스로 드래그합니다. 이후 XCode -> Target -> General -> Frameworks, Libraries, and Embedded Content 항목에 TnkRwdSdk2.xcframework 가 있는 것을 확인하시고 Embed 설정을 Embed & Sign 으로 변경합니다.

아래의 이미지를 참고하세요.

![framework_embed](https://github.com/tnkfactory/ios-sdk-rwd2/raw/main/img/framework_embed.jpg)

### 2.2.3 앱 추적 동의

앱 광고의 경우 유저들의 광고 참여여부를 확인하기 위해서는 사전에 앱추적동의를 받아야합니다.  앱추적동의는 iOS 14부터 제공되는 기능으로 기기의 IDFA 값 수집을 위하여 필요합니다. 앱 추적 동의 창은 가급적이면 개발하시는 앱이 시작되는 시점에 띄우는 것을 권고드립니다.  [앱 추적동의에 대하여 더 알아보기](https://developer.apple.com/kr/app-store/user-privacy-and-data-use/)

앱 추적 동의에 거부한 유저에게는 광고가 제한적으로 노출됩니다.

#### 앱 추적 동의 창 띄우기

앱 추적동의 창을 띄우기 위해서는 우선 info.plist 파일에 아래와 같이 "Privacy - Tracking Usage Description" 문구를 추가합니다.  추가한 문구는 앱 추적 동의 팝업 창에 노출됩니다.

작성 예시) 사용자에게 최적의 광고를 제공하기 위하여 광고활동 정보를 수집합니다.

![att_info_plist](https://github.com/tnkfactory/ios-sdk-rwd2/raw/main/img/att_info_plist.jpg)

아래의 API 를 호출하여 앱 추적 동의 창을 띄울 수 있습니다. [AppTrackingTransparency API 가이드 보기](https://developer.apple.com/documentation/apptrackingtransparency)

```tsx
showAttPopup();
```

아래의 함수를 사용하여 오퍼월을 호출하시면 자동으로 att팝업 호출 후 오퍼월로 이동합니다. 

![att_popup](https://github.com/tnkfactory/ios-sdk-rwd2/raw/main/img/att_popup.jpg)

### 2.2.4 권한 안내 문구 설정

오퍼월에 제공되는 광고 중에는 이미지 파일을 첨부를 필요로하는 광고들이 많이 있습니다. 이미지 파일 첨부를 위해서는 info.plist 파일에 포토 앨범 접근 권한 안내 문구(Privacy - Photo Library Usage Description)와 카메라 접근 권한 안내 문구(Privacy - Camera Usage Description) 설정이 필요합니다.

아래의 이미지를 참고하여 설정해주세요.

![usage_info_plist](https://github.com/tnkfactory/ios-sdk-rwd2/raw/main/img/usage_info_plist.jpg)

### 2.2.5 Tnk 객체 초기화

SDK 사용을 위해서는 사전에 **APP-ID** 값을 발급 받으셔야합니다.  **APP-ID** 값은 [Tnk 사이트](https://tnkfactory.com) 에서 발급 받으 실 수 있습니다. **APP-ID** 값을 발급 받으셨다면 이 값을 사용하여 TnkSession 객체가 초기화되어야합니다. 이를 위해서는 2가지 방법이 존재합니다. 아래 2가지 방법 중 하나를 선택하시어 진행하시면 됩니다.

#### 초기화 API 호출하기

SDK 가 사용되기 전에 (일반적으로는 Application Delegate 의 applicationDidFinishLaunchingWithOption 메소드 내) 아래와 같이 초기화 로직을 넣습니다. 실제 **APP-ID** 값을 아래 로직의 **your-app-id-from-tnk-site** 부분에 넣어주어야합니다.

```swift
// Swift
import TnkRwdSdk2

TnkSession.initInstance(appId: "your-app-id-from-tnk-site")
```

```objective-c
// Objective-C
#import <WebKit/WebKit.h>
#import "TnkRwdSdk2/TnkRwdSdk2-Swift.h"

[TnkSession initInstanceWithAppId:@"your-app-id-from-tnk-site"];
```

#### info.plist 파일에 등록하기

XCode 프로젝트의 info.plist 파일내에 아래와 같이 `tnkad_app_id` 항목을 추가하고 **APP-ID** 값을 설정합니다. 이곳에 설정해두면 TnkSession 객체가 처음 사용되는 시점에 해당 **APP-ID** 값을 사용하여 자동으로 초기화됩니다.

![appid_info_plist](https://github.com/tnkfactory/ios-sdk-rwd2/raw/main/img/appid_info_plist.jpg)



프로젝트의 패키지(샘플코드에서는 ios/tnk_rwd_rn)에 우클릭 후 New file 을 선택하여 파일을 생성합니다.
swift를 선택 후 ReactWrapperModule를 입력하여 ReactWrapperModule.swift 파일을 생성합니다.
이때 자동으로 '프로젝트명-Bridging-Header.h' 파일을 생성 할 것인지 물어보는데 'Create Bridging Header'를 선택하여 파일을 생성합니다.

같은 방법으로 프로젝트 폴더를 우클릭 하여 'New file'을 선택 - 'cocoaTouch class'를 선택 후 objective-c를 선택합니다.
파일 이름은 ReactWrapperModule으로 입력하면 ReactWrapperModule.m 파일과 ReactWrapperModule.h 파일이 생성됩니다.

'프로젝트명-Bridging-Header.h'파일에는 다음과 같이 RCTBridgeModule.h가 import되어야 합니다.

```objective-c
#import <React/RCTBridgeModule.h>
```

아래 세개의 파일은 샘플코드에 있는 파일을 덮어쓰기 하시기 바랍니다.
[ReactWrapperModule.h](ios%2FReactWrapperModule.h)

[ReactWrapperModule.m](ios%2FReactWrapperModule.m)

[ReactWrapperModule.swift](ios%2FReactWrapperModule.swift)



## 3 React Native 프로젝트 설정

### 3.1. App.tsx 수정

App.tsx 파일을 열어서 import 부분에 'NativeModules'를 추가합니다.

```tsx
import React from 'react';
import type {PropsWithChildren} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  Button,
  useColorScheme,
  View,
  NativeModules,
} from 'react-native';
```

다음과 같이 버튼 이벤트에 setUserName, setCoppa, showOfferwallWithAtt을 호출합니다.
```tsx
<Button
  title="오퍼월 실행"
  onPress={() => {
    const {ReactWrapperModule} = NativeModules;
    console.log(ReactWrapperModule);
    ReactWrapperModule.setUserName('rn_test'); // 유저 이름 설정
    ReactWrapperModule.setCoppa(0);            // coppa 설정
    ReactWrapperModule.showOfferwallWithAtt(); // 오퍼월 실행(iOS의 경우 att 팝업 호출 후 오퍼월로 이동)
  }}
/>
```



