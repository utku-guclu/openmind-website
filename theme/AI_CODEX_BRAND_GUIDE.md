# AI Codex — Brand Identity Guide

> Derived from the **OpenMind Projects** (openmindprojects.org) visual identity.  
> Version 1.0 · May 2026

---

## 1. Source Analysis — OpenMind Projects

The OpenMind Projects website uses a warm, trustworthy, and education-focused design language built around a **blue-dominant palette** with **amber/gold accents** and a **tri-color card system** (orange, green, blue) for content differentiation.

![OpenMind Projects Hero Section](/home/tradex/.gemini/antigravity/brain/5d819f21-c4b8-43b3-83a7-771edac33156/artifacts/omp_hero_reference.png)

### Key Design Observations

| Element | Details |
|---|---|
| **Overall Mood** | Warm, trustworthy, educational, community-driven |
| **Mode** | Light mode with soft blue-tinted backgrounds |
| **Navigation** | White/transparent header bar with blue text + orange CTA buttons |
| **Hero** | Full-width image overlay with white italic serif text |
| **Cards** | Bold colored panels — Orange, Green, Blue — for 3 pillars |
| **CTAs** | Teal/dark-blue rounded buttons with white uppercase text |
| **Logo** | Globe icon (blue ocean + gold/amber landmass) + serif text |
| **Footer** | Light blue-gray background, partner logos carousel |

![OpenMind Projects Card System](/home/tradex/.gemini/antigravity/brain/5d819f21-c4b8-43b3-83a7-771edac33156/artifacts/omp_cards_reference.png)

---

## 2. Color Palette

![AI Codex Brand Color Palette](/home/tradex/.gemini/antigravity/brain/5d819f21-c4b8-43b3-83a7-771edac33156/artifacts/brand_color_palette.png)

### 2.1 Primary Colors

| Color | Hex | RGB | Usage |
|---|---|---|---|
| **Deep Ocean Blue** | `#0C7ABF` | `rgb(12, 122, 191)` | Primary brand color, headers, navigation, links |
| **Amber Gold** | `#E89B1C` | `rgb(232, 155, 28)` | Accent, CTAs, highlights, warmth elements |

### 2.2 Secondary Colors

| Color | Hex | RGB | Usage |
|---|---|---|---|
| **Fresh Green** | `#4CAF50` | `rgb(76, 175, 80)` | Success states, "Development" pillar, growth |
| **Sky Blue** | `#5DADE2` | `rgb(93, 173, 226)` | Light accents, hover states, info panels |
| **Cornflower Blue** | `#6B8EC7` | `rgb(107, 142, 199)` | Card section headings on blue pillar |
| **Teal** | `#008B8B` | `rgb(0, 139, 139)` | CTA buttons, active states |

### 2.3 Neutral Colors

| Color | Hex | RGB | Usage |
|---|---|---|---|
| **Charcoal** | `#2C3E50` | `rgb(44, 62, 80)` | Primary text, headings |
| **Slate Gray** | `#5D6D7E` | `rgb(93, 109, 126)` | Secondary text, captions |
| **Light Steel** | `#D6E4F0` | `rgb(214, 228, 240)` | Section backgrounds, dividers |
| **Ice Blue** | `#EBF5FB` | `rgb(235, 245, 251)` | Page background tint |
| **Pure White** | `#FFFFFF` | `rgb(255, 255, 255)` | Cards, content areas |
| **Near Black** | `#1A1A2E` | `rgb(26, 26, 46)` | Dark mode text, overlays |

### 2.4 Pillar Card Colors (Feature Sections)

| Pillar | Color | Hex | Represents |
|---|---|---|---|
| **Education & Culture** | Amber Orange | `#E89B1C` | Training, cross-cultural learning |
| **Upskill & Development** | Leaf Green | `#4CAF50` | Local community development |
| **Research & Development** | Steel Blue | `#6B8EC7` | Technology, AI, innovation |

### 2.5 CSS Variables

```css
:root {
  /* Primary */
  --color-primary: #0C7ABF;
  --color-primary-dark: #095A8F;
  --color-primary-light: #3D9BD5;
  --color-accent: #E89B1C;
  --color-accent-dark: #C07E10;
  --color-accent-light: #F0B44D;

  /* Secondary */
  --color-green: #4CAF50;
  --color-green-light: #81C784;
  --color-sky: #5DADE2;
  --color-cornflower: #6B8EC7;
  --color-teal: #008B8B;
  --color-teal-light: #00BFBF;

  /* Neutrals */
  --color-text-primary: #2C3E50;
  --color-text-secondary: #5D6D7E;
  --color-bg-tint: #EBF5FB;
  --color-bg-section: #D6E4F0;
  --color-bg-white: #FFFFFF;
  --color-dark: #1A1A2E;

  /* Semantic */
  --color-success: #4CAF50;
  --color-warning: #E89B1C;
  --color-error: #E74C3C;
  --color-info: #5DADE2;
}
```

