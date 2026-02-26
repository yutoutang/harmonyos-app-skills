---
name: harmonyos-app
description: HarmonyOS application development expert. Use when building HarmonyOS apps with ArkTS, ArkUI, Stage model, and distributed capabilities. Covers HarmonyOS NEXT (API 12+) and HarmonyOS 6.0 best practices.
---
# HarmonyOS Application Development

## Core Principles

- **ArkTS First** — Use ArkTS with strict type safety, no `any` or dynamic types
- **Declarative UI** — Build UI with ArkUI's declarative components and state management
- **Stage Model** — Use modern Stage model (UIAbility), not legacy FA model
- **ComponentV2** — Use the new ComponentV2 system for better performance and developer experience
- **Atomic Services** — Consider atomic services and cards for lightweight experiences

---

## Hard Rules (Must Follow)

> These rules are mandatory. Violating them means the skill is not working correctly.

### No Dynamic Types

**ArkTS prohibits dynamic typing. Never use `any`, type assertions, or dynamic property access.**

```typescript
// ❌ FORBIDDEN: Dynamic types
let data: any = fetchData();
let obj: object = {};
obj['dynamicKey'] = value;  // Dynamic property access
(someVar as SomeType).method();  // Type assertion

// ✅ REQUIRED: Strict typing
interface UserData {
id: string;
name: string;
}
let data: UserData = fetchData();

// Use Record for dynamic keys
let obj: Record<string, string> = {};
obj['key'] = value;  // OK with Record type
```

### Use ComponentV2 and ObservedV2 (HarmonyOS 6.0+)

**Always use @ComponentV2 and @ObservedV2 for new development. These provide better performance and developer experience.**

```typescript
// ❌ OLD: Using legacy @Component and @State
@Component
struct HomePage {
  @State isLoading: boolean = false;
  @State dataList: Item[] = [];

  loadData() {
    this.isLoading = true;
    // This requires manual state management
  }
}

// ✅ NEW: Using ComponentV2 and ObservedV2
@ComponentV2
struct HomePage {
  @Local vm: HomePageVM = new HomePageVM();

  loadData() {
    this.vm.loadData();
  }
}

@ObservedV2
export class HomePageVM {
  @Trace isLoading: boolean = false;
  @Trace dataList: Item[] = [];

  loadData() {
    this.isLoading = true;
    // Automatic state tracking with @Trace
  }

  @Monitor('isLoading')
  onLoadingChanged() {
    // Automatically called when isLoading changes
  }
}
```

### State Mutation with ObservedV2

**With @ObservedV2 and @Trace, direct mutation IS allowed and triggers UI updates.**

```typescript
// ✅ CORRECT: Direct mutation with @Trace
@ObservedV2
export class UserViewModel {
  @Trace name: string = '';
  @Trace age: number = 0;
  @Trace addresses: string[] = [];

  updateName(newName: string) {
    this.name = newName;  // ✅ Direct assignment works with @Trace
  }

  addAddress(address: string) {
    this.addresses.push(address);  // ✅ Array mutation works
  }

  @Monitor('name')
  onNameChange(prevName: string) {
    console.info(`Name changed from ${prevName} to ${this.name}`);
  }
}
```

### Stage Model Only

**Always use Stage model (UIAbility).**

```typescript
// ❌ FORBIDDEN: FA Model (deprecated)
// config.json with "pages" array
export default {
  onCreate() { ... }  // PageAbility lifecycle
}

// ✅ REQUIRED: Stage Model
// module.json5 with abilities configuration
import { UIAbility } from '@kit.AbilityKit';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // Modern Stage model lifecycle
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index');
  }
}
```

### Component Reusability

**Extract reusable UI into @ComponentV2. No inline complex UI in build() methods.**

```typescript
// ❌ FORBIDDEN: Monolithic build method
@Entry
@ComponentV2
struct MainPage {
  build() {
    Column() {
      // 200+ lines of inline UI...
      Row() {
        Image($r('app.media.avatar'))
        Column() {
          Text(this.user.name)
          Text(this.user.email)
        }
      }
      // More inline UI...
    }
  }
}

// ✅ REQUIRED: Extract components
@ComponentV2
struct UserCard {
  @Param user: User;

  build() {
    Row() {
      Image($r('app.media.avatar'))
      Column() {
        Text(this.user.name)
        Text(this.user.email)
      }
    }
  }
}

@Entry
@ComponentV2
struct MainPage {
  @Local vm: MainPageVM = new MainPageVM();

  build() {
    Column() {
      UserCard({ user: this.vm.user })
    }
  }
}
```

