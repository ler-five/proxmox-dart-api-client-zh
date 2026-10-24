/// Snapshot of a QEMU/LXC guest.
///
/// Plain data class (no built_value) because the snapshot endpoint returns a
/// small, flat structure.
class PveGuestSnapshotModel {
  final String name;
  final String? description;
  final int? snaptime;
  final String? parent;
  final bool vmstate;

  PveGuestSnapshotModel({
    required this.name,
    this.description,
    this.snaptime,
    this.parent,
    this.vmstate = false,
  });

  factory PveGuestSnapshotModel.fromJson(Map<String, dynamic> json) {
    final vmstate = json['vmstate'];
    return PveGuestSnapshotModel(
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      snaptime: (json['snaptime'] as num?)?.toInt(),
      parent: json['parent'] as String?,
      vmstate: vmstate == 1 || vmstate == true,
    );
  }

  DateTime? get snapDateTime => snaptime != null
      ? DateTime.fromMillisecondsSinceEpoch(snaptime! * 1000).toLocal()
      : null;
}
