

import 'package:flutter/material.dart';

List<Step> steps = [
  Step(
    title: Text('Step 1'),
    content: Text('Hello!'),
    isActive: true,
  ),
  Step(
    title: Text('Step 2'),
    content: Text('World!'),
    isActive: true,
  ),
  Step(
    title: Text('Step 3'),
    content: Text('Hello World!'),
    state: StepState.complete,
    isActive: true,
  ),
];