import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditationapp/providers/tips_provider.dart';
import 'package:provider/provider.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tips'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "All Tips"),
              Tab(text: "My Tips"),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add_comment_rounded,
                color: const Color.fromARGB(255, 255, 255, 255),
                size: 50,
              ),
              onPressed: () {
                context.push("/CreateTipPage");
              },
              tooltip: 'Create a New Tip',
            ),
          ],
        ),
        body: TabBarView(
          children: [
            buildTips(context),
            myBuild(context),
          ],
        ),
      ),
    );
  }

  Widget myBuild(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: context.read<TipProvider>().myFetchTips(),
          builder: (context, _) {
            return Consumer<TipProvider>(builder: (context, tipProvider, _) {
              return tipProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: tipProvider.tips.length,
                      itemBuilder: (context, index) {
                        var tip = tipProvider.tips[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.arrow_upward,
                                        color: Color.fromARGB(204, 24, 215, 37),
                                      ),
                                      onPressed: () {
                                        tipProvider.upvoteTip(tip.id);
                                      },
                                    ),
                                    Text(
                                      '${tip.upvotes.length}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(204, 24, 215, 37)),
                                    ),
                                    Text(
                                      '${tip.downvotes.length}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(201, 255, 0, 0)),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_downward,
                                        color: Color.fromARGB(201, 255, 0, 0),
                                      ),
                                      onPressed: () {
                                        tipProvider.downvoteTip(tip.id);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tip.text!,
                                        style: const TextStyle(fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'by ${tip.author}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    tipProvider.deleteTip(tipId: tip.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            });
          }),
    );
  }

  Widget buildTips(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: context.read<TipProvider>().fetchTips(),
          builder: (context, _) {
            return Consumer<TipProvider>(builder: (context, tipProvider, _) {
              return tipProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: tipProvider.tips.length,
                      itemBuilder: (context, index) {
                        var tip = tipProvider.tips[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.arrow_upward,
                                        color: Color.fromARGB(204, 24, 215, 37),
                                      ),
                                      onPressed: () {
                                        tipProvider.upvoteTip(tip.id);
                                      },
                                    ),
                                    Text(
                                      '${tip.upvotes.length}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(204, 24, 215, 37)),
                                    ),
                                    Text(
                                      '${tip.downvotes.length}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(201, 255, 0, 0)),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_downward,
                                        color: Color.fromARGB(201, 255, 0, 0),
                                      ),
                                      onPressed: () {
                                        tipProvider.downvoteTip(tip.id);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tip.text!,
                                        style: const TextStyle(fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'by ${tip.author}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            });
          }),
    );
  }
}
