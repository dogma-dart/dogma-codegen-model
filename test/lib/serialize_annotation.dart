// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

import 'package:dogma_convert/serialize.dart';

class Foo {
  @Serialize.field('field')
  int field;
  @Serialize.field('optionalField', optional: true, defaultsTo: 1)
  int optionalField;
  @Serialize.decodeField('decodeField')
  int decodeField;
  @Serialize.decodeField('optionalDecodeField', optional: true, defaultsTo: 2)
  int optionalDecodeField;
  @Serialize.encodeField('encodeField')
  int encodeField;
  @Serialize.encodeField('optionalEncodeField', optional: true, defaultsTo: 3)
  int optionalEncodeField;
  @Serialize.function('functionField', encode: 'encodeFunc', decode: 'decodeFunc')
  int functionField;
  @Serialize.function('decodeFunctionField', decode: 'decodeFunc')
  int decodeFunctionField;
  @Serialize.function('encodeFunctionField', encode: 'encodeFunc')
  int encodeFunctionField;
  @Serialize.field('doNotSerialize', encode: false, decode: false)
  int doNotSerialize;
}

@Serialize.using
DateTime decodeDateTime(int value) => new DateTime.fromMicrosecondsSinceEpoch(value);

@Serialize.values(const {
  0x0000ff: Color.blue,
  0xff0000: Color.red,
  0x00ff00: Color.green
})
enum Color {
  red,
  blue,
  green
}
