# RouterManager

O `RouterManager` é responsável pelo registo e gestão da árvore de navegação da aplicação. Abaixo descrevem-se os métodos fundamentais para a definição de rotas.

## Métodos

### `r.redirect`
Define um redirecionamento forçado e imediato de um caminho (path) para outro. É utilizado para garantir que rotas vazias ou depreciadas encaminhem o utilizador para o módulo correto sem renderizar uma view intermédia.

**Exemplo:**
```dart
// Redireciona o acesso à raiz do módulo para a rota interna '/list'
r.redirect('/', to: '/list');
```

### `r.child`
Regista uma sub-rota (rota filha) associada a uma página ou a um sub-módulo. O caminho definido neste método é relativo, ou seja, será concatenado ao caminho do módulo onde está inserido.

**Exemplo:**
```dart
// Regista a página de detalhes. Se o módulo estiver em '/product',
// a rota final será '/product/details'
r.child('/details', child: (_) => ProductDetailsPage());
```

### `r.module`
Importa e regista um módulo inteiro numa rota específica. É fundamental para arquiteturas modulares, encapsulando rotas, *binds* e lógica de negócio de um domínio específico, isolando-o do módulo pai.

**Exemplo:**
```dart
// Carrega o módulo de definições quando a rota '/settings' for acessada.
// Todas as rotas dentro de SettingsModule herdarão o prefixo '/settings'.
r.module('/settings', module: SettingsModule());
```

### `r.wildcard`
Define uma rota de fallback (segurança). É acionada automaticamente quando a URI solicitada não corresponde a nenhuma outra rota registada no módulo atual. Geralmente utilizada para apresentar páginas de "Erro 404" ou "Não Encontrado".

```dart
// Qualquer rota não reconhecida renderiza a NotFoundPage
r.wildcard(child: (_) => NotFoundPage());
```