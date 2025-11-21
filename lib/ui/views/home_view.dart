import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_kut/ui/viewmodels/posts_view_model.dart';
import 'package:web_kut/ui/views/const/colors_const.dart';
import 'package:web_kut/ui/views/const/fonts_const.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          toolbarHeight: 100.0,

          backgroundColor: ColorsConst.bgColor,
          centerTitle: true,

          title: SizedBox(
            width: 300,
            height: 80,
            child: Image.asset('assets/images/ws.png', fit: BoxFit.contain),
          ),
        ),
      ),
      body: Center(
        child: Consumer<PostsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.carregando) {
              return const CircularProgressIndicator(
                color: Color.fromRGBO(101, 96, 234, 1),
              );
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsConst.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: const Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(101, 96, 234, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 12,
                      ),
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
                                  style: FontsConst.nomeAuthorPost,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Color.fromARGB(148, 158, 158, 158),
                          ),

                          Text(post.title, style: FontsConst.tituloPost),
                          const SizedBox(height: 5),

                          Text(post.body, style: FontsConst.conteudoPost),
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
