class GistResponse {
  final String? url;
  final String? forksUrl;
  final String? commitsUrl;
  final String? id;
  final String? nodeId;
  final String? gitPullUrl;
  final String? gitPushUrl;
  final String? htmlUrl;
  final Map<String, GistFile>? files;
  final bool? isPublic;
  final String? createdAt;
  final String? updatedAt;
  final String? description;
  final int? comments;
  final String? commentsUrl;
  final GistOwner? owner;
  final bool? truncated;

  GistResponse({
    required this.url,
    required this.forksUrl,
    required this.commitsUrl,
    required this.id,
    required this.nodeId,
    required this.gitPullUrl,
    required this.gitPushUrl,
    required this.htmlUrl,
    required this.files,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.comments,
    required this.commentsUrl,
    required this.owner,
    required this.truncated,
  });

  factory GistResponse.fromJson(Map<String, dynamic> json) {
    return GistResponse(
      url: json['url'] as String?,
      forksUrl: json['forks_url'] as String?,
      commitsUrl: json['commits_url'] as String?,
      id: json['id'] as String?,
      nodeId: json['node_id'] as String?,
      gitPullUrl: json['git_pull_url'] as String?,
      gitPushUrl: json['git_push_url'] as String?,
      htmlUrl: json['html_url'] as String?,
      files: json['files'] != null
          ? (json['files'] as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, GistFile.fromJson(value)))
          : null,
      isPublic: json['public'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      description: json['description'] as String?,
      comments: json['comments'] as int?,
      commentsUrl: json['comments_url'] as String?,
      owner: json['owner'] != null ? GistOwner.fromJson(json['owner']) : null,
      truncated: json['truncated'] as bool?,
    );
  }
}

class GistFile {
  final String? filename;
  final String? type;
  final String? language;
  final String? rawUrl;
  final int? size;

  GistFile({
    this.filename,
    this.type,
    this.language,
    this.rawUrl,
    this.size,
  });

  factory GistFile.fromJson(Map<String, dynamic> json) {
    return GistFile(
      filename: json['filename'] as String?,
      type: json['type'] as String?,
      language: json['language'] as String?,
      rawUrl: json['raw_url'] as String?,
      size: json['size'] as int?,
    );
  }
}

class GistOwner {
  final String? login;
  final int? id;
  final String? nodeId;
  final String? avatarUrl;
  final String? url;
  final String? htmlUrl;
  final String? followersUrl;
  final String? followingUrl;
  final String? gistsUrl;
  final String? starredUrl;
  final String? subscriptionsUrl;
  final String? organizationsUrl;
  final String? reposUrl;
  final String? eventsUrl;
  final String? receivedEventsUrl;
  final bool? siteAdmin;

  GistOwner({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.siteAdmin,
  });

  factory GistOwner.fromJson(Map<String, dynamic> json) {
    return GistOwner(
      login: json['login'] as String?,
      id: json['id'] as int?,
      nodeId: json['node_id'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      url: json['url'] as String?,
      htmlUrl: json['html_url'] as String?,
      followersUrl: json['followers_url'] as String?,
      followingUrl: json['following_url'] as String?,
      gistsUrl: json['gists_url'] as String?,
      starredUrl: json['starred_url'] as String?,
      subscriptionsUrl: json['subscriptions_url'] as String?,
      organizationsUrl: json['organizations_url'] as String?,
      reposUrl: json['repos_url'] as String?,
      eventsUrl: json['events_url'] as String?,
      receivedEventsUrl: json['received_events_url'] as String?,
      siteAdmin: json['site_admin'] as bool?,
    );
  }
}
