<!-- Adapted from https://github.com/MakieOrg/Makie.jl/blob/master/docs/src/.vitepress/theme/VersionPicker.vue -->

<script setup lang="ts">
import { ref, onMounted, computed} from 'vue'
import { useData } from 'vitepress'
import VPNavBarMenuGroup from 'vitepress/dist/client/theme-default/components/VPNavBarMenuGroup.vue'
import VPNavScreenMenuGroup from 'vitepress/dist/client/theme-default/components/VPNavScreenMenuGroup.vue'

declare global {
  interface Window {
    DOC_VERSIONS?: string[];
    DOCUMENTER_CURRENT_VERSION?: string;
  }
}

const props = defineProps<{ screenMenu?: boolean }>();
const versions = ref<Array<{ text: string, link: string, class?: string }>>([]);
const currentVersion = ref('Versions');
const isClient = ref(false);
const { site } = useData();

const isLocalBuild = () => {
  return typeof window !== 'undefined' && (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1');
};

const getBaseRepository = () => {
  if (typeof window === 'undefined') return '';
  const { origin, pathname } = window.location;
  if (origin.includes('github.io')) {
    const pathParts = pathname.split('/').filter(Boolean);
    return `${origin}/${pathParts[0] ?? ''}`;
  }
  return origin;
};

// DocumenterVitepress requests `/dev/versions.js`, which only exists on github.io
// deployments; on our root custom domain the file lives at `/versions.js`, so load
// it from there when it is missing (LuxDL/DocumenterVitepress.jl#354).
const loadVersionsScript = () => {
  if (typeof window === 'undefined' || window.DOC_VERSIONS) return;
  const script = document.createElement('script');
  script.src = `${getBaseRepository()}/versions.js`;
  document.head.appendChild(script);
};

// Keep the dropdown short: named entries (`dev`, `stable`), every build of the
// newest major (v2.10, v2.11, ... with `keep = :minor` in make.jl, `v2` until
// then), one entry per older major, nothing pre-v1. Hidden builds stay deployed.
const listedVersions = (all: string[]) => {
  const major = (v: string) => Number(/^v(\d+)/.exec(v)?.[1] ?? NaN);
  const newest = Math.max(...all.map(major).filter(Number.isFinite));
  const newestHasMinors = all.some(v => major(v) === newest && v.includes('.'));
  return all.filter(v => {
    const m = major(v);
    if (Number.isNaN(m)) return true;            // dev, stable, previews/...
    if (m === 0) return false;                   // pre-v1
    if (v.includes('.')) return m === newest;    // v2.10: only for the newest major
    return m !== newest || !newestHasMinors;     // v2: until it has minor builds
  });
};

const waitForScriptsToLoad = () => {
  return new Promise<boolean>((resolve) => {
    if (isLocalBuild() || typeof window === 'undefined') {
      resolve(false);
      return;
    }
    const checkInterval = setInterval(() => {
      if (window.DOC_VERSIONS && window.DOCUMENTER_CURRENT_VERSION) {
        clearInterval(checkInterval);
        resolve(true);
      }
    }, 100);
    setTimeout(() => {
      clearInterval(checkInterval);
      resolve(false);
    }, 5000);
  });
};

const loadVersions = async () => {
  if (typeof window === 'undefined') return;

  try {
    if (isLocalBuild()) {
      versions.value = [{ text: 'dev', link: '/' }];
      currentVersion.value = 'dev';
    } else {
      loadVersionsScript();
      const scriptsLoaded = await waitForScriptsToLoad();
      const baseRepoPath = getBaseRepository();

      if (scriptsLoaded && window.DOC_VERSIONS && window.DOCUMENTER_CURRENT_VERSION) {
        // list deployed folders only: a release build's `DOCUMENTER_CURRENT_VERSION` is
        // its full version (v2.10.0), which has no folder of its own under `keep = :minor`
        versions.value = listedVersions(window.DOC_VERSIONS).map(v => ({
          text: v,
          link: `${baseRepoPath}/${v}/`
        }));
        currentVersion.value = window.DOCUMENTER_CURRENT_VERSION;
      } else {
        versions.value = [{ text: 'dev', link: `${baseRepoPath}/dev/` }];
        currentVersion.value = 'dev';
      }
    }
  } catch (error) {
    console.warn('Error loading versions:', error);
    const baseRepoPath = getBaseRepository();
    versions.value = [{ text: 'dev', link: `${baseRepoPath}/dev/` }];
    currentVersion.value = 'dev';
  }
  isClient.value = true;
};

const versionItems = computed(() => {
  return versions.value.map((v) => ({
    text: v.text,
    link: v.link
  }));
});

onMounted(() => {
  if (typeof window !== 'undefined') {
    currentVersion.value = window.DOCUMENTER_CURRENT_VERSION ?? 'Versions';
    loadVersions();
  }
});
</script>

<template>
  <template v-if="isClient">
    <VPNavBarMenuGroup
      v-if="!screenMenu && versions.length > 0"
      :item="{ text: 'Version', items: versionItems }"
      class="VPVersionPicker"
    />
    <VPNavScreenMenuGroup
      v-else-if="screenMenu && versions.length > 0"
      :text="'Version'"
      :items="versionItems"
      class="VPVersionPicker"
    />
  </template>
</template>

<style scoped>
.VPVersionPicker :deep(button .text) {
  color: var(--vp-c-text-1) !important;
}
.VPVersionPicker:hover :deep(button .text) {
  color: var(--vp-c-text-2) !important;
}
</style>
