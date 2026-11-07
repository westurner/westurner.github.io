import { expect, test } from '@playwright/test';

test('sidebar search submits the query and returns matching content', async ({ page }) => {
  const query = 'Grassmannian Plucker';

  await page.goto('/');
  const searchInput = page.locator('#searchbox input[name="q"]');
  await expect(searchInput).toHaveAccessibleName('Search this site');
  await searchInput.fill(query);
  await Promise.all([
    page.waitForURL((url) => {
      return (
        ['/search', '/search.html'].includes(url.pathname) &&
        url.searchParams.get('q') === query
      );
    }),
    searchInput.press('Enter'),
  ]);

  const results = page.locator('#search-results');
  await expect(page.locator('.searchbox input[name="q"]')).toHaveAccessibleName('Search query');
  await expect(page.getByRole('main')).toHaveCount(1);
  await expect(page.getByRole('region', { name: 'Search results' })).toBeVisible();
  await expect(results.getByRole('heading', { name: 'Matching posts' })).toBeVisible();
  await expect(results.locator('li').first()).toBeVisible();
  await expect(results).toContainText(/grassmannian[\s\S]*plucker/i);

  const result = results.locator('li').first();
  await expect(result.locator('.context')).toHaveCSS('overflow-wrap', 'anywhere');
  await expect(result.locator('.context span.highlighted').filter({ hasText: /grassmannian/i }).first()).toBeVisible();
  await expect(result.locator('.context span.highlighted').filter({ hasText: /plucker/i }).first()).toBeVisible();
  const highlightedMatch = result.locator('.context span.highlighted').first();

  await page.locator('#settings-toggle').click();
  const widthWide = await results.boundingBox();
  await page.locator('[data-display-setting="width"][data-value="narrow"]').click();
  const widthNarrow = await results.boundingBox();
  expect(widthWide && widthNarrow && widthNarrow.width).toBeLessThan(widthWide.width);

  await page.locator('[data-display-setting="line-height"][data-value="wide"]').click();
  const wideLineHeight = await results.evaluate((element) => getComputedStyle(element).lineHeight);
  await page.locator('[data-display-setting="line-height"][data-value="compact"]').click();
  const compactLineHeight = await results.evaluate((element) => getComputedStyle(element).lineHeight);
  expect(compactLineHeight).not.toBe(wideLineHeight);

  const content = page.locator('.main-container[role="main"] > .main.wrapper');
  const fontSizeOptions = page.getByRole('group', { name: 'Font size' });
  await expect(fontSizeOptions.getByRole('button')).toHaveText([
    'Small', 'Medium', 'Large', 'X-large',
  ]);
  const baseFontSize = await content.evaluate((element) => parseFloat(getComputedStyle(element).fontSize));
  await page.locator('[data-display-setting="font-size"][data-value="x-large"]').click();
  const largestFontSize = await content.evaluate((element) => parseFloat(getComputedStyle(element).fontSize));
  expect(largestFontSize).toBeGreaterThan(baseFontSize);
  await expect(page.locator('[data-display-setting="font-size"][data-value="x-large"]'))
    .toHaveAttribute('aria-pressed', 'true');

  await page.locator('html').evaluate((html) => html.setAttribute('data-theme', 'light'));
  await expect(result).toHaveCSS('background-color', 'rgb(255, 255, 255)');
  await expect(result).toHaveCSS('color', 'rgb(34, 34, 34)');
  await expect(highlightedMatch).toHaveCSS('background-color', 'rgb(255, 242, 168)');
  await expect(highlightedMatch).toHaveCSS('color', 'rgb(48, 43, 19)');

  await page.locator('html').evaluate((html) => html.setAttribute('data-theme', 'dark'));
  await expect(result).toHaveCSS('background-color', 'rgb(25, 24, 23)');
  await expect(result).toHaveCSS('color', 'rgb(176, 170, 170)');
  await expect(highlightedMatch).toHaveCSS('background-color', 'rgb(244, 201, 93)');
  await expect(highlightedMatch).toHaveCSS('color', 'rgb(33, 27, 11)');
});

test('search page shows tagged posts under matching tags', async ({ page }) => {
  await page.goto('/search.html?q=python');

  const pythonTag = page.locator('.tag-search-match[data-tag="python"]');
  await expect(pythonTag).toBeVisible();
  const expectedTagCount = await page.locator('#tag-search-index a[data-tag]').evaluateAll((links) => {
    return links.filter((link) => link.getAttribute('data-tag')?.toLowerCase().includes('python')).length;
  });
  await expect(page.locator('#tag-search-results h2')).toHaveText(`Matching tags (${expectedTagCount})`);
  const taggedPost = pythonTag.locator('ul.search li.search-result').first();
  await expect(taggedPost.locator('a').first()).toBeVisible();
  await expect(taggedPost.locator('.post-tags')).toContainText('python');
  await expect(taggedPost.locator('.post-tags a').filter({ hasText: 'python' }))
    .toHaveAttribute('href', /tags\/python\.html$/);

  await expect(page.locator('#search-results li.search-result .post-tags a').first()).toBeVisible();
});