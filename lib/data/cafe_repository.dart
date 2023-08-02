import 'cafe_model.dart';

class CafeRepository {

  List<Cafe> cafes = [
    Cafe(
      name: 'Cafe 1',
      address: '123 Street, City',
      distance: 1.2,
      openingTime: '08:00',
      closingTime: '20:00',
      holidays: 'Sunday',
      images: [
        'https://example.com/images/cafe1_1.jpg',
        'https://example.com/images/cafe1_2.jpg',
      ],
    ),
    Cafe(
      name: 'Cafe 2',
      address: '456 Street, City',
      distance: 2.3,
      openingTime: '09:00',
      closingTime: '21:00',
      holidays: 'Monday',
      images: [
        'https://example.com/images/cafe2_1.jpg',
        'https://example.com/images/cafe2_2.jpg',
      ],
    ),
    // Add more cafes as necessary...
  ];


}