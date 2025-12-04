# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**LocalCafe** is a Elixir project that staticly generates a web site with help of nimble publish and heex templates. The project philosophy emphasizes semantic HTML, vanilla CSS with design tokens, and no JavaScript.

## Development Commands

### Initial Setup

```bash
mix setup  # Install deps, setup and build assets
```

### Testing

```bash
mix test                         # Run all tests
mix test test/path/to/test.exs   # Run specific test file
mix test --failed                # Run previously failed tests
```

### Asset Pipeline

```bash
mix assets.setup     # Install npm dependencies in assets folder
mix assets.build     # Build assets with source maps (development)
mix assets.deploy    # Build minified assets without source maps + digest (production)

# Or run directly in assets folder:
cd assets
npm install          # Install dependencies
npm run build        # Build assets once (with external source maps)
npm run watch        # Watch and rebuild on changes (inline source maps)
npm run deploy       # Build minified production assets (no source maps)
```

### Pre-commit Quality Checks

```bash
mix precommit  # Compile with warnings-as-errors, unlock unused deps, format, and test
```

**IMPORTANT**: Always run `mix precommit` when done with changes to ensure code quality.


**Web Layer** (FullStackingWeb):

- Router defines URL routing with pipelines (`:browser`, `:api`)
- Controllers handle traditional HTTP requests (currently just PageController)
- Components provide reusable UI elements (CoreComponents)
- Layouts define page structure (root.html.heex)
- LiveView support included but not yet heavily utilized (aligns with project vision)

### Frontend Architecture

**Current State**:

- Lightning CSS for vanilla CSS processing with autoprefixing
- TypeScript configuration present (assets/tsconfig.json)
- Build process runs independently via Node.js

**Architecture**:

- Semantic HTML with standard elements
- Vanilla CSS with design tokens and cascade layers for encapsulation
- Separate asset pipelines: ESBuild for JS, Lightning CSS for styles ✓
- No JavaScript - Dont add js unless told to.

### Asset Pipeline Configuration

**Build System**:

- Lightning CSS for CSS processing with autoprefixing and modern CSS support
- Build script: `assets/build.js` - handles both JS and CSS compilation
- Package manager: npm with `assets/package.json`
- Outputs:
  - CSS: `output/assets/css/app.css`


**CSS Architecture**:

- Entry point: `assets/css/app.css`
- Lightning CSS provides:
  - Autoprefixing for browser compatibility
  - CSS bundling with `@import` support
  - Minification in production (`npm run deploy`)
  - Modern CSS syntax support (nesting, color functions, etc.)
  - Source maps in development (external `.css.map` files)

**Source Maps**:

- **Watch mode** (`npm run watch`): Inline source maps for JS, external for CSS
- **Build mode** (`npm run build`): External source maps for both JS and CSS (`.js.map`, `.css.map`)
- **Deploy mode** (`npm run deploy`): No source maps, minified output for production

## Project-Specific Guidelines

### Philosophy Alignment

1. **Use semantic HTML with standard elements**: Avoid custom elements and web components unless explicitly requested
2. **Vanilla CSS only**: Use design tokens and semantic class names (`.site-nav`, `.btn-primary `). Tailwind/DaisyUI have been removed
3. **No JavaScript**: Have currently have zero runtime js
4. **Question LiveView usage**: Consider if a traditional controller + HTML response would suffice

**Default Approach**:

- Standard HTML elements (`<nav>`, `<button>`, `<form>`, etc.)
- Semantic class names styled with design tokens
- CSS-only interactions where possible (`:hover`, `:focus`, disclosure widgets, etc.)
- JavaScript only when specifically requested or truly necessary


### CSS Architecture

The project uses a **layered CSS architecture** with design tokens and semantic composition, inspired by Kelp UI but adapted for our needs.

**Philosophy**:

- **Semantic class names** in HTML (`.site-nav`, `.btn-primary `)
- **Design tokens** for consistent styling (`--color-primary-500`, `--space-md`)
- **Composition** over utility classes - components compose from reusable patterns
- **Modern CSS** features: nesting, layers, custom properties, container queries

**File Structure**:

```
assets/css/
├── layers.css                 # Cascade layer definitions
├── tokens/                    # Design system variables
│   ├── colors.css            # Color palette
│   ├── spacing.css           # Spacing scale
│   ├── typography.css        # Font families, sizes, weights
│   ├── sizing.css            # Border radius, shadows, z-index
│   └── breakpoints.css       # Media query breakpoints
├── base/                      # Foundation styles
│   ├── reset.css             # Modern CSS reset
│   └── elements.css          # Styled HTML elements
├── utilities/                 # Reusable patterns (for composition, not HTML)
│   ├── layout.css            # Layout patterns (:container, :stack, :grid)
│   └── patterns.css          # Common patterns (:focus-ring, :surface)
├── components/                # Semantic component styles
│   ├── navigation.css
│   ├── buttons.css
│   ├── forms.css
│   └── ...
└── app.css                    # Main stylesheet (imports everything)
```

