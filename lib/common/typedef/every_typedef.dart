/// 常用容器类型
/// [MapSDy]
/// [MapDyS]
/// [MapSS]
/// [ListS]
/// [ListDy]
///
typedef MapSDy = Map<String, dynamic>;
typedef MapDyS = Map<dynamic, String>;
typedef MapSS = Map<String, String>;
typedef ListS = List<String>;
typedef ListDy = List<dynamic>;

typedef FunctionS = void Function(String);
typedef FunctionT<T> = void Function(T);
typedef FunctionInt = void Function(int);
typedef FunctionDy = void Function(dynamic);
typedef FunctionNone = void Function();
