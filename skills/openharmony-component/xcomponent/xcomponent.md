# XComponent 组件参考

## 概述

`XComponent` 是 OpenHarmony 中用于嵌入原生 C++ 绘制内容的特殊组件。它提供了 ArkTS 与 Native C++ 代码之间的桥接，使得开发者可以使用 C++ 进行高性能图形渲染，同时与 ArkTS UI 进行集成。

XComponent 常用于：
- 游戏开发
- 视频/图像处理
- 高性能图形渲染
- OpenGL/Vulkan 图形编程
- 相机预览
- 自定义绘制组件

## 基本语法

```typescript
XComponent({
  id: string,
  type: string,
  libraryname?: string,
  onload?: (event: XComponentContext) => void,
  onDestroy?: () => void
})
```

## 核心属性

### id
- **类型**: `string`
- **说明**: XComponent 的唯一标识符，用于在 C++ 代码中定位该组件
- **必需**: 是

### type
- **类型**: `string`
- **说明**: XComponent 的类型
- **可选值**:
  - `'surface'`: 表面类型，用于 EGL/OpenGL ES 渲染
  - `'texture'`: 纹理类型，用于 Vulkan 渲染
- **必需**: 是

### libraryname
- **类型**: `string`
- **说明**: 指定加载的 native 动态库名称（不含 `lib` 前缀和 `.so` 后缀）
- **必需**: 是（对于 surface 类型）

### onload
- **类型**: `(event: XComponentContext) => void`
- **说明**: XComponent 加载完成时的回调，返回 XComponent 的上下文
- **必需**: 是

### onDestroy
- **类型**: `() => void`
- **说明**: XComponent 销毁时的回调
- **可选**: 是

## XComponentContext 接口

```typescript
interface XComponentContext {
  xComponentId: string;           // XComponent 的 ID
  xComponentWidth: number;        // 宽度
  xComponentHeight: number;       // 高度
  surfaceNode: SurfaceNode;       // Native surface 节点
}
```

## 项目配置

### 1. 配置 build-profile.json5

启用 Native C++ 支持：

```json5
{
  "apiType": "stageMode",
  "buildOption": {
    "externalNativeOptions": {
      "path": "./src/main/cpp/CMakeLists.txt",
      "arguments": "",
      "cppFlags": "",
      "abiFilters": [
        "armeabi-v7a",
        "arm64-v8a"
      ]
    }
  }
}
```

### 2. 配置 oh-package.json5

添加 Native 依赖：

```json5
{
  "dependencies": {
    "@ohos/napi": "^1.0.0"
  }
}
```

### 3. 配置 CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.4.1)

project(XComponentDemo)

set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

include_directories(
    ${NATIVERENDER_ROOT_PATH}
    ${NATIVERENDER_ROOT_PATH}/include
)

add_library(xcomponentdemo SHARED
    napi_init.cpp
    xcomponent_render.cpp
)

target_link_libraries(xcomponentdemo PUBLIC
    libace_napi.z.so
    libnative_drawing.so
    EGL
    GLESv3
)
```

## 使用示例

### 基础 XComponent 示例

```typescript
@ComponentV2
struct BasicXComponentExample {
  @Local xComponentId: string = 'xcomponent_surface'
  @Local surfaceWidth: number = 0
  @Local surfaceHeight: number = 0

  build() {
    Column() {
      Text('XComponent 基础示例')
        .fontSize(18)
        .margin({ bottom: 16 })

      XComponent({
        id: this.xComponentId,
        type: 'surface',
        libraryname: 'xcomponentdemo',
        onload: (context) => {
          console.info('XComponent loaded');
          this.surfaceWidth = context.xComponentWidth;
          this.surfaceHeight = context.xComponentHeight;
        },
        onDestroy: () => {
          console.info('XComponent destroyed');
        }
      })
      .width('100%')
      .height(400)
      .border({ width: 1, color: Color.Gray })
    }
    .padding(16)
  }
}
```

### 动态调整尺寸

```typescript
@ComponentV2
struct ResizableXComponentExample {
  @Local componentWidth: string = '100%'
  @Local componentHeight: number = 400
  @Local context: XComponentContext | null = null

