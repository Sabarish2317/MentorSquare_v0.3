part of 'aff_favs_bloc.dart';

@immutable
sealed class AffFavsEvent {}

class AffFavsFetchEvent extends AffFavsEvent {
  AffFavsFetchEvent({
    required this.favourites,
    required this.staffId,
  });

  final Map<String, String> favourites;
  final String? staffId;

  factory AffFavsFetchEvent.fromJson(Map<String, dynamic> json) {
    return AffFavsFetchEvent(
      favourites: Map<String, String>.from(json["favourites"]),
      staffId: json["staff_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "favourites": favourites,
        "staff_id": staffId,
      };

  @override
  String toString() {
    return "$favourites, $staffId";
  }
}
