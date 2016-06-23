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

/// Generates source code for the enumeration [view] into the [buffer].
void generateEnum(ModelEnumView view, StringBuffer buffer) {
  var annotationGenerators = <AnnotationGenerator>[];

  if (view.isExplicit) {
    annotationGenerators.add(generateValuesAnnotation);
  }

  generateEnumDefinition(
      view.metadata,
      buffer,
      annotationGenerators: annotationGenerators
  );
}