  build() {
    Column() {
      Row() {
        Button('放大')
          .onClick(() => {
            this.componentHeight += 50
          })

        Button('缩小')
          .onClick(() => {
            if (this.componentHeight > 100) {
              this.componentHeight -= 50
            }
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ bottom: 16 })

      XComponent({
        id: 'resizable_xcomponent',
        type: 'surface',
        libraryname: 'xcomponentdemo',
        onload: (ctx) => {
          this.context = ctx
          console.info(`Size: ${ctx.xComponentWidth}x${ctx.xComponentHeight}`)
        },
        onDestroy: () => {
          this.context = null
        }
      })
      .width(this.componentWidth)
      .height(this.componentHeight)
    }
    .padding(16)
  }
}
```

### 多 XComponent 管理

```typescript
@ComponentV2
struct MultipleXComponentExample {
  @Local activeIndex: number = 0
  @Local contexts: Map<string, XComponentContext> = new Map()

  build() {
    Column() {
      Tabs({ index: this.activeIndex }) {
        TabContent() {
          XComponent({
            id: 'xcomp_1',
            type: 'surface',
            libraryname: 'xcomponentdemo',
            onload: (ctx) => {
              this.contexts.set('xcomp_1', ctx)
            }
          })
        }
        .tabBar('组件 1')

        TabContent() {
          XComponent({
            id: 'xcomp_2',
            type: 'surface',
            libraryname: 'xcomponentdemo',
            onload: (ctx) => {
              this.contexts.set('xcomp_2', ctx)
            }
          })
        }
        .tabBar('组件 2')
      }
      .onChange((index) => {
        this.activeIndex = index
      })
      .width('100%')
      .height(500)
    }
  }
}
```

## Native C++ 实现示例

### napi_init.cpp - NAPI 模块注册

```cpp
#include "napi/native_api.h"
#include "xcomponent_render.h"

static XComponentRenderer* g_renderer = nullptr;

// NAPI 方法：初始化渲染器
static napi_value InitRenderer(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value args[1];
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);

    // 获取 XComponent ID
    size_t idLength;
    napi_get_value_string_utf8(env, args[0], nullptr, 0, &idLength);
    char* id = new char[idLength + 1];
    napi_get_value_string_utf8(env, args[0], id, idLength + 1, &idLength);

    // 创建渲染器
    g_renderer = new XComponentRenderer(id);
    g_renderer->Initialize();

    delete[] id;
    return nullptr;
}

// NAPI 模块导出
static napi_value Export(napi_env env, napi_value exports) {
    napi_property_descriptor desc[] = {
        {"initRenderer", nullptr, InitRenderer, nullptr, nullptr, nullptr, napi_default, nullptr}
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}

// NAPI 模块注册
EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports) {
    return Export(env, exports);
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "xcomponentdemo",
    .nm_priv = nullptr,
    .reserved = {0},
};

extern "C" __attribute__((constructor)) void RegisterXComponentDemoModule(void) {
    napi_module_register(&demoModule);
}
```

### xcomponent_render.cpp - 渲染器实现

```cpp
#include "xcomponent_render.h"
#include <EGL/egl.h>
#include <GLES3/gl3.h>
#include < OH_NativeWindow.h>

class XComponentRendererImpl {
public:
    XComponentRendererImpl(const std::string& id) : xComponentId_(id) {}

    ~XComponentRendererImpl() {
        Cleanup();
    }

    void Initialize() {
        // 初始化 EGL
        InitializeEGL();
        // 初始化 OpenGL
        InitializeGL();
        // 开始渲染循环
        StartRenderLoop();
    }

private:
    void InitializeEGL() {
        // 获取 EGL 显示
        display_ = eglGetDisplay(EGL_DEFAULT_DISPLAY);
        eglInitialize(display_, nullptr, nullptr);

        // 配置 EGL
        EGLint attribs[] = {
            EGL_RENDERABLE_TYPE, EGL_OPENGL_ES3_BIT,
            EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
            EGL_RED_SIZE, 8,
            EGL_GREEN_SIZE, 8,
            EGL_BLUE_SIZE, 8,
            EGL_ALPHA_SIZE, 8,
            EGL_DEPTH_SIZE, 24,
            EGL_NONE
        };

        EGLConfig config;
        EGLint numConfigs;
        eglChooseConfig(display_, attribs, &config, 1, &numConfigs);

        // 创建 EGL 表面（需要从 XComponent 获取）
        // surface_ = eglCreateWindowSurface(...);

        // 创建 EGL 上下文
        EGLint contextAttribs[] = {
            EGL_CONTEXT_CLIENT_VERSION, 3,
            EGL_NONE
        };
        context_ = eglCreateContext(display_, config, EGL_NO_CONTEXT, contextAttribs);
    }

    void InitializeGL() {
        // 编译着色器
        // 创建顶点缓冲
        // 设置 OpenGL 状态
    }

    void StartRenderLoop() {
        // 启动渲染线程
    }

