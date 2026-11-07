import { defineConfig } from '@playwright/test';

const port = process.env.PW_PORT || '18284';

export default defineConfig({
  testDir: './tests',
  use: {
    baseURL: `http://127.0.0.1:${port}`,
  },
  webServer: {
    command: `python3 -m http.server ${port} --directory blog/html`,
    cwd: '..',
    url: `http://127.0.0.1:${port}`,
    reuseExistingServer: !process.env.CI,
  },
});