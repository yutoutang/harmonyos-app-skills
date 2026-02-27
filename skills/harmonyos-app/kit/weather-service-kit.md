---
name: weather-service-kit
description: 天气服务 Kit，提供天气查询能力
---

# 天气服务 HarmonyOS 开发 Skill

## 概述

天气服务 Kit (WeatherServiceKit) 为 HarmonyOS 应用提供天气查询能力，支持实时天气、天气预报等。

## 重要说明

- **Kit 名称**: WeatherServiceKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import { weatherService } from '@kit.WeatherServiceKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| weatherService | Module | 天气服务模块 |

### 2.2 主要接口

#### weatherService.getWeather()

获取天气信息。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| location | Location | 是 | - | 位置信息 |

返回值: `Promise<WeatherInfo>`

## 三、使用示例

### 3.1 查询天气

```typescript
import { weatherService } from '@kit.WeatherServiceKit'

async function getWeather(): Promise<void> {
  try {
    const weather = await weatherService.getWeather({
      latitude: 39.9,
      longitude: 116.4
    })

    console.log('Temperature:', weather.temperature)
    console.log('Condition:', weather.condition)
  } catch (error) {
    console.error('Get weather failed:', error)
  }
}
```

## 四、最佳实践

1. **位置缓存**: 缓存位置信息减少请求
2. **数据更新**: 合理设置数据更新频率
3. **网络检测**: 网络异常时的降级处理

## 五、参考资料

- [天气服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/weather-introduction-V5)

---
## See Also
- [MapKit](kit/map-kit.md) - 地图服务
