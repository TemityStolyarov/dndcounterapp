int modifier(int attr) {
  if (attr >= 30) return 10;
  if (attr >= 28) return 9;
  if (attr >= 26) return 8;
  if (attr >= 24) return 7;
  if (attr >= 22) return 6;
  if (attr >= 20) return 5;
  if (attr >= 18) return 4;
  if (attr >= 16) return 3;
  if (attr >= 14) return 2;
  if (attr >= 12) return 1;
  if (attr >= 10) return 0;
  if (attr >= 8) return -1;
  if (attr >= 6) return -2;
  if (attr >= 4) return -3;
  if (attr >= 2) {
    return -4;
  } else {
    return -5;
  }
}
