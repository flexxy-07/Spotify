import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/presentation/songs/bloc/songs_bloc.dart';

/// Example Widget showing how to fetch and display offline songs
/// This is a reference implementation for your home page or songs page
class SongsListPage extends StatefulWidget {
  const SongsListPage({super.key});

  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  @override
  void initState() {
    super.initState();
    // Trigger fetching songs when page loads
    context.read<SongsBloc>().add(FetchSongsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Songs')),
      body: BlocBuilder<SongsBloc, SongsState>(
        builder: (context, state) {
          if (state is SongsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SongsLoaded) {
            final songs = state.songs;
            return ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return ListTile(
                  title: Text(song.title),
                  subtitle: Text(song.artist),
                  trailing: Text('${(song.duration / 1000).toStringAsFixed(0)}s'),
                  onTap: () {
                    // You can play the song here using the filePath
                    print('Playing: ${song.filePath}');
                  },
                );
              },
            );
          }

          if (state is SongsError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }

          return const Center(child: Text('No songs found'));
        },
      ),
    );
  }
}
