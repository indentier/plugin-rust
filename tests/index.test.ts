import { describe, expect, it } from 'vitest';
import { format, resolveOptions, registerPlugin, clearPlugins } from 'indentier';
import plugin from '../src/index.ts';

describe('@indentier/plugin-rust', () => {
  it('registers .rs extension', () => {
    expect(plugin.extensions).toContain('.rs');
  });

  it('is ruby compatible', () => {
    expect(plugin.rubyCompatible).toBe(true);
  });

  it('formats a Rust file with ruby mode: const declaration at top', () => {
    clearPlugins();
    registerPlugin(plugin);

    const input = 'fn main() {\n  println!("hello");\n}\n';
    const out = format(
      input,
      resolveOptions({ mode: 'ruby', minColumn: 60, offset: 4 }),
      '.rs',
      plugin,
    );

    expect(out).toContain('const end:()=();');
    expect(out.split('\n').some((l) => l.trim() === 'end')).toBe(true);
    // Declaration is at the very first line
    expect(out.split('\n')[0]!.trim()).toBe('const end:()=();');

    clearPlugins();
  });

  it('idempotent: formatting twice gives the same result', () => {
    const input = 'fn main() {\n  println!("hello");\n}\n';
    const opts = resolveOptions({ mode: 'ruby', minColumn: 60, offset: 4 });
    const first = format(input, opts, '.rs', plugin);
    const second = format(first, opts, '.rs', plugin);
    expect(second).toBe(first);
  });
});
