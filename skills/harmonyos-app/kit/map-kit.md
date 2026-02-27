---
name: map-kit
description: 地图服务 Kit，提供地图展示、定位、导航等功能
---

# 地图服务 HarmonyOS 开发 Skill

## 概述

地图 Kit (MapKit) 为 HarmonyOS 应用提供完整的地图服务解决方案。包括地图展示、位置搜索、路线规划、场景地图、静态地图等功能。

## 重要说明

- **Kit 名称**: MapKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  mapCommon,
  map,
  MapComponent,
  staticMap,
  site,
  navi,
  sceneMap,
  petalMaps
} from '@kit.MapKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| mapCommon | Module | 地图通用模块 |
| map | Module | 地图核心模块 |
| MapComponent | Component | 地图组件 |
| staticMap | Module | 静态地图模块 |
| site | Module | 位置搜索模块 |
| navi | Module | 导航模块 |
| sceneMap | Module | 场景地图模块 |
| petalMaps | Module | 花瓣地图模块 |

### 2.2 主要接口

#### MapOptions

地图配置选项。

| 属性 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| mapType | MapType | 否 | NORMAL | 地图类型 |
| zoomLevel | number | 否 | 10 | 缩放级别 |
| center | Coordinate | 否 | - | 中心点坐标 |

## 三、使用示例

### 3.1 显示基础地图

```typescript
import { map, MapComponent, mapCommon } from '@kit.MapKit'

@Entry
@ComponentV2
struct MapExamplePage {
  @State mapOptions: mapCommon.MapOptions = {
    mapType: mapCommon.MapType.NORMAL,
    zoomLevel: 12,
    center: { latitude: 39.9, longitude: 116.4 }
  }

  build() {
    MapComponent({
      mapOptions: this.mapOptions
    })
      .width('100%')
      .height('100%')
  }
}
```

### 3.2 添加标记点

```typescript
import { map, mapCommon } from '@kit.MapKit'

async function addMarker(): Promise<void> {
  const marker = new map.Marker({
    position: { latitude: 39.9, longitude: 116.4 },
    title: '标记点',
    snippet: '这是一个标记点'
  })

  // 添加到地图
  // mapController.addMarker(marker)
}
```

### 3.3 位置搜索

```typescript
import { site } from '@kit.MapKit'

async function searchLocation(keyword: string): Promise<void> {
  try {
    const result = await site.search({
      keyword: keyword,
      city: '北京'
    })

    console.log('Search results:', result.sites)
  } catch (error) {
    console.error('Search failed:', error)
  }
}
```

### 3.4 路线规划

```typescript
import { navi } from '@kit.MapKit'

async function planRoute(): Promise<void> {
  try {
    const route = await navi.calculateRoute({
      origin: { latitude: 39.9, longitude: 116.4 },
      destination: { latitude: 39.92, longitude: 116.42 },
      mode: navi.RouteMode.DRIVING
    })

    console.log('Route distance:', route.distance)
  } catch (error) {
    console.error('Route planning failed:', error)
  }
}
```

## 四、最佳实践

1. **权限管理**: 使用前确保已获取位置权限
2. **地图生命周期**: 正确管理地图组件的生命周期
3. **性能优化**: 合理设置缩放级别，避免过度渲染
4. **用户隐私**: 遵守位置数据使用规范
5. **离线支持**: 考虑离线地图场景

## 五、常见问题

### Q: 地图不显示怎么办？

A: 检查网络连接、API 密钥配置和权限设置。

### Q: 如何自定义地图样式？

A: 使用 `mapOptions` 配置或自定义地图样式文件。

### Q: 路线规划支持哪些方式？

A: 支持驾车、步行、骑行等多种导航方式。

## 六、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.LOCATION | 位置权限 |
| ohos.permission.APPROXIMATELY_LOCATION | 大致位置权限 |
| ohos.permission.INTERNET | 网络权限 |

## 七、参考资料

- [地图服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/map-introduction-V5)

---
## See Also
- [AccountKit](kit/account-kit.md) - 华为账号
- [ShareKit](kit/share-kit.md) - 分享服务
