# Particle 组件 HarmonyOS 6.0 开发 Skill

## 概述

Particle 组件是 OpenHarmony 中提供粒子动画效果的组件，用于创建各种粒子特效，如火焰、烟雾、雪花、火花等。它提供了丰富的配置选项，支持自定义粒子的发射速率、生命周期、运动轨迹、颜色变化等属性。

## 重要说明

- **性能**: 粒子系统是计算密集型，注意控制粒子数量
- **动画**: 使用配置对象控制粒子行为，无需手动管理每个粒子
- **混合模式**: 支持多种粒子混合模式，创造不同的视觉效果
- **物理模拟**: 内置简单的物理模拟，如重力、风力等

## 模块信息

- **组件名称**: Particle
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Particle 粒子 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-particle-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Particle 是内置组件，无需导入
// 直接使用即可
Particle()
```

### 1.2 基础用法

```typescript
// 基本粒子效果
Particle()
  .width(200)
  .height(200)

// 带配置的粒子效果
Particle({
  particles: [
    {
      emitRate: 10,
      lifetime: 1000,
      color: '#FF0000'
    }
  ]
})
  .width(200)
  .height(200)
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `ParticleOptions` | 否 | - | 粒子配置选项 |

### 2.2 ParticleOptions 配置

```typescript
interface ParticleOptions {
  particles: Array<ParticleConfiguration>
}

interface ParticleConfiguration {
  emitRate?: number              // 发射速率 (个/秒)
  lifetime?: number              // 粒子生命周期 (毫秒)
  particle?: {
    type?: 'Point' | 'Circle' | 'Image'  // 粒子类型
    size?: number                // 粒子大小
    color?: Color                // 粒子颜色
    opacity?: number             // 不透明度
  }
  emitter?: {
    position?: { x: number, y: number }  // 发射位置
    size?: { width: number, height: number }  // 发射区域
    emitType?: 'Point' | 'Rectangle'  // 发射类型
  }
  physics?: {
    velocity?: { x: number, y: number }  // 初始速度
    velocityRange?: { x: number, y: number }  // 速度范围
    acceleration?: { x: number, y: number }  // 加速度
    gravity?: number             // 重力
  }
  render?: {
    mode?: 'BlendMode'           // 混合模式
  }
}
```

### 2.3 组件属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `number \| string` | - | 粒子区域宽度 |
| `height` | `number \| string` | - | 粒子区域高度 |
| `backgroundColor` | `ResourceColor` | - | 背景颜色 |

## 三、常见使用场景

### 3.1 基本火焰效果

```typescript
@ComponentV2
struct FireParticle {
  build() {
    Column({ space: 16 }) {
      Text('Fire Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: 50,
            lifetime: 1000,
            particle: {
              type: 'Circle',
              size: 8,
              color: '#FF4500',
              opacity: 0.8
            },
            emitter: {
              position: { x: 100, y: 200 },
              emitType: 'Point'
            },
            physics: {
              velocity: { x: 0, y: -150 },
              velocityRange: { x: 50, y: 50 },
              gravity: -50
            }
          }
        ]
      })
        .width(200)
        .height(250)
        .backgroundColor('#1A000000')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 雪花效果

```typescript
@ComponentV2
struct SnowParticle {
  build() {
    Column({ space: 16 }) {
      Text('Snow Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: 20,
            lifetime: 3000,
            particle: {
              type: 'Circle',
              size: 5,
              color: '#FFFFFF',
              opacity: 0.8
            },
            emitter: {
              position: { x: 150, y: 0 },
              emitType: 'Rectangle',
              size: { width: 300, height: 0 }
            },
            physics: {
              velocity: { x: 0, y: 100 },
              velocityRange: { x: 30, y: 20 }
            }
          }
        ]
      })
        .width('100%')
        .height(300)
        .backgroundColor('#1A87CEEB')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 烟雾效果

```typescript
@ComponentV2
struct SmokeParticle {
  build() {
    Column({ space: 16 }) {
      Text('Smoke Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: 30,
            lifetime: 2000,
            particle: {
              type: 'Circle',
              size: 20,
              color: '#808080',
              opacity: 0.3
            },
            emitter: {
              position: { x: 150, y: 250 },
              emitType: 'Point'
            },
            physics: {
              velocity: { x: 0, y: -50 },
              velocityRange: { x: 20, y: 20 }
            }
          }
        ]
      })
        .width(300)
        .height(300)
        .backgroundColor('#1A000000')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 火花效果

```typescript
@ComponentV2
struct SparkParticle {
  build() {
    Column({ space: 16 }) {
      Text('Spark Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: 100,
            lifetime: 500,
            particle: {
              type: 'Point',
              size: 3,
              color: '#FFD700',
              opacity: 1.0
            },
            emitter: {
              position: { x: 150, y: 150 },
              emitType: 'Point'
            },
            physics: {
              velocity: { x: 0, y: 0 },
              velocityRange: { x: 200, y: 200 },
              acceleration: { x: 0, y: 100 }
            }
          }
        ]
      })
        .width(300)
        .height(300)
        .backgroundColor('#000000')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 魔法粒子

