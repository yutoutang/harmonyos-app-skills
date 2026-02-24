---
name: openharmony-curves
description: HarmonyOS Curves API expert. Specialized in creating and using animation curves with the curves namespace. Covers predefined curves, cubic Bezier curves, spring curves, custom curves, and step curves for smooth animations in HarmonyOS applications.
---

# HarmonyOS Curves API

## Core Principles

- **Curve-Based Animation** — Use curves to define animation interpolation and create natural motion
- **Predefined Curves** — Leverage built-in curves for common animation patterns
- **Custom Curves** — Create custom curves for unique animation behaviors
- **Physics-Based** — Use spring curves for realistic physics animations
- **Performance** — Curves are calculated at runtime for optimal performance

---

## Hard Rules (Must Follow)

> These rules are mandatory. Violating them means the skill is not working correctly.

### Use Curves for Animation

**Always use curves from the `curves` namespace for animations. Never hardcode animation values.**

```typescript
// ❌ FORBIDDEN: Hardcoded animation values
animateTo({
  duration: 1000,
  curve: [0.25, 0.1, 0.25, 1.0] // Raw Bezier values
}, () => {
  this.width = 200
})

// ✅ REQUIRED: Use curves namespace
animateTo({
  duration: 1000,
  curve: curves.cubicBezierCurve(0.25, 0.1, 0.25, 1.0)
}, () => {
  this.width = 200
})
```

### Use Proper Curve Types

**Always use the correct curve function for your use case.**

```typescript
// ✅ CORRECT: Use appropriate curve types
// Linear animations
curves.initCurve(curves.Curve.Linear)

// Standard UI animations
curves.initCurve(curves.Curve.EaseInOut)

// Custom Bezier curves
curves.cubicBezierCurve(0.42, 0.0, 0.58, 1.0)

// Physics-based animations
curves.springCurve(1.0, 1.0, 1.0, 1.0)

// ✅ CORRECT: Use responsive springs for touch interactions
curves.responsiveSpringMotion(0.15, 0.86, 0.25)
```

### Curve Parameter Validation

**Always validate curve parameters within their specified ranges.**

```typescript
// ✅ CORRECT: Validate parameters
const createSafeBezier = (x1: number, y1: number, x2: number, y2: number) => {
  // Clamp x values to [0, 1] range
  const safeX1 = Math.max(0, Math.min(1, x1))
  const safeX2 = Math.max(0, Math.min(1, x2))
  
  return curves.cubicBezierCurve(safeX1, y1, safeX2, y2)
}

// ✅ CORRECT: Validate spring parameters
const createSafeSpring = (velocity: number, mass: number, stiffness: number, damping: number) => {
  // Ensure positive values for mass, stiffness, damping
  const safeMass = Math.max(0.01, mass)
  const safeStiffness = Math.max(0.01, stiffness)
  const safeDamping = Math.max(0.01, damping)
  
  return curves.springCurve(velocity, safeMass, safeStiffness, safeDamping)
}
```

---

## API Reference

### Core Functions

#### curves.initCurve(curve?: Curve): ICurve
Initializes a predefined curve.

**Parameters:**
- `curve` (optional): Predefined curve type from `Curve` enum
  - Default: `Curve.Linear`
  - Values: `Linear`, `Ease`, `EaseIn`, `EaseOut`, `EaseInOut`, etc.

**Returns:**
- `ICurve`: Curve object with `interpolate(fraction: number): number` method

**Example:**
```typescript
// Create a standard easing curve
const curve = curves.initCurve(curves.Curve.EaseInOut)
animateTo({
  duration: 1000,
  curve: curve
}, () => {
  this.width = 200
})
```

#### curves.cubicBezierCurve(x1: number, y1: number, x2: number, y2: number): ICurve
Creates a cubic Bezier curve with specified control points.

**Parameters:**
- `x1` (number): X coordinate of first control point [0, 1]
- `y1` (number): Y coordinate of first control point (-∞, +∞)
- `x2` (number): X coordinate of second control point [0, 1]
- `y2` (number): Y coordinate of second control point (-∞, +∞)

**Returns:**
- `ICurve`: Bezier curve object

**Example:**
```typescript
// Custom ease curve
const customEase = curves.cubicBezierCurve(0.25, 0.1, 0.25, 1.0)
animateTo({
  duration: 800,
  curve: customEase
}, () => {
  this.opacity = 1.0
})
```

#### curves.springCurve(velocity: number, mass: number, stiffness: number, damping: number): ICurve
Creates a physics-based spring curve.

**Parameters:**
- `velocity` (number): Initial velocity (-∞, +∞)
- `mass` (number): Mass value (0, +∞) - affects inertia
- `stiffness` (number): Stiffness value (0, +∞) - resistance to deformation
- `damping` (number): Damping value (0, +∞) - oscillation control

