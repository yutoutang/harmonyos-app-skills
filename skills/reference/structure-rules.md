## Code Organization and Component Architecture

This section covers best practices for organizing HarmonyOS application code, including file structure, component design, and architectural patterns.

### File Structure Standards

#### Recommended Directory Layout

```
entry/src/main/ets/
├── pages/                     # Page components with @Entry
│   └── Index.ets             # Main entry point (< 500 lines)
├── viewmodels/               # Business logic (@ObservedV2)
│   └── FeatureViewModel.ets  # State management
├── components/               # Reusable UI components
│   ├── common/               # Shared components
│   │   └── TabBarBuilder.ets
│   ├── [feature]/            # Feature-specific components
│   │   ├── [Feature]Page.ets     # Page container
│   │   ├── [Feature]Card.ets     # Card component
│   │   └── [Feature]Item.ets     # List item component
│   ├── statistics/
│   └── profile/
├── models/                   # Data models/interfaces
│   └── User.ets
├── services/                 # Business services
│   └── ApiService.ets
└── utils/                    # Utility functions
    └── DateUtil.ets
```

#### File Size Guidelines

| File Type               | Max Lines | Recommendation             |
| ----------------------- | --------- | -------------------------- |
| Page component (@Entry) | 500 lines | Keep under 200 lines       |
| ViewModel               | 500 lines | Extract services if needed |
| UI Component            | 300 lines | Split if larger            |
| Utility file            | 500 lines | Group related functions    |

**Example: Large File Refactoring**

```typescript
// ❌ BEFORE: Index.ets with 510 lines
@Entry
@ComponentV2
struct Index {
  @Local vm: ViewModel = new ViewModel();

  // 440 lines of @Builder functions
  @Builder buildCheckInPage() { /* 100 lines */ }
  @Builder buildUserInfoCard() { /* 60 lines */ }
  @Builder buildCheckInButton() { /* 80 lines */ }
  @Builder buildCheckInRecords() { /* 100 lines */ }
  @Builder buildStatisticsPage() { /* 50 lines */ }
  @Builder buildProfilePage() { /* 50 lines */ }
}

// ✅ AFTER: Component-based structure
@Entry
@ComponentV2
struct Index {
  @Local vm: ViewModel = new ViewModel();

  build() {
    Tabs() {
      TabContent() { CheckInTabPage({ vm: this.vm }) }
      TabContent() { StatisticsPage({ vm: this.vm }) }
      TabContent() { ProfilePage({ vm: this.vm }) }
    }
  }
}
```

---

### Component Design Principles

#### 1. Single Responsibility Principle

Each component should have one clear purpose.

```typescript
// ✅ Good: Single purpose
@ComponentV2
struct UserInfoCard {
  @Param userName: string = '';
  @Param userDepartment: string = '';

  build() {
    Row() {
      Text('Avatar')
      Text(this.userName)
      Text(this.userDepartment)
    }
  }
}

// ❌ Bad: Multiple responsibilities
@ComponentV2
struct UserSection {
  build() {
    Column() {
      // User info
      Text('John Doe')

      // Check-in button
      Button('Check In')

      // Records list
      List() { /* ... */ }
    }
  }
}
```

#### 2. Component Size Guidelines

```typescript
// ✅ Good: Focused component (< 150 lines)
@ComponentV2
struct CheckInButton {
  @Param vm: CheckInViewModel = new CheckInViewModel();

  build() {
    Column() {
      Text(this.vm.location)
      Button('Check In').onClick(() => this.vm.handleCheckIn())
    }
  }
}

// ⚠️ Warning: Large component (> 300 lines)
@ComponentV2
struct CheckInPage {
  build() {
    Column() {
      // 300+ lines of UI
    }
  }
  // Consider splitting into smaller components
}
```

#### 3. Props vs State

```typescript
@ComponentV2
struct ProductCard {
  // ✅ @Param: Data from parent (read-only)
  @Param product: Product = new Product();

  // ✅ @Local: Component's own state
  @Local isExpanded: boolean = false;

  // ✅ @Event: Callback to parent
  @Event onAddToCart: (product: Product) => void = () => {};

  build() {
    Column() {
      Text(this.product.name)  // From parent
      if (this.isExpanded) {   // Local state
        Text(this.product.description)
      }
      Button('Add').onClick(() => {
        this.onAddToCart(this.product);  // Notify parent
      })
    }
  }
}
```

---

### Component Naming Conventions

#### Naming Rules

