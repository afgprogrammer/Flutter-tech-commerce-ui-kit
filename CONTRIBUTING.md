# Contributing to Como

First off, thank you for considering contributing to Como! 🎉

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### 🐛 Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and what you expected**
- **Include screenshots if possible**
- **Include your environment details** (Flutter version, device, OS, etc.)

### 💡 Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **Include mockups or examples if applicable**

### 🔧 Pull Requests

1. Fork the repository
2. Create your feature branch from `main`:
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. Make your changes
4. Ensure your code follows the project's coding standards
5. Run tests if applicable
6. Commit your changes with clear commit messages:
   ```bash
   git commit -m "feat: add amazing feature"
   ```
7. Push to your branch:
   ```bash
   git push origin feature/amazing-feature
   ```
8. Open a Pull Request

## Development Guidelines

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use consistent formatting (run `flutter format .`)

### Project Structure

- Place new screens in appropriate feature folders under `lib/features/`
- Shared widgets go in `lib/shared/widgets/`
- Constants should be added to appropriate files in `lib/core/constants/`
- Follow the existing folder structure

### Widget Guidelines

- Prefer `const` constructors when possible
- Extract reusable widgets into separate files
- Use meaningful widget names that describe their purpose
- Keep widgets focused and single-purpose

### Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `camelCase` or `UPPER_SNAKE_CASE` for compile-time constants
- **Private members**: prefix with `_`

### Commit Message Guidelines

We follow conventional commits format:

```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(cart): add quantity selector
fix(product): resolve image loading issue
docs(readme): update installation instructions
```

## Testing

- Test your changes on both iOS and Android if possible
- Ensure the app runs without errors
- Test on different screen sizes
- Verify that existing functionality still works

## Documentation

- Update README.md if you add new features or change existing ones
- Add inline comments for complex logic
- Update relevant documentation files

## Questions?

Feel free to open an issue with the `question` label if you have any questions about contributing.

## Recognition

Contributors will be recognized in the project's README and release notes.

Thank you for contributing to Como! 🙏

