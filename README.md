# semantic_test (QA semantic playground)

Small Flutter app intended for QA automation feasibility testing (widget keys + semantic labels).

## Requirements
- FVM (`fvm --version`)
- Flutter SDK pinned via `.fvm/fvm_config.json`

## Run
```bash
fvm install
fvm flutter pub get
fvm flutter run
```

## What’s inside
- Two screens:
  - First screen: checkbox, grouped radio buttons, validated text fields, and a button that navigates to screen 2
  - Second screen: simple content + back button
- Automation hooks:
  - Each interactive widget has a stable `Key(...)` (see `lib/main.dart`)
  - Each interactive widget is wrapped with a `Semantics(...)` label

## QA docs
See `docs/QA_AUTOMATION.md` for the semantic labels and suggested Appium selection strategy.

## Key names (examples)
- `textfield_name`, `textfield_email`
- `checkbox_agree`
- `radio_option_a`, `radio_option_b`, `radio_option_c`
- `button_go_second`, `button_back_first`
