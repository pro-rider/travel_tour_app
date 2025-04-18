extension DateTimeExtensions on DateTime {
  String toFormattedString() {
    // ignore: unnecessary_this
    return "${this.year}-${this.month}-${this.day} ${this.hour}:${this.minute}:${this.second}";
  }

  DateTime addDays(int days) {
    // ignore: unnecessary_this
    return this.add(Duration(days: days));
  }

  DateTime subtractDays(int days) {
    // ignore: unnecessary_this
    return this.subtract(Duration(days: days));
  }
}
