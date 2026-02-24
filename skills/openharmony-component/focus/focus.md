# Focus Management in HarmonyOS 6.0

Comprehensive guide to focus control, keyboard navigation, and accessibility in HarmonyOS 6.0 using ArkTS focus API.

## Table of Contents

1. [Overview](#overview)
2. [Focus Request API](#focus-request-api)
3. [Focus Events](#focus-events)
4. [Keyboard Navigation](#keyboard-navigation)
5. [Focus Scope](#focus-scope)
6. [Accessibility Integration](#accessibility-integration)
7. [Custom Focus Behavior](#custom-focus-behavior)
8. [Best Practices](#best-practices)

---

## Overview

Focus management enables users to navigate and interact with UI elements using keyboard, remote control, or other input devices. In HarmonyOS 6.0, the focus system is essential for accessibility and TV/webOS applications.

### Key Concepts

- **Focus Ownership**: Only one component can be focused at a time
- **Focus Request**: Programmatically request focus for a component
- **Focus Events**: Respond to focus gain/loss
- **Focus Scope**: Container that manages focus for its children
- **Tab Navigation**: Sequential navigation with Tab/Shift+Tab
- **Directional Navigation**: Arrow key navigation

### When to Use Focus Management

- Keyboard navigation for desktop/web
- Remote control navigation for TV
- Accessibility for screen readers
- Form input validation
- Custom navigation patterns

---

## Focus Request API

### Basic Focus Request

Request focus using the `focusable()` and `onFocus()` methods.

```typescript
@ComponentV2
export struct BasicFocusExample {
  @Local focusedBox: string = 'None'

  build() {
    Column({ space: 16 }) {
      Text('Click boxes to focus, or use Tab key')
        .fontSize(16)
        .fontColor('#666')

      Row({ space: 12 }) {
        this.FocusableBox('Box 1', 'Box 1')
        this.FocusableBox('Box 2', 'Box 2')
        this.FocusableBox('Box 3', 'Box 3')
      }

      Text(`Focused: ${this.focusedBox}`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .padding(20)
  }

  @Builder
  FocusableBox(label: string, boxId: string) {
    Text(label)
      .fontSize(16)
      .width(100)
      .height(100)
      .backgroundColor(this.focusedBox === boxId ? '#007DFF' : '#E0E0E0')
      .fontColor(this.focusedBox === boxId ? Color.White : '#333')
      .borderRadius(8)
      .textAlign(TextAlign.Center)
      .focusable(true)
      .onFocus(() => {
        this.focusedBox = boxId
      })
      .onBlur(() => {
        // Optional: Clear focus when lost
        // this.focusedBox = 'None'
      })
      .border(this.focusedBox === boxId ? { width: 3, color: '#0056B3' } : undefined)
  }
}
```

### Default Focus

Set initial focus when component loads.

```typescript
@ComponentV2
export struct DefaultFocusExample {
  @Local isFirstFocused: boolean = false
  @Local isSecondFocused: boolean = false
  @Local isThirdFocused: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('First box has default focus')
        .fontSize(16)
        .fontColor('#666')

      Row({ space: 12 }) {
        this.FocusableBox('Box 1', 0, true)
        this.FocusableBox('Box 2', 1, false)
        this.FocusableBox('Box 3', 2, false)
      }
    }
    .width('100%')
    .padding(20)
  }

  @Builder
  FocusableBox(label: string, index: number, defaultFocus: boolean) {
    Text(label)
      .fontSize(16)
      .width(100)
      .height(100)
      .backgroundColor(this.getBgColor(index))
      .fontColor(this.getFontColor(index))
      .borderRadius(8)
      .textAlign(TextAlign.Center)
      .focusable(true)
      .defaultFocus(defaultFocus)
      .onFocus(() => {
        this.updateFocus(index)
      })
      .border(this.isFocused(index) ? { width: 3, color: '#0056B3' } : undefined)
  }

  private isFocused(index: number): boolean {
    return [this.isFirstFocused, this.isSecondFocused, this.isThirdFocused][index]
  }

  private getBgColor(index: number): string {
    return this.isFocused(index) ? '#007DFF' : '#E0E0E0'
  }

  private getFontColor(index: number): ResourceColor {
    return this.isFocused(index) ? Color.White : '#333'
  }

  private updateFocus(index: number): void {
    this.isFirstFocused = index === 0
    this.isSecondFocused = index === 1
    this.isThirdFocused = index === 2
  }
}
```

### Programmatic Focus Request

Request focus from code (e.g., after validation error).

```typescript
@ComponentV2
export struct ProgrammaticFocusExample {
  @Local username: string = ''
  @Local password: string = ''
  @Local usernameFocused: boolean = false
  @Local passwordFocused: boolean = false
  @Local errorMessage: string = ''

  build() {
    Column({ space: 16 }) {
      Text('Login Form')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      TextInput({ placeholder: 'Username', text: $$this.username })
        .width('100%')
        .focusable(true)
        .border(this.usernameFocused ? { width: 2, color: '#007DFF' } : undefined)
        .onFocus(() => {
          this.usernameFocused = true
          this.passwordFocused = false
        })
        .onBlur(() => {
          this.usernameFocused = false
          this.validateUsername()
        })

      TextInput({ placeholder: 'Password', text: $$this.password })
        .width('100%')
        .type(InputType.Password)
        .focusable(true)
        .border(this.passwordFocused ? { width: 2, color: '#007DFF' } : undefined)
        .onFocus(() => {
          this.passwordFocused = true
          this.usernameFocused = false
        })
        .onBlur(() => {
          this.passwordFocused = false
        })

      if (this.errorMessage.length > 0) {
        Text(this.errorMessage)
          .fontSize(14)
          .fontColor(Color.Red)
          .margin({ top: 8 })
      }

      Button('Login')
        .width('100%')
        .onClick(() => {
          if (!this.validateUsername()) {
            // Request focus back to username field
            console.info('Requesting focus on username')
            // Note: Actual focus request would be handled by framework
          }
        })
    }
    .width('100%')
    .padding(20)
  }

  private validateUsername(): boolean {
    if (this.username.length < 3) {
      this.errorMessage = 'Username must be at least 3 characters'
      return false
    }
    this.errorMessage = ''
    return true
  }
}
```

---

## Focus Events

### onFocus and onBlur

Respond to focus gain and loss.

```typescript
@ComponentV2
export struct FocusEventExample {
  @Local focusedElement: string = 'None'
  @Local focusHistory: string[] = []

  build() {
    Column({ space: 16 }) {
      Text('Focus Events Demo')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        ForEach(['Element 1', 'Element 2', 'Element 3', 'Element 4'], (element: string) => {
          Text(element)
            .fontSize(16)
            .width('100%')
            .padding(16)
            .backgroundColor(this.focusedElement === element ? '#007DFF' : '#F5F5F5')
            .fontColor(this.focusedElement === element ? Color.White : '#333')
            .borderRadius(8)
            .focusable(true)
            .onFocus(() => {
              this.handleFocusGain(element)
            })
            .onBlur(() => {
              this.handleFocusLoss(element)
            })
        })
      }

      Text('Focus History:')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 16 })

      ForEach(this.focusHistory.slice(-5).reverse(), (entry: string) => {
        Text(entry)
          .fontSize(12)
          .fontColor('#666')
      })
    }
    .width('100%')
    .padding(20)
  }

  private handleFocusGain(element: string): void {
    this.focusedElement = element
    this.focusHistory.push(`Focus gained: ${element} (${new Date().toLocaleTimeString()})`)
  }

  private handleFocusLoss(element: string): void {
    this.focusHistory.push(`Focus lost: ${element} (${new Date().toLocaleTimeString()})`)
  }
}
```

### onFocusChange

Combined event for both focus gain and loss.

```typescript
@ComponentV2
export struct FocusChangeExample {
  @Local focusedId: string = ''
  @Local lastFocusChange: string = ''

  build() {
    Column({ space: 16 }) {
      Text('onFocusChange Demo')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 12 }) {
        ForEach(['A', 'B', 'C'], (id: string) => {
          Text(`Item ${id}`)
            .fontSize(16)
            .width(80)
            .height(80)
            .backgroundColor(this.focusedId === id ? '#28A745' : '#E0E0E0')
            .fontColor(Color.White)
            .borderRadius(8)
            .textAlign(TextAlign.Center)
            .focusable(true)
            .onFocusChange((isFocused: boolean) => {
              if (isFocused) {
                this.focusedId = id
                this.lastFocusChange = `Gained focus: ${id}`
              } else {
                this.lastFocusChange = `Lost focus: ${id}`
              }
              console.info('Focus change:', id, isFocused)
            })
        })
      }

      Text(this.lastFocusChange)
        .fontSize(14)
        .fontColor('#666')
        .margin({ top: 16 })
    }
    .width('100%')
    .padding(20)
  }
}
```

---

## Keyboard Navigation

### Tab Navigation

Sequential navigation with Tab/Shift+Tab.

```typescript
@ComponentV2
export struct TabNavigationExample {
  @Local tabIndex: number = -1
  private items: string[] = ['Field 1', 'Field 2', 'Field 3', 'Field 4']

  build() {
    Column({ space: 16 }) {
      Text('Press Tab to navigate')
        .fontSize(16)
        .fontColor('#666')

      Column({ space: 12 }) {
        ForEach(this.items, (item: string, index: number) => {
          TextInput({ placeholder: item })
            .width('100%')
            .focusable(true)
            .tabIndex(index)
            .border(this.tabIndex === index ? { width: 2, color: '#007DFF' } : undefined)
            .onFocus(() => {
              this.tabIndex = index
            })
            .onBlur(() => {
              if (this.tabIndex === index) {
                this.tabIndex = -1
              }
            })
        })
      }

      Text(`Tab index: ${this.tabIndex}`)
        .fontSize(14)
        .fontColor('#666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(20)
  }
}
```

### Directional Navigation

Arrow key navigation for grid layouts.

```typescript
@ComponentV2
export struct DirectionalNavigationExample {
  @Local focusedPosition: { row: number; col: number } = { row: 0, col: 0 }
  private readonly rows: number = 3
  private readonly cols: number = 3

  build() {
    Column({ space: 16 }) {
      Text('Use arrow keys to navigate')
        .fontSize(16)
        .fontColor('#666')

      Column({ space: 8 }) {
        ForEach(Array.from({ length: this.rows }), (_, rowIndex: number) => {
          Row({ space: 8 }) {
            ForEach(Array.from({ length: this.cols }), (_, colIndex: number) => {
              Text(`${rowIndex},${colIndex}`)
                .fontSize(14)
                .width(80)
                .height(80)
                .backgroundColor(
                  this.focusedPosition.row === rowIndex && this.focusedPosition.col === colIndex
                    ? '#007DFF'
                    : '#E0E0E0'
                )
                .fontColor(Color.White)
                .borderRadius(8)
                .textAlign(TextAlign.Center)
                .focusable(true)
                .onFocus(() => {
                  this.focusedPosition = { row: rowIndex, col: colIndex }
                })
            })
          }
          .justifyContent(FlexAlign.Center)
        })
      }

      Text(`Position: Row ${this.focusedPosition.row}, Column ${this.focusedPosition.col}`)
        .fontSize(14)
        .fontColor('#666')
        .margin({ top: 16 })
    }
    .width('100%')
    .padding(20)
  }
}
```

### Custom Key Handling

Handle specific keyboard events.

```typescript
@ComponentV2
export struct CustomKeyExample {
  @Local message: string = 'Press Enter, Escape, or Space'
  @Local counter: number = 0

  build() {
    Column({ space: 16 }) {
      Text('Custom Key Handling')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text('Focus me and press keys')
        .fontSize(16)
        .width('100%')
        .height(100)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .padding(16)
        .focusable(true)
        .onKeyEvent((event: KeyEvent) => {
          if (event.type === KeyType.Down) {
            switch (event.keyCode) {
              case KeyCode.ENTER:
                this.message = 'Enter key pressed'
                this.performEnterAction()
                break
              case KeyCode.ESCAPE:
                this.message = 'Escape key pressed'
                this.performEscapeAction()
                break
              case KeyCode.SPACE:
                this.message = 'Space key pressed'
                this.counter++
                break
              default:
                this.message = `Key pressed: ${event.keyCode}`
            }
          }
          return false // Let system handle the key
        })

      Text(this.message)
        .fontSize(16)
        .fontColor('#007DFF')

      if (this.counter > 0) {
        Text(`Space pressed ${this.counter} times`)
          .fontSize(14)
          .fontColor('#666')
      }
    }
    .width('100%')
    .padding(20)
  }

  private performEnterAction(): void {
    console.info('Enter action performed')
  }

  private performEscapeAction(): void {
    console.info('Escape action performed')
  }
}
```

---

## Focus Scope

### Tab Navigation Scope

Group related focusable elements.

```typescript
@ComponentV2
export struct FocusScopeExample {
  @Local activeScope: string = 'Scope 1'
  @Local scope1Focus: number = 0
  @Local scope2Focus: number = 0

  build() {
    Column({ space: 20 }) {
      Text('Focus Scope Demo')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // Scope 1
      Column({ space: 12 }) {
        Text('Scope 1')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Row({ space: 8 }) {
          ForEach(['A', 'B', 'C'], (item: string, index: number) => {
            Text(item)
              .fontSize(16)
              .width(60)
              .height(60)
              .backgroundColor(this.scope1Focus === index ? '#007DFF' : '#E0E0E0')
              .fontColor(Color.White)
              .borderRadius(8)
              .textAlign(TextAlign.Center)
              .focusable(true)
              .tabIndex(index)
              .onFocus(() => {
                this.scope1Focus = index
                this.activeScope = 'Scope 1'
              })
          })
        }
      }
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // Scope 2
      Column({ space: 12 }) {
        Text('Scope 2')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Row({ space: 8 }) {
          ForEach(['X', 'Y', 'Z'], (item: string, index: number) => {
            Text(item)
              .fontSize(16)
              .width(60)
              .height(60)
              .backgroundColor(this.scope2Focus === index ? '#28A745' : '#E0E0E0')
              .fontColor(Color.White)
              .borderRadius(8)
              .textAlign(TextAlign.Center)
              .focusable(true)
              .tabIndex(index)
              .onFocus(() => {
                this.scope2Focus = index
                this.activeScope = 'Scope 2'
              })
          })
        }
      }
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      Text(`Active scope: ${this.activeScope}`)
        .fontSize(14)
        .fontColor('#666')
    }
    .width('100%')
    .padding(20)
  }
}
```

---

## Accessibility Integration

### Accessibility Focus

Integrate with screen readers and accessibility services.

```typescript
@ComponentV2
export struct AccessibilityFocusExample {
  @Local focusedIndex: number = -1

  build() {
    Column({ space: 16 }) {
      Text('Accessibility Focus')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      ForEach([
        { label: 'Button 1', desc: 'Performs primary action' },
        { label: 'Button 2', desc: 'Performs secondary action' },
        { label: 'Button 3', desc: 'Opens settings' }
      ], (item: { label: string; desc: string }, index: number) => {
        Button(item.label)
          .width('100%')
          .height(60)
          .fontSize(16)
          .backgroundColor(this.focusedIndex === index ? '#007DFF' : '#6C757D')
          .focusable(true)
          .accessibilityText(item.desc)
          .accessibilityGroup(true)
          .onFocus(() => {
            this.focusedIndex = index
            console.info(`Screen reader should announce: ${item.label}, ${item.desc}`)
          })
          .onBlur(() => {
            if (this.focusedIndex === index) {
              this.focusedIndex = -1
            }
          })
      })
    }
    .width('100%')
    .padding(20)
  }
}
```

### Semantic Focus Actions

Associate focus with semantic actions.

```typescript
@ComponentV2
export struct SemanticFocusExample {
  @Local selectedItem: string = ''

  build() {
    Column({ space: 16 }) {
      Text('Semantic Actions')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      ForEach(['Play', 'Pause', 'Stop'], (action: string) => {
        Row({ space: 12 }) {
          Text(action)
            .fontSize(16)
            .width(100)

          Text('Double tap to activate')
            .fontSize(14)
            .fontColor('#666')

          Blank()
        }
        .width('100%')
        .height(60)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .focusable(true)
        .accessibilityText(`${action} button`)
        .accessibilityLevel('important')
        .onClick(() => {
          this.selectedItem = action
          console.info(`Action: ${action}`)
        })
      })

      if (this.selectedItem.length > 0) {
        Text(`Last action: ${this.selectedItem}`)
          .fontSize(14)
          .fontColor('#007DFF')
          .margin({ top: 8 })
      }
    }
    .width('100%')
    .padding(20)
  }
}
```

---

## Custom Focus Behavior

### Focus Trap

Keep focus within a container (useful for modals).

```typescript
@ComponentV2
export struct FocusTrapExample {
  @Local isModalOpen: boolean = false
  @Local modalFocusIndex: number = 0
  private readonly modalItems: string[] = ['Cancel', 'Save', 'Delete']

  build() {
    Stack() {
      Column({ space: 20 }) {
        Text('Focus Trap Demo')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Button('Open Modal')
          .onClick(() => {
            this.isModalOpen = true
            this.modalFocusIndex = 0
          })
      }
      .width('100%')
      .height('100%')
      .padding(20)

      if (this.isModalOpen) {
        // Modal overlay
        Column() {
          Column({ space: 16 }) {
            Text('Modal Dialog')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 16 })

            Text('Focus is trapped in this modal')
              .fontSize(14)
              .fontColor('#666')
              .margin({ bottom: 20 })

            ForEach(this.modalItems, (item: string, index: number) => {
              Button(item)
                .width('100%')
                .backgroundColor(this.modalFocusIndex === index ? '#007DFF' : '#E0E0E0')
                .fontColor(this.modalFocusIndex === index ? Color.White : '#333')
                .focusable(true)
                .tabIndex(index)
                .onFocus(() => {
                  this.modalFocusIndex = index
                })
                .onClick(() => {
                  if (item === 'Cancel') {
                    this.isModalOpen = false
                  }
                })
            })
          }
          .width(300)
          .padding(24)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .shadow({ radius: 20, color: '#00000030' })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#00000080')
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          // Prevent clicking outside to close (focus trap)
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}
```

### Focus Restoration

Restore focus when returning to a view.

```typescript
@ComponentV2
export struct FocusRestorationExample {
  @Local currentView: 'main' | 'detail' = 'main'
  @Local mainFocusIndex: number = 0
  @Local detailFocusIndex: number = 0

  build() {
    Column({ space: 20 }) {
      if (this.currentView === 'main') {
        // Main view
        Column({ space: 16 }) {
          Text('Main View')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          ForEach(['Item 1', 'Item 2', 'Item 3'], (item: string, index: number) => {
            Button(item)
              .width('100%')
              .focusable(true)
              .tabIndex(index)
              .backgroundColor(this.mainFocusIndex === index ? '#007DFF' : '#E0E0E0')
              .fontColor(this.mainFocusIndex === index ? Color.White : '#333')
              .onFocus(() => {
                this.mainFocusIndex = index
              })
              .onClick(() => {
                this.currentView = 'detail'
              })
          })
        }
        .padding(20)

      } else {
        // Detail view
        Column({ space: 16 }) {
          Text('Detail View')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Button('Back to Main')
            .width('100%')
            .focusable(true)
            .onClick(() => {
              this.currentView = 'main'
              // Focus restoration happens automatically due to state binding
            })

          ForEach(['Option A', 'Option B'], (option: string, index: number) => {
            Button(option)
              .width('100%')
              .focusable(true)
              .tabIndex(index + 1) // Offset by 1 for back button
              .backgroundColor(this.detailFocusIndex === index ? '#28A745' : '#E0E0E0')
              .fontColor(this.detailFocusIndex === index ? Color.White : '#333')
              .onFocus(() => {
                this.detailFocusIndex = index
              })
          })
        }
        .padding(20)
      }
    }
    .width('100%')
    .height('100%')
  }
}
```

### Custom Focus Navigation

Override default focus behavior.

```typescript
@ComponentV2
export struct CustomNavigationExample {
  @Local focusPosition: { x: number; y: number } = { x: 1, y: 1 }
  private readonly gridSize: number = 3

  build() {
    Column({ space: 16 }) {
      Text('Custom Arrow Navigation')
        .fontSize(18)
        .fontColor('#666')

      // Grid where focus wraps around
      Column({ space: 8 }) {
        ForEach(Array.from({ length: this.gridSize }), (_, row: number) => {
          Row({ space: 8 }) {
            ForEach(Array.from({ length: this.gridSize }), (_, col: number) => {
              Text(`${row},${col}`)
                .fontSize(14)
                .width(70)
                .height(70)
                .backgroundColor(
                  this.focusPosition.x === col && this.focusPosition.y === row
                    ? '#FF5722'
                    : '#E0E0E0'
                )
                .fontColor(Color.White)
                .borderRadius(8)
                .textAlign(TextAlign.Center)
                .focusable(true)
                .onKeyEvent((event: KeyEvent) => {
                  if (event.type === KeyType.Down) {
                    switch (event.keyCode) {
                      case KeyCode.UP:
                        this.focusPosition.y = (this.focusPosition.y - 1 + this.gridSize) % this.gridSize
                        return true // Handled
                      case KeyCode.DOWN:
                        this.focusPosition.y = (this.focusPosition.y + 1) % this.gridSize
                        return true
                      case KeyCode.LEFT:
                        this.focusPosition.x = (this.focusPosition.x - 1 + this.gridSize) % this.gridSize
                        return true
                      case KeyCode.RIGHT:
                        this.focusPosition.x = (this.focusPosition.x + 1) % this.gridSize
                        return true
                    }
                  }
                  return false
                })
                .onFocus(() => {
                  this.focusPosition = { x: col, y: row }
                })
            })
          }
          .justifyContent(FlexAlign.Center)
        })
      }

      Text(`Position: (${this.focusPosition.x}, ${this.focusPosition.y})`)
        .fontSize(14)
        .fontColor('#666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(20)
  }
}
```

---

## Best Practices

### 1. Visible Focus Indicators

Always show clear focus indication.

```typescript
@ComponentV2
export struct VisibleFocusIndicator {
  @Local focusedId: string = ''

  build() {
    Column({ space: 16 }) {
      ForEach(['Button 1', 'Button 2', 'Button 3'], (id: string) => {
        Button(id)
          .width('100%')
          .backgroundColor(this.focusedId === id ? '#007DFF' : '#E0E0E0')
          .fontColor(this.focusedId === id ? Color.White : '#333')
          .border(this.focusedId === id ? { width: 3, color: '#0056B3' } : undefined)
          .focusable(true)
          .onFocus(() => {
            this.focusedId = id
          })
      })
    }
    .padding(20)
  }
}
```

### 2. Logical Tab Order

Arrange tabIndex in logical flow order.

```typescript
@ComponentV2
export struct LogicalTabOrder {
  @Local focusMap: Map<string, boolean> = new Map()

  build() {
    Column({ space: 16 }) {
      // Form fields should follow visual order
      TextInput({ placeholder: 'First Name' })
        .width('100%')
        .tabIndex(0)
        .focusable(true)
        .onFocus(() => this.focusMap.set('firstName', true))

      TextInput({ placeholder: 'Last Name' })
        .width('100%')
        .tabIndex(1)
        .focusable(true)
        .onFocus(() => this.focusMap.set('lastName', true))

      TextInput({ placeholder: 'Email' })
        .width('100%')
        .tabIndex(2)
        .focusable(true)
        .onFocus(() => this.focusMap.set('email', true))

      // Submit button last
      Button('Submit')
        .width('100%')
        .tabIndex(3)
        .focusable(true)
        .onFocus(() => this.focusMap.set('submit', true))
    }
    .padding(20)
  }
}
```

### 3. Skip Links for Accessibility

Provide way to skip navigation.

```typescript
@ComponentV2
export struct SkipLinksExample {
  @Local showSkipLink: boolean = false

  build() {
    Column({ space: 0 }) {
      // Skip to main content (visible on first focus)
      if (this.showSkipLink) {
        Button('Skip to main content')
          .position({ x: 0, y: 0 })
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .focusable(true)
          .defaultFocus(true)
          .onFocus(() => {
            this.showSkipLink = true
          })
          .onBlur(() => {
            this.showSkipLink = false
          })
          .onClick(() => {
            // Scroll to main content
            console.info('Skipping to main content')
          })
      }

      // Navigation
      Row({ space: 12 }) {
        ForEach(['Home', 'About', 'Contact'], (item: string) => {
          Text(item)
            .fontSize(16)
            .padding(12)
            .focusable(true)
        })
      }
      .width('100%')
      .backgroundColor('#F5F5F5')
      .padding(16)

      // Main content
      Column({ space: 16 }) {
        Text('Main Content')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)

        Text('This is the main content area')
          .fontSize(16)
      }
      .padding(20)
    }
  }
}
```

### 4. Keyboard Shortcuts

Document and implement keyboard shortcuts.

```typescript
@ComponentV2
export struct KeyboardShortcutsExample {
  @Local lastShortcut: string = 'None'
  @Local searchQuery: string = ''

  build() {
    Column({ space: 16 }) {
      // Help panel showing shortcuts
      Row({ space: 16 }) {
        Column({ space: 8 }) {
          Text('Keyboard Shortcuts:')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)

          ForEach([
            { key: 'Ctrl+F', action: 'Focus search' },
            { key: 'Ctrl+S', action: 'Save' },
            { key: 'Escape', action: 'Clear search' }
          ], (shortcut: { key: string; action: string }) => {
            Text(`${shortcut.key}: ${shortcut.action}`)
              .fontSize(12)
              .fontColor('#666')
          })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // Search field
        TextInput({ placeholder: 'Search (Ctrl+F)', text: $$this.searchQuery })
          .width(200)
          .focusable(true)
          .onKeyEvent((event: KeyEvent) => {
            if (event.type === KeyType.Down) {
              if (event.keyCode === KeyCode.F && event.ctrlKey) {
                this.lastShortcut = 'Ctrl+F: Focus search'
                return true
              }
              if (event.keyCode === KeyCode.ESCAPE) {
                this.searchQuery = ''
                this.lastShortcut = 'Escape: Clear search'
                return true
              }
            }
            return false
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      Text(`Last shortcut: ${this.lastShortcut}`)
        .fontSize(14)
        .fontColor('#007DFF')
    }
    .padding(20)
  }
}
```

### 5. Focus Validation

Validate on blur, not on input.

```typescript
@ComponentV2
export struct FocusValidationExample {
  @Local email: string = ''
  @Local emailError: string = ''
  @Local isEmailFocused: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Email Validation')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextInput({ placeholder: 'Email', text: $$this.email })
        .width('100%')
        .focusable(true)
        .border({
          width: 2,
          color: this.emailError.length > 0 ? Color.Red : (this.isEmailFocused ? '#007DFF' : '#E0E0E0')
        })
        .onFocus(() => {
          this.isEmailFocused = true
          // Clear error when user starts editing
          if (this.emailError.length > 0) {
            this.emailError = ''
          }
        })
        .onBlur(() => {
          this.isEmailFocused = false
          this.validateEmail()
        })

      if (this.emailError.length > 0 && !this.isEmailFocused) {
        Text(this.emailError)
          .fontSize(14)
          .fontColor(Color.Red)
      }

      Button('Submit')
        .width('100%')
        .enabled(this.emailError.length === 0 && this.email.length > 0)
    }
    .padding(20)
  }

  private validateEmail(): void {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (this.email.length > 0 && !emailRegex.test(this.email)) {
      this.emailError = 'Please enter a valid email address'
    } else {
      this.emailError = ''
    }
  }
}
```

---

## Summary

HarmonyOS 6.0 focus management enables accessible, keyboard-navigable applications:

**Core Concepts:**
- **Focus Request**: `focusable()`, `defaultFocus()`
- **Focus Events**: `onFocus()`, `onBlur()`, `onFocusChange()`
- **Key Events**: `onKeyEvent()` for custom key handling
- **Focus Scope**: Group related focusable elements
- **Tab Navigation**: Sequential with `tabIndex`
- **Directional Navigation**: Arrow keys for grid layouts

**Best Practices:**
- Always provide visible focus indicators
- Use logical tab order following visual flow
- Implement skip links for accessibility
- Document keyboard shortcuts
- Validate on blur, not during input
- Restore focus when navigating between views
- Trap focus in modals and dialogs
- Provide accessibility text for screen readers

**Use Cases:**
- Form validation and submission
- Keyboard navigation for desktop
- Remote control navigation for TV
- Accessibility compliance
- Custom navigation patterns

Proper focus management ensures your application is usable by everyone, regardless of their input method or accessibility needs.
