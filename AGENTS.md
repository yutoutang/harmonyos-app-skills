# Repository Guidelines

## Project Structure & Module Organization
This HarmonyOS project is split into two modules:
- `entry/`: main HAP app module (`src/main/ets/pages`, `entryability`, `entrybackupability`, resources under `src/main/resources`).
- `ycomponent/`: reusable HAR component library (`src/main/ets/components`, exports in `Index.ets`).

App-level config is in `AppScope/` and root build/dependency settings are in `build-profile.json5`, `hvigorfile.ts`, and `oh-package.json5`. Keep tests in module-local folders: `src/test/` (unit) and `src/ohosTest/` (device/instrumented).

## Build, Test, and Development Commands
Use Hvigor from repo root:
- `hvigorw init`: sync dependencies and project metadata.
- `hvigorw assembleApp --mode debug`: build all modules for development.
- `hvigorw assembleApp --mode release`: release build.
- `hvigorw :entry:assembleHap`: build only the app module.
- `hvigorw :ycomponent:assembleHar`: build only the shared HAR.
- `hvigorw :entry:test`: run local unit tests.
- `hvigorw :entry:ohosTest`: run instrumentation tests.
- `hvigorw clean`: remove build artifacts.

## Coding Style & Naming Conventions
Write ArkTS (`.ets`) with 2-space indentation and clear, small components.
- Pages: `*Page` (example: `OpenHarmonyComponentPage`).
- Reusable components: `*Example`, `*Card`, `*Item` patterns.
- Avoid built-in type names (`Button`, `ListItem`) as custom component names.

Linting is configured in `code-linter.json5` (`@typescript-eslint` + security rules). Run linting in DevEco/Hvigor workflow before opening a PR.

## Testing Guidelines
Frameworks: `@ohos/hypium` and `@ohos/hamock`.
- Unit tests: `entry/src/test/*.test.ets`.
- Instrumentation tests: `entry/src/ohosTest/ets/test/*.test.ets`.
- Keep test filenames ending with `.test.ets`; aggregate suites in `List.test.ets` where applicable.

## Commit & Pull Request Guidelines
Recent commits are short and imperative (`init`, `comp`, `add skill`). Follow that style, but make messages more descriptive, e.g. `add nav router component demo`.

For PRs, include:
- Scope summary (which module: `entry` or `ycomponent`).
- Linked issue/task ID.
- Test evidence (commands run and results).
- UI screenshots/video for ArkUI page/component changes.

## Security & Configuration Tips
Do not commit machine-specific or sensitive files/values (signing materials, `local.properties`, keystore/cert paths). Keep secrets out of JSON5 configs and use local environment configuration instead.
