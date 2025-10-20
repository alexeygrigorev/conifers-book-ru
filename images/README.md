# Images Directory

This directory is intended for book images and illustrations.

## Cover Image

To add a cover image:
1. Create or obtain an image (PNG or JPEG format recommended)
2. Name it `cover.png` or `cover.jpg`
3. Place it in this directory
4. The build script will automatically include it in the EPUB

## Other Images

You can add other images and reference them in Markdown chapters using:

```markdown
![Description](images/your-image.png)
```

## Image Requirements

- **Cover**: Recommended size 1600x2400 pixels (2:3 aspect ratio)
- **Content images**: Any reasonable size, will be scaled in the book
- **Format**: PNG, JPEG, or SVG
- **File size**: Keep images optimized for ebook readers (< 500KB each)
