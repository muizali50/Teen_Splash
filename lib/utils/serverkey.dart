import 'package:googleapis_auth/auth_io.dart';

class get_server_key {
  Future<String> server_token() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "teen-splah",
          "private_key_id": "4efe893b882374ab42f24cdea16281d964a7bda7",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCH8/fpMXMLfKyY\nehP2nwHzBUYmXx8V6Sz5jZNm8xxMM5J+I1FZ1Ww6UTEcw4XMPtAfsv58tAmwQ7y2\nia0TC2Y/LHw+i/AjGTRXjDxx87TYcaGG6a73e5fFnEA/4Zih4LRN+JuL7+xXjCMZ\n7uEGehIfNgQhoCi8EC3RfUu8aOCMchgyq9kJgZS4pi8oupJeN3jRx6rz+ICmB8f9\n5Wec5PWEw0anfognnRcRCqGSRifMA0e7Dh2S/K7q7xcit1C3uQMNY9xYYuAe1hg0\n15+NQID5RVa1XpdwctIY18/TT40cTgLn0lOHDtQX58gs2MrvS8yFSV1kfaFtsXFT\n7KbTuzjJAgMBAAECggEACsBMVptGfHNmOBikri1yO1mra9VnNpWzV3jOs1F+Z2Ly\nBBpJkKUZY0iQbbSN8Xz2JcuYkcawYsljNGbm0kll0zvIB4Thf0+68pbFy5fOMV+r\nD77jIJxxgCW/HvjO195Wjo6ec7k2ziWS5mDHAtAcfBi1cu32IAks1mg7g7F3hc5S\ngdylr6O3mnpbPra4WiyuSPoUx2d4wrRcEtecCUXD6m/dUK8B+XaGlAE/1ho5cqgF\n8S5ypyNvTepBPm2gnjUZ4kyyZddOG4aJysU6CPJ3brsdli4tFHAOxPhl1AtsScUR\nDReClXWPe7vDNYPPS2IV+mCB4aoUn1irV+b7SPNgUQKBgQC7HUi8lb8AaTu3y2hW\n5l2HfudDoyU84IVO1OUW4T0bx4ehcQQNDMr0Rng6D4EKWRb/+89V99Zf4S2d0wpo\nPhzF+z6iz1/PRL1GpxQPi1tvvYwa+zVx4tnW+snD9Qq2W29doBsaMXP7AzZlgNwc\ns0akuS8yMKLtAEsOZy7o4nz7YwKBgQC6API/m4lRa09P/i/3D4sE3kkI/vK86c8y\nARr6el1ekehYECGzhiYbKH9g5BNyCUachBVLtbhVKY4k6P0bhm8em2cuvYzqHio0\n32ni8z+9EflMyXO8xYXay4HBwNVSDSKbKafUH+vgMhqd8veinfPVL23MhP8UHjzT\nyBLfu29w4wKBgF/PsO0P6Iu3VuLX/wdwUjgNXTIfGfRAK0KgdOXwU7AjzWl3S1G7\nWTkX1Hw2cCbyU3qkYBhvHZBe51LHO68BDw65hessMK0bT6gb6YPEIf/nmRQ/ybAV\nLuKL7ECw+tlBnJbeYsJYzECd9n6nKw5vJh82y9nxWZvt6IDpiPWq88BtAoGAHpHX\nPpL+f44ma9w33+ADFhq+YCcel+PJdMtvtqjzvX43dHm6QDoU+zOts6vocj6KB2FB\n6r6D/CMnRHOyXZq7mokp7SmkBjpM74GkcnNOD3Hryi31wpmoBSybN8/Mf36/KEcx\nWRCiAKfbbggnoOda0rfH0OwuzAyoLJpeV70DdMcCgYBcAypW5j4rryiJ1Tf/oWKM\nsJ7xK66bytupV7whnWD/xVBAvo1uGHGEd5cMy7Z7z1JLfHf7do/OfPGM/4twDqHZ\nZB/Hj2/YMB7Sk7ubkvHVHzCA9HySY/LO758EIDjRzWLHx0tiABkGlkOA41ma4TuM\nH1s3VrLCDmHttzblaQvv3A==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-34dtf@teen-splah.iam.gserviceaccount.com",
          "client_id": "103173457865185871358",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-34dtf%40teen-splah.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}
