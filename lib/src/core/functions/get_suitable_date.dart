String getShortestSuitableDate(DateTime dateTime) {
  final currentDate = DateTime.now().toUtc();
  final difference = currentDate.difference(dateTime);
  if (difference.inMinutes <= 0) {
    return '${difference.inSeconds} s left';
  } else if (difference.inHours <= 0) {
    return '${difference.inMinutes} m left';
  } else if (difference.inDays <= 0) {
    return '${difference.inHours} h left';
  } else if (difference.inDays > 0 && difference.inDays < 31) {
    return '${difference.inDays} d left';
  } else if (difference.inDays > 0 && difference.inDays > 31) {
    return '${difference.inDays / 31} M left';
  } else if (difference.inDays > 365) {
    return '${difference.inDays / 365} y left';
  } else {
    return 'N/A';
  }
}

String getLongestSuitableDate(DateTime dateTime) {
  final currentDate = DateTime.now().toUtc();
  final difference = currentDate.difference(dateTime);
  if (difference.inMinutes <= 0) {
    return '${difference.inSeconds} Seconds left';
  } else if (difference.inHours <= 0) {
    return '${difference.inMinutes} Minutes left';
  } else if (difference.inDays <= 0) {
    return '${difference.inHours} Hours left';
  } else if (difference.inDays > 0 && difference.inDays < 31) {
    return '${difference.inDays} Days left';
  } else if (difference.inDays > 0 && difference.inDays > 31) {
    return '${difference.inDays / 31} Months left';
  } else if (difference.inDays > 365) {
    return '${difference.inDays / 365} Years left';
  } else {
    return 'N/A';
  }
}