---

## Quick Reference

**New V2 Decorators (HarmonyOS 6.0+):**

```
@ComponentV2  → New component decorator with better performance
@Local        → Local component state (replaces @State)
@Param        → Component parameters (replaces @Prop/@Link)
@Event        → Event callbacks from child to parent
@Provider     → Provide data to descendants (new name)
@Consumer     → Consume from ancestor (new name)
@ObservedV2   → Observable class decorator (replaces @Observed)
@Trace        → Track property changes (replaces @ObjectLink)
@Computed     → Computed properties (auto-updated)
@Monitor      → Watch property changes (replaces @Watch)
AppStorageV2  → Global state with better performance
PersistenceV2 → Persistent storage with async API
```

---

## HarmonyOS 6.0+ State Management

### ComponentV2 and ObservedV2

The new state management system provides better performance and simpler APIs.

#### Basic ComponentV2 Structure

```typescript
@ComponentV2
struct ProductCard {
  // Parameters from parent (read-only by default)
  @Param product: Product = new Product();

  // Two-way binding parameter
  @Param @Require twoWayCount: number = 0;

  // Event callback to parent
  @Event onAddToCart: (product: Product) => void = () => {};

  // Local state
  @Local isExpanded: boolean = false;

  // Computed property (auto-updated when dependencies change)
  @Computed
  get formattedPrice(): string {
    return `¥${this.product.price.toFixed(2)}`;
  }

  // Monitor changes
  @Monitor('isExpanded')
  onExpandChange(prevValue: boolean) {
    console.info(`Expanded changed from ${prevValue} to ${this.isExpanded}`);
  }

  build() {
    Column() {
      Text(this.product.name)
      Text(this.formattedPrice)

      if (this.isExpanded) {
        Text(this.product.description)
      }

      Button('Toggle')
        .onClick(() => {
          this.isExpanded = !this.isExpanded;
        })

      Button('Add to Cart')
        .onClick(() => {
          this.onAddToCart(this.product);
        })
    }
  }
}
```

#### ObservedV2 ViewModels

```typescript
@ObservedV2
export class HomePageVM {
  // Tracked properties - any change triggers UI update
  @Trace isLoading: boolean = false;
  @Trace errorMsg: string = '';
  @Trace bannerList: BannerData[] = [];
  @Trace categoryList: CategoryItem[] = [];
  @Trace currentTab: number = 0;

  // Computed property
  @Computed
  get hasData(): boolean {
    return this.bannerList.length > 0 || this.categoryList.length > 0;
  }

  // Monitor specific property
  @Monitor('currentTab')
  onTabChange(prevTab: number) {
    console.info(`Tab changed from ${prevTab} to ${this.currentTab}`);
    this.loadDataForTab(this.currentTab);
  }

  // Monitor multiple properties
  @Monitor(['isLoading', 'errorMsg'])
  onLoadingStateChange() {
    if (!this.isLoading && this.errorMsg) {
      // Show error
    }
  }

  async loadData(): Promise<void> {
    this.isLoading = true;
    try {
      const data = await api.fetchHomeData();
      this.bannerList = data.banners;
      this.categoryList = data.categories;
    } catch (error) {
      this.errorMsg = (error as Error).message;
    } finally {
      this.isLoading = false;
    }
  }

  private async loadDataForTab(tab: number): Promise<void> {
    // Load data for specific tab
  }
}
```

#### Using ViewModel in Component

