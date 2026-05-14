<div align="center">

  <img src="./icon.png" width="256" height="256" alt="Indentier">

# @indentier/plugin-rust

</div>

[![npm version](https://img.shields.io/npm/v/@indentier/plugin-rust.svg?color=cb3837&logo=npm)](https://www.npmjs.com/package/@indentier/plugin-rust)
[![CI](https://github.com/indentier/plugin-rust/actions/workflows/ci.yml/badge.svg)](https://github.com/indentier/plugin-rust/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

> Rust support for [Indentier](https://github.com/indentier/indentier).

Full documentation: **[indentier.github.io](https://indentier.github.io)**

## Install

```sh
npm i -D indentier @indentier/plugin-rust
```

## Setup

```jsonc
// .indentierrc.json
{
  "plugins": ["@indentier/plugin-rust"]
}
```

<!-- prettier-ignore -->
| | |
|-|-|
| Language | Rust |
| Extensions | `.rs` |
| Ruby mode | Yes — injects `const end:()=();`; end statement: `end` |

## License

[MIT](./LICENSE) © otoneko.
