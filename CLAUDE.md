# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **HarmonyOS/OpenHarmony** application project targeting SDK version 6.0.1 (API Level 21). The project demonstrates native OpenHarmony UI components and is built using ArkTS (TypeScript-based language for HarmonyOS).

**Key Information:**
- **Bundle ID:** `com.txy.comp`
- **Target SDK:** 6.0.1(21)
- **Runtime OS:** HarmonyOS
- **Build System:** Hvigor (HarmonyOS build tool)
- **Language:** ArkTS (`.ets` files)

## Project Structure

The project follows a **multi-module architecture** with two main modules:

```
hmComponent/
├── entry/                    # Main application module (HAP - HarmonyOS Ability Package)
│   ├── src/main/ets/        # ArkTS source code
│   │   ├── pages/          # Page components with @Entry decorator
│   │   ├── entryability/   # Application entry point (EntryAbility.ets)
│   │   └── entrybackupability/  # Backup extension ability
│   ├── src/ohosTest/       # Instrumentation tests
│   └── src/test/           # Unit tests
│
├── ycomponent/              # Shared HAR module (HarmonyOS Archive)
│   ├── src/main/ets/       # Reusable components
│   │   └── components/     # Component library
│   │       └── button/     # Button component examples
│   └── Index.ets           # Module export file
│
├── AppScope/                # Application-level configuration
│   └── app.json5           # App metadata (bundleName, version, etc.)
├── build-profile.json5      # Build configuration for all modules
├── oh-package.json5         # Root dependencies (devDependencies for testing)
└── hvigorfile.ts           # Build script configuration
```

**Module Dependencies:**
- `entry` depends on `ycomponent` (via `file:../ycomponent`)
- Both modules can be built independently or together

## Build Commands

### Building the Project

```bash
# Build all modules (production mode)
hvigorw assembleApp

# Build specific module
hvigorw :entry:assembleHap
hvigorw :ycomponent:assembleHar

# Clean build artifacts
hvigorw clean

# Build with specific mode
hvigorw assembleApp --mode release
hvigorw assembleApp --mode debug
```

### Common Hvigor Tasks

```bash
# List all available tasks
hvigorw tasks

# Show task dependency tree
hvigorw taskTree

# Display build information
hvigorw buildInfo

# Sync project dependencies
hvigorw init

# Stop daemon processes
hvigorw --stop-daemon
```

### Build Modes

The project supports two build modes (configured in `build-profile.json5`):
- **debug:** Development builds with debugging enabled
- **release:** Production builds with optional obfuscation

## Testing

### Test Structure

Tests are organized by module:

```
entry/
├── src/test/           # Local unit tests (run on host)
│   └── LocalUnit.test.ets
├── src/ohosTest/       # Instrumentation tests (run on device/emulator)
│   └── ets/test/
│       ├── Ability.test.ets
│       └── List.test.ets
```

### Running Tests

```bash
# Run tests for a specific module
hvigorw :entry:test
hvigorw :entry:ohosTest

# Generate coverage reports
hvigorw collectCoverage
```

**Test Framework:** Uses `@ohos/hypium` (1.0.24) and `@ohos/hamock` (1.0.0) for testing.

## Code Architecture

### Component Architecture

The project uses **ArkTS component decorators** for reactive UI development:

```typescript
@ComponentV2          // V2 component with enhanced reactivity
export struct MyComponent {
  @Param              // Input props from parent (read-only)
  @Local              // Component local state
  @Event              // Output events to parent

  build() {           // Required render method
    // UI declaration
  }
}

@Entry               // Page entry point
@ComponentV2
export struct MyPage {
  build() {
    // Page content
  }
}
```

### Module Pattern: HAR (HarmonyOS Archive)

The `ycomponent` module is a **HAR package** - a reusable component library:

1. **Exports:** Defined in `ycomponent/Index.ets`
2. **Consumption:** Imported by `entry` via `oh-package.json5` dependency
3. **Structure:** Components organized by feature (e.g., `components/button/`)

**Example:**
```typescript
// In ycomponent/Index.ets
export { ButtonExamplePage } from './src/main/ets/components/button/ButtonExample';

// In entry module
import { ButtonExamplePage } from 'ycomponent'
```

### Page Navigation

Uses **NavDestination** for page navigation (see `OpenHarmonyComponentPage.ets`):

```typescript
@ComponentV2
struct MyPage {
  @Param navPathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      // Page content
    }
    .title('Page Title')
    .mode(NavDestinationMode.STANDARD)
  }
}
```

## Development Guidelines

### File Organization (from skills/reference/structure-rules.md)

**Recommended structure for ArkTS projects:**

```
src/main/ets/
├── pages/                    # Entry pages (@Entry decorator)
├── viewmodels/              # Business logic (@ObservedV2)
├── components/              # Reusable UI components
│   ├── common/              # Shared components
│   └── [feature]/           # Feature-specific components
├── models/                  # Data models/interfaces
├── services/                # Business services
└── utils/                   # Utility functions
```

**File Size Limits:**
- Page components (@Entry): Max 500 lines (prefer < 200)
- ViewModels: Max 500 lines
- UI Components: Max 300 lines
- Utility files: Max 500 lines

