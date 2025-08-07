# icarios's Neovim Config

Bienvenue dans ma configuration Neovim, construite sur une installation
de [LazyVim](https://github.com/LazyVim/LazyVim), via son [starter
pack](https://github.com/LazyVim/starter), mais entièrement repensée
pour être propre, modulaire, maintenable, et agréable à faire évoluer.
Elle s’appuie sur ses fondations robustes, tout en structurant
clairement la personnalisation utilisateur.

Ce repo reflète mon besoin de structure.

## Objectifs

- plugins activés séparés de leur configuration
- Respect du principe **KISS** et de la **séparation des concepts** :
  chaque fichier a une responsabilité claire et unique
- Config pensée pour rester lisible, modulaire, et non-couplée
- Chargement **automatisé** des configurations avec des sécurités
  pour échouer proprement si le plugin n'est pas présent
- Un vrai focus sur la **personnalisation ciblée**, plutôt que de
  réinventer LazyVim

Ce que je versionne ici, ce n’est **pas LazyVim lui-même** :

> 📦 La majorité des plugins proviennent du preset LazyVim. Ceux-ci ne
> sont **pas visibles** dans mon répertoire `plugins/`, car ils sont
> gérés par l’**UI de Lazy** et rangés dans `~/.local/share/nvim/lazy/`.

Ce que je versionne ici est **la configuration ciblée** des plugins qui
me sont utiles, selon **mes propres workflows**. LazyVim fait le gros du
travail, moi je pose simplement mes briques autour.

## Architecture modulaire (inspirée DDD)

```text
~/.config/nvim/
├── init.lua                    # Point d’entrée, initialise la config globale
├── lua/
│   ├── config/
│   │   ├── lazy.lua            # Initialisation Lazy.nvim (venant du starter)
│   │   ├── autocmds.lua        # Autocommandes globales (hors plugins)
│   │   ├── keymaps.lua         # Keymaps globales (hors plugins)
│   │   ├── options.lua         # Options natives de Neovim
│   │   ├── modules/
│   │   │   ├───init.lua        # Détecte et charge les modules
│   │   │   ├── blink/
│   │   │   ├── luasnip/        # Dossier de configuration ciblée par plugin
│   │   │   │   ├── commands.lua
│   │   │   │   ├── init.lua
│   │   │   │   ├── keymaps.lua
│   │   │   │   └── setup.lua
│   │   │   ├── telescope/
│   │   │   ├── template/
│   │   │   ├── zk/
│   │   │   └── ...
│   │   └── utils/              # Helpers communs (require safe, outils snippets)
│   ├── plugins/                # Déclarations Lazy.nvim
│   └── snippets/               # Snippets personnalisés par filetype
└── templates/                  # Templates de fichiers (HTML, JSX, etc.)
```

Chaque **module** agit comme un mini-plugin interne, avec :

- un `init.lua` comme point d’entrée
- des fichiers complémentaires (`setup.lua`, `keymaps.lua`, etc.)

Ce système permet d’organiser la logique par domaine ou plugin, tout en
gardant une config lisible et maintenable.

## Plugins visibles et leur modules

- [`luasnip`](https://github.com/L3MON4D3/LuaSnip) Snippets dynamiques, contextuels
- [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) Recherche floue, navigation rapide
- [`template.nvim`](https://github.com/sudormrfbin/template.nvim) Création de fichiers à partir de templates
- [`zk-nvim`](https://github.com/mickael-menu/zk-nvim) Prise de notes Zettelkasten
- [`blink.cmp`](https://github.com/saghen/blink.cmp) Complétion intelligente, rapide, contextuelle
- _(et d'autres à venir...)_

## 🧬 Inspirations

- [LazyVim](https://github.com/LazyVim/LazyVim) comme base solide
- [DDD - Domain-Driven Design](https://fr.wikipedia.org/wiki/Conception_dirig%C3%A9e_par_le_domaine)
  pour penser les responsabilités
- ✂️ Anti-spaghetti code : chaque plugin, chaque logique a son fichier,
  son rôle, son contexte

## Installation

Ce dépôt est une config personnelle. Ne l’utilise pas en copier-coller,
mais plutôt comme **base d’inspiration**.

```bash
git clone https://github.com/ArnaudPithon/config-nvim ~/.config/nvim
nvim
```

## Roadmap perso

- Meilleure intégration de la méthode Zettelkasten
- Plus de snippets pour les langages que j'utilise
- Les templates sont ultra basique, il faut les étoffer
- Plus d'intégration des IA
- Toujours plus de personnalisation ciblée pour mes workflows

## 🐾 À propos

Cette conf évolue au fil de mes besoins de développeur, de mes lectures
techniques, et de mes découvertes de l'univers Neovim. Et souvent, entre
deux balades avec ma chienne, pendant que les étoiles se lèvent.
