# 🎨 Components Reference

This document provides a comprehensive guide to all reusable components in the Como Ecommerce UI Kit.

## Table of Contents
- [Buttons](#buttons)
- [Text Fields](#text-fields)
- [Product Cards](#product-cards)
- [Category Cards](#category-cards)
- [Design System](#design-system)

---

## Buttons

### ComoButton

A versatile button component with multiple variants and states.

**Location**: `lib/shared/widgets/como_button.dart`

#### Usage

```dart
import 'package:como/shared/widgets/como_button.dart';

ComoButton(
  text: 'Add to Cart',
  onPressed: () {
    // Handle button press
  },
  variant: ButtonVariant.primary,
  isLoading: false,
  isFullWidth: true,
)
```

#### Variants

- `ButtonVariant.primary` - Primary action button
- `ButtonVariant.secondary` - Secondary action button
- `ButtonVariant.outline` - Outlined button
- `ButtonVariant.text` - Text-only button

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| text | String | required | Button text |
| onPressed | VoidCallback? | null | Callback when pressed |
| variant | ButtonVariant | primary | Button style variant |
| isLoading | bool | false | Shows loading indicator |
| isFullWidth | bool | false | Expands to full width |
| icon | IconData? | null | Optional icon |

---

## Text Fields

### ComoTextField

A styled text input field with validation support.

**Location**: `lib/shared/widgets/como_text_field.dart`

#### Usage

```dart
import 'package:como/shared/widgets/como_text_field.dart';

ComoTextField(
  label: 'Email',
  hint: 'Enter your email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    return null;
  },
)
```

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| label | String? | null | Label text |
| hint | String? | null | Placeholder text |
| controller | TextEditingController? | null | Text controller |
| keyboardType | TextInputType | text | Keyboard type |
| obscureText | bool | false | Hide text (for passwords) |
| validator | FormFieldValidator? | null | Validation function |
| prefixIcon | IconData? | null | Leading icon |
| suffixIcon | IconData? | null | Trailing icon |
| maxLines | int | 1 | Number of lines |
| enabled | bool | true | Enable/disable field |

---

## Product Cards

### ProductCard

Display product information in a card layout with vertical or horizontal orientation.

**Location**: `lib/shared/widgets/product_card.dart`

#### Usage

**Vertical Card** (Default):
```dart
import 'package:como/shared/widgets/product_card.dart';

ProductCard(
  imageUrl: 'https://example.com/product.jpg',
  title: 'Product Name',
  price: '\$99.99',
  originalPrice: '\$149.99',
  rating: 4.5,
  reviewCount: 128,
  isFavorite: false,
  badge: 'NEW',
  onTap: () {
    // Navigate to product details
  },
  onFavoriteTap: () {
    // Toggle favorite
  },
)
```

**Horizontal Card**:
```dart
ProductCard(
  imageUrl: 'https://example.com/product.jpg',
  title: 'Product Name',
  price: '\$99.99',
  isHorizontal: true,
  onTap: () => Navigator.push(...),
)
```

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| imageUrl | String | required | Product image URL |
| title | String | required | Product name |
| price | String | required | Product price |
| originalPrice | String? | null | Original price (for discounts) |
| rating | double? | null | Product rating (0-5) |
| reviewCount | int? | null | Number of reviews |
| isFavorite | bool | false | Favorite state |
| onTap | VoidCallback? | null | Card tap callback |
| onFavoriteTap | VoidCallback? | null | Favorite button callback |
| badge | String? | null | Badge text (e.g., "NEW", "SALE") |
| isHorizontal | bool | false | Use horizontal layout |

---

## Category Cards

### CategoryCard

Display category information with image and title.

**Location**: `lib/shared/widgets/product_card.dart` (CategoryCard class)

#### Usage

```dart
import 'package:como/shared/widgets/product_card.dart';

CategoryCard(
  title: 'Electronics',
  imageUrl: 'https://example.com/category.jpg',
  backgroundColor: Colors.blue.shade50,
  onTap: () {
    // Navigate to category
  },
)
```

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| title | String | required | Category name |
| imageUrl | String | required | Category image URL |
| onTap | VoidCallback? | null | Tap callback |
| backgroundColor | Color? | grey50 | Background color |

---

## Design System

### Colors

**Location**: `lib/core/constants/app_colors.dart`

```dart
import 'package:como/core/constants/app_colors.dart';

// Usage
Container(
  color: AppColors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.white),
  ),
)
```

#### Available Colors

- `AppColors.primary` - Primary brand color
- `AppColors.secondary` - Secondary/accent color
- `AppColors.accent` - Accent color
- `AppColors.success` - Success state color
- `AppColors.error` - Error state color
- `AppColors.warning` - Warning state color
- `AppColors.white` - White
- `AppColors.black` - Black
- `AppColors.grey50` - Grey shades (50-900)
- `AppColors.textPrimary` - Primary text color
- `AppColors.textSecondary` - Secondary text color
- `AppColors.border` - Border color
- `AppColors.shadow` - Shadow color
- `AppColors.background` - Background color

### Typography

**Location**: `lib/core/constants/app_text_styles.dart`

```dart
import 'package:como/core/constants/app_text_styles.dart';

Text(
  'Heading',
  style: AppTextStyles.headingLarge,
)

Text(
  'Body text',
  style: AppTextStyles.bodyMedium,
)
```

#### Available Styles

**Headlines**:
- `AppTextStyles.headingLarge` - 32px, bold
- `AppTextStyles.headingMedium` - 28px, bold
- `AppTextStyles.headingSmall` - 24px, semi-bold

**Body Text**:
- `AppTextStyles.bodyLarge` - 16px
- `AppTextStyles.bodyMedium` - 14px
- `AppTextStyles.bodySmall` - 12px

**Labels**:
- `AppTextStyles.labelLarge` - 14px, medium
- `AppTextStyles.labelMedium` - 12px, medium
- `AppTextStyles.labelSmall` - 10px, medium

**Product-Specific**:
- `AppTextStyles.productTitle` - Product name style
- `AppTextStyles.productPrice` - Price style
- `AppTextStyles.categoryTitle` - Category name style

### Constants

**Location**: `lib/core/constants/app_constants.dart`

```dart
import 'package:como/core/constants/app_constants.dart';

Padding(
  padding: EdgeInsets.all(AppConstants.paddingM),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
    ),
  ),
)
```

#### Available Constants

**Padding**:
- `AppConstants.paddingXS` - 4px
- `AppConstants.paddingS` - 8px
- `AppConstants.paddingM` - 16px
- `AppConstants.paddingL` - 24px
- `AppConstants.paddingXL` - 32px

**Border Radius**:
- `AppConstants.radiusS` - 4px
- `AppConstants.radiusM` - 8px
- `AppConstants.radiusL` - 12px
- `AppConstants.radiusXL` - 16px

**Icon Sizes**:
- `AppConstants.iconS` - 16px
- `AppConstants.iconM` - 24px
- `AppConstants.iconL` - 32px
- `AppConstants.iconXL` - 48px

---

## Examples

### Complete Product Card Example

```dart
import 'package:flutter/material.dart';
import 'package:como/shared/widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          imageUrl: product.imageUrl,
          title: product.name,
          price: '\$${product.price}',
          originalPrice: product.discount > 0 
              ? '\$${product.originalPrice}' 
              : null,
          rating: product.rating,
          reviewCount: product.reviewCount,
          badge: product.isNew ? 'NEW' : null,
          isFavorite: product.isFavorite,
          onTap: () => navigateToProduct(product.id),
          onFavoriteTap: () => toggleFavorite(product.id),
        );
      },
    );
  }
}
```

### Form with ComoTextField and ComoButton

```dart
import 'package:flutter/material.dart';
import 'package:como/shared/widgets/como_text_field.dart';
import 'package:como/shared/widgets/como_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ComoTextField(
            label: 'Email',
            hint: 'Enter your email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Email is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ComoTextField(
            label: 'Password',
            hint: 'Enter your password',
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Password is required';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          ComoButton(
            text: 'Login',
            isFullWidth: true,
            isLoading: _isLoading,
            onPressed: _handleLogin,
          ),
        ],
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Perform login
      await Future.delayed(Duration(seconds: 2));
      setState(() => _isLoading = false);
    }
  }
}
```

---

## Best Practices

1. **Always use the design system** - Use predefined colors, text styles, and constants
2. **Reuse components** - Don't recreate common UI elements
3. **Handle loading states** - Use `isLoading` property for async operations
4. **Provide callbacks** - Make components interactive with callbacks
5. **Add validation** - Use validators for text fields
6. **Test on multiple devices** - Ensure components look good on different screen sizes

---

## Contributing

To add new components:

1. Create the component in `lib/shared/widgets/`
2. Follow the existing naming conventions
3. Document the component in this file
4. Add usage examples
5. Submit a pull request

---

For more information, see the main [README.md](README.md) or [CONTRIBUTING.md](CONTRIBUTING.md).

