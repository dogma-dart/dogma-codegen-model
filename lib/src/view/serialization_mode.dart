// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Describes how the serialization is performed.
abstract class SerializationMode {
  /// Whether the serialization is implicit.
  bool get isImplicit;
  /// Whether the serialization is explicit.
  bool get isExplicit => !isImplicit;
}
