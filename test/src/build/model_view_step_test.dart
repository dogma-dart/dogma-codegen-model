// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen_test/model.dart';
import 'package:test/test.dart';

import 'package:dogma_codegen_model/build.dart';
import 'package:dogma_codegen_model/view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  test('ModelImplicit', () {
    var modelViewStep = new ModelViewStep();
    var library = modelImplicitLibrary();
    var modelLibraryView = modelViewStep.view(library) as ModelLibraryView;

    expect(modelLibraryView, isNotNull);
    expect(modelLibraryView.models, hasLength(1));

    var model = modelLibraryView.models[0];

    expect(model.metadata.name, equals(modelImplicitName));
    expect(model.isImplicit, isTrue);
    expect(model.isExplicit, isFalse);
    expect(model.serializableFields, hasLength(7));
  });
  test('ModelExplicit', () {
    var modelViewStep = new ModelViewStep();
    var library = modelExplicitLibrary();
    var modelLibraryView = modelViewStep.view(library) as ModelLibraryView;

    expect(modelLibraryView, isNotNull);
    expect(modelLibraryView.models, hasLength(1));

    var model = modelLibraryView.models[0];

    expect(model.metadata.name, equals(modelExplicitName));
    expect(model.isImplicit, isFalse);
    expect(model.isExplicit, isTrue);
    expect(model.serializableFields, hasLength(7));
  });
}
