import 'package:flutter/material.dart';
import 'package:redscope_inc/modelclass/git_response_model.dart';

class AllFilesListing extends StatefulWidget {
  GistResponse? gistResponse;
  AllFilesListing(this.gistResponse, {super.key});

  @override
  State<AllFilesListing> createState() => _AllFilesListingState();
}

class _AllFilesListingState extends State<AllFilesListing> {
  @override
  Widget build(BuildContext context) {
    if (widget.gistResponse?.files == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("All Files"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("No files available."),
        ),
      );
    }

    var files = widget.gistResponse!.files!.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Files"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          var file = files[index];
          return Card(
            child: ListTile(
              trailing: Text("File Size\n${file.size ?? "N/A"}"),
              title: Text("File Name: ${file.filename ?? "N/A"}"),
              subtitle: Text(
                  "File Language: ${file.language ?? "N/A"}\nFile Type: ${file.type ?? "N/A"}"),
            ),
          );
        },
      ),
    );
  }
}
