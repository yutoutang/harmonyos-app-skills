/**
 * Map Kit 示例页面
 * 演示地图显示、定位、标记等功能
 *
 * 权限要求:
 * - ohos.permission.LOCATION
 * - ohos.permission.APPROXIMATELY_LOCATION
 */

import { map, mapCommon, MapComponent } from '@kit.MapKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { geoLocationManager } from '@kit.LocationKit'
import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit'

/**
 * 地图选项
 */
interface MapOptions {
  mapType: mapCommon.MapType
  zoomLevel: number
  target: mapCommon.LatLng
}

/**
 * Map Kit 示例 ViewModel
 */
@ObservedV2
export class MapKitExampleVM {
  @Trace mapOptions: MapOptions = {
    mapType: mapCommon.MapType.STANDARD,
    zoomLevel: 10,
    target: { latitude: 39.9, longitude: 116.4 }
  }
  @Trace currentLocation: mapCommon.LatLng | null = null
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace markers: mapCommon.Marker[] = []

  /**
   * 初始化地图
   */
  async initializeMap(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      hilog.info(0x0000, 'MapKitExample', 'Map initialized successfully')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `地图初始化失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'MapKitExample', 'Initialize failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 获取当前位置
   */
  async getCurrentLocation(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const requestInfo: geoLocationManager.LocationRequest = {
        priority: geoLocationManager.LocationRequestPriority.FIRST_FIX,
        scenario: geoLocationManager.LocationRequestScenario.UNSET,
        timeInterval: 1,
        distanceInterval: 0,
        maxAccuracy: 0
      }

      const location = await geoLocationManager.getCurrentLocation(requestInfo)
      this.currentLocation = {
        latitude: location.latitude,
        longitude: location.longitude
      }

      this.mapOptions.target = this.currentLocation
      this.mapOptions.zoomLevel = 15

      hilog.info(0x0000, 'MapKitExample', 'Location obtained')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `获取位置失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'MapKitExample', 'Get location failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 添加标记
   */
  addMarker(position: mapCommon.LatLng, title: string): void {
    const marker: mapCommon.Marker = {
      position: position,
      markerId: Date.now(),
      title: title
    }
    this.markers.push(marker)
    hilog.info(0x0000, 'MapKitExample', 'Marker added')
  }

  /**
   * 清除标记
   */
  clearMarkers(): void {
    this.markers = []
    hilog.info(0x0000, 'MapKitExample', 'Markers cleared')
  }

  /**
   * 切换地图类型
   */
  switchMapType(mapType: mapCommon.MapType): void {
    this.mapOptions.mapType = mapType
    hilog.info(0x0000, 'MapKitExample', 'Map type switched')
  }

  /**
   * 设置缩放级别
   */
  setZoomLevel(level: number): void {
    this.mapOptions.zoomLevel = level
    hilog.info(0x0000, 'MapKitExample', 'Zoom level set')
  }
}

/**
 * Map Kit 示例页面
 */
@ComponentV2
export struct MapKitExamplePage {
  @Local vm: MapKitExampleVM = new MapKitExampleVM()
  mapController?: map.MapController

  aboutToAppear(): void {
    this.vm.initializeMap()
  }

  build() {
    Column() {
      // 标题
      Text('地图 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      // 地图容器
      Column() {
        MapComponent({
          mapOptions: this.vm.mapOptions,
          mapCallback: async (err, mapController) => {
            if (!err) {
              this.mapController = mapController
              hilog.info(0x0000, 'MapKitExample', 'Map ready')
            } else {
              this.vm.errorMessage = `地图加载失败: ${err.message}`
            }
          }
        })
          .width('100%')
          .height('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .clip(true)
      .borderRadius(12)
      .backgroundColor('#F0F0F0')

      // 控制面板
      Column() {
        // 功能按钮
        Row() {
          Button('获取位置')
            .enabled(!this.vm.isLoading)
            .onClick(() => {
              this.vm.getCurrentLocation()
            })

          Button('添加标记')
            .enabled(!this.vm.isLoading && this.vm.currentLocation !== null)
            .onClick(() => {
              if (this.vm.currentLocation) {
                this.vm.addMarker(this.vm.currentLocation, '当前位置')
              }
            })

          Button('清除标记')
            .enabled(!this.vm.isLoading)
            .onClick(() => {
              this.vm.clearMarkers()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 12 })

        // 地图类型切换
        Row() {
          Button('标准')
            .fontSize(12)
            .onClick(() => {
              this.vm.switchMapType(mapCommon.MapType.STANDARD)
            })

          Button('卫星')
            .fontSize(12)
            .onClick(() => {
              this.vm.switchMapType(mapCommon.MapType.SATELLITE)
            })

          Button('地形')
            .fontSize(12)
            .onClick(() => {
              this.vm.switchMapType(mapCommon.MapType.TERRAIN)
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

        // 缩放控制
        Row() {
          Button('放大')
            .onClick(() => {
              this.vm.setZoomLevel(Math.min(this.vm.mapOptions.zoomLevel + 1, 20))
            })

          Text(`缩放: ${this.vm.mapOptions.zoomLevel}`)
            .fontSize(14)
            .margin({ left: 16, right: 16 })

          Button('缩小')
            .onClick(() => {
              this.vm.setZoomLevel(Math.max(this.vm.mapOptions.zoomLevel - 1, 3))
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 12 })

        // 状态信息
        if (this.vm.currentLocation) {
          Text(`位置: ${this.vm.currentLocation.latitude.toFixed(4)}, ${this.vm.currentLocation.longitude.toFixed(4)}`)
            .fontSize(12)
            .fontColor('#666666')
            .margin({ top: 12 })
        }

        // 错误信息
        if (this.vm.errorMessage) {
          Text(this.vm.errorMessage)
            .fontSize(12)
            .fontColor('#FF3B30')
            .margin({ top: 8 })
        }

        // 加载指示器
        if (this.vm.isLoading) {
          LoadingProgress()
            .width(24)
            .height(24)
            .margin({ top: 8 })
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }
}

@Builder
export function MapKitExamplePageBuilder() {
  MapKitExamplePage()
}
