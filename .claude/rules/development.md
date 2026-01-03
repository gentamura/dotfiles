# Development Rules

## File Formatting

- All files must end with an actual newline character
- Let tools (e.g., Biome) handle formatting
- Avoid manual line breaks within a single sentence

## Tools

- Use `rg` (ripgrep) instead of `grep` whenever possible
- Use `psql` directly for database access
- Check `context7` documentation before implementing frameworks/libraries

## Development Server

- Check the port in `package.json` before starting
- The server is usually already running
- If restart needed, kill existing process first
- Never start in background using `&`

## Conventions

- Follow existing conventions before introducing new patterns
- Keep documentation, comments, and text in English
- Coordinate schema changes via Drizzle migrations
