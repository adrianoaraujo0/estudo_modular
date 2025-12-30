# Route Guards (Proteção de Rotas)

O **RouteGuard** atua como um *middleware* de segurança no Flutter Modular. Ele intercepta a navegação **antes** que a tela de destino seja construída, permitindo validar regras de negócio (ex: autenticação, permissões) para autorizar ou negar o acesso.

## Estrutura Básica

Para criar um guard, deve-se estender a classe `RouteGuard` e implementar o método `canActivate`.

```dart
class AuthGuard extends RouteGuard {
  // Define para onde o usuário será enviado caso o acesso seja negado (return false)
  AuthGuard() : super(redirectTo: '/login/');

  @override
  Future<bool> canActivate(String path, ParallelRoute route) async {
    // Lógica de verificação (Síncrona ou Assíncrona)
    final isLogged = await AuthService.instance.isLogged();
    
    // Retorna TRUE para permitir a navegação
    // Retorna FALSE para bloquear e acionar o 'redirectTo'
    return isLogged;
  }
}
```

### Implementação na Rota
Os guards são definidos através da propriedade guards (que aceita uma lista) no registro da rota ou do módulo.

```dart
// No HomeModule
r.child(
  '/perfil', 
  child: (_) => PerfilPage(),
  guards: [AuthGuard()], // A navegação só ocorre se AuthGuard retornar true
);
```

### ⚠️ Regras Críticas (Anti-Patterns)
1. O Loop Infinito
Jamais aplique um Guard na mesma rota para a qual ele redireciona.

Errado: Colocar AuthGuard na LoginPage com redirectTo: '/login'.

Resultado: O usuário tenta entrar no login -> Guard bloqueia -> Redireciona para login -> Guard bloqueia novamente -> Crash/Loop.