| Component Type | Pattern                   | Example             |
| -------------- | ------------------------- | ------------------- |
| Page           | `[Name]Page`              | `CheckInPage`       |
| Card           | `[Name]Card`              | `UserInfoCard`      |
| Button         | `[Name]Button`            | `CheckInButton`     |
| List/Container | `[Name]List` or `[Name]s` | `CheckInRecords`    |
| Item           | `[Name]Item`              | `CheckInRecordItem` |
| Dialog/Modal   | `[Name]Dialog`            | `ConfirmDialog`     |

#### Avoid Naming Conflicts

```typescript
// ❌ BAD: Conflicts with built-in component
@ComponentV2
export struct MenuItem {  // 'MenuItem' is a built-in type
  @Param onClick: () => void = () => {};  // 'onClick' conflicts
}

// ✅ GOOD: Use descriptive names
@ComponentV2
export struct ProfileMenuItem {
  @Param onItemClick: () => void = () => {};  // Avoids conflicts
}
```

**Common Built-in Component Names to Avoid:**

- `MenuItem` → Use `ProfileMenuItem`, `SettingsMenuItem`
- `ListItem` → Use `TaskListItem`, `ContactItem`
- `Button` → Use `PrimaryButton`, `IconButton`
- `Image` → Use `AvatarImage`, `ProductImage`

---

### Data Flow Patterns

#### 1. ViewModel Sharing Pattern

Share a single ViewModel across multiple components.

```typescript
// In page
@Entry
@ComponentV2
struct Index {
  @Local vm: CheckInViewModel = new CheckInViewModel();

  build() {
    Column() {
      // Pass VM to child components
      UserInfoCard({ vm: this.vm })
      CheckInButton({ vm: this.vm })
      CheckInRecords({ vm: this.vm })
    }
  }
}

// In child component
@ComponentV2
struct UserInfoCard {
  @Param vm: CheckInViewModel = new CheckInViewModel();

  build() {
    Text(this.vm.userName)  // Direct access
  }
}
```

#### 2. Event Bubbling Pattern

Child components notify parents through callbacks.

```typescript
// Child component
@ComponentV2
struct TaskItem {
  @Param task: Task = new Task();
  @Event onDelete: (taskId: string) => void = () => {};
  @Event onToggle: (task: Task) => void = () => {};

  build() {
    Row() {
      Checkbox().onChange(() => {
        this.onToggle(this.task);  // Notify parent
      })
      Button('Delete').onClick(() => {
        this.onDelete(this.task.id);  // Notify parent
      })
    }
  }
}

// Parent component
@ComponentV2
struct TaskList {
  @Local tasks: Task[] = [];

  build() {
    ForEach(this.tasks, (task: Task) => {
      TaskItem({
        task: task,
        onToggle: (t: Task) => this.toggleTask(t),
        onDelete: (id: string) => this.deleteTask(id)
      })
    })
  }
}
```

#### 3. Provider/Consumer Pattern (App-wide State)

```typescript
// In EntryAbility
export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // Initialize global state
    AppStorageV2.connect(UserModel, () => new UserModel());
  }
}

// In any component
@ComponentV2
struct UserProfile {
  @Local user: UserModel = AppStorageV2.connect(UserModel, () => new UserModel())!;

  build() {
    Text(this.user.userName)
  }
}
```

---

### Component Extraction Guidelines

#### When to Extract a Component

Extract a component when:

1. **Reuse**: Used in 2+ places
2. **Complexity**: > 100 lines of UI code
3. **State**: Has independent state management
4. **Testing**: Needs independent testing

```typescript
// ❌ BEFORE: Inline complex UI
@Builder
buildCheckInPage() {
  Column() {
    // 50 lines - User Info Card
    Row() { /* Avatar, Name, Dept */ }

    // 80 lines - Check In Button
    Column() {
      Text('Location')
      Button('Check In')
      Button('Check Out')
    }

    // 100 lines - Records List
    List() { /* Complex list rendering */ }
  }
}

// ✅ AFTER: Extracted components
@ComponentV2
struct CheckInTabPage {
  @Param vm: CheckInViewModel = new CheckInViewModel();

  build() {
    Column() {
      UserInfoCard({ vm: this.vm })      // 50 lines → separate file
      CheckInButton({ vm: this.vm })     // 80 lines → separate file
      CheckInRecords({ vm: this.vm })    // 100 lines → separate file
    }
  }
}
```

#### Extraction Steps

1. **Identify the UI block** to extract
2. **Create component file** in appropriate directory
3. **Define @Param props** needed from parent
4. **Define @Event callbacks** for child→parent communication
5. **Move @Builder logic** to component's build() method
6. **Update parent** to use new component
7. **Test functionality** remains intact

---

### Directory Organization Patterns

