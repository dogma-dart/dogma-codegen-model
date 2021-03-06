// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'src/build/model_view_step_test.dart' as model_view_step_test;
import 'src/build/predefined_model_builder_test.dart' as predefined_model_builder_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  group('ModelViewStep', model_view_step_test.main);
  group('PredefinedModelBuilder', predefined_model_builder_test.main);
}
