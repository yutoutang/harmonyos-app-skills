/**
 * Game Service Kit 示例页面
 * 演示游戏服务功能
 */

import { gameService } from '@kit.GameServiceKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Game Service Kit 示例 ViewModel
 */
@ObservedV2
export class GameServiceKitExampleVM {
  @Trace playerScore: number = 0
  @Trace achievements: string[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isSignedIn: boolean = false

  /**
   * 玩家登录
   */
  async signIn(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isSignedIn = true
      hilog.info(0x0000, 'GameServiceExample', 'Player signed in')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `登录失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'GameServiceExample', 'Sign in failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 提交分数
   */
  async submitScore(score: number): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.playerScore = score
      hilog.info(0x0000, 'GameServiceExample', 'Score submitted')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `提交失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'GameServiceExample', 'Submit failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 解锁成就
   */
  async unlockAchievement(achievement: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.achievements.push(achievement)
      hilog.info(0x0000, 'GameServiceExample', 'Achievement unlocked')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `解锁失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'GameServiceExample', 'Unlock failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Game Service Kit 示例页面
 */
@ComponentV2
export struct GameServiceKitExamplePage {
  @Local vm: GameServiceKitExampleVM = new GameServiceKitExampleVM()
  @Local scoreInput: string = '100'
  @Local achievementInput: string = '新手玩家'

  build() {
    Column() {
      Text('游戏服务 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 登录卡片
          this.buildSignInCard()

          // 分数卡片
          if (this.vm.isSignedIn) {
            this.buildScoreCard()

            // 成就卡片
            this.buildAchievementCard()
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
  buildSignInCard() {
    Column() {
      Text('玩家登录')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isSignedIn ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isSignedIn ? '已登录' : '未登录')
          .fontSize(14)
          .fontColor(this.vm.isSignedIn ? '#4CAF50' : '#999999')
      }

      Button('登录')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading && !this.vm.isSignedIn)
        .onClick(() => {
          this.vm.signIn()
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
  buildScoreCard() {
    Column() {
      Text('分数提交')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(`当前分数: ${this.vm.playerScore}`)
        .fontSize(14)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '分数', text: this.scoreInput })
        .width('100%')
        .type(InputType.Number)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.scoreInput = value
        })

      Button('提交分数')
        .width('100%')
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          const score = parseInt(this.scoreInput) || 0
          this.vm.submitScore(score)
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildAchievementCard() {
    Column() {
      Text('成就系统')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '成就名称', text: this.achievementInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.achievementInput = value
        })

      Button('解锁成就')
        .width('100%')
        .enabled(!this.vm.isLoading && this.achievementInput.length > 0)
        .onClick(() => {
          this.vm.unlockAchievement(this.achievementInput)
        })

      if (this.vm.achievements.length > 0) {
        Text('已解锁成就:')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ top: 16, bottom: 8 })

       ForEach(this.vm.achievements, (achievement: string, index: number) => {
          Text(`${index + 1}. ${achievement}`)
            .fontSize(14)
            .width('100%')
            .padding(8)
            .backgroundColor('#F5F5F5')
            .borderRadius(4)
            .margin({ bottom: 4 })
        })
      }
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
export function GameServiceKitExamplePageBuilder() {
  GameServiceKitExamplePage()
}
