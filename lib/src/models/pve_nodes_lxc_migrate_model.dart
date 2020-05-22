import 'package:built_value/built_value.dart';

part 'pve_nodes_lxc_migrate_model.g.dart';

abstract class PveNodesLxcMigrateModel
    implements Built<PveNodesLxcMigrateModel, PveNodesLxcMigrateModelBuilder> {
  bool get running;

  PveNodesLxcMigrateModel._();
  factory PveNodesLxcMigrateModel(
          [void Function(PveNodesLxcMigrateModelBuilder) updates]) =
      _$PveNodesLxcMigrateModel;
}
