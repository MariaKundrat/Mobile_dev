import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/profile/profile_cubit.dart';
import 'package:lab1/cubit/profile/profile_logic_state.dart';
import 'package:lab1/presentation/widgets/background_waves.dart';
import 'package:lab1/presentation/widgets/profile_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            const BackgroundWaves(),
            SafeArea(
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoaded) {
                    return ProfileContent(state);
                  } else {
                    return const Center(child: Text('Unexpected error'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
