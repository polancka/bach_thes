import 'package:flutter/material.dart';
import 'models/peak.dart';
import 'mock_database/mock_peak.dart';
import 'package:bach_thes/peak_list';

void main() {
  final List<Peak> mockPeaks = MockPeak.FetchAll();

  return runApp(MaterialApp(home: PeakList(mockPeaks)));
}
