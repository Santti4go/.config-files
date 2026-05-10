# Atajos de Git en Neovim (Revisión de PRs)

Aquí tienes una guía rápida de los atajos configurados en tu entorno para revisar cambios y Pull Requests usando `gitsigns`, `neogit` y `diffview`.

## 🔍 Diffview (Revisión de Pull Requests y Diffs globales)

Ideal para revisar todos los cambios de tu rama antes de hacer un commit o para revisar el código de otra persona.

- `<leader>gd` : **Open Diffview.** Abre la vista de diff dividida. A la izquierda verás la lista de archivos modificados, a la derecha el diff comparativo del archivo seleccionado.
- `<leader>gx` : **Close Diffview.** Cierra la vista de revisión y vuelve a tu código normal.
- `<leader>gh` : **File History.** Abre el historial completo de commits del archivo actual. Muestra las versiones anteriores a la izquierda y el diff a la derecha.

> **💡 Tip de Experto para PRs:**
> Para revisar específicamente qué cambios introduce tu rama comparada con `main` (ideal para auto-revisar un PR), usa el comando manual en Neovim:
> `:DiffviewOpen main...HEAD`
> Esto filtrará la vista y mostrará solo los archivos y líneas modificadas en tu rama actual.

## 📝 Gitsigns (Micro-revisiones en el archivo actual)

Para revisar, deshacer o preparar cambios rápidamente mientras estás editando un archivo en particular.

- `]c` : Saltar al **siguiente** cambio (hunk) dentro del archivo.
- `[c` : Saltar al **anterior** cambio (hunk) dentro del archivo.
- `<leader>ghp` : **Preview Hunk.** Abre una pequeña ventana flotante mostrando cómo era el código en la versión anterior para esa sección específica.
- `<leader>ghb` : **Blame Line.** Muestra un mensaje temporal flotante indicando quién, cuándo y en qué commit se hizo la última modificación en la línea donde está tu cursor.
- `<leader>ghs` : **Stage Hunk.** Prepara (`git add`) solo el bloque de código donde se encuentra tu cursor.
- `<leader>ghu` : **Undo Stage Hunk.** Revierte el `git add` del bloque de código actual (lo saca del stage).
- `<leader>ghr` : **Reset Hunk.** Deshace los cambios del bloque de código actual y lo devuelve al estado del último commit (`git checkout` de esa porción).

## 🚀 Neogit (Manejo de Commits y Status)

- `<leader>gs` : Abre **Neogit** (interfaz similar a `git status` pero interactiva). Desde ahí puedes hacer `stage` de archivos completos, escribir tu mensaje de commit de manera guiada y ejecutar `push` o `pull`.
