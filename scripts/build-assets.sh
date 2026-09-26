#!/usr/bin/env bash
# 從 held_events/ 與 videos/ 的原始素材產生網站用的壓縮衍生檔。
# GitHub Pages 的 Jekyll 沒有圖片管線，所有衍生檔必須預先產生並 commit。
#
# 用法：./scripts/build-assets.sh
# 依賴：sips（macOS 內建）、cwebp、ffmpeg、python3 + segno
set -euo pipefail
cd "$(dirname "$0")/.."

POSTER_W=1200
PHOTO_W=1600
WEBP_Q=80
DISCORD_URL="https://discord.gg/fWcPCyMBta"

log() { printf '  %s\n' "$*"; }

# ---------- 圖片 ----------
echo "圖片"
last_event=""
n=0
while IFS=$'\t' read -r kind event src; do
  [[ "$kind" =~ ^#|^$ ]] && continue
  [[ -f "$src" ]] || { echo "  缺少素材：$src" >&2; exit 1; }
  if [[ "$event" != "$last_event" ]]; then last_event="$event"; n=0; fi
  case "$kind" in
    poster)
      out="assets/img/posters/${event}.jpg"; w=$POSTER_W ;;
    photo)
      n=$((n + 1))
      mkdir -p "assets/img/events/${event}"
      out=$(printf 'assets/img/events/%s/%02d.jpg' "$event" "$n"); w=$PHOTO_W ;;
    *) echo "  未知類型：$kind" >&2; exit 1 ;;
  esac
  sips -s format jpeg -s formatOptions 82 -Z "$w" "$src" -o "$out" >/dev/null
  cwebp -quiet -q "$WEBP_Q" "$out" -o "${out%.jpg}.webp"
  log "$out"
done < scripts/assets.tsv

# ---------- Hero 影片 ----------
# 正放 + 倒放接成無縫循環；去音軌；720p。
echo "Hero 影片"
HERO_SRC="videos/2026-08-28 18.10.08.mp4"
if [[ -f "$HERO_SRC" ]]; then
  ffmpeg -v error -y -i "$HERO_SRC" \
    -filter_complex "[0:v]scale=-2:720,fps=24,split[a][b];[b]reverse[r];[a][r]concat=n=2:v=1[v]" \
    -map "[v]" -an -c:v libx264 -crf 32 -preset veryslow -pix_fmt yuv420p -movflags +faststart \
    assets/video/hero.mp4
  ffmpeg -v error -y -ss 0 -i assets/video/hero.mp4 -frames:v 1 -q:v 3 assets/img/hero-poster.jpg
  cwebp -quiet -q "$WEBP_Q" assets/img/hero-poster.jpg -o assets/img/hero-poster.webp
  log "assets/video/hero.mp4 ($(du -h assets/video/hero.mp4 | cut -f1))"
fi

# ---------- 活動頁影片 ----------
# 不自動播放，保留聲音。
echo "活動頁影片"
TALK_SRC="videos/2026-08-28 20.03.29.mp4"
if [[ -f "$TALK_SRC" ]]; then
  ffmpeg -v error -y -i "$TALK_SRC" -vf "scale=-2:720" \
    -c:v libx264 -crf 28 -preset slow -pix_fmt yuv420p \
    -c:a aac -b:a 96k -movflags +faststart \
    assets/video/2026-08-28-talk.mp4
  ffmpeg -v error -y -ss 1 -i assets/video/2026-08-28-talk.mp4 -frames:v 1 -q:v 3 \
    assets/img/events/2026-08-28/video-poster.jpg
  log "assets/video/2026-08-28-talk.mp4 ($(du -h assets/video/2026-08-28-talk.mp4 | cut -f1))"
fi

# ---------- QR code ----------
echo "QR code"
python3 - "$DISCORD_URL" <<'PY'
import sys, segno
segno.make(sys.argv[1], error='m').save(
    'assets/img/qr/discord.svg', scale=1, border=2, dark='#111111', light=None)
print('  assets/img/qr/discord.svg')
PY

# ---------- favicon ----------
echo "favicon"
cat > assets/img/favicon.svg <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <rect width="64" height="64" rx="12" fill="#D97757"/>
  <text x="32" y="44" font-family="Helvetica,Arial,sans-serif" font-size="30"
        font-weight="600" fill="#fff" text-anchor="middle">cf</text>
</svg>
SVG
log "assets/img/favicon.svg"

echo "完成。"
