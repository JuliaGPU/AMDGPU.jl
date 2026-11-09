<!--
  Icons for the feature tiles on the landing page (docs/src/index.md).

  Each <symbol> is a Lucide icon (https://lucide.dev, ISC license) and is named
  after it. A tile uses one with

      icon: '<svg class="feature-icon"><use href="#icon-NAME"/></svg>'

  To add an icon, copy the children of the Lucide SVG into a new <symbol>.
  The sprite is rendered once, hidden, by the `<FeatureIcons />` tag in index.md;
  the tile size is set in .vitepress/theme/style.css.
-->
<template>
  <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false"
       style="position: absolute; width: 0; height: 0; overflow: hidden">
    <symbol id="icon-grid-3x3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <rect width="18" height="18" x="3" y="3" rx="2"/>
      <path d="M3 9h18"/>
      <path d="M3 15h18"/>
      <path d="M9 3v18"/>
      <path d="M15 3v18"/>
    </symbol>
    <symbol id="icon-cpu" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M12 20v2"/>
      <path d="M12 2v2"/>
      <path d="M17 20v2"/>
      <path d="M17 2v2"/>
      <path d="M2 12h2"/>
      <path d="M2 17h2"/>
      <path d="M2 7h2"/>
      <path d="M20 12h2"/>
      <path d="M20 17h2"/>
      <path d="M20 7h2"/>
      <path d="M7 20v2"/>
      <path d="M7 2v2"/>
      <rect x="4" y="4" width="16" height="16" rx="2"/>
      <rect x="8" y="8" width="8" height="8" rx="1"/>
    </symbol>
    <symbol id="icon-network" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <rect x="16" y="16" width="6" height="6" rx="1"/>
      <rect x="2" y="16" width="6" height="6" rx="1"/>
      <rect x="9" y="2" width="6" height="6" rx="1"/>
      <path d="M5 16v-3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v3"/>
      <path d="M12 12V8"/>
    </symbol>
    <symbol id="icon-sigma" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M18 7V5a1 1 0 0 0-1-1H6.5a.5.5 0 0 0-.4.8l4.5 6a2 2 0 0 1 0 2.4l-4.5 6a.5.5 0 0 0 .4.8H17a1 1 0 0 0 1-1v-2"/>
    </symbol>
    <symbol id="icon-grip" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <circle cx="12" cy="5" r="1"/>
      <circle cx="19" cy="5" r="1"/>
      <circle cx="5" cy="5" r="1"/>
      <circle cx="12" cy="12" r="1"/>
      <circle cx="19" cy="12" r="1"/>
      <circle cx="5" cy="12" r="1"/>
      <circle cx="12" cy="19" r="1"/>
      <circle cx="19" cy="19" r="1"/>
      <circle cx="5" cy="19" r="1"/>
    </symbol>
    <symbol id="icon-audio-waveform" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M2 13a2 2 0 0 0 2-2V7a2 2 0 0 1 4 0v13a2 2 0 0 0 4 0V4a2 2 0 0 1 4 0v13a2 2 0 0 0 4 0v-4a2 2 0 0 1 2-2"/>
    </symbol>
    <symbol id="icon-dices" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <rect width="12" height="12" x="2" y="10" rx="2" ry="2"/>
      <path d="m17.92 14 3.5-3.5a2.24 2.24 0 0 0 0-3l-5-4.92a2.24 2.24 0 0 0-3 0L10 6"/>
      <path d="M6 18h.01"/>
      <path d="M10 14h.01"/>
      <path d="M15 6h.01"/>
      <path d="M18 9h.01"/>
    </symbol>
    <symbol id="icon-brain" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M12 18V5"/>
      <path d="M15 13a4.17 4.17 0 0 1-3-4 4.17 4.17 0 0 1-3 4"/>
      <path d="M17.598 6.5A3 3 0 1 0 12 5a3 3 0 1 0-5.598 1.5"/>
      <path d="M17.997 5.125a4 4 0 0 1 2.526 5.77"/>
      <path d="M18 18a4 4 0 0 0 2-7.464"/>
      <path d="M19.967 17.483A4 4 0 1 1 12 18a4 4 0 1 1-7.967-.517"/>
      <path d="M6 18a4 4 0 0 1-2-7.464"/>
      <path d="M6.003 5.125a4 4 0 0 0-2.526 5.77"/>
    </symbol>
    <symbol id="icon-cuboid" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="m21.12 6.4-6.05-4.06a2 2 0 0 0-2.17-.05L2.95 8.41a2 2 0 0 0-.95 1.7v5.82a2 2 0 0 0 .88 1.66l6.05 4.07a2 2 0 0 0 2.17.05l9.95-6.12a2 2 0 0 0 .95-1.7V8.06a2 2 0 0 0-.88-1.66Z"/>
      <path d="M10 22v-8L2.25 9.15"/>
      <path d="m10 14 11.77-6.87"/>
    </symbol>
  </svg>
</template>
