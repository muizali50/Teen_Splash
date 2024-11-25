import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/home_registered_user/widgets/drawer.dart';
import 'package:teen_splash/features/users/views/sub_features/profile_screen/widgets/membership_card.dart';
import 'package:teen_splash/features/users/views/sub_features/profile_screen/widgets/profile_row.dart';
import 'package:teen_splash/user_provider.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isMenyIcon: true,
          isChatIcon: true,
          isTittle: true,
          title: 'Profile',
        ),
      ),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.hGap50,
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(-4, 4),
                          blurRadius: 4,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gaps.hGap30,
                          Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                              return Center(
                                child: Text(
                                  '@${userProvider.user?.name ?? ''}',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              );
                            },
                          ),
                          Gaps.hGap40,
                          Container(
                            padding: const EdgeInsets.all(
                              16.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color(
                                  0xFFFFD700,
                                ),
                              ),
                              color: const Color(
                                0xFFF8F8F8,
                              ),
                            ),
                            child: Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                                return Column(
                                  children: [
                                    ProfileRow(
                                      title: 'Name',
                                      content: userProvider.user?.name ?? '',
                                    ),
                                    Gaps.hGap10,
                                    ProfileRow(
                                      title: 'Gender',
                                      content: userProvider.user?.gender ?? '',
                                    ),
                                    Gaps.hGap10,
                                    const ProfileRow(
                                      title: 'Age',
                                      content: '25 y/o',
                                    ),
                                    Gaps.hGap10,
                                    ProfileRow(
                                      title: 'Country',
                                      content:
                                          '${userProvider.user?.country ?? ''} ${userProvider.user?.countryFlag ?? ''}',
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Gaps.hGap20,
                          Center(
                            child: Text(
                              'Membership Card',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Gaps.hGap15,
                          const Center(
                            child: MembershipCard(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              // bottom: 670, // Adjust the position as necessary
              // left: 0,
              // right: 0,
              top: 0, // Reduced value from 30 to 15 to pull the card up.
              left: 20,
              right: 20,
              child: Container(
                height: 105,
                width: 105,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(
                      0xFFFFD700,
                    ),
                  ),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1722945691819-e58990e7fb27?q=80&w=1442&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
