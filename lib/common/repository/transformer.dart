// Transform From type F To type T using type I as and identifier
//
abstract class Transformer<F, T, I> {
  T transform(
    F object, {
    I? identifier,
  });
}
