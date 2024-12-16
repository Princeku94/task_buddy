class Task {
  String title;
  String description; // New field for description
  bool completed;

  Task({
    required this.title,
    required this.description,
    this.completed = false,
  });

  // Convert task to a Map for storage
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'completed': completed,
      };

  // Create a task from a Map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
    );
  }
}
