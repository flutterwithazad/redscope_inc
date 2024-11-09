import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redscope_inc/controller/git_owner_controller.dart';
import 'package:redscope_inc/controller/git_response_controller.dart';
import 'package:redscope_inc/modelclass/git_owner_model.dart';
import 'package:redscope_inc/modelclass/git_response_model.dart';
import 'package:redscope_inc/screens/all_files_listing.dart';

class GitScreen extends StatefulWidget {
  const GitScreen({super.key});

  @override
  State<GitScreen> createState() => _GitScreenState();
}

class _GitScreenState extends State<GitScreen> {
  late Future<List<GistResponse>> gists;
  @override
  void initState() {
    super.initState();
    gists = fetchGists();
  }

  Future<GitOwnerModel?> handleSecondApiData(String url) async {
    return await fetchSecondApiData(url);
  }

  void _showDialog(String url) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 400,
              height: 300,
              padding: const EdgeInsets.all(16),
              child: Material(
                child: FutureBuilder<GitOwnerModel?>(
                  future: handleSecondApiData(url),
                  builder: (BuildContext context,
                      AsyncSnapshot<GitOwnerModel?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Failed to load data'));
                    } else if (snapshot.hasData) {
                      GitOwnerModel? ownerData = snapshot.data;

                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage(ownerData!.avatarUrl.toString()),
                          ),
                          const SizedBox(height: 10),
                          Text("Name: ${ownerData.name ?? 'N/A'}"),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${ownerData.followers ?? '0'}\nFollowers",
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${ownerData.following ?? '0'}\nFollowing",
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${ownerData.public_repos ?? '0'}\nPublic Repo",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                "Bio: ${ownerData.bio ?? 'N/A'}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Git Screen"),
      ),
      body: FutureBuilder<List<GistResponse>>(
        future: gists,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final gists = snapshot.data!;

            return ListView.builder(
              itemCount: gists.length,
              itemBuilder: (context, index) {
                final gist = gists[index];

                String? createdTime = DateFormat("dd MMM yyyy")
                    .format(DateTime.parse(gist.createdAt!));
                String? updatedTime = DateFormat("dd MMM yyyy")
                    .format(DateTime.parse(gist.updatedAt!));

                return Card(
                  child: ListTile(
                    onLongPress: () {
                      _showDialog(gist.owner!.url.toString());

                      print(gist.owner!.url);
                    },
                    title: Text(
                      "Description: ${gist.description ?? "N/A"}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.comment,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(gist.comments.toString()),
                              ],
                            ),
                            const Text(
                              "Comments",
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            "Created on: ${createdTime}\nUpdate on: ${updatedTime}")
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllFilesListing(gist)));
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Data not Found'));
          }
        },
      ),
    );
  }
}
