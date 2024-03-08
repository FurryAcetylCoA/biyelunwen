#import "nju-thesis/template.typ": documentclass, tablex, fig, tlt, indent
#import "nju-thesis/utils/style.typ": 字号, 字体

// 双面模式，会加入空白页，便于打印
#let twoside = false
// #let twoside = true

#let (
  doc, preface, mainmatter, mainmatter-end, appendix,
  fonts-display-page, cover, decl-page, abstract, abstract-en, outline-page, list-of-figures, list-of-tables, notation, acknowledgement,
) = documentclass(
  // anonymous: true,  // 盲审模式
  twoside: twoside,  // 双面模式，会加入空白页，便于打印
  // 可自定义字体，先英文字体后中文字体，应传入「宋体」、「黑体」、「楷体」、「仿宋」、「等宽」
   fonts: (楷体: ("Times New Roman", "LXGW WenKai GB"),
           仿宋: ("Times New Roman", "Zhuque Fangsong (technical preview)")),

  info: (
    title: ("基于Chisel的精简指令集微处理器设计"),
    title-en: ("Chisel implementation of a RISC microprocessor"),
    grade: "20物联网02",
    student-id: "19125042040",
    author: "荀阳霖",
    department: "信息工程学院",
    major: "物联网工程",
    supervisor: ("王娜", "讲师"),
    submit-date: datetime.today(),
  ),
)

// 文稿设置
#show: doc

// 字体展示测试页
//#fonts-display-page()

// 封面页
#cover()

// 前言
#show: preface

// 中文摘要
#abstract(
  keywords: ("我", "就是", "测试用", "关键词")
)[
  写完再摘

  #indent 高效抽象的处理器芯片
硬件设计语言与工具.快速迭代的芯片设计与
系统级原型验证方法(敏捷开发)让开发硬件像开发软件那
么容易
]

// 英文摘要
#abstract-en(
  keywords: ("Dummy", "Keywords", "Here", "It Is")
)[
  English abstract
]

// 目录
#outline-page()

// 插图目录
//#list-of-figures()

// 表格目录
//#list-of-tables()

// 正文
#show: mainmatter

//使用外文缩写代替某一名词术语，首次出现时应在括号内注明其含义

= 绪论

== 研究工作的背景与意义


世界正在加速转型进入数字经济时代。而做为数字化引擎的芯片，则是这一切的基石。虽然信息领域市场巨大，竞争强烈
但十几年来却已经形成了“赢家通吃”

我国的计算机专业人才培养面临着较大的结构问题。主要体现在顶层应用开发者过多，而下层软硬件研发人员缺乏。特别是计算机处理器芯片设计人才严重不足。
在2008到2017年间，芯片架构研究优秀人才85%选择在美国就业，仅有 4%在中国就业，差距巨大。这与当前芯片设计门槛过高，导致中国大学无法开展芯片相关教学与研究密切相关#cite(<方法思考与实践>)。

而随着一种中国企业和高校被美国政府列入“实体清单” 【再想想这里怎么写，参考一下00icci那篇，参考一下 基于Verilog和chisel的乱序超标量....的开头】
  并且，从数量上来看【我忘记那个数量了，得去再看看报告】#cite(<供需报告>)

  晶体管性能高速提升的时代即将结束，半导体行业即将进入后摩尔时代。提升芯片性能与能效的压力逐渐转移到了架构设计师与电路设计师上#cite(<7436635>)

  目前，由于芯片开发周期长， 验证、流片成本高。【参考《问题与挑战》的引文1 举点例子出来】
  
  【这里不用开小标题】

  【介绍RiscV指令集，参考吕的文章，参考包老师的诸文章，bytefield可以派上用场】

= 处理器架构与敏捷开发 //working title

== 指令集架构




=== 复杂指令集与精简指令集

=== 物联网时代与精简指令集

== RISC-V 指令集架构

=== RISC-V 指令集架构的优势

=== RISV-V 指令集架构的格式


//TODO: 下面两段的开发者换成工程师，以区分软硬件

== 敏捷开发

传统上的软件开发通常会对整个项目制定一个规划，严格分阶段推进开发过程，称为瀑布式开发。
上一阶段成功完成后，才会移至下一阶段，每个阶段只和自己的上下游对接，其他各阶段之间缺乏业务交流，
这有可能导致细节疏漏、理解偏差，进而发展为项目延期，客户需求无法满足，甚至项目失败。

