# Windows 無 Mac：編譯與安裝原生 iPhone 待機小工具

這是 **SwiftUI + WidgetKit 原始碼**，不是可直接在 iPhone 開啟的網頁或現成 IPA。

## 先用 GitHub Actions 雲端 macOS 編譯

1. 在 GitHub 建立新的 **Public** Repository，例如 `elder-standby-native`。不要覆蓋原本 `elder-clock` PWA 專案。
2. 把此資料夾內的 `ElderStandBy.xcodeproj`、`ElderStandByApp`、`ElderCalendarWidget`、`Shared`、`.github` 等檔案/資料夾上傳到新 Repo 根目錄；不要只上傳 ZIP。**不要公開 Apple 密碼、憑證或設備識別碼**。
3. 在 GitHub `Actions` 找 `Build iPhone App and StandBy Widget (unsigned IPA)`，執行 `Run workflow`。第一次上傳到 `main` 也會觸發編譯。
4. 等該工作顯示綠勾後，點進該工作，在 `Artifacts` 下載 `ElderStandBy-unsigned-ipa`，解壓得到 `ElderStandBy-unsigned.ipa`。如果顯示紅叉請保留編譯錯誤；這份原始專案尚未經 Xcode 實際驗證。

## Windows 安裝（免費體驗）

1. 參照 https://faq.altstore.io/altstore-classic/how-to-install-altstore-windows 安裝 AltServer/AltStore Classic（使用官方來源）。
2. 使用 USB 連接 iPhone，在 Windows 安裝必要的 Apple 裝置驅動程式，啟用需要的信任/開發者模式。
3. 透過 AltStore Classic 選擇 `ElderStandBy-unsigned.ipa` 並簽署安裝。**務必保留小工具 extension**；Widget 需要額外 App ID。
4. 在 iPhone 開啟「長輩大字時鐘」App 一次，進入「設定 → 待機模式」啟用待機。充電、橫放、鎖定，切換至兩欄小工具頁，長按編輯：左側 Apple 時鐘，右側「長輩大字農曆」。
5. 免費 Apple ID 佈建通常 7 天到期；AltStore 須在到期前成功重新整理，否則 App／Widget 可能無法正常使用。不能保證 WidgetKit extension 用第三方簽署工具安裝一定成功，須以實機測試為準。

## 長期使用方式

若希望避免每週自行更新，可加入 Apple Developer Program（官方標示 US$99/年，可能依地區收費），再使用 Ad Hoc 裝置配送或 App Store/TestFlight。TestFlight 版本最長可測 90 天，需繼續上傳新版本。

## 限制

- GitHub Actions 在 public repository 的標準 macOS runner 免費，仍受 GitHub 的使用政策約束。
- GitHub Actions 只負責編譯，不會替你簽署 iPhone App。
- iPhone StandBy 不是 PWA 可直接替換的系統畫面；需 WidgetKit 小工具。
- 一般 iPhone 充電、橫放才會進入待機模式；是否長亮由機型與 iOS 控制。
- 資料（日期、星期、農曆）在裝置內計算，不需日常上網，安裝、簽署與更新需要網路。
