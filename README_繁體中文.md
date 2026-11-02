# 長輩大字時鐘：iPhone 原生 App + 待機模式農曆 Widget（方案 B）

## 這份專案包含

- **長輩大字時鐘 App**：開啟 App 時顯示時間、國曆、星期與農曆；橫放左右各 50%，直放上下各 50%。
- **長輩大字農曆 Widget**：使用 Apple WidgetKit 的 `.systemSmall` 小工具，在 iPhone StandBy（待機模式）右側顯示國曆、星期與農曆。
- **左側時鐘**：建議在待機模式選 Apple 自帶「時鐘」小工具，較能保證時間即時顯示。第三方 WidgetKit 小工具並非持續執行，無法承諾每分鐘任意重繪自訂時鐘。
- **完全離線**：日期使用 iPhone 內建 Calendar（農曆）計算，不使用 GitHub、API 或伺服器。

## 最重要的限制

這不是能靠 GitHub Pages 安裝的網站。**必須有 macOS + Xcode（自己的、借用的或合法雲端 Mac）來編譯與簽署**，再安裝到 iPhone。

- 免費 Apple Account + Xcode 的 Personal Team 可測試個人裝置，但簽署通常每 7 天到期，須重新簽署安裝。
- 需長期正常使用或給其他家庭成員安裝，應研究 Apple Developer Program 與正式配送方式；不是把 `.ipa` 放上 GitHub 就能隨意安裝。
- 一般 iPhone StandBy 需要充電、鎖定、橫放且保持不動。非 Always-On iPhone 的畫面可能熄滅。
- Widget 由 iOS 管理，字體、背景、顏色和更新頻率可能受待機顯示模式影響。

## 在 Mac 上建立／安裝（Xcode 15 或更新版，iOS 17+）

1. 把這個資料夾複製到 Mac。雙擊 `ElderStandBy.xcodeproj`。
2. 在 Xcode 的 TARGETS 中選 `ElderStandByApp` → Signing & Capabilities → Team，選自己的 Apple Account（Personal Team 亦可）；再對 `ElderCalendarWidget` 選同一個 Team。
3. 將 App 的 Bundle Identifier 改為獨一無二，例如 `com.yourname.elderstandby`，Widget 改為 `com.yourname.elderstandby.widget`；注意 Widget ID 必須以前者加一段後綴開頭。
4. 將 iPhone 用 USB 接到 Mac，允許「信任此電腦」。iPhone 如提示 Developer Mode，依指示開啟。Xcode 上方選你的 iPhone。
5. 選 `ElderStandByApp` Scheme，按 ▶ Run。安裝好後，先在手機開啟 App 一次。
6. iPhone 設定 → 待機模式（StandBy）→ 開啟。接上充電器、鎖定畫面、橫放。
7. 切到左右小工具畫面，長按畫面進入編輯。左側選 Apple「時鐘」，右側按 + 搜尋「長輩大字農曆」，加入。按完成；必要時關閉智慧型輪替／Widget 建議，避免畫面自己換掉。

## 程式碼說明

- `Shared/CalendarInfo.swift`：計算台灣時間、國曆、農曆與星期。
- `ElderStandByApp/ContentView.swift`：App 全螢幕大字視圖。
- `ElderCalendarWidget/ElderCalendarWidget.swift`：待機小工具，每日更新日期，無需連網。
- `ElderStandBy.xcodeproj`：Xcode 專案與 App／Widget 兩個 targets。

## 如果沒有 Mac

你可以先保留這份程式；Windows 可以編輯、上傳 GitHub 當作原始碼備份，但 GitHub Pages **無法直接把這份原生程式安裝成 Widget**。後續需要 Mac 或有 macOS 建置及 Apple 簽署能力的服務。原本的 PWA 仍然可以在 Windows 下持續更新。

## 尚未完成的測試

本專案已備好原始碼與 Xcode 專案結構，但目前沒有 macOS / Xcode 編譯與 iPhone 實機測試環境，因此**尚未確認編譯及實機待機畫面效果**。
