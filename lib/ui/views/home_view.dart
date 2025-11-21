import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_kut/ui/viewmodels/posts_view_model.dart';
import 'package:web_kut/ui/views/const/colors_const.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostsViewModel>().getPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.bgColor,
      appBar: AppBar(
        backgroundColor: ColorsConst.bgColor,
        title: Text('Teste', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 16),
        ),
      ),
      body: Center(
        child: Consumer<PostsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.carregando) {
              return const CircularProgressIndicator();
            }

            if (viewModel.postList.isEmpty) {
              return const Text(
                'Nenhum post carregado!',
                style: TextStyle(color: Colors.red),
              );
            }

            return ListView.builder(
              itemCount: viewModel.postList.length,
              itemBuilder: (context, index) {
                final post = viewModel.postList[index];
                final String authorName = viewModel.getNomeAutor(post.userId);

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: ColorsConst.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorsConst.btnColor,
                                child: Text(
                                  authorName.isNotEmpty ? authorName[0] : '?',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  authorName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),

                          Text(
                            post.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Corpo do Post
                          Text(post.body, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
