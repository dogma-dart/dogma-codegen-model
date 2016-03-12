// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_convert/serialize.dart';
import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/query.dart';

import 'package:dogma_codegen_model/analyzer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

Serialize _fieldAnnotation(ClassMetadata clazz, String field) {
  var field = classMetadataQuery/*<FieldMetadata>*/(
      clazz,
      nameMatch('field'),
      includeFields: true
  );

  expect(field, isNotNull);
  expect(field.annotations, hasLength(1));

  var annotation = field.annotations[0];

  expect(annotation is Serialize, isTrue);

  return annotation;
}

void main() {
  var context = analysisContext();

  test('Serialize.field tests', () {
    var library = libraryMetadata(
        join('test/lib/serialize_annotation.dart'),
        context,
        annotationCreators: [analyzeSerializeAnnotation]
    );

    expect(library, isNotNull);
    expect(library.classes, hasLength(2));
    expect(library.functions, hasLength(1));
    expect(library.fields, isEmpty);

    var clazz = libraryMetadataQuery/*<ClassMetadata>*/(
        library,
        nameMatch('Foo'),
        includeClasses: true
    ) as ClassMetadata;

    expect(clazz, isNotNull);
    expect(clazz.fields, hasLength(10));

    var annotation;
    annotation = _fieldAnnotation(clazz, 'field');
    expect(annotation.name, 'field');
    expect(annotation.encode, isTrue);
    expect(annotation.decode, isTrue);
    expect(annotation.encodeUsing, isNull);
  });
  test('Serialize.values tests', () {
    var library = libraryMetadata(
        join('test/lib/serialize_annotation.dart'),
        context,
        annotationCreators: [analyzeSerializeAnnotation]
    );

    expect(library, isNotNull);

    var clazz = libraryMetadataQuery/*<ClassMetadata>*/(
        library,
        nameMatch('Color'),
        includeClasses: true
    ) as ClassMetadata;

    expect(clazz, isNotNull);
    expect(clazz.annotations, hasLength(1));

    var annotation = clazz.annotations[0];
    expect(annotation is Serialize, isTrue);

    var serialize = annotation as Serialize;
    var mapping = serialize.mapping;
    expect(mapping, isNotNull);
    expect(mapping, hasLength(3));
    expect(mapping[0xff0000], equals(0));
    expect(mapping[0x0000ff], equals(1));
    expect(mapping[0x00ff00], equals(2));
  });
  /*
  test('Serialize.using', () {
    var library = libraryMetadata(
        join('test/lib/serialize_annotation.dart'),
        context,
        annotationCreators: [analyzeSerializeAnnotation]
    );

    expect(library, isNotNull);

    var function = libraryMetadataQuery/*<FunctionMetadata>*/(
        library,
        nameMatch('decodeDateTime'),
        includeFunctions: true
    );

    expect(function, isNotNull);
    expect(function.annotations, hasLength(1));

    var annotation = function.annotations[0];
    expect(annotation is Serialize, isTrue);
    expect(annotation, Serialize.using);
  });
  */
}
