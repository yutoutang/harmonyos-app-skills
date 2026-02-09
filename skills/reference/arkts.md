# ArkTS Language Guide

ArkTS is a TypeScript superset optimized for HarmonyOS with strict static typing enforcement and UI declaration extensions.

## Key Differences from TypeScript

### Prohibited Features (Critical!)

ArkTS **strictly prohibits** these TypeScript features. Using them will cause **compilation errors**:

```typescript
// ❌ These TypeScript features are NOT allowed in ArkTS

// 1. any type - ABSOLUTELY FORBIDDEN
let data: any;  // Compilation Error!

// 2. unknown type
let value: unknown;  // Error!

// 3. Type assertions
(value as string).length;  // Error!
(<SomeType>data).method();  // Error!

// 4. Dynamic property access (without Record type)
let obj = {};
obj['key'] = value;  // Error! (unless Record type)

// 5. Structural typing for classes
class A { x: number = 0; }
class B { x: number = 0; }
let a: A = new B();  // Error! Classes must be explicitly related

// 6. typeof for types
type T = typeof someVariable;  // Error!

// 7. keyof operator
type Keys = keyof SomeType;  // Error!

// 8. Indexed access types
type Value = SomeType['key'];  // Error!

// 9. Conditional types
type Check<T> = T extends string ? 'yes' : 'no';  // Error!

// 10. Mapped types
type Readonly<T> = { readonly [P in keyof T]: T[P] };  // Error!

// 11. Symbol type
const sym = Symbol('key');  // Error!

// 12. Decorators on non-class elements (except specific ArkTS decorators)
```

### Allowed Patterns (ArkTS-Specific)

```typescript
// ✅ These patterns are supported and recommended

// 1. Explicit types
let data: string = 'hello';
let count: number = 42;
let flag: boolean = true;

// 2. Interfaces
interface User {
  id: string;
  name: string;
  age?: number;  // Optional properties OK
}

// 3. Type aliases (basic)
type UserId = string;
type Callback = (data: string) => void;
type Status = 'loading' | 'success' | 'error';  // Union types

// 4. Record type for dynamic keys
let map: Record<string, number> = {};
map['key1'] = 100;  // OK with Record type

// 5. Enums
enum Color {
  Red,
  Green,
  Blue
}

// 6. Class inheritance
class Animal {
  name: string = '';
}

class Dog extends Animal {
  breed: string = '';
}

// 7. Generics (basic)
class Container<T> {
  private value: T = {} as T;

  setValue(value: T): void {
    this.value = value;
  }

  getValue(): T {
    return this.value;
  }
}
```

## Type System

### Primitive Types

```typescript
// Numbers
let integer: number = 42;
let float: number = 3.14;

// Strings
let text: string = 'Hello';
let template: string = `Value: ${integer}`;  // Template literals

// Booleans
let flag: boolean = true;

// Arrays
let numbers: number[] = [1, 2, 3];
let strings: Array<string> = ['a', 'b', 'c'];

// Tuples
let tuple: [string, number] = ['age', 25];

// Null and undefined (with unions)
let nullable: string | null = null;
let optional: string | undefined = undefined;

// Resource types (HarmonyOS-specific)
let icon: Resource = $r('app.media.icon');
let color: Resource = $r('app.color.primary');
let string: ResourceStr = $r('app.string.app_name');
```

### Object Types

```typescript
// Interface (preferred)
interface Product {
  readonly id: string;  // Read-only
  name: string;
  price: number;
  description?: string;  // Optional
  tags?: string[];
}

// Implementation
const product: Product = {
  id: 'prod_001',
  name: 'Phone',
  price: 999
};

// Type alias (for unions, primitives)
type Point = {
  x: number;
  y: number;
};

// Nested interfaces
interface Address {
  street: string;
  city: string;
  country: string;
}

interface UserProfile {
  id: string;
  name: string;
  address: Address;
}
```

### Function Types

