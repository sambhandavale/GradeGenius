String truncateText(String text, int limit) {
  if (text.length <= limit) {
    return text;
  } else {
    return '${text.substring(0, limit)}...';
  }
}
