# LocalCafe

LocalCafe is a website builder specifically designed for small, independent restaurants and cafes.
It creates a professional website that can cost nothing to host and are easy to update.

---

## Features

### Free / No Monthly Fees
- This project is open source and free
- This project can host for free on GitHub Pages, Netlify, or Cloudflare Pages

### Static Website
- Fast page loads - everything pre-generated
- No database or server required

### Online Menu
- Display your full menu with photos, descriptions, and prices
- Highlight daily specials above the menu (no tags, stands out visually)
- Single prices or multiple options (small/large, hot/iced, etc.)
- Control the order items appear with position field
- Customers filter by tags (vegetarian, gluten-free, breakfast, lunch)
- Update by editing simple text files

### Location & Maps
- Show one location or multiple locations
- Automatic maps - just provide your address
- Each location has its own hours, phone, and email
- Maps adjust to any screen size

### Photo Slideshow
- Homepage displays rotating photos with smooth transitions
- Supports single image or multiple images
- Photos fade between each other automatically

### Mobile Responsive
- Works on all phones and tablets
- Menu and navigation adapt to screen size
- No pinching or zooming required

### Social Sharing
- Links shared on Facebook, Twitter, Instagram show rich previews
- Displays your photo and description automatically

### Social Media Links
- Display social media icons in the footer
- Links to your Instagram, Facebook, X (Twitter), and more
- Simple configuration with platform and URL
- Available platforms: bluesky, doordash, facebook, github, instagram, tiktok, ubereats, x, yelp

---

## Configuration

### Site Settings
Edit `priv/home.md` to configure your site:

```elixir
%{
  site_name: "Your Cafe Name",
  title: "Home",
  description: "Your tagline",
  image: "/images/preview.jpg",           # Social sharing image
  logo: "/images/logo.png",               # Optional: Logo in navigation
  hero: ["Main headline", "Subheading"],   # Hero text lines
  hero_image: ["/images/hero_1.jpg"],      # Single image or list
  domain: "https://yourcafe.com",         # Full URL including path for GitHub Pages
  social_links: [                         # Optional: Social media links
    instagram: "https://instagram.com/yourcafe",
    facebook: "https://facebook.com/yourcafe",
    x: "https://x.com/yourcafe"
  ]
}
```

**Note on `domain`:**
- For root domain: `domain: "https://yourcafe.com"`
- For GitHub Pages subdirectory: `domain: "https://username.github.io/repo-name"`

The path from the domain is automatically used for all internal links.

**Note on `social_links`:**
- Optional field - footer displays icons only if configured
- Available platforms: `bluesky`, `doordash`, `facebook`, `github`, `instagram`, `tiktok`, `ubereats`, `x`, `yelp`
- Icons appear in the footer above the copyright text
- Each link opens in a new tab

### Menu Items
Create markdown files in `priv/menu/`. File name becomes URL path.

**Single price:**
```elixir
%{
  title: "Espresso",
  prices: "$3.50",
  tags: ~w(coffee hot),
  description: "Rich, bold espresso",
  image: "/images/espresso.jpg"
}
---
Your detailed description here...
```

**Multiple prices:**
```elixir
%{
  title: "Latte",
  prices: [small: "$4.50", large: "$5.50"],
  tags: ~w(coffee hot dairy),
  description: "Smooth espresso with steamed milk",
  image: "/images/latte.jpg"
}
```

**Controlling display order:**

Add a `position` field to control the order items appear on the menu (0-indexed, lower numbers first):

```elixir
%{
  title: "Featured Special",
  prices: "$8.99",
  tags: ~w(featured lunch),
  description: "Today's special",
  image: "/images/special.jpg",
  position: 0  # Appears first
}
```

- Items are sorted by `position` first, then alphabetically by title
- Items with the same position are sorted alphabetically
- Items without a position appear at the end, sorted alphabetically

### Specials

Create markdown files in `priv/specials/` for daily specials and temporary deals. Specials appear above the menu grid and don't have tags (no filtering).

