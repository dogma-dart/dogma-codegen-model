// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/build.dart';
import 'package:dogma_source_analyzer/metadata.dart';

import 'model_codegen_step.dart';
import 'model_view_step.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Builder for predefined model metadata.
///
/// The [PredefinedModelBuilder] can be used to generate source code from
/// [LibraryMetadata] that was created in code. It can also be used to test
/// the build pipeline for [SourceBuilder]s that rely on the output of model
/// data.
class PredefinedModelBuilder extends SourceBuilder<TargetConfig>
                                with PredefinedMetadataStep,
                                     ModelViewStep,
                                     SkipViewGenerationStep,
                                     ModelCodegenStep {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  @override
  final LibraryMetadata library;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [PredefinedModelBuilder] with the given [config]
  /// which uses predefined [library] metadata.
  PredefinedModelBuilder(BuilderConfig config, this.library)
      : super(config);
}
