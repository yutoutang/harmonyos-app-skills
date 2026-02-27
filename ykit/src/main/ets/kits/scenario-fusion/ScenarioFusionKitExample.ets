/**
 * Scenario Fusion Kit 示例页面
 * 演示场景融合功能
 */

import { scenarioFusion } from '@kit.ScenarioFusionKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Scenario Fusion Kit 示例 ViewModel
 */
@ObservedV2
export class ScenarioFusionKitExampleVM {
  @Trace fusionEnabled: boolean = false
  @Trace currentScenario: string = '无'
  @Trace scenarios: string[] = ['办公', '出行', '家庭', '娱乐']
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启用场景融合
   */
  async enableFusion(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.fusionEnabled = true
      hilog.info(0x0000, 'ScenarioFusionExample', 'Fusion enabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ScenarioFusionExample', 'Enable failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 切换场景
   */
  async switchScenario(scenario: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.currentScenario = scenario
      hilog.info(0x0000, 'ScenarioFusionExample', `Scenario switched to ${scenario}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `切换失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ScenarioFusionExample', 'Switch failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Scenario Fusion Kit 示例页面
 */
@ComponentV2
export struct ScenarioFusionKitExamplePage {
  @Local vm: ScenarioFusionKitExampleVM = new ScenarioFusionKitExampleVM()

  build() {
    Column() {
      Text('场景融合 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 融合状态卡片
          this.buildFusionStatusCard()

          // 场景选择卡片
          if (this.vm.fusionEnabled) {
            this.buildScenarioCard()
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
  buildFusionStatusCard() {
    Column() {
      Text('场景融合状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.fusionEnabled ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.fusionEnabled ? '已启用' : '未启用')
          .fontSize(14)
          .fontColor(this.vm.fusionEnabled ? '#4CAF50' : '#999999')
      }

      Text(`当前场景: ${this.vm.currentScenario}`)
        .fontSize(14)
        .width('100%')
        .margin({ top: 8 })

      Button(this.vm.fusionEnabled ? '禁用融合' : '启用融合')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          if (this.vm.fusionEnabled) {
            this.vm.fusionEnabled = false
          } else {
            this.vm.enableFusion()
          }
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
  buildScenarioCard() {
    Column() {
      Text('场景选择')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

     ForEach(this.vm.scenarios, (scenario: string) => {
        Row() {
          Text(scenario)
            .fontSize(14)
            .layoutWeight(1)

          if (this.vm.currentScenario === scenario) {
            Text('当前')
              .fontSize(12)
              .fontColor('#4CAF50')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .backgroundColor('#E8F5E9')
              .borderRadius(4)
          }
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .margin({ bottom: 8 })
        .onClick(() => {
          this.vm.switchScenario(scenario)
        })
      })
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
export function ScenarioFusionKitExamplePageBuilder() {
  ScenarioFusionKitExamplePage()
}
