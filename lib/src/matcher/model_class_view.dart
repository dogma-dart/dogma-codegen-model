// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Matches class metadata that can be used as a model.
MetadataMatchFunction modelViewMatch = andList([
  // Models should be concrete
  concreteMatch,
  // Models should not be generic
  not(genericClassMatch),
  // Should not have any final fields
  not(classWithFinalFieldsMatch),
  // Should have an empty default constructor
  classWithEmptyDefaultConstructor
]);

/// Checks the class [metadata] for any final fields on the instance.
bool classWithFinalFieldsMatch(Metadata metadata) {
  var fields = (metadata as ClassMetadata).fields;

  return fields.any(and(not(staticMatch), finalFieldMatch));
}

/// Checks the class [metadata] for an empty default constructor.
bool classWithEmptyDefaultConstructor(Metadata metadata) {
  var constructors = (metadata as ClassMetadata).constructors;

  return constructors.any(and(defaultConstructorMatch, emptyParametersMatch));
}