    void Cleanup() {
        if (display_ != EGL_NO_DISPLAY) {
            eglMakeCurrent(display_, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
            if (context_ != EGL_NO_CONTEXT) {
                eglDestroyContext(display_, context_);
            }
            if (surface_ != EGL_NO_SURFACE) {
                eglDestroySurface(display_, surface_);
            }
            eglTerminate(display_);
        }
    }

    std::string xComponentId_;
    EGLDisplay display_ = EGL_NO_DISPLAY;
    EGLSurface surface_ = EGL_NO_SURFACE;
    EGLContext context_ = EGL_NO_CONTEXT;
};
```

## 常见应用场景

### 1. 相机预览

```typescript
@ComponentV2
struct CameraPreviewExample {
  @Local cameraXComponentId: string = 'camera_preview'

  build() {
    Column() {
      XComponent({
        id: this.cameraXComponentId,
        type: 'surface',
        libraryname: 'camerademo',
        onload: (context) => {
          // 通知 native 层开始相机预览
        }
      })
      .width('100%')
      .height(300)
    }
  }
}
```

### 2. 视频播放器

```typescript
@ComponentV2
struct VideoPlayerExample {
  @Local videoXComponentId: string = 'video_player'
  @Local isPlaying: boolean = false

  build() {
    Column() {
      XComponent({
        id: this.videoXComponentId,
        type: 'surface',
        libraryname: 'videodemo',
        onload: (context) => {
          // 初始化视频播放器
        }
      })
      .width('100%')
      .height(240)

      Row() {
        Button(this.isPlaying ? '暂停' : '播放')
          .onClick(() => {
            this.isPlaying = !this.isPlaying
            // 控制视频播放
          })
      }
    }
  }
}
```

### 3. 游戏渲染

```typescript
@ComponentV2
struct GameRenderExample {
  @Local gameXComponentId: string = 'game_render'

  build() {
    Column() {
      XComponent({
        id: this.gameXComponentId,
        type: 'surface',
        libraryname: 'gamedemo',
        onload: (context) => {
          // 初始化游戏引擎
        },
        onDestroy: () => {
          // 清理游戏资源
        }
      })
      .width('100%')
      .height('100%')
    }
  }
}
```

## 权限配置

根据使用场景可能需要以下权限：

### 相机权限
```json5
{
  "requestPermissions": [
    {
      "name": "ohos.permission.CAMERA",
      "reason": "$string:camera_permission_reason",
      "usedScene": {
        "abilities": ["EntryAbility"],
        "when": "inuse"
      }
    }
  ]
}
```

### 麦克风权限
```json5
{
  "requestPermissions": [
    {
      "name": "ohos.permission.MICROPHONE",
      "reason": "$string:microphone_permission_reason",
      "usedScene": {
        "abilities": ["EntryAbility"],
        "when": "inuse"
      }
    }
  ]
}
```

## 最佳实践

### 1. 资源管理

```typescript
@ComponentV2
struct ProperCleanupExample {
  @Local isMounted: boolean = true

  build() {
    XComponent({
      id: 'cleanup_example',
      type: 'surface',
      libraryname: 'demo',
      onload: (context) => {
        // 保存上下文
      },
      onDestroy: () => {
        // 清理 native 资源
        if (this.isMounted) {
          // 通知 native 层清理
        }
      }
    })
  }

  aboutToDisappear() {
    this.isMounted = false
  }
}
```

### 2. 错误处理

```typescript
@ComponentV2
struct ErrorHandlingExample {
  @Local hasError: boolean = false
  @Local errorMessage: string = ''

