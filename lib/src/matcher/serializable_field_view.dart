// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_convert/serialize.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Matches field metadata that can be serialized.
MetadataMatchFunction serializableFieldMatch = andList([
  // The field cannot be static
  // This automatically rules out const
  instanceMatch,
  // The field cannot be final
  not(finalFieldMatch),
  // The field must not be a property
  // This automatically rules out abstract
  fieldMatch
]);

/// Matches [metadata] containing a [Serialize] annotation.
bool serializeAnnotatedMatch(Metadata metadata) =>
    (Metadata as AnnotatedMetadata)
        .annotations
        .any((annotation) => annotation is Serialize);