```typescript
// Function declarations
function add(a: number, b: number): number {
  return a + b;
}

// Arrow functions
const multiply = (a: number, b: number): number => a * b;

// Optional parameters
function greet(name: string, greeting?: string): string {
  return `${greeting ?? 'Hello'}, ${name}`;
}

// Default parameters
function createUser(name: string, role: string = 'user'): User {
  return { id: '0', name, role };
}

// Rest parameters
function sum(...numbers: number[]): number {
  return numbers.reduce((a, b) => a + b, 0);
}

// Callback types
type ClickHandler = (event: ClickEvent) => void;

function setOnClick(handler: ClickHandler): void {
  // ...
}

// Function overloading (limited)
function process(input: string): string;
function process(input: number): number;
function process(input: string | number): string | number {
  return input;
}
```

### Generics

```typescript
// Generic function
function identity<T>(value: T): T {
  return value;
}

// With constraints
interface HasId {
  id: string;
}

function findById<T extends HasId>(items: T[], id: string): T | undefined {
  return items.find(item => item.id === id);
}

// Generic interface
interface Repository<T extends HasId> {
  getById(id: string): Promise<T>;
  save(item: T): Promise<void>;
  delete(id: string): Promise<void>;
}

// Generic class
class Stack<T> {
  private items: T[] = [];

  push(item: T): void {
    this.items.push(item);
  }

  pop(): T | undefined {
    return this.items.pop();
  }

  peek(): T | undefined {
    return this.items[this.items.length - 1];
  }

  get length(): number {
    return this.items.length;
  }
}

// Usage
const numberStack = new Stack<number>();
numberStack.push(1);
numberStack.push(2);
console.log(numberStack.pop());  // 2
```

## Classes

### Class Declaration

```typescript
class User {
  // Properties MUST have default values (strict requirement)
  private id: string = '';
  public name: string = '';
  protected email: string = '';
  readonly createdAt: Date = new Date();

  // Static members
  static userCount: number = 0;
  static readonly MAX_USERS: number = 1000;

  // Constructor
  constructor(id: string, name: string, email: string) {
    this.id = id;
    this.name = name;
    this.email = email;
    User.userCount++;
  }

  // Methods
  public getDisplayName(): string {
    return this.name;
  }

  private validateEmail(): boolean {
    return this.email.includes('@');
  }

  protected getInitials(): string {
    return this.name.charAt(0);
  }

  // Getter/Setter
  get displayName(): string {
    return `USER-${this.id}`;
  }

  set displayName(value: string) {
    // Validate and process
    this.name = value;
  }

  // Static method
  static createGuest(): User {
    return new User('guest', 'Guest', 'guest@example.com');
  }
}
```

## ArkTS-Specific Decorators

### Component Decorators (HarmonyOS 6.0+)

```typescript
// ComponentV2 - New component system
@ComponentV2
struct ProductCard {
  @Param product: Product = new Product();
  @Local isFavorite: boolean = false;
  @Event onFavoriteToggle: (product: Product) => void = () => {};

  build() {
    Column() {
      Text(this.product.name)
      Button('Toggle')
        .onClick(() => {
          this.isFavorite = !this.isFavorite;
          this.onFavoriteToggle(this.product);
        })
    }
  }
}

// ObservedV2 - Observable class
@ObservedV2
export class HomePageVM {
  @Trace isLoading: boolean = false;
  @Trace dataList: Item[] = [];
  @Trace errorMsg: string = '';

  @Computed
  get hasData(): boolean {
    return this.dataList.length > 0;
  }

  @Monitor('isLoading')
  onLoadingChange() {
    console.info(`Loading: ${this.isLoading}`);
  }
}
```

### Property Initializers

```typescript
// ALL properties must have initial values
class MyClass {
  // ✅ Correct: Has default value
  name: string = '';
  count: number = 0;
  items: string[] = [];
  user: User | null = null;

  // ✅ Correct: Initialized in constructor
  private value: number;

  constructor(value: number) {
    this.value = value;
  }

  // ❌ WRONG: No default value
  // data: string;  // Compilation Error!
}
```

## Async/Await

