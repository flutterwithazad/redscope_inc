class GitOwnerModel {
  final String? login;
  final String? avatarUrl;
  final String? name;
  final int? followers;
  final int? following;
  final String? bio;
  final int? public_repos;

  GitOwnerModel(
      {this.login,
      this.avatarUrl,
      this.name,
      this.followers,
      this.following,
      this.bio,
      this.public_repos});
  factory GitOwnerModel.fromJson(Map<String, dynamic> json) {
    return GitOwnerModel(
        login: json['login'] ?? 'N/A',
        avatarUrl: json['avatar_url'] ?? 'N/A',
        name: json['name'] ?? 'N/A',
        followers: json['followers'] ?? 0,
        following: json['following'] ?? 0,
        bio: json['bio'] ?? 'N/A',
        public_repos: json['public_repos'] ?? 0);
  }
}
