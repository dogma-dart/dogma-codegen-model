// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/view.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/query.dart';

import '../../matcher.dart';
import 'model_class_view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a view over [ClassMetadata] for model data.
class ModelLibraryView extends MetadataView<LibraryMetadata> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  final List<ModelClassView> models;

  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  /// Creates and instance of [ModelLibraryView] from the [metadata].
  factory ModelLibraryView(LibraryMetadata metadata) {
    var models = libraryMetadataQueryAll/*<ClassMetadata>*/(
        metadata,
        modelViewMatch,
        includeClasses: true
    ).map/*<ModelClassView>*/((clazz) => new ModelClassView(clazz)).toList();

    return new ModelLibraryView._(metadata, models);
  }

  /// Creates an instance of [ModelClassView] from the [metadata].
  ModelLibraryView._(LibraryMetadata metadata, this.models)
      : super(metadata);
}
