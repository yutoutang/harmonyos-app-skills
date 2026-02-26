# Component3D 组件 HarmonyOS 6.0 开发 Skill

## 概述

Component3D 是 HarmonyOS 6.0 (API 12+) 引入的 3D 渲染组件，用于在 ArkUI 应用中展示和交互 3D 模型。该组件基于 ArkGraphics3D 图形引擎，提供完整的 3D 场景管理、渲染和动画控制能力。

## 重要说明

- **API 版本要求**: API 12+ (HarmonyOS 5.0.0 及以上)
- **3D 格式支持**: 当前主要支持 GLTF 格式的 3D 模型
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **性能考虑**: 3D 渲染对 GPU 性能要求较高，建议在支持硬件加速的设备上使用
- **元服务支持**: 从 API 12 开始支持在元服务（小程序）中使用

## 模块信息

- **组件名称**: Component3D
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.Graphics3D
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Component3D - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-basic-components-component3d-V13)
  - [ArkGraphics3D - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkgraphics-3d-overview-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// 导入 ArkGraphics3D 模块的核心类
import {
  Animation,
  Environment,
  LayerMask,
  NodeType,
  Node,
  Geometry,
  Material,
  LightType,
  Light,
  Camera,
  Scene
} from '@kit.ArkGraphics3D'

// Component3D 是内置组件，直接使用即可
```

### 1.2 基础用法

```typescript
@ComponentV2
struct Basic3DExample {
  // 场景配置
  sceneOptions: SceneOptions = {
    scene: 'common/scenes/warehouse.glb',  // 3D 模型资源路径
    modelType: ModelType.SURFACE           // 显示模式
  }

  build() {
    Column() {
      Component3D(this.sceneOptions)
        .width('100%')
        .height('100%')
        .backgroundColor('#000000')
    }
  }
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| sceneOptions | `SceneOptions` | 否 | - | 场景配置选项 |

### 2.2 SceneOptions 配置

| 属性 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| scene | `ResourceStr \| Scene` | 是 | - | 3D 模型资源文件路径或 Scene 对象 |
| modelType | `ModelType` | 否 | SURFACE | 3D 场景显示组成模式 |

### 2.3 ModelType 枚举

| 值 | 描述 |
|----|------|
| `TEXTURE` | GPU 合成显示模式，使用纹理进行渲染 |
| `SURFACE` | 专用硬件合成显示模式（默认），性能更好 |

### 2.4 组件属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `number \| string` | - | 组件宽度 |
| `height` | `number \| string` | - | 组件高度 |
| `backgroundColor` | `ResourceColor` | - | 背景颜色 |

## 三、3D 场景核心概念

### 3.1 Scene（场景）

场景是 3D 世界的根容器，包含所有 3D 对象。

```typescript
// 创建场景
const scene = new Scene()

// 添加子节点
scene.addNode(node)

// 获取根节点
const rootNode = scene.getRootNode()

// 查找节点
const node = scene.getNodeByName('nodeName')

// 移除节点
scene.removeNode(node)
```

### 3.2 Node（节点）

节点是场景中所有 3D 对象的基类，包括几何体、灯光、相机等。

```typescript
// 创建节点
const node = new Node()

// 设置节点名称
node.name = 'MyNode'

// 设置父节点
node.setParent(parentNode)

// 获取子节点
const children = node.getChildren()

// 查找子节点
const child = node.getChildByName('ChildName')

// 设置位置
node.setPosition({ x: 0, y: 0, z: 0 })

// 设置旋转
node.setRotation({ x: 0, y: 0, z: 0 })

// 设置缩放
node.setScale({ x: 1, y: 1, z: 1 })
```

### 3.3 Camera（相机）

相机定义了观察 3D 场景的视角。

```typescript
// 创建相机
const camera = new Camera()

// 设置相机类型
camera.type = CameraType.PERSPECTIVE  // 透视相机

// 设置位置
camera.position = { x: 0, y: 5, z: 10 }

// 设置目标点（看向哪里）
camera.lookAt = { x: 0, y: 0, z: 0 }

// 设置视野角度
camera.fov = 45  // 45 度视角

// 设置近平面和远平面
camera.near = 0.1
camera.far = 100

// 设置宽高比
camera.aspect = 16 / 9
```

**相机类型**:

| 类型 | 描述 |
|------|------|
| `PERSPECTIVE` | 透视相机，有近大远小效果，适合真实场景 |
| `ORTHOGRAPHIC` | 正交相机，无透视效果，适合工程图 |

### 3.4 Light（灯光）

灯光照亮 3D 场景中的物体。

```typescript
// 创建灯光
const light = new Light()

// 设置灯光类型
light.type = LightType.POINT  // 点光源

// 设置位置
light.position = { x: 5, y: 10, z: 5 }

// 设置颜色
light.color = { r: 1, g: 1, b: 1 }  // 白色

// 设置强度
light.intensity = 1.0

// 设置范围（点光源和聚光灯）
light.range = 100

// 设置内锥角（聚光灯）
light.innerConeAngle = 0.1

// 设置外锥角（聚光灯）
light.outerConeAngle = 0.3
```

**灯光类型**:

| 类型 | 描述 |
|------|------|
| `AMBIENT` | 环境光，均匀照亮整个场景 |
| `DIRECTIONAL` | 平行光，类似太阳光 |
| `POINT` | 点光源，从一点向四面八方发光 |
| `SPOT` | 聚光灯，形成锥形光束 |

### 3.5 Geometry（几何体）

几何体定义了 3D 物体的形状。

```typescript
// 创建几何体
const geometry = new Geometry()

// 设置几何体类型
geometry.type = GeometryType.BOX  // 立方体

// 设置材质
geometry.material = material

// 设置可见性
geometry.isVisible = true
```

**常见几何体类型**:

| 类型 | 描述 |
|------|------|
| `BOX` | 立方体 |
| `SPHERE` | 球体 |
| `CYLINDER` | 圆柱体 |
| `CONE` | 圆锥体 |
| `PLANE` | 平面 |
| `CUSTOM` | 自定义几何体 |

### 3.6 Material（材质）

材质定义了物体表面的外观特性。

```typescript
// 创建材质
const material = new Material()

// 设置基础颜色
material.baseColor = { r: 0.5, g: 0.5, b: 0.5 }

// 设置金属度
material.metallic = 0.5

// 设置粗糙度
material.roughness = 0.5

// 设置自发光
material.emissive = { r: 0, g: 0, b: 0 }

// 设置透明度
material.opacity = 1.0

// 设置双面渲染
material.doubleSided = false
```

### 3.7 Environment（环境）

环境定义了场景的背景和环境光照。

```typescript
// 创建环境
const environment = new Environment()

// 设置环境贴图
environment.reflectionTexture = texture

// 设置环境光强度
environment.ambientLightIntensity = 0.3

// 设置天空盒
environment.skybox = skybox

// 设置背景颜色
environment.backgroundColor = { r: 0.1, g: 0.1, b: 0.2 }
```

### 3.8 Animation（动画）

动画控制 3D 对象的运动和变化。

```typescript
// 创建动画
const animation = new Animation()

// 播放动画
animation.play()

// 暂停动画
animation.pause()

// 停止动画
animation.stop()

// 跳转到指定时间
animation.seek(time)

// 设置播放速度
animation.speed = 1.0

// 设置循环模式
animation.loop = true

// 监听动画事件
animation.on('complete', () => {
  console.info('Animation completed')
})
```

## 四、使用示例

### 4.1 加载 GLTF 模型

```typescript
@ComponentV2
struct LoadGLTFModel {
  build() {
    Column() {
      Component3D({
        scene: $rawfile('models/car.glb'),
        modelType: ModelType.SURFACE
      })
        .width('100%')
        .height('100%')
        .backgroundColor('#1a1a1a')
    }
  }
}
```

### 4.2 场景配置示例

```typescript
@ComponentV2
struct SceneConfigExample {
  private scene: Scene = new Scene()

  aboutToAppear() {
    this.setupScene()
  }

  private setupScene() {
    // 创建并添加相机
    const camera = new Camera()
    camera.position = { x: 0, y: 5, z: 10 }
    camera.lookAt = { x: 0, y: 0, z: 0 }
    this.scene.addCamera(camera)

    // 创建并添加灯光
    const light = new Light()
    light.type = LightType.DIRECTIONAL
    light.position = { x: 5, y: 10, z: 5 }
    light.intensity = 1.0
    this.scene.addLight(light)

    // 创建环境光
    const ambientLight = new Light()
    ambientLight.type = LightType.AMBIENT
    ambientLight.intensity = 0.3
    this.scene.addLight(ambientLight)
  }

  build() {
    Column() {
      Component3D({
        scene: this.scene,
        modelType: ModelType.SURFACE
      })
        .width('100%')
        .height('100%')
    }
  }
}
```

### 4.3 交互式 3D 模型

```typescript
@ComponentV2
struct Interactive3DModel {
  private scene: Scene = new Scene()
  private modelNode: Node | null = null
  @Local rotationX: number = 0
  @Local rotationY: number = 0

  aboutToAppear() {
    this.loadModel()
  }

  private async loadModel() {
    // 加载模型
    this.modelNode = await this.scene.loadModel($rawfile('models/product.glb'))

    // 设置初始位置
    if (this.modelNode) {
      this.modelNode.setPosition({ x: 0, y: 0, z: 0 })
    }
  }

  build() {
    Column() {
      Component3D({
        scene: this.scene,
        modelType: ModelType.SURFACE
      })
        .width('100%')
        .height('100%')
        .gesture(
          RotationGesture()
            .onActionStart(() => {
              console.info('Rotation started')
            })
            .onActionUpdate((event: GestureEvent) => {
              if (this.modelNode) {
                this.rotationY = event.rotation
                this.modelNode.setRotation({
                  x: this.rotationX,
                  y: this.rotationY,
                  z: 0
                })
              }
            })
        )

      Row({ space: 16 }) {
        Button('旋转 X')
          .onClick(() => {
            this.rotationX += 45
            if (this.modelNode) {
              this.modelNode.setRotation({
                x: this.rotationX,
                y: this.rotationY,
                z: 0
              })
            }
          })

        Button('重置')
          .onClick(() => {
            this.rotationX = 0
            this.rotationY = 0
            if (this.modelNode) {
              this.modelNode.setRotation({ x: 0, y: 0, z: 0 })
            }
          })
      }
      .padding(16)
    }
  }
}
```

### 4.4 动画控制示例

```typescript
@ComponentV2
struct AnimationControlExample {
  private scene: Scene = new Scene()
  private animation: Animation | null = null
  @Local isPlaying: boolean = false
  @Local playbackSpeed: number = 1.0

  aboutToAppear() {
    this.setupAnimation()
  }

  private async setupAnimation() {
    // 加载带动画的模型
    await this.scene.loadModel($rawfile('models/animated_character.glb'))

    // 获取动画
    this.animation = this.scene.getAnimation('walk')
  }

  build() {
    Column() {
      Component3D({
        scene: this.scene,
        modelType: ModelType.SURFACE
      })
        .width('100%')
        .height('100%')

      Row({ space: 16 }) {
        Button(this.isPlaying ? '暂停' : '播放')
          .onClick(() => {
            if (this.animation) {
              if (this.isPlaying) {
                this.animation.pause()
              } else {
                this.animation.play()
              }
              this.isPlaying = !this.isPlaying
            }
          })

        Button('停止')
          .onClick(() => {
            if (this.animation) {
              this.animation.stop()
              this.isPlaying = false
            }
          })

        Button('0.5x')
          .onClick(() => {
            if (this.animation) {
              this.animation.speed = 0.5
              this.playbackSpeed = 0.5
            }
          })

        Button('1.0x')
          .onClick(() => {
            if (this.animation) {
              this.animation.speed = 1.0
              this.playbackSpeed = 1.0
            }
          })

        Button('2.0x')
          .onClick(() => {
            if (this.animation) {
              this.animation.speed = 2.0
              this.playbackSpeed = 2.0
            }
          })
      }
      .padding(16)
    }
  }
}
```

### 4.5 多灯光场景

```typescript
@ComponentV2
struct MultiLightScene {
  private scene: Scene = new Scene()

  aboutToAppear() {
    this.setupLights()
  }

  private setupLights() {
    // 主光源（平行光）
    const mainLight = new Light()
    mainLight.type = LightType.DIRECTIONAL
    mainLight.position = { x: -5, y: 10, z: 5 }
    mainLight.color = { r: 1, g: 0.95, b: 0.9 }  // 暖色
    mainLight.intensity = 1.0
    this.scene.addLight(mainLight)

    // 补光（点光源）
    const fillLight = new Light()
    fillLight.type = LightType.POINT
    fillLight.position = { x: 5, y: 5, z: 5 }
    fillLight.color = { r: 0.8, g: 0.9, b: 1 }  // 冷色
    fillLight.intensity = 0.5
    fillLight.range = 50
    this.scene.addLight(fillLight)

    // 环境光
    const ambientLight = new Light()
    ambientLight.type = LightType.AMBIENT
    ambientLight.color = { r: 0.2, g: 0.2, b: 0.2 }
    ambientLight.intensity = 0.3
    this.scene.addLight(ambientLight)

    // 聚光灯（高光）
    const spotLight = new Light()
    spotLight.type = LightType.SPOT
    spotLight.position = { x: 0, y: 10, z: 0 }
    spotLight.color = { r: 1, g: 1, b: 1 }
    spotLight.intensity = 0.8
    spotLight.range = 30
    spotLight.innerConeAngle = 0.1
    spotLight.outerConeAngle = 0.3
    this.scene.addLight(spotLight)
  }

  build() {
    Column() {
      Component3D({
        scene: this.scene,
        modelType: ModelType.SURFACE
      })
        .width('100%')
        .height('100%')
    }
  }
}
```

## 五、高级功能

### 5.1 自定义着色器

```typescript
// 创建自定义材质
const customMaterial = new Material()

// 自定义着色器代码
const vertexShader = `
  uniform mat4 modelViewMatrix;
  uniform mat4 projectionMatrix;
  attribute vec3 position;

  void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
  }
`

const fragmentShader = `
  precision mediump float;
  uniform vec3 color;

  void main() {
    gl_FragColor = vec4(color, 1.0);
  }
`

customMaterial.setShader(vertexShader, fragmentShader)
```

### 5.2 节点层级管理

```typescript
@ComponentV2
struct NodeHierarchyExample {
  private scene: Scene = new Scene()
  private rootNode: Node = new Node()
  private childNode1: Node = new Node()
  private childNode2: Node = new Node()

  aboutToAppear() {
    // 构建节点层级
    this.rootNode.name = 'Root'
    this.childNode1.name = 'Child1'
    this.childNode2.name = 'Child2'

    // 设置父子关系
    this.childNode1.setParent(this.rootNode)
    this.childNode2.setParent(this.rootNode)

    // 设置位置（相对坐标）
    this.childNode1.setPosition({ x: -2, y: 0, z: 0 })
    this.childNode2.setPosition({ x: 2, y: 0, z: 0 })

    // 添加到场景
    this.scene.addNode(this.rootNode)
  }

  build() {
    Column() {
      Component3D({
        scene: this.scene,
        modelType: ModelType.SURFACE
      })
        .width('100%')
        .height('100%')
    }
  }
}
```

### 5.3 材质动画

```typescript
@ComponentV2
struct MaterialAnimationExample {
  private scene: Scene = new Scene()
  private material: Material = new Material()
  @Local emissiveIntensity: number = 0

  aboutToAppear() {
    this.setupMaterial()
  }

  private setupMaterial() {
    this.material.baseColor = { r: 0.2, g: 0.4, b: 0.8 }
    this.material.metallic = 0.8
    this.material.roughness = 0.2
    this.material.emissive = { r: 0, g: 0.5, b: 1 }
  }

  private animateEmissive() {
    setInterval(() => {
      this.emissiveIntensity = (Math.sin(Date.now() / 500) + 1) / 2
      this.material.emissive = {
        r: 0,
        g: this.emissiveIntensity * 0.5,
        b: this.emissiveIntensity
      }
    }, 16)
  }

  build() {
    Column() {
      Component3D({
        scene: this.scene,
        modelType: ModelType.SURFACE
      })
        .width('100%')
        .height('100%')

      Button('开始发光动画')
        .onClick(() => {
          this.animateEmissive()
        })
    }
  }
}
```

## 六、性能优化

### 6.1 模型优化

```typescript
// ✅ 推荐：使用简化模型
const optimizedModel = await scene.loadModel($rawfile('models/low_poly.glb'))

// ❌ 避免：使用过高精度的模型
const heavyModel = await scene.loadModel($rawfile('models/high_poly.glb'))
```

### 6.2 渲染优化

```typescript
// 使用合适的 modelType
Component3D({
  scene: scene,
  modelType: ModelType.SURFACE  // 硬件加速，性能更好
})

// 合理设置相机裁剪面
camera.near = 1.0   // 避免设置过小
camera.far = 100.0  // 避免设置过大
```

### 6.3 动画优化

```typescript
// 限制同时播放的动画数量
private maxConcurrentAnimations = 3

// 使用动画实例池
private animationPool: Animation[] = []

function getAnimation(): Animation {
  return this.animationPool.pop() || new Animation()
}

function releaseAnimation(animation: Animation): void {
  animation.stop()
  this.animationPool.push(animation)
}
```

## 七、常见问题

### Q1: Component3D 显示黑屏？

**解决方案**:

```typescript
// 1. 检查模型路径是否正确
Component3D({
  scene: $rawfile('models/correct_path.glb'),  // 确保路径正确
  modelType: ModelType.SURFACE
})

// 2. 确保添加了灯光
const light = new Light()
light.type = LightType.DIRECTIONAL
light.intensity = 1.0
scene.addLight(light)

// 3. 检查相机位置
camera.position = { x: 0, y: 5, z: 10 }
camera.lookAt = { x: 0, y: 0, z: 0 }
```

### Q2: 如何优化模型加载性能？

**解决方案**:

```typescript
// 1. 使用压缩格式
// 使用 draco 压缩的 GLTF 模型

// 2. 异步加载
async loadModelAsync() {
  showLoading()
  try {
    await scene.loadModel($rawfile('models/heavy_model.glb'))
  } finally {
    hideLoading()
  }
}

// 3. 使用低多边形版本作为占位符
async loadWithPlaceholder() {
  // 先加载简化版本
  await scene.loadModel($rawfile('models/low_poly.glb'))

  // 后台加载完整版本
  scene.loadModel($rawfile('models/full_detail.glb'))
    .then(() => {
      // 替换模型
    })
}
```

### Q3: 动画播放不流畅？

**解决方案**:

```typescript
// 1. 降低骨骼数量
// 使用骨骼数少于 50 的模型

// 2. 减少关键帧
// 在建模软件中简化动画曲线

// 3. 使用动画混合
animation.useBlendShapes = true
```

### Q4: 如何实现模型点击检测？

**解决方案**:

```typescript
@ComponentV2
struct ClickDetectionExample {
  private scene: Scene = new Scene()

  build() {
    Column() {
      Component3D({
        scene: this.scene,
        modelType: ModelType.SURFACE
      })
        .width('100%')
        .height('100%')
        .onClick((event: ClickEvent) => {
          // 获取点击位置
          const x = event.x
          const y = event.y

          // 射线检测
          const hitResult = this.scene.raycast(x, y)
          if (hitResult) {
            console.info(`Clicked on: ${hitResult.node.name}`)
          }
        })
    }
  }
}
```

## 八、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 11 | ❌ | 不支持 Component3D |
| API 12 | ✅ | 首次引入，支持基础 3D 渲染 |
| API 13 | ✅ | 增强功能，更好的性能 |
| API 14+ | ✅ | 持续优化和功能增强 |

## 九、参考资料

- [Component3D 官方文档 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-basic-components-component3d-V13)
- [ArkGraphics3D 概述 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkgraphics-3d-overview-V5)
- [3D 模型格式规范 - GLTF](https://www.khronos.org/gltf/)
- [HarmonyOS 鸿蒙Next体验官#5行代码渲染出3D悟空](https://bbs.itying.com/topic/66d150ca6e3c6500bcd72e06)
- 【鸿蒙next开发】ArkUI框架：ArkTS组件-Component3D](https://m.blog.csdn.net/m0_73088370/article/details/148308978)

## 十、最佳实践

### 1. 场景设计

- **保持场景简洁**: 避免过多不必要的节点和几何体
- **使用实例化**: 对于重复的几何体，使用实例化技术
- **合理分组**: 使用节点层级组织场景结构

### 2. 性能优化

- **LOD 技术**: 根据距离使用不同精度的模型
- **遮挡剔除**: 移除视野外的物体
- **批量渲染**: 合并相同材质的物体

### 3. 资源管理

- **异步加载**: 大模型应在后台加载
- **内存管理**: 及时释放不需要的资源
- **资源复用**: 共享材质和纹理

### 4. 用户体验

- **加载提示**: 显示加载进度
- **降级方案**: 为低端设备提供简化版本
- **交互反馈**: 提供清晰的用户交互反馈
