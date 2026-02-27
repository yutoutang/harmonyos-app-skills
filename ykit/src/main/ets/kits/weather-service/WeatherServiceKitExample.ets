/**
 * Weather Service Kit 示例页面
 * 演示天气服务功能
 */

import { weatherService } from '@kit.WeatherServiceKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 天气信息
 */
interface WeatherInfo {
  city: string
  temperature: number
  condition: string
  humidity: number
  windSpeed: number
}

/**
 * Weather Service Kit 示例 ViewModel
 */
@ObservedV2
export class WeatherServiceKitExampleVM {
  @Trace weatherInfo: WeatherInfo | null = null
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace cityInput: string = '深圳'

  /**
   * 获取天气信息
   */
  async getWeather(city: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 模拟天气数据
      this.weatherInfo = {
        city: city,
        temperature: 25,
        condition: '晴',
        humidity: 60,
        windSpeed: 3
      }
      hilog.info(0x0000, 'WeatherServiceExample', 'Weather obtained')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `获取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'WeatherServiceExample', 'Get weather failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 获取天气预报
   */
  async getForecast(city: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 获取天气预报逻辑
      hilog.info(0x0000, 'WeatherServiceExample', 'Forecast obtained')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `获取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'WeatherServiceExample', 'Get forecast failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Weather Service Kit 示例页面
 */
@ComponentV2
export struct WeatherServiceKitExamplePage {
  @Local vm: WeatherServiceKitExampleVM = new WeatherServiceKitExampleVM()
  @Local cityNameInput: string = '深圳'

  build() {
    Column() {
      Text('天气服务 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 查询天气卡片
          this.buildQueryCard()

          // 天气信息卡片
          if (this.vm.weatherInfo) {
            this.buildWeatherInfoCard()
          }

          // 错误信息
          if (this.vm.errorMessage) {
            Text(this.vm.errorMessage)
              .fontSize(14)
              .fontColor('#FF3B30')
              .margin({ top: 16 })
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildQueryCard() {
    Column() {
      Text('天气查询')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        TextInput({ placeholder: '城市名称', text: this.cityNameInput })
          .width('100%')
          .layoutWeight(1)
          .onChange((value: string) => {
            this.cityNameInput = value
          })

        Button('查询')
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading && this.cityNameInput.length > 0)
          .onClick(() => {
            this.vm.getWeather(this.cityNameInput)
          })
      }
      .width('100%')

      Button('查询预报')
        .width('100%')
        .margin({ top: 8 })
        .enabled(!this.vm.isLoading && this.cityNameInput.length > 0)
        .onClick(() => {
          this.vm.getForecast(this.cityNameInput)
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)

    if (this.vm.isLoading) {
      LoadingProgress()
        .width(40)
        .height(40)
        .margin({ top: 16 })
    }
  }

  @Builder
  buildWeatherInfoCard() {
    Column() {
      Text('天气信息')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 城市和温度
      Row() {
        Column() {
          Text(this.vm.weatherInfo!.city)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          Text(`${this.vm.weatherInfo!.temperature}°C`)
            .fontSize(48)
            .fontColor('#007DFF')
            .fontWeight(FontWeight.Bold)
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.vm.weatherInfo!.condition)
          .fontSize(36)
      }
      .width('100%')

      // 详细信息
      Divider().margin({ top: 16, bottom: 16 })

      Row() {
        Column() {
          Text('湿度')
            .fontSize(14)
            .fontColor('#666666')

          Text(`${this.vm.weatherInfo!.humidity}%`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text('风速')
            .fontSize(14)
            .fontColor('#666666')

          Text(`${this.vm.weatherInfo!.windSpeed} m/s`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Builder
export function WeatherServiceKitExamplePageBuilder() {
  WeatherServiceKitExamplePage()
}
