# claude.formosa 活動網站規格

本文是網站的唯一規格來源。所有決定都已定案，實作時直接依此進行；若實作中發現與現實素材衝突，先回報再改規格，不要在程式裡默默偏離。

---

## 1. 目標

這個網站只有一個任務，其餘一切決定都服從它：

1. **主要** — 招募新的參加者。讓一個從未聽過 claude.formosa 的人，在不點任何連結的情況下，看完首頁就知道這是什麼、在哪裡、什麼時候、要不要來。
2. **次要** — 作為社群公信力的存在，可作為 Anthropic 參考 Community Ambassador 的依據。

非目標（明確排除）：不做報名系統、不做檔案庫式的完整紀錄、不做社群數據統計。

---

## 2. 原始需求（保留）

- 可以同時在電腦與手機上使用
- 需要中英文雙語
- Discord 的連結在電腦版上還需要顯示對應的 QR code 供手機掃描，手機版則不顯示 QR code
- 網站風格參考 [Tesla](https://tesla.com/)
- 資料內的 Video 可以應用
- 不是每一張照片跟每一個影片都要編入網站，可以選擇部份內容達成圖文平衡，內容不會貧乏但也不會過多
- 過去的每一場 event 都應該有自己的一頁來讓大家回顧
- 提供資料的文字不要照單全收，應該要經過修飾並且要有一致性
- 文字語氣參考 **samson-voice** skill

---

## 3. 內容原則

### 3.1 素材與內容的分界

`held_events/`、`videos/` 內的一切都是**未整理的原始素材**，不是網站內容。網站內容一律另外撰寫，放在 Jekyll 的內容層（見 §5）。`held_events/` 永遠保持原封不動。

### 3.2 改寫的尺度

- **散文全部重新撰寫**。不照抄 email 摘要的句子，為網站重新安排文宣，四場活動的語氣必須一致。
- **事實與連結原樣保留**：講者姓名、所屬機構、簡報連結、GitHub／YouTube／個人網站連結，一律照搬，不改寫、不省略。這些是真實的人的貢獻，替他們曝光是最低的禮貌。
- **不得編造**任何數字、人數、引述或成果。
- **長內容不進網站**：Tina Lin 的九節穿搭提示詞、陳紹慶的 Ethan Mollick 摘要表格這類原文，只以一句話帶過（例如「當天分享了可直接使用的提示詞範本」）。它們屬於 email 摘要，會破壞頁面的視覺節奏。

### 3.3 已知的素材缺口

- **2026-05-22 沒有活動摘要**，但講者資料在 `event_reminder.txt` 裡（Samson Chen 講 Claude Design 到 Claude Code，Sophie Lin 講用 Claude 整理知識庫）。該頁照常列出講者，只是分享者人數較少、沒有外部連結，頁面自然比其他三場短。
- **三位召集人沒有照片**。先用首字母佔位圖上線（見 §7.5）。
- `held_events/2026-08-28/海報/claude.formosa.8-28.png` **其實是一張 QR code**（當時的報名表單），不是海報，不要當成海報使用。

---

## 4. 網站結構

共 5 頁，沒有活動列表頁、沒有關於頁。

| 頁面 | URL | 說明 |
| :--- | :--- | :--- |
| 首頁 | `/` | 宗旨、過去活動、下一場、召集人、社群連結全部在這裡 |
| 活動頁 ×4 | `/events/2026-05-22/` 等 | 每場一頁 |

### 4.1 首頁分區（順序即為此）

1. **Hero** — 全螢幕循環影片，疊上社群名 `claude.formosa`、一句話定位、一個 Discord 按鈕。全站唯一的滿版視覺。
2. **這是什麼** — 宗旨四點，四欄並排，每欄一個短標題 + 一行說明，**去掉 emoji**。內容來源為原始提案的四點（推廣真實正確的 AI 知識／倡導 AI 治理與安全使用／實戰經驗分享交流／推廣 Anthropic 生態系）。
3. **過去活動** — **純文字列表**，每列為日期 + 主題 + 講者數，連到各活動頁。不放縮圖。
4. **下一場活動** — 只顯示最近一場（2026-10-30）。日期、時間、場地、費用以表格或並排資料呈現，不用散文。附一行：「報名將於活動前在 Discord 與 Threads 公告。」
5. **召集人** — 純文字三欄 + 首字母佔位圖：Samson Chen／科技公司技術長、Shinru Wang／資深產品經理、Sophie Lin／資深系統架構師。不放個人連結。
6. **Discord** — Discord 連結按鈕；**桌機版**額外顯示 QR code，手機版不顯示。
7. **頁尾** — 社群三連結（Discord／Threads／Instagram）、場地致謝（花蓮雲基地、花蓮縣政府）、版權年份。**不放退訂信箱**。

首頁除 hero 影片外不放照片，所有照片都在活動頁。

### 4.2 活動頁結構

海報 → 導言（一段，重寫）→ 講者逐位（姓名／主題／外部連結）→ 照片區 → 底部導覽（上一場／下一場／回到首頁）。

- **不放**當場的特殊狀況列（6/26 的大雨、8/28 的颱風延期預案等）。
- 2026-08-28 一頁額外包含影片 `20.03.29`（見 §6.2）。

### 4.3 導覽

頂部固定列：左為站名（連回首頁），右為語言切換。活動頁底部有上一場／下一場與回到首頁。

---

## 5. 技術與內容層

### 5.1 技術選型

**Jekyll**，使用 GitHub Pages 的原生 build，**不使用 GitHub Actions**。因此只能使用 Pages 白名單內的插件 —— 特別是**沒有任何圖片處理能力**，所有圖片與影片衍生檔必須預先產生並 commit（見 §6）。

### 5.2 雙語機制

中英兩種語言**同時輸出到 HTML**，以前端 JavaScript 切換顯示。

- 預設語言**依瀏覽器語言自動判斷**
- 語言狀態寫進 URL query（`?lang=en`），使英文版可被單獨連結分享（對 Anthropic 與國際講者是必要的）
- 以 `localStorage` 記住使用者的選擇
- 語言切換鈕位於頂部固定列，任何位置都可及

技術後果：每一段文字的中英兩版都必須成對存在於內容檔與 DOM 中。

### 5.3 內容層

每場活動一個 collection 檔，**一場活動的事實只存在一份**，中英文以成對欄位並存，避免兩份檔案日後不一致。

```
_config.yml
_data/
  i18n.yml            # 介面文字（nav、按鈕、區塊標題）中英成對
  site.yml            # 社群連結、場地、下一場活動資訊
_events/
  2026-05-22.md
  2026-06-26.md
  2026-07-31.md
  2026-08-28.md
_layouts/   _includes/
assets/
  css/  js/
  img/events/<date>/  img/posters/  img/organizers/  img/qr/
  video/
index.html
scripts/build-assets.sh
```

`_events/*.md` 的 frontmatter 形狀：

```yaml
date: 2026-08-28
title:   { zh: "...", en: "..." }
intro:   { zh: "...", en: "..." }
speakers:
  - name: Edward Kennedy
    topic: { zh: "...", en: "..." }
    links:
      - { label: "簡報", url: "https://latentwill.com/presentations/" }
photos:  [ "18.09.31.jpg", "19.22.55.jpg" ]
video:   "2026-08-28-2003.mp4"   # 選填
poster:  "2026-08-28.jpg"
```

collection 設定為 `output: true`、`permalink: /events/:name/`。

**新增一場活動必須只是新增一個檔案**，不得需要修改模板。

---

## 6. 媒體處理

### 6.1 Hero 影片

來源 `videos/2026-08-28 18.10.08.mp4`（1920×1080、10.0 秒、4.5 Mbps）。選它是因為畫面拍到的是**坐滿的台下**，而非單一講者特寫。

處理：縮至 720p、24 fps、**去除音軌**、正放 + 倒放接成 20 秒無縫循環（原片為緩慢平移，倒放不可察覺），CRF 32，實際輸出 1.47 MB，並輸出首帧 poster 圖。

```bash
ffmpeg -i "videos/2026-08-28 18.10.08.mp4" \
  -filter_complex "[0:v]scale=-2:720,fps=24,split[a][b];[b]reverse[r];[a][r]concat=n=2:v=1[v]" \
  -map "[v]" -an -c:v libx264 -crf 32 -preset veryslow -pix_fmt yuv420p -movflags +faststart \
  assets/video/hero.mp4
ffmpeg -ss 0 -i assets/video/hero.mp4 -frames:v 1 assets/img/hero-poster.jpg
```

播放屬性：`autoplay muted loop playsinline preload="metadata"`，並指定 `poster`。

### 6.2 活動頁影片

`videos/2026-08-28 20.03.29.mp4` 放進 2026-08-28 活動頁。**不自動播放**、保留聲音、顯示播放控制項。它只屬於該場活動，不得出現在其他頁面。

### 6.3 圖片

Jekyll 在 Pages 上無圖片管線，**衍生檔一律預先產生並 commit 到 `assets/`**，原始檔留在 `held_events/` 不動。

- 海報：寬 1200
- 照片：寬 1600
- 每張額外產生 WebP，以 `<picture>` 提供
- 工具：`sips -Z <寬度>` 與 `cwebp -q 80`（本機已具備）
- 腳本收在 `scripts/build-assets.sh`，素材清單在 `scripts/assets.tsv`

預估 repo 增加 3–5 MB，遠低於 Pages 限制（單檔 100 MB、建議 repo 1 GB、每月 100 GB 流量）。

### 6.4 照片挑選

每場活動頁**上限 6 張**，由實作者挑選，原則：

- 優先講者台上照與現場全景
- 去掉連拍重複（例如 08-28 的 `19.22.55` 與 `19.22.58` 僅相差 3 秒）
- 現有張數：05-22 三張、06-26 六張、07-31 五張、08-28 十張 → 08-28 減為 6 張
- 實際入選由 `scripts/assets.tsv` 記錄；08-28 捨棄 `18.09.31`、`19.22.55`、`19.58.56` 之外的連拍重複與構圖相近者

照片與影片**照原樣使用**，不做去識別化處理。

---

## 7. 視覺設計

### 7.1 風格定義

「Tesla 風格」在此具體指兩件事：

- **克制的排版系統** — 大量留白、極少顏色、極細線條、依靠字級與間距而非裝飾建立層次
- **全螢幕視覺**，但**只用在首頁 hero 一處**。素材現實（24 張照片、2 支影片）撐不起每區一張滿版大圖，硬做會讓同一批照片被反覆使用

動效維持最低限度（僅必要的淡入）。過多動效是「像範本」的最強訊號。

### 7.2 顏色

黑、白、灰為主；唯一重點色為 Claude 橘 `#D97757`。**只做亮色模式**，不支援 `prefers-color-scheme: dark` —— 核心素材（活動照片、白底直式海報）都是為亮底而生。

### 7.3 字體

系統字體堆疊，不載入任何外部字體：

```css
font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "PingFang TC",
             "Noto Sans TC", "Microsoft JhengHei", sans-serif;
```

### 7.4 識別

- 站名：`claude.formosa`
- favicon：自製文字圖示（Claude 橘底 + 白色 `cf`）。日後有正式 logo 可直接替換
- OG 分享圖：hero 影片的 poster 首帧（活動現場照比海報更能說明這是什麼，直式海報在 1.91:1 的框裡會被裁壞）

### 7.5 召集人佔位圖

純色圓形 + 姓名首字母。三張正式照片到位時直接替換檔案，版面不需更動。照片請盡量同構圖：正方形、半身、背景乾淨。

### 7.6 QR code

Discord 邀請連結固定不變，**預先產生一張 SVG QR code** commit 到 `assets/img/qr/`，靜態引用。不在前端載入 QR 函式庫。僅桌機版顯示。

---

## 8. Page Hosting

使用本 repository 以 **GitHub Pages** hosting，分支 `main`，Jekyll 原生 build。

完成後**直接推 `main` 並啟用 Pages**，網站即刻上線，後續再迭代。（注意：repo 為 public，啟用 Pages 等同對外發布，包含含人臉的照片與影片。）

---

## 9. 每月新增一場活動的步驟

這是本網站唯一會反覆發生的維護動作，執行者可能是不同的 Claude session 或不同的召集人。

1. 在 `held_events/YYYY-MM-DD/` 放入該場的原始素材（摘要、通知、海報、照片），保持原樣。
2. 挑選照片（上限 6 張，原則見 §6.4），跑 `scripts/build-assets.sh` 產生壓縮衍生檔到 `assets/img/events/YYYY-MM-DD/`；海報同樣處理。
3. 新增 `_events/YYYY-MM-DD.md`，依 §5.3 的 frontmatter 形狀填寫。文案**重新撰寫**（§3.2），語氣依 **samson-voice** skill，中英成對。
4. 更新 `_data/site.yml` 的「下一場活動」為再下一場的日期（見 `claude.formosa-profile.md`）。
5. 若該場有值得放的影片，依 §6.2 處理後填入 `video:` 欄位。
6. Commit、推上 `main`，Pages 自動 build。確認頁面在桌機與手機、中英兩種語言下都正常。

**不需要修改任何模板。** 若發現必須改模板才能新增一場活動，那是模板的缺陷，應該修掉。

---

## 10. GitHub Access

- Use the `gh` CLI for GitHub operations (PRs, issues, Actions runs). Don't use the GitHub connector tools unless gh can't do it.
- When making CLAUDE.md, put this instruction there.

---

## 11. Other Reference

- Basic organizer information: [claude.formosa profile](./claude.formosa-profile.md)
- Why we organize this: [claude.formosa original proposal](./claude.formosa.hualien%20v2.txt)
- [Held Events](./held_events/)
- [Selected Event Videos](./videos/)
