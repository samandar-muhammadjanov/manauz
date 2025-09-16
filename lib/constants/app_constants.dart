class AppConstants {
  // App info
  static const String appName = 'Roza Electronics';
  static const String appTagline =
      'Telefon va noutbuklarni qulay to\'lov bilan oling';

  // API and storage
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // Shared Preferences keys
  static const String firstLaunchKey = 'is_first_launch';
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';

  // Assets
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderImage = 'assets/images/placeholder.png';

  // Animations
  static const String loadingAnimation = 'assets/animations/loading.json';
  static const String successAnimation = 'assets/animations/success.json';
  static const String emptyAnimation = 'assets/animations/empty.json';

  // Default values
  static const int defaultAnimationDuration = 300;
  static const int defaultDebounceTime = 500;

  // Form validation messages
  static const String requiredField = 'Iltimos, maydonni to\'ldiring';
  static const String invalidPhoneNumber =
      'Iltimos, to\'g\'ri telefon raqam kiriting';
  static const String invalidEmail = 'Iltimos, to\'g\'ri email manzil kiriting';

  // Routes
  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String catalogRoute = '/catalog';
  static const String productDetailsRoute = '/product-details';
  static const String orderRoute = '/order';
  static const String aboutRoute = '/about';

  // Categories
  static const List<Map<String, dynamic>> categories = [
    {'id': 'phones', 'name': 'Telefonlar', 'icon': '📱'},
    {'id': 'laptops', 'name': 'Noutbuklar', 'icon': '💻'},
  ];

  // Mock data (temporary, will be replaced with real data)
  static const List<Map<String, dynamic>> featuredProducts = [
    {
      'id': '1',
      'name': 'iPhone 14 Pro Max',
      'category': 'phones',
      'price': 11999000,
      'installmentPrice': 999917,
      'months': 12,
      'rating': 4.8,
      'reviews': 124,
      'images': [
        'https://i.pinimg.com/474x/4a/2a/26/4a2a2666202f6c71863b5fe478c4a517.jpg',
        'https://www.iport.ru/_next/image/?url=https%3A%2F%2Fcdn.iport.ru%2Fiblock%2F963%2F9634317981c1c74ee855596b779fb23a%2F90d416788c43541d8d675034bbe23d8a.jpg&w=1080&q=80',
      ],
      'specs': {
        'display': '6.7" Super Retina XDR',
        'processor': 'A16 Bionic',
        'ram': '6GB',
        'storage': '256GB',
        'camera': '48MP + 12MP + 12MP',
        'battery': '4323 mAh',
      },
      'description':
          'Eng yangi iPhone 14 Pro Max - ajoyib dizayn va kuchli imkoniyatlar',
    },
    {
      'id': '2',
      'name': 'Samsung Galaxy S23 Ultra',
      'category': 'phones',
      'price': 10999000,
      'installmentPrice': 916583,
      'months': 12,
      'rating': 4.7,
      'reviews': 98,
      'images': [
        'https://cdn1.ozone.ru/s3/multimedia-e/6562593218.jpg',
        'https://yandex-images.clstorage.net/ce56k0l85/9bc936yI/hgQnw4dX_LdMxWYYAxyrsQaAlVp2JPjQU8QRW9bVnAlDsXRB4O5BgpYNLbw3bHe1N05G5Gn9qERurA4DHpuMqRMQUqeS09lTPMU3XLO4ahHHgcGbohVZ9dMHcuwR4u_r0LP2FmeP8Ycj3SlIk0ghI8Yes1F8mI8SOQ0Y1y27GM5nJ8SB5TXtMq7WBb_BvMhh5EHgKfaELWKm9bI8UsDemVKQZ-ZkLiN0kW_KHhC7oIGyPNExjruPoCk-uXdfCZoOVCfFMrQ2fcMOJfdvQM6K0xRzYvhlR0xzl0TCHtLjzspCE9UGJjyTppIceGyACyDBcqyyouwJToE5LFjHjXmp_3eXxwPldk9Szxan7AP_6XJ1U7AoFrbuALakMwyxAm6aEPB1xgWew3fQPDlPUWkSshNf8pLvyZ6jKx-KNA4761y1B2dD9ZWuE75WBY-wruuCdFKw2hblDsGGJaJtkHDdGcFAJVfnrME2Qa_4b_BJgINzvkGz3AqMg-p-quTOeupOlAQFAcQUHMMsdeceY_zbIddCMarXRy0zlFagLGBj7rigglb2N_7jB6FtKuzC-VHQsn1hIF6IvaGKzvmGv_hKrFS2FEL3Ng3hvZaH_fAeeQJEUACo9vf9Q2THIJxRwc0LQUDHddes4feDTfv9YWoyUxDugKJPu77gClya5y35yU1UhcdDZuQ_8Y-FZh_TjFnTlKMw-NaVDsCFVAEuouOuSBHj5FeUDvA1A-4r3IArUUORnPNRHtmdQCpM2sVNqeneRgWEs9QnzoNcdnY8Qq3Ic7fTghj2Vq7zpVQyvJCQDbih4gfl139RNlL8Or6hC0IgYA6S4R2KjXH6jgkVjit6n3bGVWLVNj8jnGdnbXEc6CMFUXP5hjXe8eTEsk8zQ68L0BGExActYjZBLtmtIAghUuA_MpLcqtxQ2U7pJ45bOjzXtsaxlDa8o22HZV1B_gpTB5FgyfT3jzB0htOOwUNeo',
      ],
      'specs': {
        'display': '6.8" Dynamic AMOLED 2X',
        'processor': 'Snapdragon 8 Gen 2',
        'ram': '12GB',
        'storage': '256GB',
        'camera': '200MP + 12MP + 10MP + 10MP',
        'battery': '5000 mAh',
      },
      'description': 'Professional kamera tizimi va kuchli protsessor',
    },
  ];
}