**Cascade Layers** (lowest to highest priority):

1. `reset` - CSS reset
2. `tokens` - Design system variables
3. `base` - Base HTML element styles
4. `utilities` - Reusable patterns
5. `components` - Component styles
6. `overrides` - Project-specific overrides

**Using Design Tokens**:

```css
.my-component {
  color: var(--color-text-primary);
  padding: var(--space-md);

  font-size: var(--text-base);
}
```

**Composing from Utilities** (using CSS nesting):

```css
.my-component {
  /* Use utility patterns as building blocks */
  display: flex;
  flex-direction: column;
  gap: var(--space-md);

  & > * + * {
    /* Stack pattern */
    margin-top: var(--space-md);
  }

  &:focus-visible {
    /* Focus ring pattern */
    outline: var(--focus-ring-width) solid var(--focus-ring-color);
    outline-offset: var(--focus-ring-offset);
  }
}
```

**Modern CSS Support** (via Lightning CSS):

- CSS nesting (native syntax)
- Custom properties (CSS variables)
- `color-mix()` for transparency
- Container queries
- Modern selectors (`:has()`, `:is()`, `:where()`)
- Autoprefixing for browser compatibility
- `@layer` for cascade management

**Component Styling**:

- Use semantic class names that describe purpose, not appearance
- Style with design tokens for consistency
- Example: `.site-header`, `.post-card`, `.btn-primary `
- Avoid: `.bg-blue-500`, `.flex`, `.mt-4` (utility classes)

**Component Pattern** (Standard HTML with Semantic Classes):

```heex
<!-- lib/full_stacking_web/components/core_components.ex -->
def alert(assigns) do
  ~H"""
  <div class="alert" role="alert" data-kind={@kind}>
    <div class="alert-content">
      <p class="alert-message">{@message}</p>
    </div>
    <button class="alert-close" aria-label="Close">×</button>
  </div>
  """
end
```

```css
/* assets/css/components/alert.css */
@layer components {
  .alert {
    display: flex;
    gap: var(--space-3);
    padding: var(--space-4);
    background-color: var(--color-surface-primary);

    border-left: 4px solid var(--color-gray-400);
  }

  .alert[data-kind="info"] {
    border-left-color: var(--color-primary-500);
    background-color: var(--color-primary-50);
  }

  .alert[data-kind="error"] {
    border-left-color: var(--color-error-500);
    background-color: var(--color-error-50);
  }

  .alert-close {
    color: var(--color-text-secondary);
    background: none;
    border: none;
    cursor: pointer;
  }

  .alert-close:hover {
    color: var(--color-text-primary);
  }
}
```

This approach uses:

- Standard HTML elements (`<div>`, `<button>`)
- Semantic class names (`.alert`, `.alert-close`)
- Design tokens for all styling
- Data attributes for variants (`data-kind="info"`)
- CSS-only hover states (no JavaScript required)

### JavaScript and Web Components

**IMPORTANT**: This project has no JavaScript and avoids web components unless explicitly requested.

**Default Approach**:

- Use standard HTML elements (`<div>`, `<nav>`, `<button>`, `<article>`, etc.)
- Style with semantic CSS classes and design tokens
- Avoid custom elements (`<flash-message>`, `<custom-dropdown>`, etc.)
- Only add JavaScript when specifically requested by the user

### Build System & Live Reload

**Asset Build**: npm-based build system (configured in `assets/build.js`)

- Lightning CSS for CSS processing ✓
- Single build script handles both JS and CSS compilation


**Adding New CSS Files**:

- Create CSS files in `assets/css/`
- Import them in `assets/css/app.css` with `@import "./path/to/file.css"`
- Lightning CSS will bundle them automatically
- Organized by component: `assets/css/components/buttons.css`, etc.

### Elixir Best Practices

**Elixir**:

- Lists don't support index-based access syntax (`list[i]` is invalid)
- Use pattern matching and `Enum` functions instead
- Follow Elixir naming conventions (snake_case for functions/variables)

**Templates**:

- HEEx templates use `{...}` for attribute interpolation
- Use `<%= %>` for body content
- Keep logic minimal - move complex logic to controllers or context modules

**Runing locally**:
- `mix setup`
- `mix build`
- `cd output && python3 -m http.server 8000`
