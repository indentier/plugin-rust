# Contributing

## Setup

```sh
pnpm install
pnpm test
pnpm build
```

## Development

The plugin source is in `src/index.ts`. Tests are in `tests/index.test.ts`.

For general Indentier development guidelines, see the [Indentier contributing guide](https://github.com/indentier/indentier/blob/main/CONTRIBUTING.md).

## Scripts

<!-- prettier-ignore -->
| Script | Purpose |
|-|-|
| `pnpm dev` | tsdown in watch mode |
| `pnpm build` | Produce ESM + CJS bundles in `dist/` |
| `pnpm test` | Run vitest |
| `pnpm typecheck` | TypeScript type check |
| `pnpm lint` / `lint:fix` | ESLint |
| `pnpm format` / `format:check` | Prettier |
| `pnpm play` / `play:ruby` | Run indentier against `testplay/` sample files |

## Releasing

Releases follow the same workflow as Indentier core — see the [core contributing guide](https://github.com/indentier/indentier/blob/main/CONTRIBUTING.md#releasing) for details.