```typescript
// Async function
async function fetchUser(id: string): Promise<User> {
  const response = await httpClient.get<User>(`/users/${id}`);
  return response;
}

// Error handling
async function safeGetUser(id: string): Promise<User | null> {
  try {
    return await fetchUser(id);
  } catch (error) {
    console.error(`Failed to fetch user: ${(error as Error).message}`);
    return null;
  }
}

// Parallel execution
async function loadDashboard(): Promise<DashboardData> {
  const [user, orders, notifications] = await Promise.all([
    fetchUser('current'),
    fetchOrders(),
    fetchNotifications()
  ]);

  return { user, orders, notifications };
}

// Sequential execution with error handling
async function processOrder(orderIds: string[]): Promise<void> {
  for (const id of orderIds) {
    try {
      await processOrder(id);
    } catch (error) {
      console.error(`Failed to process ${id}:`, error);
      // Continue with next order
    }
  }
}
```

## Common Patterns

### Factory Pattern

```typescript
interface Product {
  id: string;
  name: string;
  price: number;
}

class ProductFactory {
  static create(type: 'book' | 'electronics' | 'clothing'): Product {
    switch (type) {
      case 'book':
        return { id: '1', name: 'Book', price: 29.99 };
      case 'electronics':
        return { id: '2', name: 'Electronics', price: 999.99 };
      case 'clothing':
        return { id: '3', name: 'Clothing', price: 49.99 };
      default:
        throw new Error('Unknown product type');
    }
  }
}

// Usage
const book = ProductFactory.create('book');
```

### Singleton Pattern

```typescript
class DatabaseManager {
  private static instance: DatabaseManager;
  private isConnected: boolean = false;

  private constructor() {
    // Private constructor
  }

  static getInstance(): DatabaseManager {
    if (!DatabaseManager.instance) {
      DatabaseManager.instance = new DatabaseManager();
    }
    return DatabaseManager.instance;
  }

  connect(): void {
    if (!this.isConnected) {
      // Connect to database
      this.isConnected = true;
    }
  }
}

// Usage
const db1 = DatabaseManager.getInstance();
const db2 = DatabaseManager.getInstance();
console.info(db1 === db2);  // true
```

## Best Practices

### 1. Always Initialize Properties

```typescript
// ❌ BAD
class User {
  name: string;  // Error: not initialized
}

// ✅ GOOD
class User {
  name: string = '';
}

// ✅ ALSO GOOD: Initialize in constructor
class User {
  name: string;

  constructor(name: string) {
    this.name = name;
  }
}
```

### 2. Use Explicit Return Types

```typescript
// ❌ BAD
function getUser(id: string) {
  return { id, name: 'John' };
}

// ✅ GOOD
function getUser(id: string): User {
  return { id, name: 'John' };
}
```

### 3. Prefer Interfaces Over Type Aliases for Objects

```typescript
// ✅ PREFERRED for object types
interface User {
  id: string;
  name: string;
  email: string;
}

// Use type for unions, primitives, tuples
type Status = 'active' | 'inactive';
type Coordinate = [number, number];
type StringMap = Record<string, string>;
```

### 4. Use Record for Dynamic Keys

```typescript
// ❌ BAD
let cache = {};
cache['key'] = value;  // Error!

// ✅ GOOD
let cache: Record<string, CacheEntry> = {};
cache['key'] = value;  // OK
```

### 5. Avoid Optional Chaining on Non-Nullable

```typescript
// ❌ BAD: unnecessary optional chaining
const user: User = getUser();
console.log(user?.name);  // user is not nullable

// ✅ GOOD
console.log(user.name);
```

### 6. Use Readonly for Immutable Data

```typescript
interface Config {
  readonly apiUrl: string;
  readonly timeout: number;
  readonly retryCount: number;
}

const config: Config = {
  apiUrl: 'https://api.example.com',
  timeout: 5000,
  retryCount: 3
};

// config.apiUrl = 'new-url';  // Compilation error
```

### 7. Leverage Type Guards

```typescript
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function isNumber(value: unknown): value is number {
  return typeof value === 'number';
}

function process(value: string | number): void {
  if (isString(value)) {
    console.info(value.toUpperCase());  // TypeScript knows it's string
  } else if (isNumber(value)) {
    console.info(value.toFixed(2));  // TypeScript knows it's number
  }
}
```

