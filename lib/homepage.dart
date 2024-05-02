import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:usersapiapp/detail_page.dart';

import 'model/news.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// //user list
//   final List<APIModel> dataa = [];

  // Future<List<APIModel>> getData() async {
  //   var data =
  //       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  //   var jsonData = jsonDecode(data.body.toString());
  //   if (data.statusCode == 200) {
  //     for (Map i in jsonData) {
  //       dataa.add(APIModel.fromJson(i as Map<String, dynamic>));
  //     }
  //     return dataa;
  //   } else {
  //     return dataa;
  //   }
  // }

  final NewsService _newsService =
      NewsService(); // Created an instance of NewsService

  late Future<List<NewsArticle>>
      _futureNews; // Future to hold the news articles

  @override
  void initState() {
    super.initState();
    _futureNews = _newsService
        .fetchNews(); // Fetch news articles when the widget initializes
  }

  Future<void> _refreshNews() async {
    setState(() {
      _futureNews = _newsService.fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tesla\'s News'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Iconsax.add,
          color: Colors.black87,
          size: 30,
        ),
        onPressed: () {
          _refreshNews();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshNews,
              child: FutureBuilder(
                future: _futureNews,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    final newsArticles = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final article = newsArticles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailPage(article: article)));
                            },
                            child: Column(
                              children: [
                                if (article.imageUrl.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      article.imageUrl,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width, // Image width as screen width
                                      height:
                                          200, // Set image height as desired
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                const SizedBox(height: 5),
                                Text(
                                  article.title,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                ),
                                const Divider(),
                                Text(
                                  article.description,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      article.formattedPublishedAt,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      article.sourceName,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: newsArticles.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
