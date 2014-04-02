marker() {
  MARKERS=("🌛" "☕" "🍄" "🐴" "🌎" "🍻" "🌞")
  DOW=$(date +%u)
  echo $MARKERS[$DOW]
}
