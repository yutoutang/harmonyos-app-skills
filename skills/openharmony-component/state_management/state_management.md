# State Management in HarmonyOS 6.0

Comprehensive guide to state management in HarmonyOS 6.0 using ArkTS reactive state system.

## Table of Contents

1. [Overview](#overview)
2. [Core Decorators](#core-decorators)
3. [Component State Patterns](#component-state-patterns)
4. [Advanced State Management](#advanced-state-management)
5. [Performance Optimization](#performance-optimization)
6. [Best Practices](#best-practices)
7. [Common Patterns](#common-patterns)

---

## Overview

HarmonyOS 6.0 introduces a **V2 state management system** with enhanced reactivity and performance. The system uses decorators to mark observable state and automatically track dependencies.

### Key Concepts

- **Reactive State**: State that automatically triggers UI updates when changed
- **Decorators**: Mark classes and properties for reactivity (`@ObservedV2`, `@Trace`, `@Computed`)
- **Component State**: Local component state using `@Local`
- **Param Passing**: Parent-to-child data flow using `@Param`
- **Event Communication**: Child-to-parent callbacks using `@Event`

### When to Use State Management

- Component-local UI state (form inputs, toggles, selections)
- Shared application state (user data, settings)
- Derived/calculated values (totals, filtered lists)
- Complex state objects (nested data structures)

---

## Core Decorators

### @ObservedV2

Marks a class as observable - all `@Trace` properties within will be tracked.

```typescript
@ObservedV2
export class User {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace email: string = ''
  @Trace age: number = 0

  // Nested object - also needs @Trace
  @Trace address: Address = new Address()
}

@ObservedV2
export class Address {
  @Trace street: string = ''
  @Trace city: string = ''
  @Trace zipCode: string = ''
}
```

**Key Points:**
- Only classes marked with `@ObservedV2` can contain `@Trace` properties
- Nested objects must also be marked with `@ObservedV2`
- Properties without `@Trace` will NOT be reactive

### @Trace

Marks individual properties as observable within an `@ObservedV2` class.

```typescript
@ObservedV2
export class Task {
  @Trace id: string = ''
  @Trace title: string = ''
  @Trace isCompleted: boolean = false
  @Trace priority: 'low' | 'medium' | 'high' = 'medium'

  // Non-reactive property
  createdAt: Date = new Date()

  // Array of objects - needs proper handling
  @Trace tags: string[] = []

  // Object array - elements must be observable
  @Trace subTasks: SubTask[] = []
}

@ObservedV2
export class SubTask {
  @Trace id: string = ''
  @Trace title: string = ''
  @Trace done: boolean = false
}
```

**Important Rules:**
1. **Primitive types**: Directly use `@Trace`
2. **Arrays**: Use `@Trace` but modify using immutable patterns
3. **Objects**: Both the array and objects must be `@ObservedV2`
4. **Maps/Sets**: Use `@Trace` but replace entire collection for updates

### @Computed

Derived values that automatically recalculate when dependencies change.

```typescript
@ObservedV2
export class Cart {
  @Trace items: CartItem[] = []

  @Computed
  get subtotal(): number {
    return this.items.reduce((sum, item) => sum + (item.price * item.quantity), 0)
  }

  @Computed
  get totalCount(): number {
    return this.items.reduce((sum, item) => sum + item.quantity, 0)
  }

  @Computed
  get isEmpty(): boolean {
    return this.items.length === 0
  }
}

@ObservedV2
export class CartItem {
  @Trace productId: string = ''
  @Trace name: string = ''
  @Trace price: number = 0
  @Trace quantity: number = 1
}
```

**Computed Properties:**
- Read-only (no setter)
- Cached until dependencies change
- Can depend on other `@Computed` properties
- Must not have side effects

### @Local

Component-local state in `@ComponentV2` components.

```typescript
@ComponentV2
export struct CounterExample {
  @Local count: number = 0
  @Local step: number = 1

  build() {
    Column({ space: 16 }) {
      Text(`Count: ${this.count}`)
        .fontSize(24)

      Row({ space: 8 }) {
        Button('-')
          .onClick(() => {
            this.count -= this.step
          })

        Button('+')
          .onClick(() => {
            this.count += this.step
          })
      }
    }
  }
}
```

**Use @Local for:**
- Simple primitive values (numbers, strings, booleans)
- Component-specific UI state
- Temporary values during user interaction

### @Param

Read-only data passed from parent component.

```typescript
@ComponentV2
export struct TaskItem {
  @Param task: Task = new Task()
  @Param index: number = 0
  @Param onSelect: (taskId: string) => void = () => {}

  build() {
    Row({ space: 12 }) {
      Checkbox()
        .select(this.task.isCompleted)
        .onChange((value: boolean) => {
          // Note: Direct mutation won't work
          // Parent must provide update callback
          this.onSelect(this.task.id)
        })

      Text(this.task.title)
        .fontSize(16)
        .decoration({
          type: this.task.isCompleted
            ? TextDecorationType.LineThrough
            : TextDecorationType.None
        })
    }
  }
}
```

**@Param Characteristics:**
- Read-only in child component
- Changes from parent trigger re-render
- Objects/arrays are references (not deep copied)
- Use callbacks for child-to-parent communication

### @Event

Callbacks for child-to-parent communication.

```typescript
@ComponentV2
export struct SearchBar {
  @Local searchText: string = ''
  @Event onSearch: (query: string) => void = () => {}
  @Event onClear: () => void = () => {}

  build() {
    Row({ space: 8 }) {
      Search({ value: $$this.searchText })
        .searchButton('Search')
        .onSubmit(() => {
          this.onSearch(this.searchText)
        })

      if (this.searchText.length > 0) {
        Button('Clear')
          .onClick(() => {
            this.searchText = ''
            this.onClear()
          })
      }
    }
  }
}

// Usage
@ComponentV2
export struct TaskListPage {
  @Local searchQuery: string = ''

  build() {
    Column() {
      SearchBar({
        onSearch: (query: string) => {
          this.searchQuery = query
        },
        onClear: () => {
          this.searchQuery = ''
        }
      })

      TaskList({ query: this.searchQuery })
    }
  }
}
```

---

## Component State Patterns

### Pattern 1: Lifted State

Share state between sibling components by lifting to parent.

```typescript
@ComponentV2
export struct FilteredTaskList {
  @Param tasks: Task[] = []
  @Param filter: 'all' | 'active' | 'completed' = 'all'

  build() {
    List({ space: 8 }) {
      ForEach(this.getFilteredTasks(), (task: Task) => {
        ListItem() {
          TaskItem({ task: task })
        }
      })
    }
  }

  private getFilteredTasks(): Task[] {
    switch (this.filter) {
      case 'active':
        return this.tasks.filter(t => !t.isCompleted)
      case 'completed':
        return this.tasks.filter(t => t.isCompleted)
      default:
        return this.tasks
    }
  }
}

@ComponentV2
export struct TaskPage {
  @Local tasks: Task[] = []
  @Local currentFilter: 'all' | 'active' | 'completed' = 'all'

  build() {
    Column() {
      FilterControls({
        filter: this.currentFilter,
        onFilterChange: (filter) => {
          this.currentFilter = filter
        }
      })

      FilteredTaskList({
        tasks: this.tasks,
        filter: this.currentFilter
      })
    }
  }
}
```

### Pattern 2: State Updater

Pass updater functions instead of direct state mutation.

```typescript
@ComponentV2
export struct TaskItem {
  @Param task: Task = new Task()
  @Param onUpdate: (taskId: string, updates: Partial<Task>) => void = () => {}
  @Param onDelete: (taskId: string) => void = () => {}

  build() {
    Row() {
      Checkbox()
        .select(this.task.isCompleted)
        .onChange((value: boolean) => {
          this.onUpdate(this.task.id, { isCompleted: value })
        })

      Button('Delete')
        .onClick(() => {
          this.onDelete(this.task.id)
        })
    }
  }
}

@ComponentV2
export struct TaskList {
  @Local tasks: Task[] = []

  build() {
    List() {
      ForEach(this.tasks, (task: Task) => {
        ListItem() {
          TaskItem({
            task: task,
            onUpdate: this.handleTaskUpdate.bind(this),
            onDelete: this.handleTaskDelete.bind(this)
          })
        }
      })
    }
  }

  private handleTaskUpdate(taskId: string, updates: Partial<Task>): void {
    const index = this.tasks.findIndex(t => t.id === taskId)
    if (index !== -1) {
      // Immutable update pattern
      this.tasks[index] = {
        ...this.tasks[index],
        ...updates
      }
    }
  }

  private handleTaskDelete(taskId: string): void {
    this.tasks = this.tasks.filter(t => t.id !== taskId)
  }
}
```

### Pattern 3: Computed View Models

Use `@Computed` for derived view state.

```typescript
@ObservedV2
export class TaskViewModel {
  @Trace tasks: Task[] = []
  @Trace filter: 'all' | 'active' | 'completed' = 'all'
  @Trace sortBy: 'date' | 'priority' = 'date'

  @Computed
  get filteredTasks(): Task[] {
    switch (this.filter) {
      case 'active':
        return this.tasks.filter(t => !t.isCompleted)
      case 'completed':
        return this.tasks.filter(t => t.isCompleted)
      default:
        return this.tasks
    }
  }

  @Computed
  get sortedTasks(): Task[] {
    const tasks = [...this.filteredTasks]

    return tasks.sort((a, b) => {
      if (this.sortBy === 'priority') {
        const priorityOrder = { high: 3, medium: 2, low: 1 }
        return priorityOrder[b.priority] - priorityOrder[a.priority]
      } else {
        return b.createdAt.getTime() - a.createdAt.getTime()
      }
    })
  }

  @Computed
  get stats(): TaskStats {
    const total = this.tasks.length
    const completed = this.tasks.filter(t => t.isCompleted).length
    const active = total - completed

    return {
      total,
      completed,
      active,
      completionRate: total > 0 ? (completed / total) * 100 : 0
    }
  }
}

interface TaskStats {
  total: number
  completed: number
  active: number
  completionRate: number
}
```

---

## Advanced State Management

### Array State Management

Properly updating reactive arrays requires immutable patterns.

```typescript
@ObservedV2
export class TaskListState {
  @Trace tasks: Task[] = []

  // Add item
  addTask(task: Task): void {
    this.tasks = [...this.tasks, task]
  }

  // Remove item
  removeTask(taskId: string): void {
    this.tasks = this.tasks.filter(t => t.id !== taskId)
  }

  // Update item
  updateTask(taskId: string, updates: Partial<Task>): void {
    this.tasks = this.tasks.map(t =>
      t.id === taskId ? { ...t, ...updates } : t
    )
  }

  // Reorder
  reorderTasks(fromIndex: number, toIndex: number): void {
    const tasks = [...this.tasks]
    const [removed] = tasks.splice(fromIndex, 1)
    tasks.splice(toIndex, 0, removed)
    this.tasks = tasks
  }

  // Batch update
  toggleAll(): void {
    const allCompleted = this.tasks.every(t => t.isCompleted)
    this.tasks = this.tasks.map(t => ({
      ...t,
      isCompleted: !allCompleted
    }))
  }
}
```

### Object State Updates

Use spread operator for immutable object updates.

```typescript
@ObservedV2
export class FormState {
  @Trace username: string = ''
  @Trace email: string = ''
  @Trace age: number = 0
  @Trace preferences: UserPreferences = new UserPreferences()

  updateField<K extends keyof FormState>(
    field: K,
    value: FormState[K]
  ): void {
    this[field] = value
  }

  updatePreferences(updates: Partial<UserPreferences>): void {
    this.preferences = {
      ...this.preferences,
      ...updates
    }
  }
}

@ObservedV2
export class UserPreferences {
  @Trace theme: 'light' | 'dark' = 'light'
  @Trace notifications: boolean = true
  @Trace language: string = 'en'
}
```

### Deep State Updates

For deeply nested state, consider flattening or using immutable libraries.

```typescript
@ObservedV2
export class AppState {
  @Trace user: UserState = new UserState()

  updateProfile(updates: Partial<UserProfile>): void {
    this.user.profile = {
      ...this.user.profile,
      ...updates
    }
  }

  updateAddress(updates: Partial<Address>): void {
    this.user.profile.address = {
      ...this.user.profile.address,
      ...updates
    }
  }
}

@ObservedV2
export class UserState {
  @Trace profile: UserProfile = new UserProfile()
  @Trace settings: UserSettings = new UserSettings()
}

@ObservedV2
export class UserProfile {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace email: string = ''
  @Trace address: Address = new Address()
}
```

---

## Performance Optimization

### Minimize Re-renders

Use `@Computed` for expensive calculations.

```typescript
@ObservedV2
export class ProductList {
  @Trace products: Product[] = []
  @Trace filters: ProductFilters = new ProductFilters()

  // Expensive computation - cached
  @Computed
  get filteredProducts(): Product[] {
    console.info('Computing filtered products...')

    return this.products.filter(product => {
      if (this.filters.minPrice !== null && product.price < this.filters.minPrice) {
        return false
      }
      if (this.filters.maxPrice !== null && product.price > this.filters.maxPrice) {
        return false
      }
      if (this.filters.category && product.category !== this.filters.category) {
        return false
      }
      if (this.filters.search && !product.name.includes(this.filters.search)) {
        return false
      }
      return true
    })
  }

  @Computed
  get priceRange(): { min: number; max: number } {
    if (this.products.length === 0) {
      return { min: 0, max: 0 }
    }

    const prices = this.products.map(p => p.price)
    return {
      min: Math.min(...prices),
      max: Math.max(...prices)
    }
  }
}
```

### Lazy Initialization

Use lazy getters for expensive initializations.

```typescript
@ObservedV2
export class ChartData {
  @Trace rawData: number[] = []
  private _processed: number[] | null = null

  @Computed
  get processedData(): number[] {
    if (this._processed === null) {
      console.info('Processing data...')
      this._processed = this.rawData.map(n => this.transform(n))
    }
    return this._processed
  }

  private transform(value: number): number {
    // Expensive computation
    return Math.sqrt(Math.abs(value)) * 100
  }

  // Reset cache when raw data changes
  updateRawData(newData: number[]): void {
    this.rawData = newData
    this._processed = null
  }
}
```

### Batch Updates

Group multiple state updates to reduce re-renders.

```typescript
@ObservedV2
export class BatchUpdater {
  @Trace items: ListItem[] = []
  @Trace selectedIndex: number = -1
  @Trace isLoading: boolean = false

  batchUpdate(items: ListItem[], selectedIndex: number): void {
    // All updates in one render cycle
    this.items = items
    this.selectedIndex = selectedIndex
    this.isLoading = false
  }

  async loadData(): Promise<void> {
    this.isLoading = true

    try {
      const [items, selectedIndex] = await Promise.all([
        fetchItems(),
        fetchLastSelectedIndex()
      ])

      this.batchUpdate(items, selectedIndex)
    } catch (error) {
      this.isLoading = false
      console.error('Failed to load data:', error)
    }
  }
}
```

---

## Best Practices

### 1. Use Immutable Updates

```typescript
// ❌ WRONG: Direct mutation
this.tasks[0].isCompleted = true

// ✅ CORRECT: Immutable update
this.tasks = this.tasks.map((task, index) =>
  index === 0 ? { ...task, isCompleted: true } : task
)
```

### 2. Keep State Flat

```typescript
// ❌ WRONG: Deeply nested
@ObservedV2
export class BadState {
  @Trace data: {
    user: {
      profile: {
        address: {
          street: string
          city: string
        }
      }
    }
  }
}

// ✅ CORRECT: Flattened structure
@ObservedV2
export class GoodState {
  @Trace userStreet: string = ''
  @Trace userCity: string = ''
  // Or use normalized state with IDs
}
```

### 3. Separate View State from Domain State

```typescript
// Domain state - business logic
@ObservedV2
export class TaskDomain {
  @Trace tasks: Task[] = []

  addTask(task: Task): void {
    this.tasks = [...this.tasks, task]
  }
}

// View state - UI concerns
@ComponentV2
export struct TaskPage {
  @Local domain: TaskDomain = new TaskDomain()
  @Local selectedTab: number = 0
  @Local isFilterVisible: boolean = false
  @Local scrollPosition: number = 0
}
```

### 4. Use @Computed for Derived State

```typescript
// ❌ WRONG: Manual tracking
@ObservedV2
export class BadCart {
  @Trace items: CartItem[] = []
  @Trace total: number = 0 // Manually maintained

  addItem(item: CartItem): void {
    this.items = [...this.items, item]
    this.total = this.items.reduce(...) // Must remember to update
  }
}

// ✅ CORRECT: Computed property
@ObservedV2
export class GoodCart {
  @Trace items: CartItem[] = []

  @Computed
  get total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0)
  }
}
```

### 5. Avoid Large Objects in @Param

```typescript
// ❌ WRONG: Large object passed around
@ComponentV2
export struct BadChild {
  @Param massiveData: MassiveDataset = new MassiveDataset()
}

// ✅ CORRECT: Pass ID or specific fields
@ComponentV2
export struct GoodChild {
  @Param itemId: string = ''
  @Param itemName: string = ''
  @Param onDataChange: (id: string) => void = () => {}
}
```

---

## Common Patterns

### Form State Pattern

```typescript
@ObservedV2
export class FormState<T> {
  @Trace values: T
  @Trace errors: Partial<Record<keyof T, string>> = {}
  @Trace touched: Partial<Record<keyof T, boolean>> = {}
  @Trace isSubmitting: boolean = false

  constructor(initialValues: T) {
    this.values = initialValues
  }

  setValue<K extends keyof T>(field: K, value: T[K]): void {
    this.values = { ...this.values, [field]: value }
    this.clearError(field)
  }

  setError<K extends keyof T>(field: K, error: string): void {
    this.errors = { ...this.errors, [field]: error }
  }

  clearError<K extends keyof T>(field: K): void {
    const { [field]: _, ...rest } = this.errors
    this.errors = rest
  }

  setTouched<K extends keyof T>(field: K): void {
    this.touched = { ...this.touched, [field]: true }
  }

  @Computed
  get isValid(): boolean {
    return Object.keys(this.errors).length === 0
  }
}

// Usage
interface LoginFormData {
  username: string
  password: string
}

@ComponentV2
export struct LoginForm {
  @Local form: FormState<LoginFormData> = new FormState<LoginFormData>({
    username: '',
    password: ''
  })

  build() {
    Column({ space: 16 }) {
      TextInput({ text: $$this.form.values.username })
        .onChange((value: string) => {
          this.form.setValue('username', value)
        })
        .onBlur(() => {
          this.form.setTouched('username')
          if (this.form.values.username.length < 3) {
            this.form.setError('username', 'Username too short')
          }
        })

      if (this.form.errors.username) {
        Text(this.form.errors.username!)
          .fontColor(Color.Red)
          .fontSize(12)
      }
    }
  }
}
```

### List with Selection Pattern

```typescript
@ObservedV2
export class SelectionManager<T> {
  @Trace items: T[] = []
  @Trace selectedIds: Set<string> = new Set()

  isSelected(id: string): boolean {
    return this.selectedIds.has(id)
  }

  toggleSelection(id: string): void {
    const newSet = new Set(this.selectedIds)
    if (newSet.has(id)) {
      newSet.delete(id)
    } else {
      newSet.add(id)
    }
    this.selectedIds = newSet
  }

  selectAll(): void {
    this.selectedIds = new Set(this.items.map(item => this.getId(item)))
  }

  clearSelection(): void {
    this.selectedIds = new Set()
  }

  @Computed
  get selectedCount(): number {
    return this.selectedIds.size
  }

  @Computed
  get isAllSelected(): boolean {
    return this.items.length > 0 && this.selectedIds.size === this.items.length
  }

  private getId(item: T): string {
    return (item as any).id
  }
}
```

### Pagination Pattern

```typescript
@ObservedV2
export class PaginationState<T> {
  @Trace items: T[] = []
  @Trace currentPage: number = 1
  @Trace pageSize: number = 20
  @Trace totalItems: number = 0
  @Trace isLoading: boolean = false

  @Computed
  get totalPages(): number {
    return Math.ceil(this.totalItems / this.pageSize)
  }

  @Computed
  get hasNextPage(): boolean {
    return this.currentPage < this.totalPages
  }

  @Computed
  get hasPrevPage(): boolean {
    return this.currentPage > 1
  }

  @Computed
  get canGoToNext(): boolean {
    return this.hasNextPage && !this.isLoading
  }

  nextPage(): void {
    if (this.canGoToNext) {
      this.currentPage++
    }
  }

  prevPage(): void {
    if (this.hasPrevPage) {
      this.currentPage--
    }
  }

  goToPage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page
    }
  }

  reset(): void {
    this.currentPage = 1
    this.items = []
  }
}
```

---

## Summary

HarmonyOS 6.0 state management provides a robust reactive system:

**Core Decorators:**
- `@ObservedV2`: Marks observable classes
- `@Trace`: Marks reactive properties
- `@Computed`: Derived/cached values
- `@Local`: Component-local state
- `@Param`: Parent-to-child data
- `@Event`: Child-to-parent callbacks

**Best Practices:**
- Always use immutable update patterns
- Keep state structure flat and normalized
- Separate domain state from view state
- Use `@Computed` for derived values
- Minimize re-renders with careful state design
- Batch updates when possible

**Common Patterns:**
- Form state management
- List selection management
- Pagination
- Lifted state for siblings
- State updater functions

This state management system enables efficient, predictable UI updates while maintaining clean separation of concerns.
