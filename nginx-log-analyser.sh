#!/bin/bash

# ===========================================================
# Simple Nginx/Apache Log Analyzer
# Usage: ./analyze_nginx_log.sh /path/to/access.log
# ===========================================================

LOGFILE="$1"

# --- Validasi input ---
if [ -z "$LOGFILE" ]; then
  echo "❌ Usage: $0 /path/to/access.log"
  exit 1
fi

if [ ! -f "$LOGFILE" ]; then
  echo "❌ File not found: $LOGFILE"
  exit 1
fi

echo "==========================================="
echo "Analyzing log file: $LOGFILE"
echo "==========================================="
echo

# --- 1️⃣ 5 IP dengan permintaan terbanyak ---
echo "🌐 Top 5 IP addresses:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

# --- 2️⃣ 5 Jalur (URL path) yang paling sering diminta ---
echo "📄 Top 5 requested paths:"
awk '{print $7}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

# --- 3️⃣ 5 Kode status HTTP terbanyak ---
echo "⚙️  Top 5 HTTP status codes:"
awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

# --- 4️⃣ 5 User-Agent terbanyak ---
echo "🧭 Top 5 User Agents:"
awk -F\" '{print $6}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

echo "✅ Analysis complete."