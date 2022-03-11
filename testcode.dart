void main() {
  print('ok');
}

mixin Animal {
  void name() {
    print("can fly");
  }
}
mixin Cow {
  void legs() {
    print('has four legs');
  }
}
