class OrderStatus {
  final String label;
  final String text;

  OrderStatus({
    required this.label,
    required this.text,
  });
}

List<OrderStatus> orderStatus = [
  OrderStatus(label: 'pending', text: 'Menunggu'),
  OrderStatus(label: 'ready', text: 'Disiapkan'),
  OrderStatus(label: 'process', text: 'Proses'),
  OrderStatus(label: 'completed', text: 'Selesai'),
  OrderStatus(label: 'canceled', text: 'Dibatalkan'),
];
