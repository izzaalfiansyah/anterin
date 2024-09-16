formatDistance(num meter) {
  if (meter > 1000) {
    final km = meter / 1000;
    return "${km.toStringAsFixed(1)}km";
  }

  return "${meter.toStringAsFixed(1)}m";
}
