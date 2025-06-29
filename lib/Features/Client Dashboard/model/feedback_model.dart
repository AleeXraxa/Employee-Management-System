import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String? id;
  final String comment;
  final int rating;
  final String givenBy;
  final DateTime givenAt;

  FeedbackModel({
    this.id,
    required this.comment,
    required this.rating,
    required this.givenBy,
    required this.givenAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'rating': rating,
      'givenBy': givenBy,
      'givenAt': Timestamp.fromDate(givenAt),
    };
  }

  factory FeedbackModel.fromMap(String id, Map<String, dynamic> map) {
    return FeedbackModel(
      id: id,
      comment: map['comment'] ?? '',
      rating: (map['rating'] as num).toInt(),
      givenBy: map['givenBy'] ?? 'Unknown',
      givenAt: map['givenAt'] != null
          ? (map['givenAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
