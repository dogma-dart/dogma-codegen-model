// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/view.dart';
import 'package:dogma_convert/serialize.dart';
import 'package:dogma_source_analyzer/metadata.dart';

import 'serialization_mode.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a view over [EnumMetadata] for model data.
class ModelEnumView extends MetadataView<EnumMetadata> with SerializationMode {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  @override
  final bool isImplicit;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [ModelEnumView] from the [metadata].
  ///
  /// This constructor assumes that the [metadata] is a valid enum. It does
  /// not do any verification.
  factory ModelEnumView(EnumMetadata metadata) {
    var annotation = metadata.annotations.firstWhere(
        (value) => value is Serialize,
        orElse: () => null
    );

    var isImplicit = annotation == null;

    return new ModelEnumView._(metadata, isImplicit);
  }

  /// Creates an instance of [ModelEnumView] from the [metadata].
  ModelEnumView._(EnumMetadata metadata, this.isImplicit)
      : super(metadata);
}
