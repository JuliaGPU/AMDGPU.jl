import DefaultTheme from "vitepress/theme";
import type { Theme as ThemeConfig } from "vitepress";
import "virtual:mathjax-styles.css";

import VersionPicker from "../../components/VersionPicker.vue";
import FeatureIcons from "../../components/FeatureIcons.vue";
import { enhanceAppWithTabs } from "vitepress-plugin-tabs/client";
import "./style.css";

export const Theme: ThemeConfig = {
  extends: DefaultTheme,
  enhanceApp({ app, router, siteData }) {
    enhanceAppWithTabs(app);
    app.component("VersionPicker", VersionPicker);
    app.component("FeatureIcons", FeatureIcons);
  },
};
export default Theme;
