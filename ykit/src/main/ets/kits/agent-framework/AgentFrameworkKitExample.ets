/**
 * Agent Framework Kit 示例页面
 * 演示智能体框架功能
 */

import { agentFramework } from '@kit.AgentFrameworkKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 智能体信息
 */
interface AgentInfo {
  id: string
  name: string
  type: string
  status: string
}

/**
 * Agent Framework Kit 示例 ViewModel
 */
@ObservedV2
export class AgentFrameworkKitExampleVM {
  @Trace agents: AgentInfo[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isInitialized: boolean = false

  /**
   * 初始化智能体框架
   */
  async initializeFramework(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 智能体框架初始化逻辑
      this.isInitialized = true
      hilog.info(0x0000, 'AgentFrameworkExample', 'Framework initialized')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `初始化失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AgentFrameworkExample', 'Initialize failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 创建智能体
   */
  async createAgent(name: string, type: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const agent: AgentInfo = {
        id: `agent_${Date.now()}`,
        name: name,
        type: type,
        status: 'active'
      }

      this.agents.push(agent)
      hilog.info(0x0000, 'AgentFrameworkExample', `Agent created: ${name}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `创建失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AgentFrameworkExample', 'Create agent failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 执行智能体任务
   */
  async executeTask(agentId: string, task: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 执行任务逻辑
      hilog.info(0x0000, 'AgentFrameworkExample', `Task executed: ${task}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `执行失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AgentFrameworkExample', 'Execute task failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 清除智能体列表
   */
  clearAgents(): void {
    this.agents = []
    hilog.info(0x0000, 'AgentFrameworkExample', 'Agents cleared')
  }
}

/**
 * Agent Framework Kit 示例页面
 */
@ComponentV2
export struct AgentFrameworkKitExamplePage {
  @Local vm: AgentFrameworkKitExampleVM = new AgentFrameworkKitExampleVM()
  @Local agentNameInput: string = 'MyAgent'
  @Local agentTypeInput: string = 'assistant'
  @Local taskInput: string = ''

  build() {
    Column() {
      Text('智能体框架 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 初始化卡片
          this.buildInitCard()

          // 创建智能体卡片
          this.buildCreateAgentCard()

          // 智能体列表卡片
          this.buildAgentListCard()

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
  buildInitCard() {
    Column() {
      Text('框架状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isInitialized ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isInitialized ? '已初始化' : '未初始化')
          .fontSize(14)
          .fontColor(this.vm.isInitialized ? '#4CAF50' : '#999999')
      }

      Button('初始化框架')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.initializeFramework()
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildCreateAgentCard() {
    Column() {
      Text('创建智能体')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '智能体名称', text: this.agentNameInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.agentNameInput = value
        })

      TextInput({ placeholder: '智能体类型', text: this.agentTypeInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.agentTypeInput = value
        })

      Button('创建智能体')
        .width('100%')
        .enabled(!this.vm.isLoading && this.vm.isInitialized && this.agentNameInput.length > 0)
        .onClick(() => {
          this.vm.createAgent(this.agentNameInput, this.agentTypeInput)
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
  buildAgentListCard() {
    Column() {
      Row() {
        Text('智能体列表')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.vm.agents.length > 0) {
          Button('清除')
            .fontSize(12)
            .onClick(() => {
              this.vm.clearAgents()
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      if (this.vm.agents.length === 0) {
        Text('暂无智能体')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.agents, (agent: AgentInfo) => {
          Column() {
            Row() {
              Text(agent.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)

              Text(agent.status)
                .fontSize(12)
                .fontColor('#4CAF50')
            }
            .width('100%')

            Text(`类型: ${agent.type}`)
              .fontSize(12)
              .fontColor('#666666')
              .width('100%')
              .margin({ top: 4 })

            Text(`ID: ${agent.id}`)
              .fontSize(10)
              .fontColor('#999999')
              .width('100%')
              .margin({ top: 4 })
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ bottom: 8 })
          .alignItems(HorizontalAlign.Start)
        })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)

    if (this.vm.isLoading) {
      LoadingProgress()
        .width(40)
        .height(40)
        .margin({ top: 16 })
    }
  }
}

@Builder
export function AgentFrameworkKitExamplePageBuilder() {
  AgentFrameworkKitExamplePage()
}