为了解决这个问题，一群软件工程师于2001年提出《敏捷开发宣言》 #cite(<fowler2001agile>) 。
重视小型、密集的多次迭代，以及对变化和新工具的使用
在实践上，敏捷开发通过以多周期、短增量的垂直形式完成工作。编码、测试和质量验证都必须在每一个周期进行一次。
将大项目拆解成小项目，从一个简单的原型开始，不断迭代开发，直至功能完备。

=== 敏捷开发的优点

传统流程的芯片开发存在 “代码冻结” 阶段，在此阶段后，除非设计出现严重问题，否则前端架构团队传递给后端物理团队的代码不能发生任何变化。
这就导致了后端团队的反馈不能及时有效地帮助上游团队改进设计。

而使用敏捷思想指导开发的硬件，在完成每一个功能点的编写后，前后端团队都会一起进行测试与验证。为快速改进设计提供了可能。

基于生成器的设计促进了模块在项目之间的重用。
敏捷开发可大幅降低处理器芯片的设计周期，并在市场需求变化时立即做出响应。通过敏捷开发，伯克利大学的研究团队成功在五年内开发并生产了11种不同的处理器芯片
#cite(<7436635>)。

=== 敏捷开发的意义

与传统互联网时代相比，智能物联网时代（AIoT）的设备成本功耗受限，专用性强。
传统上追求性能和通用的计算芯片不再适用。需要根据细分领域的需求，软硬件件协同优化，深度定制领域专用处理器（XPU）。
以满足特定场景对于芯片的成本，性能与能效需求。 #cite(<bao_1>)

这将使不同AIoT设备对芯片的需求差异化、专一化、碎片化。
如果继续沿用传统的瀑布式开发流程，过长的芯片研发和上市时间显然无法满足海量AIoT设备的快速定制需要。



== Chisel

目前，最流行的两种硬件定义语言（HDL）是Verilog和VHDL @vhdlverilog 。硬件工程师通过HDL描述硬件电路的具体行为与结构。
Verilog与VHDL最初都是为硬件仿真而创建的，后来才被用于综合。这些语言缺乏抽象能力，使得组件难以在项目之间重复使用。

Chisel #cite(<Chisel2012>) 是一种基于高级编程语言Scala @odersky2004overview 的新型硬件构造语言（HCL） 。由伯克利大学的研究团队于2012年推出。
Chisel在Scala中提供了各类硬件原语的抽象，使得开发者可以用Scala类型描述电路接口，以Scala函数操作电路组件。
这种元编程可实现表现力强、可靠、类型安全的电路生成器，从而提高逻辑设计的效率和稳健性。

需要说明的是，虽然Chisel具有许多传统硬件描述语言不具备的高级特性，但其还是一门硬件构造语言，而不是高层次综合语言。
Chisel代码在运行后会生成对应硬件的形式化描述，以FIRRTL（Flexible Intermediate Representation for RTL）语言记录 #cite(<Li:EECS-2016-9>) 。

FIRRTL随后被输入硬件编译框架CIRCT @circt2021。
经过多次降级变换（lowering transformations） @mlir2021，逐级去除抽象描述，最终输出优化后的RTL代码（如Verilog）。
使用HCL的好处之一是其内置了大量的优化器，可以进行常量传播、共用表达式合并、无效代码消除或向ASIC与FPGA提供针对性的优化#cite(<8203780>) 。
这使得工程师可以将更多精力放在逻辑功能上，进一步提升了开发效率和代码质量。

=== Chisel的优点

==== 开发高效

Chisel语言的高效主要体现在四个方面：  这里要么就稍微减少一点，然后把标签化的表4放进来

- 信号接口整体连接： Chisel丰富的类型系统允许开发者将多条线缆“打包”并做为整体声明、连接。
  使用Verilog语言开发时，若要对总线接口的成员进行改动，开发者必须对所有出现该接口的模块逐一手动修改，不仅复杂而且容易出错。
  SystemVerilog虽然提供类似的功能，但其端口定义不可嵌套，仍然无法达到良好的抽象程度。

- 元编程： Chisel可以抽象出多份相似模块的共用部分,通过使用参数化的硬件模板，工程师可以创建出可复用的硬件库。
  有效减少代码冗余，实现全局性的统一配置。SystemVerilog虽然提供类似的功能，但仅用于验证 @SV不可综合代码，属于不可综合代码。

