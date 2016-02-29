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
import 'serializable_field_view.dart';
import 'serialization_mode.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a view over [ClassMetadata] for model data.
class ModelClassView extends MetadataView<ClassMetadata>
                        with SerializationMode {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  @override
  final bool isImplicit;
  /// The serializable fields on the model.
  final List<SerializableFieldView> serializableFields;

  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  /// Creates and instance of [ModelClassView] from the [metadata].
  ///
  /// This constructor assumes that the [metadata] is a valid model. It does
  /// not do any verification.
  factory ModelClassView(ClassMetadata metadata) {
    // Get all fields that are potentially serializable
    var serializableFields = classMetadataQueryAll/*<FieldMetadata*/(
        metadata,
        serializableFieldMatch,
        includeFields: true
    );

    // Get all fields that are also annotated
    var annotatedFields = serializableFields.where(serializeAnnotatedMatch);

    // Determine which set of fields to use
    var isImplicit = annotatedFields.isEmpty;
    var fields = isImplicit ? serializableFields : annotatedFields;

    // Create views over the fields
    var fieldViews = <SerializableFieldView>[];

    for (var field in fields) {
      fieldViews.add(new SerializableFieldView(field));
    }

    // Create the class
    return new ModelClassView._(metadata, isImplicit, fieldViews);
  }

  /// Creates an instance of [ModelClassView] from the [metadata].
  ModelClassView._(ClassMetadata metadata, this.isImplicit, this.serializableFields)
      : super(metadata);
}
