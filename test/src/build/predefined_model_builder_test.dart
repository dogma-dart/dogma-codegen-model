// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/build.dart';
import 'package:dogma_codegen_test/build.dart';
import 'package:dogma_codegen_test/model.dart' as model;
import 'package:test/test.dart';

import 'package:dogma_codegen_model/build.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  test('Model libraries', () async {
    var modelConfig = new BuilderConfig<TargetConfig>()
      ..libraryOutput = 'test/lib/src/model';

    var predefined = [
      new PredefinedModelBuilder(modelConfig, model.modelImplicitLibrary()),
      new PredefinedModelBuilder(modelConfig, model.modelExplicitLibrary()),
      new PredefinedModelBuilder(modelConfig, model.modelOptionalLibrary()),
      new PredefinedModelBuilder(modelConfig, model.modelRecursiveLibrary())
    ];

    var outputs = [
      model.modelImplicitLibrary(),
      model.modelExplicitLibrary(),
      model.modelOptionalLibrary(),
      model.modelRecursiveLibrary()
    ];

    await testWithPredefinedMetadata(predefined, [], outputs);
  });
}
