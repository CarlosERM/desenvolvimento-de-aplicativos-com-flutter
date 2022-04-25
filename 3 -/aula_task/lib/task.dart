class Task {
  late String descricao;
  bool done = false;

  Task(this.descricao);

  void changeState() {
    this.done = !this.done;
  }
}