- 面向对象：通过继承，工程师可以把Chisel中多个电路模块的共性抽提成一个父类。
  在实现具体模块时，只需通过继承的方式，就可以让模块自动拥有父类的所有特征。从而减少代码冗余，便于分层次设计。

- 函数式：Chisel将多种电路元素包装为自函子。通过使用map或zip算子进行批量级联操作，工程师可以简洁地描述数据流。
  如 @fig:functional 所示，级联的算子操作可以直接对应生成后的电路。与Verilog的数据流建模相比，工程师不再需要关心运算符优先级。

#fig(image("images/functional.png", height: 38%) , caption: [函数式操作很好可以很好地与电路对应]) <functional>

==== 代码质量更优

余子濠.等的研究 @标签化 指出。
在FPGA上，与经验丰富的专职工程师使用Verilog相比，经训练的本科生使用Chisel的高级特性开发同样功能一致的二级缓存模块。
无论是能效、频率还是资源占用，均优于Verilog实现。

#fig(
  tlt(
    columns: 3,
    [类型],        [Verilog], [Chisel],    
    [最高频率/MHz], [135],     [154],      
    [功耗/W],      [0.77],    [0.74], 
    [LUT 逻辑],    [5676],    [2594],
    [LUT RAM],    [1796],    [1492],    
    [触发器],      [4266],    [747],    
    [代码长度],    [618],     [155], 
    ),
  caption: [资源占用与性能对比],
) <verilogVSchisel>

#indent 在开发速度方面，专职工程师使用Verilog，消耗至少6周完成开发。而另一位有Chisel经验的本科生则在3天内完成了所有工作。

而在处理器整体设计方面，同一个人分别使用两种语言开发同一微结构的RISC-V处理器。Verilog的时间消耗是Chisel的3倍 @lzk。



= 处理器微架构设计与实现

本文将首先实现一个单发射，非流水线，顺序执行的基本RISCV32E【格式是这样吗？】处理器微架构。
在逻辑上，为了方便将来流水线化，本处理器分为以下几个基础单元： 取指单元，译码单元，运算单元，访存单元，写回单元
【这里放一张图，】 【可能要先介绍Ready/Valid接口】
【必须要介绍反压控制代替集中控制。否则后面没法展开】

== 取指单元

取指单元的总体架构如@fig:cpu_img0

#fig(image("images/cpu_fetch.png", height: 25%) , caption: [取指单元总体架构]) <cpu_img0>

其输入来自上一条指令的译码、执行结果。整个取值单元分成PC生成单元及指令访存单元。

=== PC(程序计数器)生成单元

PC生成单元将根据当前处理器的状态以及指令来确定下一执行周期的程序计数器的值。
目前，程序计数器生成单元支持以下行为：

+ 顺序执行
+ 普通跳转（不切换特权级）
+ 暂停执行 
+ 自陷指令——陷入
+ 自陷指令——返回

RISCV架构支持比较两个通用寄存器的值并根据比较结果进行分支跳转（B系列指令）。无条件跳转（J系指令），
也支持在异常发生时进入异常处理程序并返回。PC寄存器的结构如@fig:cpu_pc_structure 所示,其行为如@tbl:next_pc_gen 所示。

#fig(
  tlt(
    columns: 5,
    [类型],      [add1], [add2],  [next_pc]     ,[PC寄存器],
    [顺序执行],   [pc],   [4],    [sum_next_pc]  ,[允许写入],
    [无条件跳转],  [pc],  [立即数], [sum_next_pc] ,[允许写入],
    [条件跳转],  [pc],  [据结果选择], [sum_next_pc] ,[允许写入], //RV的条件跳转是这样吗。确认一下
    [异常陷入],  [无关], [无关], [mtVec]       ,[允许写入],
    [异常返回],  [无关], [无关], [mePC ]       ,[允许写入],   
    [反压暂停],     [无关], [无关], [无关  ]       ,[禁止写入],        
    ),
  caption: [PC生成表],
) <next_pc_gen>


#fig(image("images/cpu_pc.png", height: 28%) , caption: [PC单元结构]) <cpu_pc_structure>

=== 指令访存单元

