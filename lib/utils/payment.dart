double getOngkir(double distance) {
  double payPerKm = 5000;

  double ongkir = distance / 1000 * payPerKm;
  ongkir = ((ongkir + 250) ~/ 500) * 500;

  return ongkir;
}
