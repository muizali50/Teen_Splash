import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/user_provider.dart';

class MembershipCard extends StatefulWidget {
  const MembershipCard({super.key});

  @override
  State<MembershipCard> createState() => _MembershipCardState();
}

class _MembershipCardState extends State<MembershipCard> {
  late final UserProvider userProvider;
  late final AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    authenticationBloc.add(
      const GetUser(),
    );
    userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      authenticationBloc.add(
        const GetUser(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        String formatMembershipNumber(String membershipNumber) {
          return membershipNumber
              .replaceAllMapped(
                RegExp(r".{4}"),
                (match) => "${match.group(0)} ",
              )
              .trim();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          height: 168,
          width: 267.95,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/card.png',
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 30,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  height: 30,
                  child: Image.asset('assets/images/chip.png'),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                formatMembershipNumber(userProvider.user?.membershipNumber ?? ''),
                style: const TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VALID',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        Text(
                          'THRU',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '10/25',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 12.76,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                (userProvider.user?.name ?? '').toUpperCase(),
                style: const TextStyle(
                  // fontFamily: 'Lexend',
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