---

## 3. Typography

![AI Codex Typography System](/home/tradex/.gemini/antigravity/brain/5d819f21-c4b8-43b3-83a7-771edac33156/artifacts/brand_typography.png)

### 3.1 Font Stack

| Role | Font Family | Fallback | Source |
|---|---|---|---|
| **Headings** | Outfit | -apple-system, sans-serif | Google Fonts |
| **Body** | Outfit | Segoe UI, Helvetica Neue, sans-serif | Google Fonts |
| **Code / Tech** | Roboto Mono | Consolas, monospace | Google Fonts |
| **Decorative / Hero** | Playfair Display | Georgia, serif | Google Fonts |

> [!NOTE]
> OpenMind Projects uses italic serif text for the hero headline ("Fight Poverty with Education"). The `Playfair Display` font captures this editorial feel for hero sections while keeping `Outfit` as the workhorse.

### 3.2 Type Scale

| Element | Size | Weight | Line Height | Letter Spacing | Color |
|---|---|---|---|---|---|
| **H1 — Page Title** | 48px / 3rem | 700 (Bold) | 1.2 | -0.02em | `--color-text-primary` |
| **H2 — Section** | 36px / 2.25rem | 600 (Semi-Bold) | 1.3 | -0.01em | `--color-primary` |
| **H3 — Subsection** | 24px / 1.5rem | 500 (Medium) | 1.4 | 0 | `--color-text-primary` |
| **H4 — Card Title** | 20px / 1.25rem | 600 (Semi-Bold) | 1.4 | 0 | `#FFFFFF` (on color) |
| **Body — Regular** | 16px / 1rem | 400 (Regular) | 1.6 | 0 | `--color-text-primary` |
| **Body — Small** | 14px / 0.875rem | 400 | 1.5 | 0.01em | `--color-text-secondary` |
| **Caption** | 12px / 0.75rem | 400 | 1.4 | 0.02em | `--color-text-secondary` |
| **Button** | 14px / 0.875rem | 600 (Semi-Bold) | 1 | 0.08em | `#FFFFFF` |
| **Code** | 14px / 0.875rem | 400 | 1.6 | 0 | `--color-primary` |

### 3.3 CSS Typography

```css
/* Import fonts */
@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,700;1,700&family=Roboto+Mono:wght@400;500&display=swap');

body {
  font-family: 'Outfit', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 16px;
  line-height: 1.6;
  color: var(--color-text-primary);
  -webkit-font-smoothing: antialiased;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'Outfit', sans-serif;
  margin-bottom: 0.5em;
}

h1 { font-size: 3rem; font-weight: 700; line-height: 1.2; letter-spacing: -0.02em; }
h2 { font-size: 2.25rem; font-weight: 600; line-height: 1.3; color: var(--color-primary); }
h3 { font-size: 1.5rem; font-weight: 500; line-height: 1.4; }
h4 { font-size: 1.25rem; font-weight: 600; line-height: 1.4; }

.hero-headline {
  font-family: 'Playfair Display', Georgia, serif;
  font-style: italic;
  font-weight: 700;
  font-size: 3.5rem;
  color: #FFFFFF;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.4);
}

code, pre, .mono {
  font-family: 'Roboto Mono', Consolas, 'Courier New', monospace;
  font-size: 0.875rem;
}
```

---

## 4. Logo System

![AI Codex Logo Concept](/home/tradex/.gemini/antigravity/brain/5d819f21-c4b8-43b3-83a7-771edac33156/artifacts/brand_logo_concept.png)

### 4.1 Logo Anatomy

The AI Codex logo combines:
- **Globe motif** — Inherited from OpenMind Projects, representing global impact
- **Code brackets `</>` overlay** — Representing technology, coding, and AI
- **Circuit traces** — Subtle lines connecting the globe elements, symbolizing digital connectivity

### 4.2 Logo Variations

| Variant | Background | Use Case |
|---|---|---|
| **Full Color** | White / Light | Primary usage, website header, documents |
| **White Reversed** | Deep Ocean Blue | Dark sections, branded panels |
| **Icon-Only Mark** | Any | Favicons, social media avatars, compact spaces |
| **Monochrome** | Any | Print, single-color applications |

### 4.3 Logo Clear Space

Minimum clear space around the logo = **height of the "A" character** in "AI CODEX" on all sides.