#### Pattern 1: Feature-Based Organization (Recommended)

Group by feature/module:

```
components/
├── checkin/
│   ├── CheckInTabPage.ets      # Container
│   ├── UserInfoCard.ets        # Card
│   ├── CheckInButton.ets       # Action
│   ├── CheckInRecords.ets      # List
│   └── CheckInRecordItem.ets   # Item
├── statistics/
│   └── StatisticsPage.ets
└── profile/
    ├── ProfilePage.ets
    └── ProfileMenuItem.ets
```

**Advantages:**

- ✅ Easy to find feature-related code
- ✅ Clear feature boundaries
- ✅ Easy to add/remove features

#### Pattern 2: Type-Based Organization

Group by component type:

```
components/
├── cards/
│   ├── UserInfoCard.ets
│   └── StatCard.ets
├── buttons/
│   └── CheckInButton.ets
└── lists/
    ├── CheckInRecords.ets
    └── CheckInRecordItem.ets
```

**Advantages:**

- ✅ Easy to find reusable components
- ✅ Clear component types

**Disadvantages:**

- ❌ Feature code scattered
- ❌ Harder to navigate large projects

---

### Code Quality Checklist

#### File Organization

- [ ] Each file < 500 lines
- [ ] Clear directory structure
- [ ] Feature-based organization preferred
- [ ] No unused files
- [ ] Consistent naming conventions

#### Component Design

- [ ] Single responsibility per component
- [ ] Components < 300 lines
- [ ] Props use @Param
- [ ] Events use @Event
- [ ] State uses @Local

#### Naming Conventions

- [ ] No conflicts with built-ins
- [ ] Descriptive component names
- [ ] PascalCase for components
- [ ] camelCase for functions/variables
- [ ] Prefix indicates purpose (User*, CheckIn*)

#### Data Flow

- [ ] Clear data direction (parent → child)
- [ ] Proper event handling (child → parent)
- [ ] ViewModel shared via @Param
- [ ] Minimal prop drilling

---

### Refactoring Case Study

#### Problem: 510-Line Index.ets

**Original Structure:**

```typescript
@Entry
@ComponentV2
struct Index {  // 510 lines total
  @Local vm: ViewModel = new ViewModel();

  @Builder buildCheckInPage() { /* 100 lines */ }
  @Builder buildUserInfoCard() { /* 60 lines */ }
  @Builder buildCheckInButton() { /* 80 lines */ }
  @Builder buildCheckInRecords() { /* 100 lines */ }
  @Builder buildRecordItem() { /* 70 lines */ }
  @Builder buildStatisticsPage() { /* 50 lines */ }
  @Builder buildProfilePage() { /* 50 lines */ }
}
```

**Refactored Structure:**

```
pages/
└── Index.ets (68 lines)         ✅ -87%

components/
├── common/
│   └── TabBarBuilder.ets (30 lines)
├── checkin/
│   ├── CheckInTabPage.ets (31 lines)
│   ├── UserInfoCard.ets (55 lines)
│   ├── CheckInButton.ets (85 lines)
│   ├── CheckInRecords.ets (62 lines)
│   └── CheckInRecordItem.ets (115 lines)
├── statistics/
│   └── StatisticsPage.ets (87 lines)
└── profile/
    ├── ProfilePage.ets (65 lines)
    └── MenuItem.ets (33 lines)
```

**Results:**

- ✅ Index.ets: 510 → 68 lines (-87%)
- ✅ 10 reusable components created
- ✅ Max file size: 115 lines
- ✅ Clear feature boundaries
- ✅ All functionality preserved

**Key Improvements:**

1. **Modularity**: Each component independently testable
2. **Reusability**: Components can be used elsewhere
3. **Maintainability**: Smaller files easier to understand
4. **Scalability**: Easy to add new features

---

### Best Practices Summary

#### Do's ✅

1. **Keep files small** (< 500 lines, preferably < 200)
2. **Organize by feature** (checkin/, statistics/, profile/)
3. **Extract reusable components** (cards, buttons, items)
4. **Use descriptive names** (UserInfoCard, not Card)
5. **Share ViewModels** via @Param for related components
6. **Use @Event** for child→parent communication
7. **Follow naming conventions** (PascalCase for components)

#### Don'ts ❌

1. **Don't create monolithic files** (> 500 lines)
2. **Don't name conflicts** with built-ins (MenuItem, Button)
3. **Don't duplicate code** - extract to components
4. **Don't mix concerns** - separate UI, logic, data
5. **Don't deep nest components** (> 5 levels)
6. **Don't use onClick** as prop name (conflicts)
7. **Don't ignore file organization** - structure matters