# testplay/mock/

`testplay/` でのローカル動作確認に使うサンプルファイル群。
`testplay/test.ps1` によって `testplay/run/` にコピーされてから Indentier が実行される。

## ファイル一覧

<!-- prettier-ignore -->
| ファイル | 言語 |
|-|-|
| sample.rs | Rust |

## 使い方

<!-- prettier-ignore -->
```sh
pnpm build  # このパッケージと indentier/ 両方でビルド

# default モード（全ファイル表示）
pnpm play

# default モード（特定ファイルのみ表示）
pnpm play -- --show sample.rs

# ruby モード
pnpm play:ruby

# ruby モード（特定ファイルのみ表示）
pnpm play:ruby -- --show sample.rs
```