  build() {
    Column() {
      if (this.hasError) {
        Text(`错误: ${this.errorMessage}`)
          .fontColor(Color.Red)
      }

      XComponent({
        id: 'error_handling',
        type: 'surface',
        libraryname: 'demo',
        onload: (context) => {
          try {
            // 初始化
          } catch (error) {
            this.hasError = true
            this.errorMessage = error.message
          }
        }
      })
    }
  }
}
```

### 3. 性能优化

- 使用离屏渲染减少 UI 线程压力
- 合理设置 XComponent 尺寸
- 避免频繁创建和销毁 XComponent
- 使用对象池复用 Native 对象

## 限制与注意事项

1. **性能开销**: Native 调用有额外的性能开销
2. **内存管理**: 需要手动管理 Native 内存
3. **线程安全**: 注意 ArkTS 和 Native 之间的线程安全
4. **生命周期**: 正确管理 XComponent 的生命周期
5. **ABI 兼容性**: 确保编译的 .so 文件与目标设备架构匹配
6. **调试困难**: Native 层的调试相对复杂

## 常见问题

### Q: 如何获取 XComponent 的 Native Surface？

A: 通过 `onload` 回调的 `XComponentContext` 获取：

```typescript
onload: (context) => {
  const surfaceNode = context.surfaceNode;
  // 传递给 Native 层
}
```

### Q: XComponent 支持哪些图形 API？

A: 支持：
- OpenGL ES 2.0/3.0/3.1/3.2
- Vulkan
- Native Drawing API

### Q: 如何调试 Native 代码？

A:
1. 使用 DevEco Studio 的 Native 调试功能
2. 添加日志输出（`__android_log_print` 或 `OH_LOG_Print`）
3. 使用 GDB 进行调试

### Q: XComponent 和 Web 组件有什么区别？

A:
- **XComponent**: 用于 Native C++ 渲染，性能更高，适合游戏和图形密集应用
- **Web**: 用于 Web 内容，基于 WebKit，适合 HTML/CSS/JavaScript 内容

### Q: 如何处理 XComponent 的触摸事件？

A: 需要在 Native 层处理：

```cpp
// 在 Native 层注册触摸事件回调
OH_NativeXComponent_RegisterCallback(nativeXComponent, &callbacks);
```

## 常见问题与陷阱 (Common Pitfalls)

### ⚠️ XComponent 需要 Native C++ 配置

**问题：**
XComponent 是一个需要 Native C++ 配置的复杂组件，不能直接使用。

**必须的配置：**
1. **CMakeLists.txt** - Native 构建配置
2. **.so 动态库** - 编译的 Native 库
3. **build-profile.json5** - 启用 C++ 支持
4. **oh-package.json5** - Native 依赖

**常见错误：**
```
Error: Cannot load native library
Error: XComponent initialization failed
```

**解决方案：**
```typescript
// 在开发阶段，使用占位符代替实际的 XComponent
@ComponentV2
struct XComponentPlaceholder {
  build() {
    Column() {
      Text('XComponent 容器区域')
        .fontSize(14)
        .fontColor('#999999')
      Text('需要配置 native C++ 项目')
        .fontSize(12)
        .fontColor('#CCCCCC')
        .margin({ top: 4 })
    }
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
    .padding(32)
    .border({ width: 2, color: '#DDDDDD', style: BorderStyle.Dashed })
    .borderRadius(8)
    .backgroundColor('#FAFAFA')
  }
}

// 实际使用时的代码（需要完整的 Native 配置）
/*
XComponent({
  id: 'x_component_id',
  type: 'surface',
  libraryname: 'xcomponentdemo',  // 对应 libxcomponentdemo.so
  onload: (context) => {
    console.info('XComponent loaded:', context.xComponentId)
  },
  onDestroy: () => {
    console.info('XComponent destroyed')
  }
})
  .width('100%')
  .height(200)
*/
```

**开发建议：**
1. 先完成 ArkTS UI 部分，使用占位符
2. 配置 Native C++ 环境
3. 编写 .so 动态库
4. 最后集成 XComponent

### ⚠️ XComponent 独立为单独组件

**说明：**
在项目重构中，XComponent 已从 EmbeddedExample 中独立出来，作为单独的示例组件。

**原因：**
- EmbeddedExample 包含 EmbeddedComponent 和 XComponent 两个不同的组件
- XComponent 功能复杂，需要详细的 Native 配置说明
- 便于组织和维护

**新位置：**
- 示例文件：`ycomponent/src/main/ets/components/xcomponent/XComponentExample.ets`
- 路由名称：`XComponentExamplePage`

**EmbeddedComponent 说明：**
- 用于嵌入其他 Ability 或组件
- 需要配置 Want 对象
- 与 XComponent 是不同的组件

---

## 相关组件

- **EmbeddedComponent**: 用于嵌入其他 Ability 或组件
- **Web**: 用于嵌入 Web 内容
- **Canvas**: 用于 2D 绘图（纯 ArkTS）

## 参考链接

- [OpenHarmony 官方文档 - XComponent](https://developer.openharmony.cn/cn/docs/documentation/doc-references-V3/arkts-xcomponent.md)
- [Native API 参考](https://developer.openharmony.cn/cn/docs/documentation/doc-references-V3/native-api-.md)
- [OpenGL ES 开发指南](https://developer.openharmony.cn/cn/docs/documentation/doc-guides-V3/graphics-opengles-guide.md)
- [EGL API](https://www.khronos.org/egl/)
