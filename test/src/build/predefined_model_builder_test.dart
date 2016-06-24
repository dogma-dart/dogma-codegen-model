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
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:test/test.dart';

import 'package:dogma_codegen_model/build.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  test('Model libraries', () async {
    var outputs = <LibraryMetadata>[
      // Model types
      model.modelImplicitLibrary(),
      model.modelExplicitLibrary(),
      model.modelOptionalLibrary(),
      model.modelRecursiveLibrary(),
      // Enum types
      model.enumImplicitLibrary(),
      model.enumExplicitLibrary(),
      // Compound type
      model.modelCompoundLibrary(),
      // Inheritance
      model.modelBaseLibrary(),
      model.modelImplementBaseLibrary(),
      model.modelExtendBaseLibrary(),
      model.modelMixinLibrary()
    ];

    var modelConfig = new BuilderConfig<TargetConfig>()
        ..libraryOutput = 'test/lib/src/model';
    var builders = <PredefinedModelBuilder>[];

    for (var library in outputs) {
      builders.add(new PredefinedModelBuilder(modelConfig, library));
    }

    await testWithPredefinedMetadata(builders, [], outputs);
  });
}