## Error Handling

```typescript
// Custom error class
class AppError extends Error {
  constructor(
    message: string,
    public code: number,
    public details?: Object
  ) {
    super(message);
    this.name = 'AppError';
  }
}

// Throwing errors
function validateUser(user: User): void {
  if (!user.name) {
    throw new AppError('Name is required', 400);
  }
  if (!user.email.includes('@')) {
    throw new AppError('Invalid email', 400, { email: user.email });
  }
}

// Error handling with try-catch
async function loadUserData(): Promise<void> {
  try {
    const user = await fetchUser('current');
    validateUser(user);
  } catch (error) {
    if (error instanceof AppError) {
      console.error(`Error ${error.code}: ${error.message}`);
      // Handle specific error
    } else if (error instanceof Error) {
      console.error(`Unexpected error: ${error.message}`);
    } else {
      console.error('Unknown error');
    }
  }
}
```

## Working with null and undefined

```typescript
// Nullish coalescing operator
function greet(name: string | null): string {
  return name ?? 'Guest';
}

// Optional chaining
interface User {
  address?: {
    city?: string;
    country?: string;
  };
}

function getUserCity(user: User | null): string {
  return user?.address?.city ?? 'Unknown';
}

// Null checks
function processValue(value: string | null | undefined): void {
  if (value != null) {  // Checks for both null and undefined
    console.info(value.length);
  }
}

// Non-null assertion (use sparingly)
function processValue2(value: string | null): void {
  // Only use when you're certain value is not null
  console.info(value!.length);
}
```

## Common Errors and Solutions

This section documents common compilation errors encountered during HarmonyOS development and their solutions.

### ArkTS Syntax Errors

#### Error 1: `"for .. in" is not supported`

**Error Code:** `10605080`
**Error Message:** `"for .. in" is not supported (arkts-no-for-in)`

**Problem:**

```typescript
// ❌ FORBIDDEN
for (const key in allKeys) {
  if (key.startsWith('record_')) {
    const value = allKeys[key];
  }
}
```

**Solution:**

```typescript
// ✅ Use Object.keys() with forEach
Object.keys(allKeys).forEach((key: string) => {
  if (key.startsWith('record_')) {
    const value = allKeys[key];
  }
});

// ✅ Or use for..of with Object.keys()
for (const key of Object.keys(allKeys)) {
  if (key.startsWith('record_')) {
    // process key
  }
}
```

---

#### Error 2: Indexed access is not supported

**Error Code:** `10605029`
**Error Message:** `Indexed access is not supported for fields (arkts-no-props-by-index)`

**Problem:**

```typescript
// ❌ FORBIDDEN: Dynamic index access
const obj: Object = {};
const value = obj['key'];  // Error!

// ❌ FORBIDDEN: Even with type assertion
const allKeys: Record<string, string> = {};
Object.keys(allKeys).forEach((key: string) => {
  const value = allKeys[key];  // Error!
});
```

**Solution 1: Use Record type properly**

```typescript
// ✅ Use Record type for dynamic keys
const obj: Record<string, string> = {};

// ✅ Access with proper type
Object.keys(obj).forEach((key: string) => {
  const value: string = obj[key];  // OK with Record
});
```

**Solution 2: Restructure data storage**

```typescript
// ❌ PROBLEMATIC: Multiple keys with dynamic names
await dataPreferences.put(`record_${date}`, JSON.stringify(record));

// ✅ BETTER: Store all data in one JSON string
interface CheckInRecord {
  date: string;
  checkInTime: string;
}

const records: CheckInRecord[] = [];
await dataPreferences.put('all_records', JSON.stringify(records));

// Later, retrieve and parse
const recordsStr = await dataPreferences.get('all_records', '') as string;
const records: CheckInRecord[] = JSON.parse(recordsStr);
```

---

#### Error 3: `any` or `unknown` types not allowed

**Error Code:** `10605001`, `10605008`
**Error Message:**

- `Type 'Object' is not assignable to type 'Record<string, ValueType>'`
- `Use explicit types instead of "any", "unknown"`

**Problem:**

