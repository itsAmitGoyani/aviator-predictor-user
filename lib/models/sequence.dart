class Sequence{
  final String id;
  final double seq;
  const Sequence (
      {
        required this.seq,
        required this.id,
      });

  factory Sequence.fromJson(Map<dynamic, dynamic> json) =>
      Sequence(
        seq: double.parse(json['seq'].toString()),
        id: json['id'].toString(),
      );
}


class SequenceData    {
  final double seq;
  const SequenceData (
      {
        required this.seq,
      });

  factory SequenceData.fromJson(Map<dynamic, dynamic> json) =>
      SequenceData(
        seq: double.parse(json['seq'].toString()),
      );
}