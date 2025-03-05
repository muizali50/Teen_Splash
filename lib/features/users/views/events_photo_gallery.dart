import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/photo_gallery_details_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class EventsPhotoGallery extends StatefulWidget {
  const EventsPhotoGallery({super.key});

  @override
  State<EventsPhotoGallery> createState() => _EventsPhotoGalleryState();
}

class _EventsPhotoGalleryState extends State<EventsPhotoGallery> {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.photoGalleries.isEmpty) {
      adminBloc.add(
        GetPhotoGallery(),
      );
    }
    super.initState();
  }

  Future<void> _refresh() async {
    adminBloc.add(
      GetPhotoGallery(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Event Photo Gallery',
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
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
                ),
                child: BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is GettingPhotoGallery) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetPhotoGalleryFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: adminBloc.photoGalleries.isEmpty
                          ? const Center(
                              child: Text(
                                'No photo gallery',
                              ),
                            )
                          : ListView.builder(
                              itemCount: adminBloc.photoGalleries.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (
                                                context,
                                              ) =>
                                                  PhotoGalleryDetailsScreen(
                                                photoGallery: adminBloc
                                                    .photoGalleries[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12.0,
                                            horizontal: 12.0,
                                          ),
                                          width: double.infinity,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                adminBloc.photoGalleries[index]
                                                        .image ??
                                                    '',
                                              ),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                offset: const Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Gaps.hGap05,
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          adminBloc
                                                  .photoGalleries[index].name ??
                                              '',
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