```typescript
// ❌ FORBIDDEN
let data: any = fetchData();
let value: unknown = result;

// ❌ FORBIDDEN: Object type issues
const all = await dataPreferences.getAll();  // Returns Object
const keys = Object.keys(all);
const value = all[key];  // Error: Object doesn't support index access
```

**Solution:**

```typescript
// ✅ Use explicit types
interface UserData {
  id: string;
  name: string;
}

let data: UserData = fetchData();

// ✅ Handle preferences.getAll() result
const all = await dataPreferences.getAll();
const keys = Object.keys(all);

// Filter and convert to proper type
const result: Record<string, string> = {};
keys.forEach((key: string) => {
  const value = all[key];
  if (typeof value === 'string') {
    result[key] = value;
  }
});

// ✅ Or use a simpler storage approach
const recordsStr = await dataPreferences.get('all_records', '') as string;
const records: CheckInRecord[] = JSON.parse(recordsStr);
```

---

### Resource Reference Errors

#### Error 4: Unknown resource name

**Error Code:** `10903329`
**Error Message:** `Unknown resource name 'chart_bar'`

**Problem:**

```typescript
// ❌ System icon names may not exist
Image($r('sys.symbol.chart_bar'))
Image($r('sys.symbol.gear'))
Image($r('sys.symbol.chevron_right'))
```

**Solution 1: Use Emoji (simplest)**

```typescript
// ✅ Use emoji for icons
Text('📊')  // chart
Text('⚙️')  // gear/settings
Text('›')   // chevron right
Text('👤')  // person
Text('⏰')  // clock
```

**Solution 2: Use valid system symbols**

```typescript
// ✅ Common system symbols that exist
$r('sys.symbol.clock_circle')
$r('sys.symbol.person_crop_circle')
$r('sys.symbol.checkmark_circle_fill')

// Check HarmonyOS documentation for available symbols
```

**Solution 3: Add custom resources**

```typescript
// 1. Add image to resources/base/media/icon.png

// 2. Reference it
Image($r('app.media.icon'))
  .width(24)
  .height(24)

// 3. Or create text-based icons
@Builder
IconBuilder(icon: string) {
  Text(icon)
    .fontSize(24)
}
```

---

#### Error 5: Missing media resources

**Error Code:** `10903329`
**Error Message:** `Unknown resource name 'app_icon'`

**Problem:**

```typescript
// ❌ Resource doesn't exist
Image($r('app.media.app_icon'))
```

**Solution:**

```typescript
// ✅ Option 1: Use existing resources
Image($r('app.media.icon'))  // Use actual existing file

// ✅ Option 2: Use placeholder with emoji
Text('👤')
  .width(60)
  .height(60)
  .fontSize(40)
  .textAlign(TextAlign.Center)
  .backgroundColor('#E0E0E0')
  .borderRadius(30)

// ✅ Option 3: Use conditional rendering
if (hasAvatar) {
  Image($r('app.media.avatar'))
} else {
  Text('👤')
}
```

### Data Storage Patterns

#### Pattern 1: Simple key-value storage

```typescript
// ✅ Good for simple data
await preferences.put('username', 'john');
await preferences.put('count', '42');
```

#### Pattern 2: JSON array storage (Recommended)

```typescript
// ✅ Best for collections of records
interface CheckInRecord {
  date: string;
  checkInTime: string;
  isLate: boolean;
}

// Save
const records: CheckInRecord[] = [record1, record2, record3];
await dataPreferences.put('all_records', JSON.stringify(records));
await dataPreferences.flush();

// Load
const recordsStr = await dataPreferences.get('all_records', '') as string;
const records: CheckInRecord[] = recordsStr ? JSON.parse(recordsStr) : [];
```

#### Pattern 3: Avoid - Multiple dynamic keys

```typescript
// ❌ PROBLEMATIC: Hard to manage with ArkTS restrictions
const date = '2025-01-30';
await dataPreferences.put(`record_${date}`, JSON.stringify(record));

// Later, retrieving all records is difficult:
const all = await dataPreferences.getAll();
// Can't easily iterate due to indexed access restrictions
```
