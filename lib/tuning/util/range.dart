class Range {
  int start;
  int end;

  Range(this.start, this.end);

  bool contains(int value) {
    return value >= start && value <= end;
  }

  get middle {
    return (start + end) ~/ 2;
  }
}
