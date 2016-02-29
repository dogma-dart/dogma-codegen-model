// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/codegen.dart';

import '../../view.dart';
import 'serialize_annotation.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Generates source code for the model [view] into the [buffer].
void generateModel(ModelClassView view, StringBuffer buffer) {
  generateClassDefinition(
      view.metadata,
      buffer,
      _generateModelDefinition(view)
  );
}

/// Creates a class generator for the given model [view].
ClassGenerator _generateModelDefinition(ModelClassView view) =>
    (metadata, buffer) {
      var annotationGenerators = <AnnotationGenerator>[
        generateOverrideAnnotation
      ];

      if (view.isExplicit) {
        annotationGenerators.add(generateFieldAnnotation);
      }

      generateFields(
          metadata.fields,
          buffer,
          annotationGenerators: annotationGenerators
      );
    };