### Component Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Page | `[Name]Page` | `CheckInPage`, `Index` |
| Card | `[Name]Card` | `UserInfoCard` |
| Button | `[Name]Button` | `CheckInButton`, `PrimaryButton` |
| List/Container | `[Name]List` or `[Name]s` | `CheckInRecords` |
| Item | `[Name]Item` | `CheckInRecordItem` |
| Dialog | `[Name]Dialog` | `ConfirmDialog` |

**Avoid naming conflicts with built-ins:**
- ❌ `MenuItem`, `ListItem`, `Button` (built-in types)
- ✅ `ProfileMenuItem`, `TaskListItem`, `PrimaryButton`

### State Management Patterns

1. **@Param:** Data from parent (read-only props)
2. **@Local:** Component's own state (mutable)
3. **@Event:** Callbacks to parent (output events)

**Example:**
```typescript
@ComponentV2
struct TaskItem {
  @Param task: Task = new Task();           // Input
  @Local isExpanded: boolean = false;       // Local state
  @Event onDelete: (id: string) => void = () => {};  // Output

  build() {
    Column() {
      Text(this.task.name)
      if (this.isExpanded) {
        Text(this.task.description)
      }
      Button('Delete').onClick(() => {
        this.onDelete(this.task.id)
      })
    }
  }
}
```

## Configuration Files

### Module Configuration

**entry/src/main/module.json5** - Entry module manifest:
```json5
{
  "module": {
    "name": "entry",
    "type": "entry",              // Entry point module
    "mainElement": "EntryAbility",
    "deviceTypes": ["phone"],
    "pages": "$profile:main_pages",
    "abilities": [...]
  }
}
```

**ycomponent/src/main/module.json5** - HAR module manifest:
```json5
{
  "module": {
    "name": "ycomponent",
    "type": "har",                // Shared library
    "deviceTypes": ["default"]
  }
}
```

### Build Configuration

**build-profile.json5** - Root build config:
- Defines products and modules
- Configures SDK versions and build modes
- Sets signing profiles

**hvigor/hvigor-config.json5** - Hvigor build settings:
- Execution mode (daemon, parallel, incremental)
- Logging level
- Node.js options

### Dependency Management

**oh-package.json5** files:
- Root: DevDependencies for testing (`@ohos/hypium`, `@ohos/hamock`)
- entry: Dependencies on local modules (`ycomponent`)
- ycomponent: Library exports configuration

## Code Quality

### Linting

**code-linter.json5** configuration:
- Files: `**/*.ets`
- Excludes: tests, mocks, node_modules, build
- Rules: TypeScript recommended + security rules
- Security rules: AES, hash, MAC, DH, DSA, ECDSA, RSA, 3DES

### Git Ignore Patterns

```
/node_modules
/oh_modules
/local.properties
/.idea
**/build
/.hvigor
.cxx
/.clangd
/.clang-format
/.clang-tidy
**/.test
/.appanalyzer
```

## Key Technologies

- **ArkTS:** TypeScript superset for HarmonyOS UI development
- **ArkUI:** Declarative UI framework (Component, Column, Row, Button, etc.)
- **Hvigor:** Build system (similar to Gradle)
- **HAR:** HarmonyOS Archive format for shared libraries
- **HAP:** HarmonyOS Ability Package for applications
- **Hypium:** Testing framework
- **Hamock:** Mocking framework

## Common Patterns

### Importing Components

From HAR module:
```typescript
import { ButtonExamplePage } from 'ycomponent'
```

Local imports:
```typescript
import { MyComponent } from '../components/MyComponent'
```

### Resource References

```typescript
// String resources
$string:app_name

// Color resources
$color:start_window_background

// Media resources
$media:layered_image

// Float resources (dimensions)
$r('app.float.page_text_font_size')
```

## Getting Started

1. **Prerequisites:** DevEco Studio installed, HarmonyOS SDK configured
2. **Open project:** Open in DevEco Studio
3. **Sync dependencies:** `hvigorw init`
4. **Build:** `hvigorw assembleApp`
5. **Run:** Deploy to device/emulator via DevEco Studio

## Module-Specific Notes

### ycomponent (HAR Module)
- **Purpose:** Reusable component library
- **Export:** `Index.ets` defines public API
- **Usage:** Imported as local dependency in `entry/oh-package.json5`
- **Components:** Currently contains Button examples

### entry (Entry Module)
- **Purpose:** Application entry point
- **Main Ability:** `EntryAbility.ets`
- **Pages:** Defined in `src/main/resources/base/profile/main_pages.json`
- **Backup:** Includes `EntryBackupAbility` for data backup

## Development Workflow

1. **Component Development:**
   - Add components to `ycomponent/src/main/ets/components/`
   - Export in `ycomponent/Index.ets`
   - Import and use in `entry` module

2. **Page Development:**
   - Create pages in `entry/src/main/ets/pages/`
   - Add to `main_pages.json` configuration
   - Use `@Entry` decorator

3. **Testing:**
   - Write unit tests in `src/test/`
   - Write instrumentation tests in `src/ohosTest/`
   - Run with `hvigorw test`

4. **Building:**
   - Debug builds: `hvigorw assembleApp --mode debug`
   - Release builds: `hvigorw assembleApp --mode release`