指令访存单元的任务是根据当前PC，向处理器核内的AXI[插入引用？]主机仲裁单元发起访存请求。其结构如@fig:imem_fsm  所示。
在复位后，指令访存控制器【就是这个状态机】在`idle`状态等待有效的访存事务发生。在发生后，按照@tbl:imem_fsm_tlb
的行为对取值单元的输出端口进行操作。需要注意的是，该状态机的输出均来自寄存器。

由于AXI协议规定在读事务完成时不再保持数据有效信号。在读取完成后，指令执行中的若干周期，指令有效信号
将由状态机提供【是这样的吗。我要确认一下】

#fig(image("images/inst-mem_stateMachine.png", height: 28%), caption: [取指单元状态机]) <imem_fsm>

#fig(
  tlt(
    columns: 3,
    [状态名],  [说明],                             [离开条件],
    [idle],    [当前未在访问指令存储器],           [存储器AXI读握手成功],
    [waiting], [读请求已发出。等待指令存储器回复], [存储器回复数据],
    [sending], [向CPU下游部件提供指令码],          [下游部件汇报准备完成]
    ),
  caption: [取指单元状态机转移说明],
) <imem_fsm_tlb>

#fig(image("images/inst-mem.png", height: 18%), caption: [取指单元结构]) <imem>



== 译码单元

== 运算单元

    [异常返回],  [未定义], [未定义], [mePC ]       ,[允许写入],    == 访存单元

== 写回单元


== dasd


引用@tbl:timing-tlt1,引用@tbl:timing-tlt，以及引用图表时，表格、图片和代码分别需要加上 `tbl:`、`fig:` 和 `lst:` 前缀才能正常显示编号。以及这里使用 `fig` 函数替代原生 `figure` 函数以支持将 `tablex` 作为表格来识别。

#align(center, (stack(dir: ltr)[
  #fig(
    tlt(
      columns: 2,
      [药品],   [规格],
      [浓氨水],  [分析纯AR],
      [盐酸],   [分析纯AR],
      [钛酸四丁酯], [≥99.0%]
    ),
    caption: [三线表1],
  ) <timing-tlt1>
][
  #h(50pt)
][
  #fig(
    tlt(
      columns: 4,
      map-cells: cell => {
        if cell.y > 0 and cell.x > 0 {
        cell.content = {
          let text-color = if int(cell.content.text) < 5 {
            red.lighten(30%)
          } else {
            green
          }
          set text(text-color)
          strong(cell.content)
        }
      }
      cell
    },
      [t], [1], [2], [3],
      [y], [3], [4], [9],
      [3], [3], [17], [0],
    ),
    caption: [三线表 - 着色],
  ) <timing-tlt>
]))


== 插图

插图必须精心制作，线条均匀，图面整洁。插图位于正文中引用该插图字段的后面。每幅插图应有图序和图题，图序和图题应放在图位下方居中处


== 数学公式

可以像 Markdown 一样写行内公式 $x + y$，以及带编号的行间公式：

$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

引用数学公式需要加上 `eqt:` 前缀，则由@eqt:ratio，我们有：

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

#indent 图表和公式后的段落要用 `#indent` 手动缩进。同时，我们也可以通过 `<->` 标签来标识该行间公式不需要编号

$ y = integral_1^2 x^2 dif x $ <->

而后续数学公式仍然能正常编号。

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

== 参考文献

可以像这样引用参考文献：@wang2010guide 


== 代码块

```py
def add(x, y):
  return x + y
```


= 正文

== 正文子标题

=== 正文子子标题

正文内容


// 手动分页
#if (twoside) {
  pagebreak() + " "
}
// 参考文献
#bibliography(("bibs/ex01.bib", "bibs/ymlex.yml"),
  style: "./china-national-standard-gb-t-7714-2015-numeric.csl"
)



// 正文结束标志，不可缺少
#mainmatter-end()


// 手动分页
#if (twoside) {
  pagebreak() + " "
}

// 附录
#show: appendix

= 附录

== 附录子标题

=== 附录子子标题

附录内容，这里也可以加入图片，例如@fig:appendix-img。

#fig(
  image("nju-thesis/assets/vi/nju-emblem.svg", width: 20%),
  caption: [图片测试],
) <appendix-img>

// 手动分页
#if (twoside) {
  pagebreak() + " "
}

// 致谢
#acknowledgement[
  感谢 NJU-LUG，提供 NJUThesis Typst 模板。
]