```typescript
@ComponentV2
struct MagicParticle {
  build() {
    Column({ space: 16 }) {
      Text('Magic Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: 40,
            lifetime: 1500,
            particle: {
              type: 'Circle',
              size: 6,
              color: '#9370DB',
              opacity: 0.7
            },
            emitter: {
              position: { x: 150, y: 150 },
              emitType: 'Point'
            },
            physics: {
              velocity: { x: 0, y: 0 },
              velocityRange: { x: 100, y: 100 }
            }
          }
        ]
      })
        .width(300)
        .height(300)
        .backgroundColor('#1A000000')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 星空效果

```typescript
@ComponentV2
struct StarParticle {
  build() {
    Column({ space: 16 }) {
      Text('Star Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: 5,
            lifetime: 5000,
            particle: {
              type: 'Circle',
              size: 2,
              color: '#FFFFFF',
              opacity: 0.8
            },
            emitter: {
              position: { x: 150, y: 0 },
              emitType: 'Rectangle',
              size: { width: 300, height: 0 }
            },
            physics: {
              velocity: { x: 0, y: 50 }
            }
          }
        ]
      })
        .width(300)
        .height(400)
        .backgroundColor('#000011')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 多色粒子

```typescript
@ComponentV2
struct MultiColorParticle {
  build() {
    Column({ space: 16 }) {
      Text('Multi-Color Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: 30,
            lifetime: 1000,
            particle: {
              type: 'Circle',
              size: 8,
              color: '#FF0000',
              opacity: 0.7
            },
            emitter: {
              position: { x: 100, y: 200 },
              emitType: 'Point'
            },
            physics: {
              velocity: { x: 0, y: -100 },
              velocityRange: { x: 30, y: 30 }
            }
          },
          {
            emitRate: 30,
            lifetime: 1000,
            particle: {
              type: 'Circle',
              size: 8,
              color: '#00FF00',
              opacity: 0.7
            },
            emitter: {
              position: { x: 150, y: 200 },
              emitType: 'Point'
            },
            physics: {
              velocity: { x: 0, y: -100 },
              velocityRange: { x: 30, y: 30 }
            }
          },
          {
            emitRate: 30,
            lifetime: 1000,
            particle: {
              type: 'Circle',
              size: 8,
              color: '#0000FF',
              opacity: 0.7
            },
            emitter: {
              position: { x: 200, y: 200 },
              emitType: 'Point'
            },
            physics: {
              velocity: { x: 0, y: -100 },
              velocityRange: { x: 30, y: 30 }
            }
          }
        ]
      })
        .width(300)
        .height(250)
        .backgroundColor('#1A000000')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 爆炸效果

```typescript
@ComponentV2
struct ExplosionParticle {
  @Local isExploding: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Explosion Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      if (this.isExploding) {
        Particle({
          particles: [
            {
              emitRate: 500,
              lifetime: 800,
              particle: {
                type: 'Circle',
                size: 5,
                color: '#FF4500',
                opacity: 1.0
              },
              emitter: {
                position: { x: 150, y: 150 },
                emitType: 'Point'
              },
              physics: {
                velocity: { x: 0, y: 0 },
                velocityRange: { x: 300, y: 300 }
              }
            }
          ]
        })
          .width(300)
          .height(300)
          .backgroundColor('#000000')
      } else {
        Column() {
          Button('Trigger Explosion')
            .onClick(() => {
              this.isExploding = true
              setTimeout(() => {
                this.isExploding = false
              }, 1000)
            })
        }
        .width(300)
        .height(300)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#1A000000')
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.9 上升气泡

```typescript
@ComponentV2
struct BubbleParticle {
  build() {
    Column({ space: 16 }) {
      Text('Bubble Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: 15,
            lifetime: 3000,
            particle: {
              type: 'Circle',
              size: 10,
              color: '#00BFFF',
              opacity: 0.5
            },
            emitter: {
              position: { x: 150, y: 280 },
              emitType: 'Rectangle',
              size: { width: 280, height: 0 }
            },
            physics: {
              velocity: { x: 0, y: -80 },
              velocityRange: { x: 10, y: 20 }
            }
          }
        ]
      })
        .width(300)
        .height(300)
        .backgroundColor('#001A33')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.10 发射器控制

```typescript
@ComponentV2
struct ControlledParticle {
  @Local emitRate: number = 30
  @Local particleSize: number = 8

  build() {
    Column({ space: 16 }) {
      Text('Controlled Particle')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Particle({
        particles: [
          {
            emitRate: this.emitRate,
            lifetime: 1500,
            particle: {
              type: 'Circle',
              size: this.particleSize,
              color: '#FF1493',
              opacity: 0.8
            },
            emitter: {
              position: { x: 150, y: 150 },
              emitType: 'Point'
            },
            physics: {
              velocity: { x: 0, y: 0 },
              velocityRange: { x: 80, y: 80 }
            }
          }
        ]
      })
        .width(300)
        .height(200)
        .backgroundColor('#1A000000')

      Column({ space: 12 }) {
        Text(`Emit Rate: ${this.emitRate}`)
          .fontSize(14)
        Slider({
          value: this.emitRate,
          min: 1,
          max: 100,
          step: 1
        })
          .onChange((value: number) => {
            this.emitRate = value
          })

        Text(`Particle Size: ${this.particleSize}`)
          .fontSize(14)
        Slider({
          value: this.particleSize,
          min: 2,
          max: 20,
          step: 1
        })
          .onChange((value: number) => {
            this.particleSize = value
          })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 性能优化

```typescript
// 好的做法：控制粒子数量和发射速率
Particle({
  particles: [
    {
      emitRate: 50,  // 合理的发射速率
      lifetime: 1000,
      // ...
    }
  ]
})

// 避免：过高的发射速率
Particle({
  particles: [
    {
      emitRate: 1000,  // 过高，可能导致性能问题
      lifetime: 1000,
      // ...
    }
  ]
})
```

### 4.2 粒子生命周期

```typescript
// 好的做法：根据效果调整生命周期
Particle({
  particles: [
    {
      emitRate: 30,
      lifetime: 2000,  // 足够长以显示完整效果
      // ...
    }
  ]
})
```

### 4.3 颜色和透明度

```typescript
// 好的做法：使用半透明粒子创建柔和效果
Particle({
  particles: [
    {
      emitRate: 30,
      lifetime: 1500,
      particle: {
        type: 'Circle',
        size: 10,
        color: '#FF69B4',
        opacity: 0.6  // 半透明
      },
      // ...
    }
  ]
})
```

### 4.4 条件渲染

```typescript
@ComponentV2
struct ConditionalParticle {
  @Local showParticles: boolean = false

  build() {
    Column() {
      if (this.showParticles) {
        Particle({
          particles: [/* ... */]
        })
          .width(300)
          .height(300)
      }

      Button('Toggle Particles')
        .onClick(() => {
          this.showParticles = !this.showParticles
        })
    }
  }
}
```

## 五、常见问题

### 5.1 粒子不显示

```typescript
// 检查以下几点：
// 1. 确保设置了宽度和高度
Particle()
  .width(300)
  .height(300)

// 2. 确保发射器位置在可见区域内
Particle({
  particles: [
    {
      emitter: {
        position: { x: 150, y: 150 },  // 在区域内
        // ...
      }
    }
  ]
})
```

### 5.2 性能问题

```typescript
// 降低发射速率
Particle({
  particles: [
    {
      emitRate: 20,  // 降低发射速率
      lifetime: 2000,
      // ...
    }
  ]
})

// 或者减少粒子数量
Particle({
  particles: [
    {
      emitRate: 30,
      lifetime: 1500,
      particle: {
        size: 10,  // 增大粒子尺寸
        // ...
      }
    }
  ]
})
```

### 5.3 粒子效果不自然

```typescript
// 添加速度范围使效果更自然
Particle({
  particles: [
    {
      emitRate: 30,
      lifetime: 1500,
      physics: {
        velocity: { x: 0, y: -100 },
        velocityRange: { x: 30, y: 30 }  // 添加随机性
      }
    }
  ]
})
```

## 六、性能优化建议

1. **控制粒子数量**: 根据设备性能调整粒子数量
2. **合理生命周期**: 避免过长的生命周期导致内存占用
3. **条件渲染**: 不需要时停止粒子系统
4. **简化粒子**: 使用简单的粒子形状（点、圆）而非复杂图像
5. **限制发射器**: 避免同时使用多个高发射率的发射器
6. **测试性能**: 在低端设备上测试粒子效果性能
