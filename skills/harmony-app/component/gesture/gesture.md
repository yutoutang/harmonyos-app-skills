# Gesture System in HarmonyOS 6.0

Comprehensive guide to gesture recognition and handling in HarmonyOS 6.0 using ArkTS gesture API.

## Table of Contents

1. [Overview](#overview)
2. [Basic Gestures](#basic-gestures)
3. [Composite Gestures](#composite-gestures)
4. [Gesture Priority](#gesture-priority)
5. [Gesture Events](#gesture-events)
6. [Advanced Patterns](#advanced-patterns)
7. [Performance Considerations](#performance-considerations)
8. [Best Practices](#best-practices)

---

## Overview

HarmonyOS 6.0 provides a comprehensive gesture system that recognizes various touch inputs and user interactions. Gestures can be attached to any component to enable interactive behavior.

### Key Concepts

- **Gesture Recognition**: Automatic detection of touch patterns
- **Gesture Competition**: Multiple gestures competing for the same touch events
- **Gesture Priority**: Control which gesture wins in competitions
- **Gesture Callbacks**: Respond to gesture lifecycle events
- **Gesture Composition**: Combine multiple gestures for complex interactions

### Gesture Categories

1. **Basic Gestures**: Tap, LongPress, Pinch, Rotation, Pan, Swipe
2. **Composite Gestures**: GestureGroup for combining gestures
3. **Custom Gestures**: Build your own gesture recognizers

---

## Basic Gestures

### TapGesture

Recognizes single or multiple taps on a component.

```typescript
@ComponentV2
export struct TapGestureExample {
  @Local tapCount: number = 0
  @Local lastTapTime: string = ''

  build() {
    Column({ space: 16 }) {
      Text('Tap Me')
        .fontSize(24)
        .padding(20)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .borderRadius(12)
        .gesture(
          TapGesture({ count: 1 })
            .onAction(() => {
              this.tapCount++
              this.lastTapTime = new Date().toLocaleTimeString()
              console.info(`Single tap detected. Total: ${this.tapCount}`)
            })
        )

      Text(`Taps: ${this.tapCount}`)
        .fontSize(16)
      Text(`Last tap: ${this.lastTapTime}`)
        .fontSize(14)
        .fontColor('#666')
    }
    .width('100%')
    .padding(20)
  }
}
```

**Multi-tap Example:**

```typescript
@ComponentV2
export struct DoubleTapExample {
  @Local message: string = 'Double tap the box'

  build() {
    Column({ space: 16 }) {
      Text('Double Tap Area')
        .fontSize(18)
        .padding(40)
        .backgroundColor('#28A745')
        .fontColor(Color.White)
        .borderRadius(12)
        .gesture(
          TapGesture({ count: 2 })
            .onAction(() => {
              this.message = 'Double tap detected at ' + new Date().toLocaleTimeString()
            })
        )

      Text(this.message)
        .fontSize(14)
        .fontColor('#666')
    }
    .padding(20)
  }
}
```

### LongPressGesture

Recognizes long press (press and hold) gestures.

```typescript
@ComponentV2
export struct LongPressExample {
  @Local pressDuration: number = 0
  @Local isPressing: boolean = false
  private pressTimer: number = -1

  build() {
    Column({ space: 16 }) {
      Text('Long Press Me')
        .fontSize(20)
        .padding(30)
        .backgroundColor(this.isPressing ? '#FFC107' : '#FF5722')
        .fontColor(Color.White)
        .borderRadius(12)
        .gesture(
          LongPressGesture({ repeat: false, duration: 500 })
            .onAction(() => {
              console.info('Long press detected!')
              // Show context menu or perform action
            })
            .onActionStart(() => {
              this.isPressing = true
              console.info('Long press started')
            })
            .onActionEnd(() => {
              this.isPressing = false
              console.info('Long press ended')
            })
        )

      Text('Press and hold for 500ms')
        .fontSize(14)
        .fontColor('#666')
    }
    .padding(20)
  }
}
```

**Repeatable Long Press:**

```typescript
@ComponentV2
export struct RepeatableLongPressExample {
  @Local count: number = 0

  build() {
    Column({ space: 16 }) {
      Text(`Hold to increment: ${this.count}`)
        .fontSize(20)
        .padding(30)
        .backgroundColor('#9C27B0')
        .fontColor(Color.White)
        .borderRadius(12)
        .gesture(
          LongPressGesture({ repeat: true, duration: 500 })
            .onAction((event: GestureEvent) => {
              this.count++
              console.info(`Repeat count: ${event.repeat}`)
            })
            .onActionEnd(() => {
              console.info('Total increments: ' + this.count)
            })
        )
    }
    .padding(20)
  }
}
```

### PanGesture

Recognizes dragging/sliding gestures in any direction.

```typescript
@ComponentV2
export struct PanGestureExample {
  @Local offsetX: number = 0
  @Local offsetY: number = 0
  @Local panDirection: string = 'None'

  build() {
    Column({ space: 16 }) {
      Text('Drag Me')
        .fontSize(20)
        .width(150)
        .height(150)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .borderRadius(12)
        .translate({ x: this.offsetX, y: this.offsetY })
        .gesture(
          PanGesture({ direction: PanDirection.All })
            .onActionStart(() => {
              console.info('Pan started')
            })
            .onActionUpdate((event: GestureEvent) => {
              this.offsetX = event.offsetX
              this.offsetY = event.offsetY

              // Determine direction
              if (Math.abs(event.offsetX) > Math.abs(event.offsetY)) {
                this.panDirection = event.offsetX > 0 ? 'Right' : 'Left'
              } else {
                this.panDirection = event.offsetY > 0 ? 'Down' : 'Up'
              }
            })
            .onActionEnd(() => {
              console.info('Pan ended at:', this.panDirection)
              // Reset position
              this.offsetX = 0
              this.offsetY = 0
            })
        )

      Text(`Direction: ${this.panDirection}`)
        .fontSize(14)
      Text(`Offset: (${this.offsetX.toFixed(0)}, ${this.offsetY.toFixed(0)})`)
        .fontSize(14)
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
```

**Directional Pan:**

```typescript
@ComponentV2
export struct HorizontalPanExample {
  @Local position: number = 0
  private readonly maxPosition: number = 200

  build() {
    Column({ space: 16 }) {
      Text('Swipe horizontally')
        .fontSize(16)

      Row() {
        // Handle indicator
        Column()
          .width(60)
          .height(60)
          .backgroundColor('#28A745')
          .borderRadius(30)
          .translate({ x: this.position })
          .gesture(
            PanGesture({ direction: PanDirection.Horizontal })
              .onActionUpdate((event: GestureEvent) => {
                let newPosition = event.offsetX
                // Clamp position
                newPosition = Math.max(0, Math.min(newPosition, this.maxPosition))
                this.position = newPosition
              })
          )
      }
      .width(300)
      .height(100)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
      .justifyContent(FlexAlign.Start)
      .padding({ left: 20, right: 20 })

      Text(`Position: ${(this.position / this.maxPosition * 100).toFixed(0)}%`)
        .fontSize(14)
    }
    .padding(20)
  }
}
```

### PinchGesture

Recognizes pinch-in/pinch-out gestures for scaling.

```typescript
@ComponentV2
export struct PinchGestureExample {
  @Local scale: number = 1
  @Local pinchCenter: string = 'Center: (0, 0)'

  build() {
    Column({ space: 16 }) {
      Text('Pinch to Scale')
        .fontSize(20)
        .width(200)
        .height(200)
        .backgroundColor('#FF5722')
        .fontColor(Color.White)
        .borderRadius(12)
        .scale({ x: this.scale, y: this.scale })
        .justifyContent(FlexAlign.Center)
        .gesture(
          PinchGesture({ fingers: 2 })
            .onActionStart(() => {
              console.info('Pinch started')
            })
            .onActionUpdate((event: GestureEvent) => {
              this.scale = event.scale
              this.pinchCenter = `Center: (${event.pinchCenter.x.toFixed(0)}, ${event.pinchCenter.y.toFixed(0)})`
            })
            .onActionEnd(() => {
              console.info('Pinch ended. Final scale:', this.scale)
              // Optional: Reset scale
              // this.scale = 1
            })
        )

      Text(`Scale: ${this.scale.toFixed(2)}x`)
        .fontSize(16)
      Text(this.pinchCenter)
        .fontSize(14)
        .fontColor('#666')

      Button('Reset Scale')
        .onClick(() => {
          this.scale = 1
        })
    }
    .width('100%')
    .padding(20)
  }
}
```

**Image Zoom Example:**

```typescript
@ComponentV2
export struct ImageZoomExample {
  @Local scale: number = 1
  @Local minScale: number = 0.5
  @Local maxScale: number = 3

  build() {
    Column({ space: 16 }) {
      Text('Pinch to zoom image')
        .fontSize(16)

      Image($r('app.media.icon'))
        .width(300)
        .height(300)
        .objectFit(ImageFit.Contain)
        .scale({ x: this.scale, y: this.scale })
        .borderRadius(12)
        .gesture(
          PinchGesture()
            .onActionUpdate((event: GestureEvent) => {
              // Clamp scale
              this.scale = Math.max(
                this.minScale,
                Math.min(this.maxScale, event.scale)
              )
            })
        )

      Row({ space: 12 }) {
        Button('Zoom Out')
          .onClick(() => {
            this.scale = Math.max(this.minScale, this.scale - 0.2)
          })

        Button('Reset')
          .onClick(() => {
            this.scale = 1
          })

        Button('Zoom In')
          .onClick(() => {
            this.scale = Math.min(this.maxScale, this.scale + 0.2)
          })
      }
    }
    .padding(20)
  }
}
```

### RotationGesture

Recognizes rotation gestures.

```typescript
@ComponentV2
export struct RotationGestureExample {
  @Local angle: number = 0

  build() {
    Column({ space: 16 }) {
      Text('Rotate Me')
        .fontSize(20)
        .width(150)
        .height(150)
        .backgroundColor('#9C27B0')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .rotate({ angle: this.angle })
        .gesture(
          RotationGesture({ fingers: 2 })
            .onActionStart(() => {
              console.info('Rotation started')
            })
            .onActionUpdate((event: GestureEvent) => {
              this.angle = event.angle
            })
            .onActionEnd(() => {
              console.info('Rotation ended. Angle:', this.angle)
            })
        )

      Text(`Angle: ${this.angle.toFixed(0)}°`)
        .fontSize(16)

      Button('Reset Rotation')
        .onClick(() => {
          this.angle = 0
        })
    }
    .width('100%')
    .padding(20)
  }
}
```

### SwipeGesture

Recognizes swipe gestures in specific directions.

```typescript
@ComponentV2
export struct SwipeGestureExample {
  @Local swipeDirection: string = 'Swipe in any direction'
  @Local swipeSpeed: number = 0

  build() {
    Column({ space: 16 }) {
      Text('Swipe Me')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#4CAF50')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          SwipeGesture({ direction: SwipeDirection.All, speed: 100 })
            .onAction((event: GestureEvent) => {
              this.swipeSpeed = event.speed

              if (event swipeDirection === SwipeDirection.Horizontal) {
                this.swipeDirection = event.offsetX > 0 ? 'Swiped Right' : 'Swiped Left'
              } else {
                this.swipeDirection = event.offsetY > 0 ? 'Swiped Down' : 'Swiped Up'
              }

              console.info('Swipe:', this.swipeDirection, 'Speed:', this.swipeSpeed)
            })
        )

      Text(this.swipeDirection)
        .fontSize(16)
      Text(`Speed: ${this.swipeSpeed}`)
        .fontSize(14)
        .fontColor('#666')
    }
    .padding(20)
  }
}
```

---

## Composite Gestures

### GestureGroup - Sequence

Recognize gestures in a specific sequence.

```typescript
@ComponentV2
export struct GestureSequenceExample {
  @Local actionLog: string[] = []

  build() {
    Column({ space: 16 }) {
      Text('Perform: Long Press → Drag')
        .fontSize(16)
        .fontColor('#666')

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          GestureGroup(GestureMode.Sequence,
            LongPressGesture({ duration: 500 }),
            PanGesture()
          )
            .onAction((event: GestureEvent) => {
              this.actionLog.push(`Sequence completed at ${new Date().toLocaleTimeString()}`)
              if (this.actionLog.length > 5) {
                this.actionLog.shift()
              }
            })
        )

      ForEach(this.actionLog, (log: string) => {
        Text(log)
          .fontSize(12)
          .fontColor('#666')
      })
    }
    .padding(20)
  }
}
```

### GestureGroup - Parallel

Recognize gestures in parallel (any can win).

```typescript
@ComponentV2
export struct ParallelGestureExample {
  @Local lastGesture: string = 'None'

  build() {
    Column({ space: 16 }) {
      Text('Tap or Long Press (both recognized)')
        .fontSize(16)
        .fontColor('#666')

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#FF5722')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          GestureGroup(GestureMode.Parallel,
            TapGesture({ count: 1 })
              .onAction(() => {
                this.lastGesture = 'Tap detected'
              }),
            LongPressGesture({ duration: 500 })
              .onAction(() => {
                this.lastGesture = 'Long press detected'
              })
          )
        )

      Text(`Last: ${this.lastGesture}`)
        .fontSize(18)
        .fontColor('#007DFF')
    }
    .padding(20)
  }
}
```

### GestureGroup - Exclusive

Only one gesture can win; first to be recognized wins.

```typescript
@ComponentV2
export struct ExclusiveGestureExample {
  @Local winner: string = 'Waiting...'

  build() {
    Column({ space: 16 }) {
      Text('Race: Tap vs Double Tap')
        .fontSize(16)
        .fontColor('#666')

      Text('Tap Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#28A745')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          GestureGroup(GestureMode.Exclusive,
            TapGesture({ count: 1 })
              .onAction(() => {
                this.winner = 'Single Tap won!'
              }),
            TapGesture({ count: 2 })
              .onAction(() => {
                this.winner = 'Double Tap won!'
              })
          )
        )

      Text(this.winner)
        .fontSize(18)
        .fontColor('#FF5722')
    }
    .padding(20)
  }
}
```

### GestureGroup - Simultaneous

All gestures must be recognized simultaneously.

```typescript
@ComponentV2
export struct SimultaneousGestureExample {
  @Local isPinching: boolean = false
  @Local isRotating: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Pinch AND Rotate simultaneously')
        .fontSize(16)
        .fontColor('#666')

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(300)
        .backgroundColor('#9C27B0')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          GestureGroup(GestureMode.Simultaneous,
            PinchGesture()
              .onActionStart(() => {
                this.isPinching = true
              })
              .onActionEnd(() => {
                this.isPinching = false
              }),
            RotationGesture()
              .onActionStart(() => {
                this.isRotating = true
              })
              .onActionEnd(() => {
                this.isRotating = false
              })
          )
            .onAction(() => {
              console.info('Both pinch and rotation detected!')
            })
        )

      Text(`Pinching: ${this.isPinching}`)
        .fontSize(14)
      Text(`Rotating: ${this.isRotating}`)
        .fontSize(14)
    }
    .padding(20)
  }
}
```

---

## Gesture Priority

Control gesture competition with priority values.

```typescript
@ComponentV2
export struct GesturePriorityExample {
  @Local message: string = 'Tap or Long Press'

  build() {
    Column({ space: 16 }) {
      Text('Long Press has higher priority')
        .fontSize(16)
        .fontColor('#666')

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#FFC107')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          GestureGroup(GestureMode.Exclusive,
            // Lower priority
            TapGesture({ count: 1 })
              .onAction(() => {
                this.message = 'Tap won (rare case)'
              }),
            // Higher priority
            LongPressGesture({ duration: 500 })
              .onAction(() => {
                this.message = 'Long Press won (normal case)'
              })
          )
        )

      Text(this.message)
        .fontSize(16)
    }
    .padding(20)
  }
}
```

**Custom Priority Example:**

```typescript
@ComponentV2
export struct CustomPriorityExample {
  @Local action: string = 'Perform gesture'

  build() {
    Column({ space: 16 }) {
      Text('Swipe (priority 1) vs Pan (priority 2)')
        .fontSize(14)
        .fontColor('#666')

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#00BCD4')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          GestureGroup(GestureMode.Exclusive,
            SwipeGesture({ direction: SwipeDirection.All })
              .onAction(() => {
                this.action = 'Swipe gesture recognized'
              }),
            PanGesture()
              .onAction(() => {
                this.action = 'Pan gesture recognized'
              })
          )
        )

      Text(this.action)
        .fontSize(16)
    }
    .padding(20)
  }
}
```

---

## Gesture Events

### GestureEvent Properties

```typescript
@ComponentV2
export struct GestureEventExample {
  @Local eventInfo: string = 'Perform any gesture'

  build() {
    Column({ space: 16 }) {
      Text('Pan to see gesture event details')
        .fontSize(16)
        .fontColor('#666')

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#3F51B5')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.eventInfo = `
                Offset: (${event.offsetX.toFixed(1)}, ${event.offsetY.toFixed(1)})
                Angle: ${event.angle.toFixed(1)}°
                Scale: ${event.scale.toFixed(2)}
                Timestamp: ${event.timestamp}
                Finger count: ${event.fingerCount}
              `.trim()
            })
        )

      Text(this.eventInfo)
        .fontSize(12)
        .fontColor('#666')
        .maxLines(10)
    }
    .padding(20)
  }
}
```

### Lifecycle Callbacks

```typescript
@ComponentV2
export struct GestureLifecycleExample {
  @Local status: string = 'Idle'
  @Local startTime: number = 0
  @Local endTime: number = 0
  @Local duration: number = 0

  build() {
    Column({ space: 16 }) {
      Text('Long press to see lifecycle')
        .fontSize(16)
        .fontColor('#666')

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#E91E63')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          LongPressGesture({ duration: 500 })
            .onActionStart((event: GestureEvent) => {
              this.status = 'Started'
              this.startTime = event.timestamp
              console.info('Gesture started at:', this.startTime)
            })
            .onAction((event: GestureEvent) => {
              this.status = 'Recognized'
              this.endTime = event.timestamp
              this.duration = this.endTime - this.startTime
              console.info('Gesture recognized after:', this.duration, 'ms')
            })
            .onActionEnd(() => {
              this.status = 'Ended'
              console.info('Gesture ended')
            })
            .onActionCancel(() => {
              this.status = 'Cancelled'
              console.info('Gesture cancelled')
            })
        )

      Text(`Status: ${this.status}`)
        .fontSize(16)
      Text(`Duration: ${this.duration} ms`)
        .fontSize(14)
        .fontColor('#666')
    }
    .padding(20)
  }
}
```

---

## Advanced Patterns

### Draggable Card

```typescript
@ComponentV2
export struct DraggableCard {
  @Local offsetX: number = 0
  @Local offsetY: number = 0
  @Local isDragging: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Draggable Card')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Stack() {
        Column()
          .width('100%')
          .height(400)
          .backgroundColor('#F5F5F5')
          .borderRadius(12)

        Column() {
          Text('Drag Me')
            .fontSize(16)
            .fontColor(Color.White)
        }
        .width(200)
        .height(150)
        .backgroundColor(this.isDragging ? '#007DFF' : '#4CAF50')
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .shadow({ radius: this.isDragging ? 20 : 5, color: '#00000020' })
        .translate({ x: this.offsetX, y: this.offsetY })
        .gesture(
          PanGesture()
            .onActionStart(() => {
              this.isDragging = true
            })
            .onActionUpdate((event: GestureEvent) => {
              this.offsetX = event.offsetX
              this.offsetY = event.offsetY
            })
            .onActionEnd(() => {
              this.isDragging = false
              // Optional: Snap to center or reset
              // this.offsetX = 0
              // this.offsetY = 0
            })
        )
      }
      .width('100%')
      .height(400)
    }
    .padding(20)
  }
}
```

### Image Viewer with Pan and Zoom

```typescript
@ComponentV2
export struct ImageViewer {
  @Local scale: number = 1
  @Local offsetX: number = 0
  @Local offsetY: number = 0
  @Local angle: number = 0

  private readonly minScale: number = 0.5
  private readonly maxScale: number = 3

  build() {
    Column({ space: 16 }) {
      Text('Pan, Pinch, and Rotate')
        .fontSize(16)
        .fontColor('#666')

      Stack() {
        Column()
          .width('100%')
          .height(400)
          .backgroundColor('#F5F5F5')
          .borderRadius(12)

        Image($r('app.media.icon'))
          .width(300)
          .height(300)
          .objectFit(ImageFit.Contain)
          .scale({ x: this.scale, y: this.scale })
          .translate({ x: this.offsetX, y: this.offsetY })
          .rotate({ angle: this.angle })
          .gesture(
            GestureGroup(GestureMode.Simultaneous,
              PinchGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.scale = Math.max(this.minScale, Math.min(this.maxScale, event.scale))
                }),
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.offsetX = event.offsetX
                  this.offsetY = event.offsetY
                }),
              RotationGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.angle = event.angle
                })
            )
          )
      }
      .width('100%')
      .height(400)

      Button('Reset View')
        .onClick(() => {
          this.scale = 1
          this.offsetX = 0
          this.offsetY = 0
          this.angle = 0
        })
    }
    .padding(20)
  }
}
```

### Swipeable List Item

```typescript
@ComponentV2
export struct SwipeableItem {
  @Local offsetX: number = 0
  @Local isDeleted: boolean = false

  build() {
    if (!this.isDeleted) {
      Stack() {
        // Background actions
        Row() {
          Button('Archive')
            .backgroundColor('#FFC107')
            .type(ButtonType.Normal)
            .height('100%')
            .width(80)

          Button('Delete')
            .backgroundColor('#F44336')
            .type(ButtonType.Normal)
            .height('100%')
            .width(80)
            .onClick(() => {
              this.isDeleted = true
            })
        }
        .position({ x: 0, y: 0 })
        .width('100%')
        .height('100%')

        // Foreground content
        Column() {
          Text('Swipeable Item')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Text('Swipe left to reveal actions')
            .fontSize(14)
            .fontColor('#666')
        }
        .width('100%')
        .height(80)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.Center)
        .translate({ x: this.offsetX })
        .gesture(
          PanGesture({ direction: PanDirection.Horizontal })
            .onActionUpdate((event: GestureEvent) => {
              // Only allow swipe to left
              if (event.offsetX < 0) {
                this.offsetX = Math.max(-160, event.offsetX)
              }
            })
            .onActionEnd(() => {
              // Snap back or reveal actions
              if (this.offsetX < -80) {
                this.offsetX = -160
              } else {
                this.offsetX = 0
              }
            })
        )
      }
      .width('100%')
      .height(80)
    }
  }
}
```

---

## Performance Considerations

### Debounce Gesture Handlers

```typescript
@ComponentV2
export struct DebouncedGestureExample {
  @Local lastUpdate: number = 0
  private updateTimer: number = -1

  build() {
    Column({ space: 16 }) {
      Text('Pan with debounced updates')
        .fontSize(16)

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#607D8B')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              // Debounce rapid updates
              if (this.updateTimer !== -1) {
                clearTimeout(this.updateTimer)
              }

              this.updateTimer = setTimeout(() => {
                this.lastUpdate = Date.now()
                this.performExpensiveOperation(event.offsetX, event.offsetY)
              }, 16) // ~60fps
            })
        )

      Text(`Last update: ${new Date(this.lastUpdate).toLocaleTimeString()}`)
        .fontSize(14)
    }
    .padding(20)
  }

  private performExpensiveOperation(x: number, y: number): void {
    // Simulate expensive operation
    console.info('Processing gesture at:', x, y)
  }
}
```

### Remove Unused Gestures

```typescript
@ComponentV2
export struct ConditionalGestures {
  @Local isEnabled: boolean = true

  build() {
    Column({ space: 16 }) {
      Toggle({ type: ToggleType.Switch, isOn: this.isEnabled })
        .onChange((value: boolean) => {
          this.isEnabled = value
        })

      // Only attach gesture when needed
      if (this.isEnabled) {
        Text('Gesture enabled')
          .fontSize(20)
          .width(200)
          .height(200)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .borderRadius(12)
          .justifyContent(FlexAlign.Center)
          .gesture(
            TapGesture().onAction(() => {
              console.info('Tap detected')
            })
          )
      } else {
        Text('Gesture disabled')
          .fontSize(20)
          .width(200)
          .height(200)
          .backgroundColor('#CCCCCC')
          .fontColor(Color.White)
          .borderRadius(12)
          .justifyContent(FlexAlign.Center)
      }
    }
    .padding(20)
  }
}
```

---

## Best Practices

### 1. Provide Visual Feedback

```typescript
@ComponentV2
export struct VisualFeedback {
  @Local isPressed: boolean = false

  build() {
    Text('Press Me')
      .fontSize(20)
      .padding(20)
      .backgroundColor(this.isPressed ? '#0056B3' : '#007DFF')
      .fontColor(Color.White)
      .borderRadius(12)
      .scale({ x: this.isPressed ? 0.95 : 1, y: this.isPressed ? 0.95 : 1 })
      .animation({ duration: 100 })
      .gesture(
        LongPressGesture()
          .onActionStart(() => {
            this.isPressed = true
          })
          .onActionEnd(() => {
            this.isPressed = false
          })
      )
  }
}
```

### 2. Use Appropriate Gesture Durations

```typescript
@ComponentV2
export struct ProperDurations {
  build() {
    Column({ space: 20 }) {
      // Short duration for quick actions
      Text('Quick Action')
        .gesture(LongPressGesture({ duration: 300 }))

      // Standard duration for context menu
      Text('Context Menu')
        .gesture(LongPressGesture({ duration: 500 }))

      // Long duration to avoid accidental triggers
      Text('Destructive Action')
        .gesture(LongPressGesture({ duration: 1000 }))
    }
  }
}
```

### 3. Handle Gesture Conflicts

```typescript
@ComponentV2
export struct HandleConflicts {
  @Local action: string = 'Tap or Swipe'

  build() {
    Column({ space: 16 }) {
      Text('Swipe horizontally, Tap for quick action')
        .fontSize(14)
        .fontColor('#666')

      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#9C27B0')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          GestureGroup(GestureMode.Exclusive,
            // Short tap timeout allows swipe to win
            TapGesture({ count: 1 })
              .onAction(() => {
                this.action = 'Tap: Quick action'
              }),
            // Swipe has priority for horizontal movements
            SwipeGesture({ direction: SwipeDirection.Horizontal })
              .onAction(() => {
                this.action = 'Swipe: Navigation'
              })
          )
        )

      Text(this.action)
        .fontSize(16)
    }
    .padding(20)
  }
}
```

### 4. Accessibility Considerations

```typescript
@ComponentV2
export struct AccessibleGestures {
  @Local message: string = 'Perform gesture or use button'

  build() {
    Column({ space: 16 }) {
      Text('Gesture Area')
        .fontSize(20)
        .width('100%')
        .height(200)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .gesture(
          SwipeGesture({ direction: SwipeDirection.Left })
            .onAction(() => {
              this.message = 'Swiped left'
            })
        )

      Text(this.message)
        .fontSize(16)

      // Provide alternative for users who can't perform gestures
      Button('Simulate Swipe Left')
        .onClick(() => {
          this.message = 'Swiped left (button)'
        })
        .margin({ top: 20 })
    }
    .padding(20)
  }
}
```

---

## Summary

HarmonyOS 6.0 gesture system provides comprehensive touch interaction:

**Basic Gestures:**
- `TapGesture`: Single/multi-tap recognition
- `LongPressGesture`: Press and hold detection
- `PanGesture`: Dragging in any direction
- `PinchGesture`: Zoom in/out with two fingers
- `RotationGesture`: Rotate with two fingers
- `SwipeGesture`: Quick directional swipes

**Gesture Groups:**
- `Sequence`: Gestures must occur in order
- `Parallel`: Any gesture can win
- `Exclusive`: First recognized wins
- `Simultaneous`: All must be recognized together

**Best Practices:**
- Always provide visual feedback
- Use appropriate gesture durations
- Handle gesture conflicts with priority
- Provide accessibility alternatives
- Debounce expensive operations
- Remove unused gestures
- Consider touch target sizes (minimum 44x44dp)

Gestures enable rich, interactive user experiences when used thoughtfully and consistently with platform conventions.
