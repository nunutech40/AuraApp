#!/bin/bash
# ============================================================
# AuraApp iOS Reset Script
# Jalankan script ini setiap kali build iOS bermasalah.
# Usage: ./reset_ios.sh
# ============================================================

set -e  # Berhenti jika ada command yang gagal
export LANG=en_US.UTF-8

echo "🧹 [1/6] Flutter clean..."
fvm flutter clean

echo "📦 [2/6] Flutter pub get..."
fvm flutter pub get

echo "🗑️  [3/6] Hapus artifacts CocoaPods lama..."
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf ios/Runner.xcworkspace

echo "🗄️  [4/6] Hapus DerivedData Xcode yang korup..."
rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
rm -rf ~/Library/Developer/Xcode/DerivedData/SDKStatCaches.noindex
rm -rf ~/Library/Developer/Xcode/DerivedData/Runner-*
rm -rf ~/Library/Developer/Xcode/DerivedData/Pods-*

echo "🔧 [5/6] Pod install ulang..."
cd ios && pod install && cd ..

echo "🚀 [6/6] Selesai! Siap build. Jalankan: fvm flutter run"
echo "✅ Reset selesai."