```typescript
@Entry
@ComponentV2
struct HomePage {
  // Connect to ViewModel
  @Local vm: HomePageVM = new HomePageVM();

  aboutToAppear(): void {
    this.vm.loadData();
  }

  build() {
    Column() {
      if (this.vm.isLoading) {
        LoadingProgress()
      } else if (this.vm.errorMsg) {
        Text(this.vm.errorMsg)
          .fontColor(Color.Red)
      } else {
        this.buildContent()
      }
    }
  }

  @Builder
  buildContent() {
    Scroll() {
      Column() {
        // Banner
        Swiper() {
          ForEach(this.vm.bannerList, (banner: BannerData) => {
            Image(banner.imageUrl)
              .width('100%')
              .height(200)
          }, (banner: BannerData) => banner.id)
        }
        .loop(true)
          .autoPlay(true)

        // Categories
        Grid() {
          ForEach(this.vm.categoryList, (category: CategoryItem) => {
            GridItem() {
              CategoryItem({ item: category })
            }
          }, (category: CategoryItem) => category.id)
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
      }
    }
  }
}
```

### AppStorageV2 and PersistenceV2

#### AppStorageV2 - Global State

```typescript
// Initialize in EntryAbility
export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // Initialize global state
    AppStorageV2.connect(UserInfoModel, () => new UserInfoModel());
    AppStorageV2.connect(StoreInfoModel, () => new StoreInfoModel());
  }
}

// Use in component
@ComponentV2
struct HomePage {
  // Connect to global state (read-only)
  @Local userInfo: UserInfoModel = AppStorageV2.connect(UserInfoModel, () => new UserInfoModel())!;

  // Connect to global state (two-way)
  @Local storeInfo: StoreInfoModel = AppStorageV2.connect(StoreInfoModel, () => new StoreInfoModel())!;

  build() {
    Column() {
      Text(`Welcome, ${this.userInfo.userName}`)
      Text(`Store: ${this.storeInfo.storeName}`)
    }
  }
}
```

#### PersistenceV2 - Persistent Storage

```typescript
@ComponentV2
struct SettingsPage {
  // Connect to persistent storage
  @Local userSettings: UserSettingsModel = PersistenceV2.connect(
    UserSettingsModel,
    () => new UserSettingsModel(),
    { name: 'user_settings' }
  )!;

  build() {
    Column() {
      Toggle({ type: ToggleType.Switch, isOn: this.userSettings.notificationsEnabled })
        .onChange((isOn: boolean) => {
          this.userSettings.notificationsEnabled = isOn;
          // Automatically persisted to disk
        })
    }
  }
}

@ObservedV2
export class UserSettingsModel {
  @Trace notificationsEnabled: boolean = true;
  @Trace darkMode: boolean = false;
  @Trace language: string = 'zh-CN';
}
```

---

## Navigation Patterns

### Navigation Component (Only)

```typescript
@Entry
@ComponentV2
struct MainPage {
  @Provide('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local vm: MainPageVM = new MainPageVM();

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'detail') {
      DetailPage({ params: params as DetailParams })
    } else if (name === 'settings') {
      SettingsPage()
    }
  }

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Button('Go to Detail')
          .onClick(() => {
            this.navPathStack.pushPathByName('detail', { id: '123' });
          })
      }
    }
    .navDestination(this.PageBuilder)
      .title('Home')
  }
}

@ComponentV2
struct DetailPage {
  @Consume('navPathStack') navPathStack: NavPathStack;
  @Param params: DetailParams = new DetailParams();

  build() {
    NavDestination() {
      Column() {
        Text(`Product ID: ${this.params.id}`)
        Button('Back')
          .onClick(() => {
            this.navPathStack.pop();
          })
      }
    }
    .title('Detail')
  }
}
```

### Tab Navigation with ComponentV2

```typescript
@Entry
@ComponentV2
struct Index {
  @Local currentIndex: number = 0;
  @Local tabController: TabsController = new TabsController();

  @Builder
  TabBuilder(title: string, targetIndex: number, selectedIcon: Resource, normalIcon: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedIcon : normalIcon)
        .width(24)
        .height(24)
      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex === targetIndex ? '#007AFF' : '#8E8E93')
        .margin({ top: 4 })
    }
    .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.currentIndex = targetIndex;
        this.tabController.changeIndex(targetIndex);
      })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      TabContent() {
        HomePage()
      }
      .tabBar(this.TabBuilder('Home', 0, $r('app.media.home_selected'), $r('app.media.home')))

      TabContent() {
        DiscoverPage()
      }
      .tabBar(this.TabBuilder('Discover', 1, $r('app.media.discover_selected'), $r('app.media.discover')))

      TabContent() {
        ProfilePage()
      }
      .tabBar(this.TabBuilder('Profile', 2, $r('app.media.profile_selected'), $r('app.media.profile')))
    }
    .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
  }
}
```

