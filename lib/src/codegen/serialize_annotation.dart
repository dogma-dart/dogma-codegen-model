// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_convert/serialize.dart';
import 'package:dogma_codegen/codegen.dart';
import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Generates a serialize [annotation] for a field into the [buffer].
///
/// The generated string will only have values that differ from the default
/// named parameters of [Serialize.field].
void generateFieldAnnotation(dynamic annotation, StringBuffer buffer) {
  if (annotation is! Serialize) {
    return;
  }

  var name = annotation.name;
  var constructor = 'field';
  var argumentBuffer = new ArgumentBuffer();

  // Write the name
  argumentBuffer.write(generateString(name));

  // Get the default values
  var defaults = new Serialize.field(name);

  // See if functions are being used
  var decodeUsing = annotation.decodeUsing;
  var decodeSet = decodeUsing != defaults.decodeUsing;
  var encodeUsing = annotation.encodeUsing;
  var encodeSet = encodeUsing != defaults.encodeUsing;

  if (decodeSet || encodeSet) {
    if (decodeSet) {
      argumentBuffer.write('decode: \'$decodeUsing\'');
    }

    if (encodeSet) {
      argumentBuffer.write('encode: \'$encodeUsing\'');
    }

    constructor = 'function';
  } else {
    // See if decode is set to the default
    var decode = annotation.decode;

    if (decode != defaults.decode) {
      argumentBuffer.write('decode: $decode');
    }

    // See if encode is set to the default
    var encode = annotation.encode;

    if (encode != defaults.encode) {
      argumentBuffer.write('encode: $encode');
    }
  }

  // See if optional is set to the default
  var optional = annotation.optional;

  if (optional != defaults.optional) {
    argumentBuffer.write('optional: $optional');
  }

  // See if defaultsTo is set to the default
  var defaultsTo = annotation.defaultsTo;

  if (defaultsTo != defaults.defaultsTo) {
    var value = generateBuiltin(defaultsTo, isConst: true);

    argumentBuffer.write('defaultsTo: $value');
  }

  // Write out the declaration
  buffer.writeln('@Serialize.$constructor(${argumentBuffer.toString()})');
}

/// Generates a serialize [annotation] for an enumeration into the [buffer].
AnnotationGenerator generateValuesAnnotation(EnumMetadata metadata) {
  var enumValues = <Field>[];

  for (var enumeration in metadata.values) {
    enumValues.add(new Field(enumeration));
  }

  return (annotation, buffer) {
    if (annotation is! Serialize) {
      return;
    }

    var mapped = {};

    annotation.mapping.forEach((key, value) {
      mapped[key] = enumValues[value];
    });

    buffer.write('@Serialize.values(');
    buffer.write(generateMap(mapped, false, true));
    buffer.writeln(')');
  };
}

/// Generates a serialize [annotation] for a default function into the [buffer].
void generateUsingAnnotation(dynamic annotation, StringBuffer buffer) {
  if (annotation == Serialize.using) {
    buffer.writeln('@Serialize.using');
  }
}
