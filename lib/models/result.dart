class Result {
  final Duration totalTime;
  final double totalDistance;    // in kilometers
  double averageVelocity;        // in km/h

  Result({ this.totalTime, this.totalDistance }) {
    double timeInHours = totalTime.inMicroseconds.toDouble() / Duration.microsecondsPerHour;
    this.averageVelocity = totalDistance / timeInHours;
    print('### 4: Average Velocity = ${this.averageVelocity}');
  }
}
