import DefaultTheme from "vitepress/theme";
import type { Theme as ThemeConfig } from "vitepress";

import VersionPicker from "../../components/VersionPicker.vue";
import { enhanceAppWithTabs } from "vitepress-plugin-tabs/client";
import "./style.css";

export const Theme: ThemeConfig = {
  extends: DefaultTheme,
  enhanceApp({ app, router, siteData }) {
    enhanceAppWithTabs(app);
    app.component("VersionPicker", VersionPicker);
  },
};
export default Theme;
