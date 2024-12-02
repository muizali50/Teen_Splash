import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                  color: Colors.transparent,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is DownloadImageSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Image downloaded successfully',
                        ),
                      ),
                    );
                  } else if (state is DownloadImageFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is DownloadingImage) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      userBloc.add(
                        DownloadImage(imageUrl),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ImageIcon(
                          color: Theme.of(context).colorScheme.secondary,
                          const AssetImage(
                            'assets/icons/download.png',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: 'background-$imageUrl',
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
