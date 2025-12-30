# Imports e Exports (Compartilhamento de Dependências)

O **Flutter Modular** permite que módulos compartilhem dependências entre si de forma controlada, através das propriedades **`imports`** e **`exportedBinds`**.  
Esses mecanismos são essenciais para manter uma arquitetura **modular, reutilizável e desacoplada**, evitando a duplicação de *binds* (instâncias injetadas) entre módulos.

---

## 🧩 Conceito Geral

- `imports`: indica **quais módulos** serão importados para uso interno do módulo atual.  
- `exportedBinds`: define **quais dependências (binds)** ficarão **disponíveis para outros módulos** que importarem o módulo atual.

> Ou seja: um módulo pode *exportar* suas dependências e outro módulo pode *importá-las* para utilizá-las sem recriá-las.

---

## 🔹 Exemplo Prático

### Módulo de Autenticação (`AuthModule`)

```dart
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    super.binds(i);

    i.addLazySingleton(HttpClient.new);
    i.addLazySingleton(LocalStorage.new);
  }
}

class HttpClient {}

class LocalStorage {}
```

### Explicação
exportedBinds substitui o método binds tradicional quando queremos tornar as dependências públicas.

Assim, qualquer módulo que importe o AuthModule poderá injetar (Modular.get()) os objetos HttpClient e LocalStorage.

➡️ O AuthModule se torna um provedor global dessas dependências.

## 🔸 Importando Módulos (imports)
No módulo principal da aplicação (AppModule), podemos importar o AuthModule para disponibilizar suas dependências a todos os outros módulos.


```dart
class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.redirect('/', to: '${PathModules.splash}${PathPages.splashPage}');
    r.module(PathModules.splash, module: SplashModule());
    r.module(PathModules.login, module: LoginModule());
    r.module(PathModules.home, module: HomeModule());
  }

  @override
  List<Module> get imports => [AuthModule()];
}
```

### Explicação

A propriedade imports traz os binds exportados pelo AuthModule para dentro do AppModule.

Todos os módulos registrados no AppModule (como SplashModule, LoginModule e HomeModule) também passam a ter acesso aos binds do AuthModule.

## 🔁 Ciclo de Disponibilidade

AuthModule
 ├── exportedBinds: [HttpClient, LocalStorage]
       ↓
AppModule (imports: [AuthModule])
 ├── módulos filhos:
 │     ├── SplashModule
 │     ├── LoginModule
 │     └── HomeModule
       ↓
Todos os módulos podem usar:
 - Modular.get<HttpClient>()
 - Modular.get<LocalStorage>()

## ✅ Resultado:
As instâncias HttpClient e LocalStorage ficam disponíveis globalmente,
sem precisar declarar binds duplicados em cada módulo.

## Use exportedBinds apenas para dependências compartilháveis (ex: AuthService, HttpClient, Storage, Logger).

- Use binds para dependências específicas daquele módulo (ex: SplashController, LoginController).

- Evite importar módulos desnecessários — cada import expande o escopo de injeção e pode aumentar o tempo de inicialização.

- Centralize binds globais em módulos de núcleo, como AuthModule ou CoreModule.