---

## Testing

### Unit Testing with ComponentV2

```typescript
import { describe, it, expect, beforeEach } from '@ohos/hypium';
import { HomePageVM } from '../viewmodel/HomePageVM';

export default function HomePageVMTest() {
  describe('HomePageVM', () => {
    let vm: HomePageVM;

    beforeEach(() => {
      vm = new HomePageVM();
    });

    it('should load data successfully', async () => {
      await vm.loadData();

      expect(vm.isLoading).assertFalse();
      expect(vm.bannerList.length).assertLarger(0);
    });

    it('should update current tab', () => {
      vm.currentTab = 1;

      expect(vm.currentTab).assertEqual(1);
    });
  });
}
```

## Best Practices Checklist

```markdown
## State Management
- [ ] Use @ComponentV2 for all new components
- [ ] Use @ObservedV2 for ViewModels
- [ ] Use @Trace for all tracked properties
- [ ] Use @Computed for derived state
- [ ] Use @Monitor for side effects
- [ ] Use AppStorageV2 for global state
- [ ] Use PersistenceV2 for persistent data

## Component Design
- [ ] Extract reusable components
- [ ] Use @Param for component inputs
- [ ] Use @Event for component outputs
- [ ] Use @Local for component-local state
- [ ] Keep components focused and small

## Performance
- [ ] Use LazyForEach for long lists
- [ ] Avoid unnecessary re-renders
- [ ] Use @Computed for expensive calculations
- [ ] Monitor with @Monitor sparingly

## Code Quality
- [ ] No any types
- [ ] Explicit return types
- [ ] Proper error handling
- [ ] Logging with hilog
```

### Debugging Tips

#### 1. Read error messages carefully

```
ERROR: "for .. in" is not supported (arkts-no-for-in)
       At File: CheckInViewModel.ets:144:22
```

- **What:** The error type
- **Where:** File and line number
- **Why:** The specific ArkTS restriction violated

#### 2. Check the error code

| Error Code | Category | Example |
|------------|----------|---------|
| 10605080 | Syntax error | for..in not supported |
| 10605029 | Type restriction | Indexed access not supported |
| 10605001 | Type error | Object type assignment issues |
| 10903329 | Resource error | Unknown resource name |

#### 3. Use hvigorw for detailed error info

```bash
# Compile with detailed output
hvigorw assembleHap --mode module -p module=entry@default -p product=default

# Check just errors
hvigorw assembleHap 2>&1 | grep ERROR

# Check specific file
hvigorw assembleHap 2>&1 | grep "CheckInViewModel"
```

#### 4. Incremental fixing

```bash
# 1. Fix first error
# 2. Recompile
# 3. Fix next error
# 4. Repeat

# Sometimes one fix resolves multiple errors
```

---

### Quick Reference: ArkTS Restrictions

| TypeScript Feature | ArkTS Status | Alternative |
|--------------------|--------------|-------------|
| `for..in` loop | ❌ Not supported | `Object.keys().forEach()` or `for..of` |
| `any` type | ❌ Not supported | Explicit types or `Record<string, T>` |
| `unknown` type | ❌ Not supported | Explicit types or union types |
| Indexed access `obj[key]` | ❌ Not supported | `Record<string, T>` type |
| Type assertions `as` | ❌ Not supported | Proper type definitions |
| `typeof` for types | ❌ Not supported | Type aliases |
| `keyof` operator | ❌ Not supported | Explicit string types |
| Decorators | ✅ Limited | `@ComponentV2`, `@ObservedV2`, etc. |



## See Also

- [reference/arkts.md](reference/arkts.md) — ArkTS language guide and restrictions, **Page Development Pitfalls**, **File Organization**
- [reference/arkui.md](reference/arkui.md) — ArkUI components and styling, **Page Routing**, **Navigation Patterns**, **Common Page Patterns**
- [reference/structure-rules.md](reference/structure-rules.md) ] — Code Organization and Component Architecture Rules
