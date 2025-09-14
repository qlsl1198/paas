# K‑Pass (paas)

Figma 디자인을 바탕으로 구현한 Flutter 애플리케이션입니다. 홈/지도/알림/로그인/스플래시 화면을 포함하며, 지도 화면은 저장한 위치 리스트와 마커 상호작용, 플로팅 액션을 제공합니다.

## 주요 기능

- 스플래시 → 로그인 → 홈 → 지도 네비게이션 플로우
- 지도(Map)
  - OpenStreetMap 기반 `flutter_map` 적용
  - 저장 위치 리스트(하단 드래그 시트)와 마커 동기화
  - 리스트 항목 탭 시 해당 좌표로 이동 및 마커 강조
  - 마커 탭 시 항목 선택 동기화
  - 플로팅 버튼
    - 나침반: 초기 중심/줌 리셋
    - 하트: 선택 위치 즐겨찾기 토글
    - 내 위치: 현재 위치로 이동(권한 필요)
- 알림/홈 화면: Figma 스타일 반영 UI

## 기술 스택

- Flutter 3.6.x
- 상태관리: provider
- 지도: flutter_map, latlong2
- 위치: geolocator
- SVG: flutter_svg

## 프로젝트 구조

```
lib/
  main.dart
  screens/
    splash_screen.dart
    login_screen.dart
    home_screen.dart
    map_screen.dart
    notification_screen.dart
  services/
    auth_service.dart
assets/images/
ios/Runner/Info.plist
android/app/src/main/AndroidManifest.xml
```

## 실행 방법

사전 요구사항
- Flutter SDK 설치, Xcode/Android Studio 설정 완료

의존성 설치
```
flutter pub get
```

iOS 시뮬레이터 실행
```
flutter run -d "iPhone 16 Pro"
```

Android 에뮬레이터 실행
```
flutter run -d emulator-XXXX   # 실제 에뮬레이터 ID로 대체
```

웹(개발용) 실행
```
flutter run -d chrome
```

### 플랫폼별 주의사항

- iOS
  - 위치 권한 문구가 `ios/Runner/Info.plist`에 추가되어 있습니다.
  - 최초 실행 시 위치 권한 팝업을 허용해야 내 위치 이동이 동작합니다.

- Android
  - 내 위치 기능을 사용할 경우 `AndroidManifest.xml`에 위치 권한 선언이 필요할 수 있습니다.
    - `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` 등

- Web
  - 내 위치는 HTTPS 또는 localhost 환경에서만 동작하며 브라우저 권한 허용이 필요합니다.
  - 하단 드래그 시트는 마우스 클릭-드래그로 조절합니다.

## 지도 화면 요약

- 하단 드래그 시트(DraggableScrollableSheet + CustomScrollView)
  - 초기/최소/최대 크기: 30% / 18% / 85%
  - 리스트 스크롤과 드래그 자연스럽게 연동
- 레이어(위에서 아래)
  1) 하단 시트(저장 위치 리스트)
  2) 플로팅 버튼(나침반/하트/내 위치)
  3) 지도(타일 + 마커)
  - 시트를 위로 올리면 버튼은 시트에 가려집니다.

## 디자인

- Figma: K-Pass 공모전 (요청 시 링크 공유)
- Figma의 간격/크기/색상/타이포를 Flutter 위젯으로 반영

## 스크립트/명령어

- 포맷터/분석기 (옵션)
```
flutter format .
flutter analyze
```

## 알려진 이슈

- 웹 실행 시 DevTools의 특정 로그 메시지가 반복 출력될 수 있습니다(지도의 타일 제공 관련 안내). 기능에는 영향 없습니다.
- 모바일에서 내 위치 이동은 OS 권한과 실제 위치 수집 상태에 따라 지연될 수 있습니다.

## 라이선스

이 저장소의 소스코드는 사내/팀 사용 목적입니다. 별도 고지 없이는 외부 배포를 제한합니다.