```elixir
%{
  title: "Today's Special",
  prices: "$9.99",
  description: "Chef's selection with seasonal ingredients",
  image: "/images/special.jpg",
  position: 0
}
---
Ask your server about today's special!
```

**Key differences from menu items:**
- No `tags` field (specials aren't filterable)
- Displayed above the regular menu in a highlighted section
- Perfect for daily specials, seasonal items, or limited-time offers
- Automatically hidden when `priv/specials/` is empty
- "SPECIAL" badge automatically appears in corner

**Dynamic layouts based on number of specials:**
- **1 special:** Full-width horizontal layout with image on left, content on right
- **2 specials:** Two-column layout, each special gets 50% width
- **3+ specials:** Three-column grid layout (responsive)
- **Mobile:** All layouts stack vertically on smaller screens

### Locations
Create markdown files in `priv/locations/`. Coordinates fetched automatically.

```elixir
%{
  name: "Downtown Location",
  street: "123 Main Street",
  city_state: "Portland, OR 97202",
  phone: "(555) 123-4567",
  email: "hello@yourcafe.com",
  hours: ["Mon-Fri: 7am-7pm", "Sat-Sun: 8am-8pm"]
}
---
Visit us in the heart of downtown!
```

To skip the map, add coordinates manually:
```elixir
%{
  # ... other fields ...
  latitude: "45.5050932",
  longitude: "-122.6445551"
}
```

### Tags
Tags enable filtering. Use any keywords:
- Dietary: `vegetarian`, `vegan`, `gluten-free`, `dairy-free`
- Categories: `breakfast`, `lunch`, `dinner`, `dessert`
- Types: `coffee`, `tea`, `sandwich`, `salad`, `soup`

### Hero Images
**Single image:**
```elixir
hero_image: "/images/hero.jpg"
```

**Slideshow (fades every 5 seconds):**
```elixir
hero_image: ["/images/hero_1.jpg", "/images/hero_2.jpg", "/images/hero_3.jpg"]
```

### Colors
Edit `assets/css/tokens/colors.css` to customize your color scheme:

```css
--color-primary: oklch(0.333 0.013 255);
--color-accent: oklch(0.45 0.08 30);
--color-background: oklch(1.0 0 0);
```

### Typography
Edit `assets/css/tokens/typography.css`:

```css
--font-display: "Georgia", serif;
--font-base: "Helvetica", sans-serif;
--text-base: 1rem;
--text-lg: 1.125rem;
```

### Build Commands
```bash
mix setup          # Initial setup
mix build          # Generate static site
mix test           # Run tests
mix precommit      # Run all checks before committing
```

### Deployment
Generated site is in `priv/output/`. Upload this folder to:
- **GitHub Pages:** Push to `gh-pages` branch
- **Netlify:** Set publish directory to `priv/output`
- **Cloudflare Pages:** Set build output to `priv/output`

## Quick Start

### Prerequisites
- Elixir 1.15+
- Node.js 18+ (for css building)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/local_cafe_lite.git
   cd local_cafe_lite
   ```

2. **Install dependencies**
   ```bash
   mix setup
   ```

3. **Configure your site**
   Edit `priv/home.md` with your cafe details:
   ```elixir
   %{
     site_name: "Your Cafe Name",
     title: "Home",
     description: "Your cafe description",
     image: "/images/preview.jpg",
     hero: ["Welcome message here"],
     hero_image: ["/images/hero_1.jpg"],
     domain: "https://yourcafe.com",
     social_links: [  # Optional
       instagram: "https://instagram.com/yourcafe",
       facebook: "https://facebook.com/yourcafe"
     ]
   }
   ```

4. **Add your menu items**
   Create markdown files in `priv/menu/`:
   ```markdown
   # /menu/coffee.md
   %{
     title: "Espresso",
     prices: [single: "$3.50", double: "$4.50"],
     tags: ~w(coffee hot),
     description: "Rich, bold espresso",
     image: "/images/espresso.jpg",
     position: 0  # Optional: controls display order (0 = first)
   }
   ---

   Our signature espresso made from locally roasted beans...
   ```

5. **Add your locations**
   Create markdown files in `priv/locations/`:
   ```markdown
   # /locations/downtown.md
   %{
     name: "Downtown Location",
     street: "123 Main Street",
     city_state: "Portland, OR 97202",
     phone: "(555) 123-4567",
     email: "hello@yourcafe.com",
     hours: ["Mon-Fri: 7am - 7pm", "Sat-Sun: 8am - 8pm"]
   }
   ---

   Visit us in the heart of downtown!
   ```

6. **Add your images**
   Place images in `priv/output/images/`:
   - Hero images: `hero_1.jpg`, `hero_2.jpg`, etc.
   - Menu item images: `coffee.jpg`, `pastry.jpg`, etc.
   - Preview image for social sharing: `preview.jpg`

7. **Build your site**
   ```bash
   mix build
   ```

8. **Preview locally**
   ```bash
   cd priv/output
   python3 -m http.server 8000
   ```
   Open http://localhost:8000 in your browser

## Project Structure

```
local_cafe_lite/
├── assets/
│   ├── css/              # Stylesheets
│   │   ├── tokens/       # Design tokens (colors, spacing, typography)
│   │   ├── base/         # Reset and base styles
│   │   ├── utilities/    # Reusable patterns
│   │   └── components/   # Component styles
├── lib/
│   ├── local_cafe.ex     # Main module with templates
│   └── local_cafe/
│       ├── menu.ex       # Menu module
│       ├── menu/
│       │   └── item.ex   # Menu item struct
│       ├── location.ex   # Location module
│       ├── location/
│       │   └── item.ex   # Location struct with geocoding
│       ├── site.ex       # Site settings module
│       └── home.ex       # Home page struct
├── priv/
│   ├── home.md           # Site configuration
│   ├── menu/             # Menu item markdown files
│   ├── specials/         # Daily specials markdown files
│   ├── locations/        # Location markdown files
│   └── output/           # Generated static site
└── mix.exs               # Project configuration
```

## Customization

### Colors
Edit `assets/css/tokens/colors.css` to customize your color scheme using design tokens.

### Typography
Edit `assets/css/tokens/typography.css` to change fonts and text sizes.

### Layout
Edit `assets/css/components/` files to customize component styles.

## Deployment

### GitHub Pages (Automatic with GitHub Actions)
1. Push your code to GitHub
2. Go to repository Settings → Pages
3. Under "Build and deployment", set Source to "GitHub Actions"
4. Push to the `main` branch - the site will build and deploy automatically
5. Your site will be available at `https://yourusername.github.io/repository-name/`

**Note:** The `.github/workflows/deploy.yml` file is already configured to build and deploy on every push to `main`.

### Netlify
1. Connect your repository
2. Set build command: `mix build`
3. Set publish directory: `priv/output`

### Cloudflare Pages
1. Connect your repository
2. Set build command: `mix setup && mix build`
3. Set build output directory: `priv/output`

## Development

### Running Tests
```bash
mix test
```

### Pre-commit Checks
```bash
mix precommit
```
Runs compilation with warnings-as-errors, formatting, and tests.

### Asset Development
```bash
cd assets
npm run watch    # Watch mode with live rebuild
npm run build    # Production build
```

## Philosophy

LocalCafe emphasizes:
- **Semantic HTML** - Standard elements, accessible markup
- **Vanilla CSS** - No frameworks, just design tokens and composition
- **Zero Runtime JavaScript** - No JS required at runtime.
- **Static generation** - Fast, secure, and free to host
- **Small business friendly** - Easy to use, easy to maintain

## Contributing

We welcome contributions! This project aims to support independent restaurants and cafes with limited budgets. Please keep the code simple, maintainable, and accessible.

## License

MIT

## Support

Built for the restaurant and cafe community. If you use LocalCafe for your business, consider contributing improvements back to help other small businesses!