**Returns:**
- `ICurve`: Spring curve object

**Example:**
```typescript
// Bouncy spring animation
const bouncySpring = curves.springCurve(0.5, 1.0, 0.5, 0.8)
animateTo({
  duration: 1500,
  curve: bouncySpring
}, () => {
  this.scale = { x: 1.2, y: 1.2 }
})
```

#### curves.springMotion(response?: number, dampingFraction?: number, overlapDuration?: number): ICurve
Creates a spring animation curve with simplified parameters.

**Parameters:**
- `response` (optional): Duration of one oscillation in seconds (0, +∞)
  - Default: 0.55
- `dampingFraction` (optional): Damping coefficient [0, +∞)
  - 0: Undamped (oscillates forever)
  - 1: Critically damped
  - Default: 0.825
- `overlapDuration` (optional): Overlap duration in seconds [0, +∞)
  - Default: 0

**Returns:**
- `ICurve`: Spring motion curve object

**Example:**
```typescript
// Responsive spring for touch interactions
const touchSpring = curves.springMotion(0.15, 0.86, 0.25)
animateTo({
  duration: 200,
  curve: touchSpring
}, () => {
  this.pressedScale = 0.95
})
```

#### curves.responsiveSpringMotion(response?: number, dampingFraction?: number, overlapDuration?: number): ICurve
Creates a responsive spring curve optimized for UI interactions.

**Parameters:**
- `response` (optional): Response time in seconds (0, +∞)
  - Default: 0.15
- `dampingFraction` (optional): Damping coefficient [0, +∞)
  - Default: 0.86
- `overlapDuration` (optional): Overlap duration in seconds [0, +∞)
  - Default: 0.25

**Returns:**
- `ICurve`: Responsive spring curve object

**Example:**
```typescript
// Quick responsive spring for button feedback
const quickSpring = curves.responsiveSpringMotion(0.1, 0.8, 0.1)
animateTo({
  duration: 100,
  curve: quickSpring
}, () => {
  this.buttonScale = 1.0
})
```

#### curves.stepsCurve(count: number, end: boolean): ICurve
Creates a step curve with discrete steps.

**Parameters:**
- `count` (number): Number of steps [1, +∞)
- `end` (boolean): Whether step occurs at end of interval
  - true: Step at end
  - false: Step at start

**Returns:**
- `ICurve`: Step curve object

**Example:**
```typescript
// 3-step progress animation
const stepProgress = curves.stepsCurve(3, false)
animateTo({
  duration: 1500,
  curve: stepProgress
}, () => {
  this.progress = 1.0
})
```

#### curves.customCurve(interpolate: (fraction: number) => number): ICurve
Creates a custom curve with user-defined interpolation function.

**Parameters:**
- `interpolate` (function): Custom interpolation function
  - Input: fraction [0, 1]
  - Output: value [0, 1]

**Returns:**
- `ICurve`: Custom curve object

**Example:**
```typescript
// Exponential ease curve
const exponentialEase = curves.customCurve((fraction: number) => {
  return Math.pow(fraction, 2)
})
animateTo({
  duration: 1000,
  curve: exponentialEase
}, () => {
  this.height = 100
})
```

### Predefined Curves

#### Curve Enum
Standard curve types for common animation patterns.

**Values:**
- `Linear`: Constant velocity animation
- `Ease`: Slow start and end, fast middle (0.25, 0.1, 0.25, 1.0)
- `EaseIn`: Slow start, fast end (0.42, 0.0, 1.0, 1.0)
- `EaseOut`: Fast start, slow end (0.0, 0.0, 0.58, 1.0)
- `EaseInOut`: Slow start and end, fast middle (0.42, 0.0, 0.58, 1.0)
- `FastOutSlowIn`: Material Design standard (0.4, 0.0, 0.2, 1.0)
- `LinearOutSlowIn`: Deceleration curve (0.0, 0.0, 0.2, 1.0)
- `FastOutLinearIn`: Acceleration curve (0.4, 0.0, 1.0, 1.0)
- `ExtremeDeceleration`: Abrupt stop (0.0, 0.0, 0.0, 1.0)
- `Sharp`: Sharp transitions (0.33, 0.0, 0.67, 1.0)
- `Rhythm`: Rhythmic motion (0.7, 0.0, 0.2, 1.0)
- `Smooth`: Smooth motion (0.4, 0.0, 0.4, 1.0)
- `Friction`: Damped motion (0.2, 0.0, 0.2, 1.0)

---

## Best Practices

### Choose the Right Curve

**Select curves based on interaction type:**

