import type { IndentierPlugin } from 'indentier';

/**
 * indentier plugin for Rust (.rs)
 *
 * - Declaration: `const end:()=();`  (top-level const; valid at module scope)
 * - End statement: `end;`  (`end` is a valid unit expression statement in Rust)
 * - Insertion index: top of file (index 0)
 */
const plugin: IndentierPlugin = {
  extensions: ['.rs'],
  rubyCompatible: true,
  declarationTemplate: 'const end:()=();',
  // getEndStatement not needed — bare `end` (+ trailing `;` from the formatter) is valid
  // declarationInsertIndex not needed — top of file (default 0) is correct
};

export default plugin;