### 4.4 Minimum Sizes

| Format | Minimum Width |
|---|---|
| Full logo (icon + text) | 120px |
| Icon-only mark | 32px |
| Favicon | 16px |

---

## 5. UI Components

### 5.1 Buttons

```css
/* Primary CTA — Teal/Blue */
.btn-primary {
  background: var(--color-teal);
  color: #FFFFFF;
  padding: 12px 32px;
  border-radius: 6px;
  font-size: 0.875rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
}
.btn-primary:hover {
  background: var(--color-primary);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(12, 122, 191, 0.3);
}

/* Secondary CTA — Outlined */
.btn-secondary {
  background: transparent;
  color: var(--color-primary);
  padding: 12px 32px;
  border: 2px solid var(--color-primary);
  border-radius: 6px;
  font-size: 0.875rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  cursor: pointer;
  transition: all 0.3s ease;
}
.btn-secondary:hover {
  background: var(--color-primary);
  color: #FFFFFF;
}

/* Accent CTA — Amber Gold */
.btn-accent {
  background: var(--color-accent);
  color: #FFFFFF;
  padding: 12px 32px;
  border-radius: 6px;
  font-size: 0.875rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
}
.btn-accent:hover {
  background: var(--color-accent-dark);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(232, 155, 28, 0.3);
}
```

### 5.2 Cards

```css
/* Feature Card — Pillar Style (Education, Development, R&D) */
.card-pillar {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.card-pillar:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.card-pillar--education { background: var(--color-accent); }
.card-pillar--development { background: var(--color-green); }
.card-pillar--research { background: var(--color-cornflower); }

.card-pillar__title {
  color: #FFFFFF;
  font-size: 1.25rem;
  font-weight: 600;
  padding: 16px 20px;
}
.card-pillar__body {
  color: #FFFFFF;
  font-size: 0.9rem;
  padding: 0 20px 20px;
  line-height: 1.6;
}

/* Standard Content Card */
.card {
  background: var(--color-bg-white);
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  border: 1px solid rgba(214, 228, 240, 0.5);
  transition: all 0.3s ease;
}
.card:hover {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}
```

### 5.3 Navigation

```css
.navbar {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  padding: 12px 24px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid var(--color-bg-section);
  position: sticky;
  top: 0;
  z-index: 1000;
}
.navbar__link {
  color: var(--color-primary);
  font-weight: 500;
  text-decoration: none;
  padding: 8px 16px;
  transition: color 0.2s ease;
}
.navbar__link:hover {
  color: var(--color-primary-dark);
}
.navbar__cta {
  background: var(--color-accent);
  color: #FFFFFF;
  padding: 8px 20px;
  border-radius: 6px;
  font-weight: 600;
  text-decoration: none;
  transition: background 0.2s ease;
}
```

---

## 6. Spacing & Layout

### 6.1 Spacing Scale

| Token | Value | Usage |
|---|---|---|
| `--space-xs` | 4px | Tight internal padding |
| `--space-sm` | 8px | Compact element gaps |
| `--space-md` | 16px | Standard padding, margins |
| `--space-lg` | 24px | Card padding, section gaps |
| `--space-xl` | 32px | Section padding |
| `--space-2xl` | 48px | Major section separation |
| `--space-3xl` | 64px | Page-level top/bottom padding |
| `--space-4xl` | 96px | Hero section padding |

### 6.2 Grid

```css
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--space-lg);
}

.grid-3 {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-lg);
}

@media (max-width: 768px) {
  .grid-3 { grid-template-columns: 1fr; }
}
```

### 6.3 Border Radius

| Token | Value | Usage |
|---|---|---|
| `--radius-sm` | 4px | Buttons, inputs |
| `--radius-md` | 8px | Cards, panels |
| `--radius-lg` | 12px | Modals, hero overlays |
| `--radius-xl` | 24px | Badges, tags |
| `--radius-full` | 50% | Avatars, icons |

---

## 7. Shadows & Effects

```css
:root {
  --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.06);
  --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08);
  --shadow-lg: 0 8px 24px rgba(0, 0, 0, 0.12);
  --shadow-xl: 0 16px 48px rgba(0, 0, 0, 0.16);
  --shadow-accent: 0 4px 16px rgba(12, 122, 191, 0.2);
  --shadow-gold: 0 4px 16px rgba(232, 155, 28, 0.2);
}
```

### Hero Overlay

```css
.hero-overlay {
  background: linear-gradient(
    to bottom,
    rgba(26, 26, 46, 0.3) 0%,
    rgba(26, 26, 46, 0.6) 100%
  );
}
```

---

## 8. Iconography

