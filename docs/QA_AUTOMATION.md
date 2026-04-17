# QA Automation Notes (Appium + Semantics)

This app is a small playground to evaluate automation feasibility with Appium on a Flutter UI.

## How Appium can select elements

Appium’s native backends typically expose Flutter `Semantics` as accessibility properties:

- Android (UIAutomator2): `Semantics(label: ...)` is usually surfaced as `content-desc` → use Appium **accessibility id**
- iOS (XCUITest): `Semantics(label: ...)` is usually surfaced as `accessibilityLabel` → use Appium **accessibility id**

In practice:
- Prefer `accessibility id` with the **Semantics label** string
- If a widget’s semantics are merged into a parent node, the exact label may appear on a parent element instead of the leaf control; confirm using Appium Inspector

## Screens

- **First screen**: form controls + navigation
- **Second screen**: simple content + back navigation

## Semantic labels + keys

Source of truth: `lib/main.dart`

### Screen 1 (title: "QA Semantic Controls")

| Control | Flutter `Key` | `Semantics.label` |
|---|---|---|
| Name field | `textfield_name` | `Name text field` |
| Email field | `textfield_email` | `Email text field` |
| Agree checkbox | `checkbox_agree` | `Agree to terms checkbox` |
| Radio option A | `radio_option_a` | `Radio option A` |
| Radio option B | `radio_option_b` | `Radio option B` |
| Radio option C | `radio_option_c` | `Radio option C` |
| Navigate button | `button_go_second` | `Go to second page button` |

Additional container labels on screen 1:
- Page container: `First page form controls`
- Radio group container: `Radio button group`

### Screen 2 (title: "Second Screen")

| Control | Flutter `Key` | `Semantics.label` |
|---|---|---|
| Back button | `button_back_first` | `Back button` |

Additional container labels on screen 2:
- Page container: `Second page`

