// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_convert/serialize.dart';
import 'package:dogma_codegen/view.dart';
import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Provides a view over [FieldMetadata] for serialization.
class SerializableFieldView extends MetadataView<FieldMetadata> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The serialization annotation.
  final Serialize _serializeAnnotation;

  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  /// Creates an instance of [SerializableFieldView] from the [metadata].
  ///
  /// This constructor assumes that the [metadata] is a valid field. It does
  /// not do any verification.
  factory SerializableFieldView(FieldMetadata metadata) {
    // Use the annotation or create a new annotation
    var annotation = metadata.annotations.firstWhere(
        (value) => value is Serialize,
        orElse: () => new Serialize.field(metadata.name)
    );

    return new SerializableFieldView._(metadata, annotation);
  }

  /// Creates an instance of [SerializableFieldView] from the [metadata].
  SerializableFieldView._(FieldMetadata metadata, this._serializeAnnotation)
      : super(metadata);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the field should be decoded.
  bool get decode => _serializeAnnotation.decode;
  /// Whether the field should be encoded.
  bool get encode => _serializeAnnotation.encode;
  /// The name to use when serializing.
  ///
  /// If the serialization name was specified on the annotation that will be
  /// used; otherwise this will return the same value as [name].
  String get serializationName => _serializeAnnotation.name;
  /// The function to use when decoding.
  String get decodeUsing => _serializeAnnotation.decodeUsing;
  /// The function to use when encoding.
  String get encodeUsing => _serializeAnnotation.encodeUsing;
  /// Whether the field is optional.
  bool get optional => _serializeAnnotation.optional;
  /// The default value for the field.
  ///
  /// This is only valid if [optional] is set to true.
  dynamic get defaultsTo => _serializeAnnotation.defaultsTo;
}