```typescript
// Entry animations - gentle ease
const entryCurve = curves.initCurve(curves.Curve.EaseOut)

// Touch feedback - responsive spring
const touchCurve = curves.responsiveSpringMotion(0.15, 0.86, 0.25)

// Loading animations - linear or ease
const loadingCurve = curves.initCurve(curves.Curve.Linear)

// Alert/dismissal - sharp attention
const alertCurve = curves.initCurve(curves.Curve.FastOutSlowIn)

// Page transitions - smooth ease
const pageCurve = curves.initCurve(curves.Curve.EaseInOut)
```

### Performance Considerations

**Optimize curve performance:**

```typescript
// ✅ GOOD: Create curves once, reuse
class ButtonComponent {
  private static readonly pressCurve = curves.responsiveSpringMotion(0.15, 0.86, 0.25)
  private static readonly releaseCurve = curves.responsiveSpringMotion(0.25, 0.8, 0.25)
  
  onPress() {
    animateTo({
      curve: ButtonComponent.pressCurve
    }, () => {
      this.scale = 0.95
    })
  }
  
  onRelease() {
    animateTo({
      curve: ButtonComponent.releaseCurve
    }, () => {
      this.scale = 1.0
    })
  }
}

// ❌ AVOID: Creating curves in animation loop
class BadButton {
  onPress() {
    animateTo({
      curve: curves.responsiveSpringMotion(0.15, 0.86, 0.25) // New curve each time
    }, () => {
      this.scale = 0.95
    })
  }
}
```

### Physics-Based Animation

**Use spring curves for realistic motion:**

```typescript
// Natural bouncing motion
const bounceSpring = curves.springCurve(2.0, 1.0, 0.8, 0.6)

// Heavy object motion
const heavySpring = curves.springCurve(0.5, 3.0, 1.0, 0.8)

// Light object motion
const lightSpring = curves.springCurve(1.0, 0.5, 0.5, 0.7)

// Damped motion (no bounce)
const dampedSpring = curves.springCurve(0.0, 1.0, 1.0, 1.0)
```

### Custom Curve Creation

**Create branded curve sets:**

```typescript
// Brand-specific easing curves
export const BrandCurves = {
  // Brand accent animation
  accent: curves.cubicBezierCurve(0.175, 0.885, 0.32, 1.275),
  
  // Brand entry animation
  entry: curves.cubicBezierCurve(0.215, 0.610, 0.355, 1.0),
  
  // Brand exit animation
  exit: curves.cubicBezierCurve(0.55, 0.055, 0.675, 0.19),
  
  // Brand gentle bounce
  gentleBounce: curves.springMotion(0.4, 0.9, 0.2)
}

// Usage in components
animateTo({
  curve: BrandCurves.accent
}, () => {
  this.highlight = true
})
```

---

## Common Patterns

### Sequence Animation

**Chain animations with different curves:**

```typescript
animateTo({
  duration: 300,
  curve: curves.initCurve(curves.Curve.EaseOut)
}, () => {
  this.firstElement = true
})

setTimeout(() => {
  animateTo({
    duration: 400,
    curve: curves.responsiveSpringMotion(0.2, 0.8, 0.1)
  }, () => {
    this.secondElement = true
  })
}, 300)

setTimeout(() => {
  animateTo({
    duration: 500,
    curve: curves.initCurve(curves.Curve.EaseInOut)
  }, () => {
    this.thirdElement = true
  })
}, 700)
```

### Responsive Animation

**Adapt curves based on context:**

```typescript
@ComponentV2
struct ResponsiveButton {
  @Param isImportant: boolean = false
  @Param isLarge: boolean = false
  
  getCurve(): curves.ICurve {
    if (this.isImportant) {
      return this.isLarge 
        ? curves.springMotion(0.2, 0.8, 0.2)
        : curves.springMotion(0.15, 0.86, 0.25)
    } else {
      return curves.initCurve(curves.Curve.EaseInOut)
    }
  }
  
  onPress() {
    animateTo({
      duration: 200,
      curve: this.getCurve()
    }, () => {
      this.pressed = true
    })
  }
}
```

### Loading States

**Use curves for realistic loading:**

```typescript
@ComponentV2
struct LoadingProgress {
  @Local progress: number = 0
  private loadingCurve = curves.cubicBezierCurve(0.4, 0.0, 0.2, 1.0)
  
  startLoading() {
    animateTo({
      duration: 1000,
      curve: this.loadingCurve
    }, () => {
      this.progress = 0.7
    })
    
    setTimeout(() => {
      animateTo({
        duration: 500,
        curve: curves.initCurve(curves.Curve.EaseOut)
      }, () => {
        this.progress = 1.0
      })
    }, 1000)
  }
}
```
