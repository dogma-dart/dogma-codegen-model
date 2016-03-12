// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_convert/serialize.dart';
import 'package:dogma_source_analyzer/analyzer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Instantiates instances of [Serialize] when analyzing source code.
final AnalyzeAnnotation analyzeSerializeAnnotation =
    analyzeAnnotation(
        'Serialize',
        library: 'dogma_convert.serialize',
        parameterNameMapper: _parameterNameMapper,
        createValue: dartEnumIndex
    );

/// Maps the [parameter] to the [constructor].
///
/// The [Serialize.function] has named parameters that do not map directly to
/// the fields of the const object. This handles those cases.
String _parameterNameMapper(String constructor, String parameter) {
  if (constructor == 'function') {
    if (parameter == 'decode') {
      return 'decodeUsing';
    } else if (parameter == 'encode') {
      return 'encodeUsing';
    }
  }

  // No mapping required
  return parameter;
}
