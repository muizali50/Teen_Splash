import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/features/users/views/private_chat_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/profile_screen/widgets/profile_row.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class OtherPersonProfile extends StatefulWidget {
  final String chatUserId;
  final String chatUserName;
  final String chatUserProfileUrl;
  final bool? isGuest;
  const OtherPersonProfile({
    required this.chatUserId,
    required this.chatUserName,
    required this.chatUserProfileUrl,
    this.isGuest,
    super.key,
  });

  @override
  State<OtherPersonProfile> createState() => _OtherPersonProfileState();
}

class _OtherPersonProfileState extends State<OtherPersonProfile> {
  late final UserBloc userBloc;
  @override
  void initState() {
    userBloc = context.read<UserBloc>();
    if (userBloc.users.isEmpty) {
      userBloc.add(
        GetAllUsers(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ImageIcon(
                      color: Theme.of(context).colorScheme.secondary,
                      const AssetImage(
                        'assets/icons/back.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            final user = userBloc.users
                    .where(
                      (user) => user.uid == widget.chatUserId,
                    )
                    .isNotEmpty
                ? userBloc.users.firstWhere(
                    (user) => user.uid == widget.chatUserId,
                  )
                : null;
            if (state is GettingAllUsers) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetAllUsersFailed) {
              return Center(
                child: Text(state.message),
              );
            } else if (user == null) {
              return const Center(
                child: Text('User not found'),
              );
            }

            return Stack(
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
                              Center(
                                child: Text(
                                  '@${user.name}',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
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
                                child: Column(
                                  children: [
                                    ProfileRow(
                                      title: 'Name',
                                      content: user.name,
                                    ),
                                    Gaps.hGap10,
                                    ProfileRow(
                                      title: 'Gender',
                                      content: user.gender.toString(),
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
                                          '${user.country} ${user.countryFlag} ',
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.isGuest == false) Gaps.hGap20,
                              if (widget.isGuest == false)
                                Center(
                                  child: Text(
                                    'Want to know @${user.name}?',
                                    style: TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ),
                              if (widget.isGuest == false) Gaps.hGap15,
                              if (widget.isGuest == false)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0,
                                  ),
                                  child: AppPrimaryButton(
                                    text: 'Initiate Chat',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (
                                            context,
                                          ) =>
                                              PrivateChatScreen(
                                            chatUserId: widget.chatUserId,
                                            chatUserName: widget.chatUserName,
                                            chatUserProfileUrl:
                                                widget.chatUserProfileUrl,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
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
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _getProfileImage(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ImageProvider<Object> _getProfileImage() {
    final profileUrl = widget.chatUserProfileUrl;
    // Check if profileUrl is empty, "null" string, or not a valid URL
    if (profileUrl.isEmpty ||
        profileUrl == "null" ||
        (Uri.tryParse(profileUrl)?.hasAbsolutePath != true)) {
      return const AssetImage('assets/images/user.png');
    } else {
      return NetworkImage(profileUrl);
    }
  }
}
