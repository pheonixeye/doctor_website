import 'package:flutter/material.dart';

/// The top left corner.
const Alignment topLeft = Alignment(-1.0, -1.0);

/// The center point along the top edge.
const Alignment topCenter = Alignment(0.0, -1.0);

/// The top right corner.
const Alignment topRight = Alignment(1.0, -1.0);

/// The center point along the left edge.
const Alignment centerLeft = Alignment(-1.0, 0.0);

/// The center point, both horizontally and vertically.
const Alignment center = Alignment(0.0, 0.0);

/// The center point along the right edge.
const Alignment centerRight = Alignment(1.0, 0.0);

/// The bottom left corner.
const Alignment bottomLeft = Alignment(-1.0, 1.0);

/// The center point along the bottom edge.
const Alignment bottomCenter = Alignment(0.0, 1.0);

/// The bottom right corner.
const Alignment bottomRight = Alignment(1.0, 1.0);

Alignment alignmentFromString(String value) {
  return switch (value) {
    'topLeft' => topLeft,
    'topCenter' => topCenter,
    'topRight' => topRight,
    'centerLeft' => centerLeft,
    'center' => center,
    'centerRight' => centerRight,
    'bottomLeft' => bottomLeft,
    'bottomCenter' => bottomCenter,
    'bottomRight' => bottomRight,
    _ => throw UnimplementedError(),
  };
}