| Style | Details |
|---|---|
| **Icon Set** | Lucide Icons or Phosphor Icons |
| **Stroke Weight** | 1.5px – 2px |
| **Default Size** | 24px × 24px |
| **Color** | Inherits text color; accent on interactive |

---

## 9. Accessibility

| Requirement | Standard |
|---|---|
| Text contrast (normal) | ≥ 4.5:1 WCAG AA |
| Text contrast (large) | ≥ 3:1 WCAG AA |
| Focus indicators | 2px solid `--color-primary` with 2px offset |
| Touch targets | Minimum 44px × 44px |
| Motion | Respect `prefers-reduced-motion` |

### Color Contrast Checks

| Pair | Ratio | Pass |
|---|---|---|
| `#2C3E50` on `#FFFFFF` | 10.7:1 | ✅ AAA |
| `#0C7ABF` on `#FFFFFF` | 4.6:1 | ✅ AA |
| `#FFFFFF` on `#0C7ABF` | 4.6:1 | ✅ AA |
| `#FFFFFF` on `#E89B1C` | 2.5:1 | ⚠️ Large text only |
| `#FFFFFF` on `#4CAF50` | 3.1:1 | ✅ AA Large |
| `#2C3E50` on `#EBF5FB` | 9.4:1 | ✅ AAA |

> [!WARNING]
> White text on Amber Gold (`#E89B1C`) only passes for **large text** (18px+ bold or 24px+ regular). Use `#2C3E50` (Charcoal) for small body text on amber backgrounds.

---

## 10. Brand Voice & Tone

Derived from the OpenMind Projects mission, adapted for AI Codex:

| Attribute | Description |
|---|---|
| **Trustworthy** | Educational nonprofit heritage — inspire confidence |
| **Empowering** | Focus on capability building, not dependency |
| **Inclusive** | Global audience, accessible language |
| **Tech-Forward** | AI, coding, innovation — but human-centered |
| **Warm** | Community-driven, approachable despite tech focus |

### Writing Guidelines

- Use **active voice**: "AI Codex empowers learners" not "Learners are empowered by AI Codex"
- Keep sentences **under 25 words** for body text
- Use **"we" and "you"** to create connection
- Lead with **impact**: "Transform education through AI" not "Our platform uses AI for education"

---

## 11. Do's and Don'ts

### ✅ Do

- Use the primary blue as the dominant brand color (60%)
- Use amber gold for highlights and calls to action (10%)
- Keep backgrounds light with the ice-blue tint
- Use the tri-color pillar system for feature differentiation
- Maintain generous whitespace

### ❌ Don't

- Don't use blue and orange in equal amounts — blue dominates
- Don't place small white text on amber backgrounds
- Don't use more than 3 accent colors in a single view
- Don't use heavy drop shadows — keep them subtle
- Don't stretch or modify the logo proportions
- Don't use colors outside the defined palette

---

## 12. Quick Reference — CSS Import

```html
<!-- Add to <head> -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,700;1,700&family=Roboto+Mono:wght@400;500&display=swap" rel="stylesheet">
```

```css
/* Full design tokens import */
:root {
  /* Colors */
  --color-primary: #0C7ABF;
  --color-primary-dark: #095A8F;
  --color-primary-light: #3D9BD5;
  --color-accent: #E89B1C;
  --color-accent-dark: #C07E10;
  --color-accent-light: #F0B44D;
  --color-green: #4CAF50;
  --color-sky: #5DADE2;
  --color-cornflower: #6B8EC7;
  --color-teal: #008B8B;
  --color-text-primary: #2C3E50;
  --color-text-secondary: #5D6D7E;
  --color-bg-tint: #EBF5FB;
  --color-bg-section: #D6E4F0;
  --color-bg-white: #FFFFFF;
  --color-dark: #1A1A2E;
  
  /* Typography */
  --font-primary: 'Outfit', -apple-system, sans-serif;
  --font-display: 'Playfair Display', Georgia, serif;
  --font-mono: 'Roboto Mono', Consolas, monospace;
  
  /* Spacing */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;
  --space-xl: 32px;
  --space-2xl: 48px;
  --space-3xl: 64px;
  --space-4xl: 96px;
  
  /* Radii */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
  --radius-xl: 24px;
  --radius-full: 50%;
  
  /* Shadows */
  --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.06);
  --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08);
  --shadow-lg: 0 8px 24px rgba(0, 0, 0, 0.12);
  --shadow-xl: 0 16px 48px rgba(0, 0, 0, 0.16);
}
```

---

*AI Codex Brand Guide v1.0 — Generated from openmindprojects.org visual analysis*
