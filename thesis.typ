#import "nju-thesis/template.typ": documentclass, tablex, fig, tlt, indent
#import "nju-thesis/utils/style.typ": 字号, 字体
#import "@preview/tablex:0.0.6": *

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
高质量芯片人才需要掌握计算机整体的软硬件理论知识与全程工程技术。既要在“学中做”，也要在“做中学” @ooicci 。
本文作者通过设计可运行基本操作系统的处理器芯片并完成投片。尝试贯穿芯片设计全链条，结合贯通计算机专业的诸多课程。
完成知识的有机融合，打通从数字电路、组成原理、体系结构、操作系统、嵌入式开发的全流程知识点。
]

#pagebreak()

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

#show figure.where(kind: "i-figured-raw"): it => {
    let dic = it.fields()
    let _ = if "body" in dic { dic.remove("body") }
    let _ = if "label" in dic { dic.remove("label") }
    let _ = if "counter" in dic { dic.remove("counter") }

  let fig = figure(text(par(it.body,justify: false,leading:0.65em),size: 12pt),
      ..dic,kind: "f" + repr(it.kind))
  fig
}

= 绪论

== 研究工作的背景与意义


世界正在加速转型进入数字经济时代。而做为数字化引擎的处理器芯片，则是一切的基石。虽然信息领域市场巨大，竞争强烈，
但十几年来却已经形成了“赢家通吃”的场面。高精尖技术与人才长期被把握在少数西方大公司的壁垒之中。

随着中美贸易环境的变化和技术封锁措施，一些中国企业和高校被列入美国政府的‘实体清单’，这对中国芯片技术研发和人才培养带来了显著影响。
目前，我国的计算机专业人才培养面临着较大的结构问题。顶层应用开发者过多，而底层软硬件研发人员缺乏。
特别是芯片设计人才严重不足。2022年间我国集成电路产业人才缺口达到3.5万#cite(<供需报告>)。
这与当前芯片设计门槛过高，导致中国大学无法开展芯片相关教学与研究密切相关#cite(<方法思考与实践>)。

晶体管性能高速提升的时代即将结束，半导体行业即将进入后摩尔时代。提升芯片性能与能效的压力逐渐转移到了架构设计师与电路设计师上#cite(<golden>)。
对领域特定架构（DSA）的需求日渐增加，产业界急需一种更加快速、灵活的研发方法和基础架构。

RISC-V(第五代精简指令集)是一款开源且免费的精简指令集架构。自从该指令集架构发布以来，在国内外吸引了许多关注。
中国工程院院士倪光南表示，RISC-V具有模块化、可扩展、易定制的优势，以及不受垄断制约、供应链安全容易保障的优势，
展基于RISC-V架构的DSA服务器是中国的机遇 @ngn-2023 @ngn-2024。

如今，已有来自70多个国家的3900多个实体加入了RISC-V联盟，其中高级成员有超过40%来自中国。
国内外越来越多的公司、组织和开发人员正在支持和贡献RISC-V。
包括芯片设计商、软件开发商、工具提供商以及三星电子、西部数据和英伟达等行业巨头。
开放的RISC-V架构鼓励了全球范围内的协作和技术创新，降低了进入壁垒，极大地促进学术界和创业公司在芯片设计领域的创新活动。
其开源免费、模块化、容易定制等特点，为我国芯片设计的发展带来了新的机遇。
有助于我国掌握核心关键技术的同时开放地对待国际交流与合作。

物联网时代的到来对处理器芯片提出了更多的需求。
RISC-V的模块化设计允许制造商根据特定应用场景进行裁剪或扩展，设计出高度优化的芯片解决方案，
降低功耗、提升性能并缩小芯片面积，进而降低成本。从而满足物联网行业中多样化、碎片化的市场需求。
同时，
鉴于物联网设备数量庞大且分布广泛，其安全问题愈发凸显。RISC-V因其透明的架构设计，有利于定制深度的防御策略，确保从硬件层面强化安全特性。
诸如“港华芯” @v5 这样的RISC-V物联网安全芯片的成功案例表明，RISC-V能够有效应对物联网安全挑战，并在能源、智慧城市等多个领域实现关键突破。

== 国内外研究现状


RISC-V指令集具有简洁，现代的特点，自2010年推出以来，受到了国内外的广泛关注。
很多高校和企业都开始基于RISC-V指令集设计设计了各式的处理器核。

在国际上，伯克利大学基于RISC-V指令集，使用Chisel语言构建来开源的SoC生成器，Rocket Chip @rocket 。由伯克利大学的研究团队于2012年推出。该生成器支持生成有序执行内核（Rocket）与乱序执行内核（Boom），还支持指令集扩展，协处理器等功能。
用户通过配置文件描述设计后，Rocket Chip生成器可以自动挑选所需的模块组合到设计中。

Tenstorrent公司通过组合大量精简的RISC-V核，使用片上网络技术，实现根据负载动态开关，在降低功耗的同时支持大规模的AI加速计算。

在国内，睿思芯科仅用了7个月的时间 @rsxk ，就完成了一款基于RISC-V的64位可编程终端AI芯片。这相比传统芯片设计效率提高了大概三倍。


中科院香山团队在2021年成功设计并流片了第一版雁栖湖架构处理器。在28nm 的工艺节点下达到 1.3GHz 的频率。
而后在2023年成功设计并流片了第二版南湖架构处理器，在 14nm 工艺节点下频率达到 2GHz。
香山处理器的目标是成为面向世界的体系结构创新开源平台，基础能力、设施、流程的建立是香山处理器长期高质量发展的关键，
香山团队设计了丰富的基础工具支撑起了这一复杂度量级的敏捷验证流程。

中国科学院软件研究所发布基于RISC-V的开源笔记本电脑“如意BOOK”，搭载C910处理器，在openEuler操作系统上流畅运行钉钉、Libre Office等大型办公软件。

阿里巴巴旗下公司平头哥的玄铁RISC-V处理器核，5年间发布3个系列9款产品，覆盖高性能、高能效、低功耗等不同场景，在AI、5G通信、自动驾驶、金融等领域展开广泛应用创新，出货已超40亿颗。

算能公司于2023年推出的基于RISC-V处理器SG2042，主频2GHz，拥有64个核心， 达到高性能处理器梯队。

兆易创新生产的GD32V系列微控制器（MCU）也使用了RISC-V核心，广泛在国内嵌入式领域使用。



= 处理器架构与敏捷开发

== 指令集架构

=== 复杂指令集与精简指令集

指令集发明于1960年代， 当时 IBM 为了解决该公司不同计算机产品线的程序无法通用的情况。
推出了完全独立于硬件架构的指令集架构（ISA）这一概念。

在当时，程序员通常直接使用汇编语言进行开发。市场普遍认为指令集应当更加丰富，每条指令本身应该能实现更多功能。
因此，当时一些高级语言中常见的概念，如函数调用、循环、数组访问等都有直接对应的机器指令。
这使得早期的指令集均为复杂指令集（CISC）。

1980年开始，随着存储器成本大幅下降、指令数目持续增加、高级语言的普及，CISC的一些缺陷开始暴露。
指令利用率低、控制电路趋于复杂、研发周期过长、验证难度增加等  @theDawnofRisc 催生了对于精简指令集（RISC）的研究。

与CISC不同，RISC强调每条指令的功能单一化。通过指令的组合来完成复杂操作。
由于指令复杂程度下降，编译器更容易进行代码生成。同时节约的电路面积可以用于缓存或流水线等高级结构，
使得RISC获得了优秀的能效比。


== RISC-V 指令集

2010年，David Patterson等人出于教学目的，在仔细评估了市面上各类指令集后，发现它们都存在设计上的不足 @waterman2016design 。
决定重头开始，吸取指令集架构领域25年期间的经验教训。设计了一款新的开源指令集架构—— RISC-V。

RISC-V 指令编码格式如下

#fig(image("images/riscv_code_format.png", height: 14%) , caption: [RISC-V指令格式]) <inst_format>

#indent RISC-V指令编码尽可能将含义相同的数据放在指令的同一位置，简化了指令译码。
如：指令存在目标寄存器字段时，其一定在指令的[11,7]位。
指令存在立即数时，立即数的符号位一定在指令的[31]位从而使符号扩展与指令译码并行展开。
当立即数在指令中的位置被其他字段切断时，指令编码的设计使得切断后数位的排布在不同指令间尽可能重叠。
允许工程师使用更少的多路选择器实现立即数的提取，简化了电路设计。

=== RISC-V 指令集的优势


- 基础加扩展式的ISA： RISC-V架构以模块化的方式组合在一起，用户可以根据需求选择不同模块以满足不同场景的应用。

#fig(
  tlt(
    columns: 4,
    [RISC-V指令集],         [名称],     [指令数],   [描述], 
    rowspanx(4)[基础指令集], [RV32I],   [47],      [基本整数指令，寻址空间32位，必须实现],  
    (),                    [RV32E],   [47],      [指令同上，寄存器减少为16个，用于嵌入式领域],  
    (),                    [RV64I],   [59],      [整数指令，寻址空间位64位，包含RV32I],  
    (),                    [RV128I],  [71],      [整数指令，寻址空间位128位，包含RV64I],  
    rowspanx(5)[扩展指令集], [M],      [8],        [整数乘除法],  
    (),                    [A],      [11],       [原子存储指令],  
    (),                    [F],      [26],       [32位单精度浮点指令],  
    (),                    [D],      [26],       [64位双精度浮点指令],
    (),                    [C],      [46],       [高密度指令，长度为正常指令的一半]
    ),
  caption: [RISC-V 指令集模块（节选）],
) <rvExts>


- 紧凑的代码体积： 智能物联网产品对成本和存储空间通常较为敏感，RISC-V提供统一的指令压缩扩展，
 可以在同样的大小下存储更多指令，并且不对成本产生显著影响。

- 开放： 传统ISA高额的授权费和严格的使用限制对于学术界和初创企业来说是巨大的负担。
  而RISC-V是开源架构,其规范可公开获取,无需支付专利费或许可费，
  有助于减少行业依赖于少数专有指令集架构的风险，促进公平竞争和市场活力。

- 简洁： RISC-V在设计之初参考了大量现有ISA的经验与缺点，设计更加现代化，基础指令只有40余条。
 避免了对某一特定微架构的过度优化，允许研究者在不被各类复杂的兼容性需求约束的情况下，自由探索各类微架构设计。

- 灵活:RISC-V允许自定义和扩展指令集架构,使芯片设计师能够根据业务需求量身定制架构。
 这种灵活性使RISC-V在物联网设备到高性能计算系统等广泛应用领域都具有吸引力。

- 便于教育和研究:RISC-V作为简洁且现代的开源架构，使其成为体系结构教学与研究的绝佳平台。
  许多大学和学术机构已采用RISC-V进行教学,并开发创新的硬件和软件解决方案。

- 完整的软件支持：RISC-V提供完整的软件堆栈，编译器工具链以及继承开发环境和操作系统支持。



== 敏捷开发及应用

敏捷开发是一种现代软件开发方法论，它倡导迭代、增量开发，强调灵活性和响应变化的能力。
这种方法论源于对传统瀑布模型的反思与改进，后者往往在一个阶段结束后才转入下一个阶段，各个阶段间耦合度较高，且不易适应需求变更。
进而发展为项目延期，客户需求无法满足，甚至项目失败。

在敏捷开发中，项目被分解为一系列短周期（称为冲刺或迭代），每个周期专注于交付可用的产品增量。
团队在整个开发过程中持续集成、测试和交付，保证软件质量。
敏捷开发的核心价值观和原则体现在《敏捷宣言》#cite(<fowler2001agile>) 中，
包括重视个体和交互胜过流程和工具、可工作的软件高于详尽的文档、与客户协作并积极响应变化、以及持续交付并欢迎更改需求。

=== 敏捷开发的意义

与传统互联网时代相比，智能物联网时代（AIoT）的设备成本功耗受限，专用性强。
传统上追求性能和通用的计算芯片不再适用。需要根据细分领域的需求，软硬件件协同优化，深度定制领域专用处理器（XPU）。
以满足特定场景对于芯片的成本，性能与能效需求。 #cite(<bao_1>)

这将使不同AIoT设备对芯片的需求差异化、专一化、碎片化。
如果继续沿用传统的瀑布式开发流程，过长的芯片研发和上市时间显然无法满足海量AIoT设备的快速定制需要。


=== 芯片设计与敏捷开发

传统的芯片设计流程包含一个固定的 “代码冻结” 阶段，在此阶段之后，代码修订受到严格限制。
这就导致了后端物理设计团队的反馈不能及时有效地帮助前端架构团队改进设计。

而使用敏捷思想指导开发的芯片，在完成每一个功能点的编写后，前后端团队都会一起进行测试与验证。为快速改进设计提供了可能。

敏捷开发可大幅降低芯片的设计周期，并在市场需求变化时快速响应。通过敏捷开发，伯克利大学的研究团队成功在五年内开发并生产了11种不同的处理器芯片 #cite(<7436635>)。


=== 芯片行业的敏捷开发

在芯片设计领域中，敏捷开发意味着在设计初期就利用高级语言快速构建模拟器原型，软件的灵活性允许工程师快速尝试各种设计方案，
尽早获得反馈，并迅速迭代设计。
设计成熟后，敏捷开发流程允许团队在较短时间内将设计迁移到FPGA上进行验证和调试，
FPGA的高速和高准确性允许工程师在这一步运行完整的操作系统与测试程序。
同时与客户紧密合作，确保芯片设计能满足客户需求。
设计过程中，
设计完成后，可以通过电子设计自动化（EDA）工具对芯片电路的面积、功耗和时序进行细致的分析。
整个过程中，前端架构和后端物理团队同步协作，共同参与每次迭代的验证和优化，从而显著缩短了设计周期，提高了产品质量。

当芯片电路设计敲定后，就可以与晶圆厂对接，准备进行投片生产。

整个设计流程如 @fig:circle 所示。其前三步都可以通过敏捷开发大幅提高效率与质量。

#fig(image("images/circle.png", height: 38%) , caption: [芯片开发流程]) <circle>


== Chisel语言在芯片设计中的优势及其实现原理

目前，最流行的两种硬件定义语言（HDL）是Verilog和VHDL @vhdlverilog 。硬件工程师通过HDL描述硬件电路的具体行为与结构。
Verilog与VHDL最初都是为硬件仿真而创建的，后来才被用于综合。这些语言缺乏抽象能力，使得组件难以在项目之间重复使用。

Chisel #cite(<Chisel2012>) 是一种基于高级编程语言Scala @odersky2004overview 的新型硬件构造语言（HCL） 。由伯克利大学的研究团队于2012年推出。

Chisel在Scala中提供了各类硬件原语的抽象，使得工程师者可以用Scala类型描述电路接口，以Scala函数操作电路组件。
这种元编程可实现表现力强、可靠、类型安全的电路生成器，从而提高逻辑设计的效率和稳健性。而基于生成器的设计促进了模块在项目之间的重用。

需要说明的是，虽然Chisel具有许多传统硬件描述语言不具备的高级特性，但其还是一门硬件构造语言，而不是高层次综合。
Chisel代码在运行后会生成对应硬件的形式化描述，以寄存器传输语言灵活中间码（Flexible Intermediate Representation for RTL，FIRRTL）形式记录 #cite(<Li:EECS-2016-9>) 。

FIRRTL随后被输入硬件编译框架(Hardware Compiler Framework，HCF) CIRCT @circt2021。
经过多次递降变换（lowering transformations） @mlir2021，逐级去除高层次的抽象，最终输出优化后的底层RTL代码（如Verilog）。
使用HCF的好处之一是其内置了大量的优化器，可进行常量传播、共用表达式合并、不可达代码消除或向专用集成电路（ASIC）与现场可编程门阵列（FPGA）提供针对性的优化#cite(<8203780>) 。
这些特点使工程师能够更专注于逻辑功能的设计，从而显著提升设计效率与代码质量。

=== Chisel的优点

==== 开发高效

Chisel语言的高效主要体现在四个方面： 

- 信号整体连接： Chisel丰富的类型系统和连接功能。允许工程师以组件化的方式声明和连接多个信号线，并进行整体连接。
  从而简化了总线接口修改的工作流程。
  避免了在使用传统HDL开发时，修改总线需要手动更新多个模块的端口而产生潜在错误。

- 元编程： Chisel可以抽象出多份相似模块的共用部分,通过使用参数化的硬件模板，工程师可以创建出可复用的硬件库。
  有效减少了代码冗余。SystemVerilog虽然提供类似的功能，但仅用于验证 @SV不可综合代码，属于不可综合代码。

- 面向对象：Chisel中可以将常用的电路组件封装成类，并通过继承与派生的方式定义常用变体，便于代码重用，减少冗余。
  籍此，Chisel内置了大量的预定义组件供工程师使用。 以描述一个32位带使能端带复位的寄存器为例，
  @lst:d1_chisel @lst:d1_verilog 表明，Chisel实现不仅更加简短，并且明确表示了这个寄存器的行为。
  而Verilog实现需要工程师阅读Always块的内容才能确定该寄存器的行为。

  #fig(```scala
      val delay1_r = RegEnable(io.in, 0.U(32.W), io.enable)
      io.out := delay1_r
  ```,caption: [Chisel实现]) <d1_chisel>

  #fig(```verilog
      reg [31:0] delay1_r; 
      assign io_out = delay1_r; 
      always @(posedge clock) begin
        if (reset) begin 
          delay1_r <= 32'h0; 
        end else if (io_enable) begin 
          delay1_r <= io_in; 
        end
      end
  ```,caption: [Verilog实现]) <d1_verilog>

- 函数式：Chisel的函数式特性将允许工程师使用map或zip算子实现电路级联的批处理操作，可以简洁地描述数据流。
  如 @fig:functional 所示，级联的算子操作可以直接对应生成后的电路。
 与Verilog的数据流建模相比，工程师不再需要关心运算符优先级。

#fig(image("images/functional.png", height: 38%) , caption: [函数式操作与电路设计紧密对应]) <functional>

==== 代码质量更优

余子濠等人（2019）的研究 @标签化 指出。
在FPGA上，与经验丰富的专职工程师使用Verilog相比，经训练的本科生使用Chisel的高级特性开发同样功能一致的缓存模块。
无论能效、频率或资源占用，均优于Verilog实现，且代码可维护性优更优。

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

#indent 在开发速度方面，专职工程师使用Verilog，消耗至少6周完成开发。而另一位有Chisel经验的本科生则在3天内完成了所有工作，
而且代码长度显著短于前者。

而在芯片整体设计方面，吕治宽（2022）的研究@lzk 表明，使用两种语言开发同一微结构的RISC-V处理器。Verilog的时间消耗是Chisel的3倍。



= 处理器微架构设计与实现

本文将首先实现一个单发射，简单流水线，顺序执行的基本RV32E扩展处理器芯片微架构。

为方便拓展，本微架构流水级之间使用异步定时方式通信，通过握手信号控制数据是否流动。
每个流水级的行为只取决于自身和下游模块的状态, 流水级均可以独立工作。
通过这种设计，避免了对全局控制器的需求，进而简化添加指令和流水级的难度。
也为探索乱序执行做好了准备。

在逻辑上，为了方便优化，
本微架构分为以下几个基础单元： 取指单元，译码单元，执行单元，访存单元，写回单元。
处理器核的设计方案如 @fig:main_flow 所示。

#fig(image("images/main_flow.png"), caption: [处理器核设计]) <main_flow>

片上系统的设计如 @fig:soc 所示。

#fig(image("images/soc_1.png",height:25%), caption: [片上系统设计]) <soc>

== 信号握手


如 @fig:ready_valid 所示，每个基础单元均可以根据自身情况产生 "准备/有效（Ready / Valid）" 握手信号。
Valid标识模块当前的数据（Data）是否有效，Ready标识本模块是否能接收Data输入。
 
模块间遵循 @tbl:ready_valid_tbl 的语义进行传输握手。
此外，为防止数据丢失，当模块表示当前数据有效后，除非数据成功传输，否则不能撤销有效信号。
本级有效而下级忙的情况称为发生数据反压（Back pressure）

#fig(image("images/ready_valid.png", height: 15%), caption: [Ready / Valid 握手信号]) <ready_valid>

#fig(
  tlt(
    columns: 3,
    [下级Ready],  [本级Valid],     [数据传输行为],
    [有效],    [有效],  [数据成功传输至下级模块],
    [有效],    [无效], [当前数据无效 下级模块需等待],
    [无效], [有效],          [下级模块忙 本级需保持Data并等待],
    [无效], [无效],          [不发生数据传输],
    ),
  caption: [握手信号行为说明],
) <ready_valid_tbl>


== 取指单元

取指单元的总体架构如@fig:cpu_img0。

#fig(image("images/cpu_fetch.png", height: 25%) , caption: [取指单元总体架构]) <cpu_img0>


#indent 取指单元根据上一条指令的译码、执行结果修改程序计数器（PC），并取出下一条指令。
整个取值单元分成PC生成器及指令访存器。

=== PC生成器

PC生成器将根据当前处理器的状态以及指令来确定下一执行周期的程序计数器的值。
目前，程序计数器生成器支持以下行为：

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
    [条件跳转],  [pc],  [据结果选择], [sum_next_pc] ,[允许写入], //todo:RV的条件跳转是这样吗。确认一下
    [异常陷入],  [无关], [无关], [mtVec]       ,[允许写入],
    [异常返回],  [无关], [无关], [mePC ]       ,[允许写入],   
    [反压暂停],     [无关], [无关], [无关  ]       ,[禁止写入],        
    ),
  caption: [PC生成表],
) <next_pc_gen>


#fig(image("images/cpu_pc.png", height: 31%) , caption: [PC生成器结构]) <cpu_pc_structure>

=== 指令访存器

指令访存器的任务是根据当前PC，向处理器核内的AXI @axiSpecification 主机仲裁单元发起访存请求。其结构如@fig:imem_fsm  所示。
在复位后，指令访存控制器在`idle`状态等待有效的访存事务发生。收到访存请求后，按照@tbl:imem_fsm_tlb
的行为对取值器的输出端口进行操作。需要注意的是，该状态机的输出均来自寄存器。

由于AXI协议规定在读事务完成时不再保持数据有效信号。在读取完成后，指令执行中的若干周期，指令有效信号
将由状态机提供

#fig(image("images/inst-mem_stateMachine.png", height: 28%), caption: [取指状态机]) <imem_fsm>

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

#fig(image("images/inst-mem.png", height: 18%), caption: [指令访存器结构]) <imem>



== 译码单元

译码单元的任务是任务是根据当前指令，通过译码器产生各类控制信号；从寄存器组中读出数据。
#fig(image("images/cpu_decode.png", height: 30%) , caption: [取指单元总体架构]) <cpu_decode>

=== 译码器

译码器主要功能如下：

- 访问寄存器： 如@tbl:rvExts 所示， RISC-V指令集中，对于需要访问寄存器的指令，
   其寄存器编号均在指令的固定位置。
   为简化电路，译码器被设计为不对当前指令类型进行判断，固定将 24～20 与 19～15段的内容视为寄存器编号，进行寄存器访问。

- 立即数产生与符号扩展： 如@tbl:rvExts 所示， RISC-V指令集中，对于具有立即数的指令，
  无论立即数长度，其符号位固定位31位。
  为简化电路，符号扩展被设计为固定使用31位做为符号进行扩展，各下级模块由解码结果决定是否使用。
  在后续设计中，将根据时序报告决定是否将本部件移动到执行单元。

- 控制信号生成： 根据指令类型和具体指令操作。为下级模块提供控制信号。 

【要解释所有控制信号的用途吗？】

== 执行单元

执行阶段是微架构数据流的核心，如 @fig:cpu_execute 所示。其任务是根据译码单元产生的控制信号，对操作数进行逻辑运算。


#fig(image("images/cpu_execute.png", height: 30%) , caption: [执行单元总体架构]) <cpu_execute>

== 访存单元

访存单元是为了装载（LOAD）与储存（STORE）指令设计的。整体结构如 @fig:cpu_memory 所示。
为了提高流水线后各阶段的效率，设计时分析了LOAD/STORE指令的资源需求，
决定将CSR的读写合并于本模块内。

根据当前执行的指令不同，模块顶层的 Ready/Valid 生成器会选择旁路或使用来自数据访存器的 Ready/Valid 信号。

在执行访存指令时AluOut输出的是目标内存地址。

#fig(image("images/cpu_memory.png", height: 38%) , caption: [访存单元总体架构]) <cpu_memory>

=== 数据访存器


#fig(image("images/cpu_memory_exmem.png", height: 38%) , caption: [数据访存器架构]) <cpu_memory_exmem>



== 写回单元
 
写回单元负责将指令运行结果写入寄存器。

#fig(image("images/cpu_writeback.png", height: 28%) , caption: [写回单元总体架构]) <cpu_writeback>

== Chisel实现

本段节选了部分模块的具体实现代码，并说明Chisel对开发带来的便利与好处。

=== 顶层模块

在Verilog中，顶层模块通常充斥着大量的模块间连线与冗长的实例化端口连接。
人工编写不仅耗费时间，且容易出错。

如 @lst:code_zhengti 所示, 通过Chisel的整体连接，可以使用少量代码完成安全可靠的连接。

#fig(```scala
  class Top extends Module {
    val fetch     = Module(new Fetch)
    val decode    = Module(new Decode)
    val execute   = Module(new Execute)
    val memory    = Module(new Memory)
    val writeback = Module(new Writeback)

    fetch.io.out   <> decode.io.in
    decode.io.out  <> execute.io.in
    execute.io.out <> memory.io.in
    memory.io.out  <> writeback.io.in
    fetch.io.in    <> writeback.io.out
  }

```, caption: [顶层模块主要代码]) <code_zhengti>

=== 寄存器组

由于线束（Bundle）的存在，声明寄存器组的IO接口变得更加容易，且当Idu或Csr
增加新的控制寄存器组的信号时，不需要改动寄存器组的IO接口声明。

使用VecInit

#fig(```scala
class Reg extends Module {
  val io = IO(new Bundle {
    val fIdu  = Flipped(new IduRegBundle())
    val wValid = Input(Bool())
    val op1   = Output(UInt(32.W))
    val op2   = Output(UInt(32.W))
    val r10   = Output(UInt(32.W)) // for ebreak
    val mem   = Input(UInt(32.W))
    val csr   = Input(UInt(XLEN.W))
  })

  val regs = RegInit(VecInit(Seq.fill(16)(0.U(32.W))))
  io.r10 := regs(10) // for ebreak

  val wdata = Wire(UInt(XLEN.W))
  wdata := MuxLookup(io.fIdu.W.wdataSel, io.mem) {
    Seq(
      RegWdataSel.csr -> io.csr,
      RegWdataSel.mOut -> io.mem
    )
  }
  when(io.fIdu.W.wen === 1.U & io.wValid) {
    regs(io.fIdu.W.rd(3,0)) := wdata
  }

  io.op1 := regs(io.fIdu.R.rs1(3,0))
  io.op2 := regs(io.fIdu.R.rs2(3,0))

  regs(0) := 0.U
}

```, caption: [REG模块整体代码]) <code_reg>

=== 译码单元

译码单元关键部分代码节选如下。根据指令类型的不同，alu操作码由不同的子电路生成，
对应电路将指令码解析成不同的bundle。
再按照该类型指令的格式从bundle中提取所需信息，形成操作码。

#fig(```scala
  io.toAlu.aluOp := MuxLookup(opType, AluOpTypes.unknown) {
    Seq(
      Optypes.I -> opI(io.inst),
      ... ...
      Optypes.B -> opB(io.inst),
    )
  }
  def opB(inst: UInt) = {
    val i = inst.asTypeOf(new Inst_B_bundle)
    val r = WireDefault(AluOpTypes.unknown)
    switch(i.fun3) {
      is("b000".U) { r := AluOpTypes.eq  } //beq
      is("b001".U) { r := AluOpTypes.neq } //bne
      ... ...
      is("b101".U) { r := AluOpTypes.s_ge } //bge
    }
    r
  }
  def opI(inst: UInt) = {
    val i = inst.asTypeOf(new Inst_I_bundle)
    val r = WireDefault(AluOpTypes.unknown)
    when(opCode === Opcodes.LOAD) {
      switch(i.fun3) {
        is("b000".U) { r := AluOpTypes.add } //lb
        ... ...
        is("b101".U) { r := AluOpTypes.add } //lhu
      }
    }.elsewhen(opCode === Opcodes.JALR) {
      r := AluOpTypes.op1p4 //jalr
    }.otherwise {
      switch(i.fun3) {
        is("b000".U) { r := AluOpTypes.add } //addi
        is("b010".U) { r := AluOpTypes.s_less } //slti
        ... ...
        is("b111".U) { r := AluOpTypes.and } //andi
        is("b101".U) {
          switch(inst(31, 26)) { // srli, srai have unique I-type format
            is("b000000".U) { r := AluOpTypes.sr } //srli
            is("b010000".U) { r := AluOpTypes.s_sr } //srai
        }}}}
    r
  }
  ... ...
  class Inst_I_bundle extends Bundle {
    val imm11_0 = UInt((31 - 20 + 1).W)
    val rs1     = UInt((19 - 15 + 1).W)
    val fun3    = UInt((14 - 12 + 1).W)
    val rd      = UInt((11 - 7 + 1).W)
    val op      = UInt((6 - 0 + 1).W)
  }
```, caption: [译码单元代码节选]) <code_idu>

=== 算数逻辑单元

算数逻辑模块（ALU）的代码如 @lst:code_alu 所示。
通过使用枚举类型，代码可读性增加，ALU操作一目了然，代码可读性显著提高。
同时Chisel可以进行类型检查，防止使用错误的数据类型进行匹配。
使用MuxLookup则有效提高了代码密度。

#fig(```scala
object AluOpTypes extends ChiselEnum {
    val sub,add, and, xor, neq, ge,
    ... ...
    less, op1p4, unknown = Value
}
class Alu extends Module {
  ... ...
  io.out := 
   MuxLookup(io.fIdu.aluOp, 0.U(XLEN.W)) {
    Seq(
      AluOpTypes.sub  -> (op1 - op2),
      AluOpTypes.add  -> (op1 + op2),
      AluOpTypes.neq  -> (op1 =/= op2),
      AluOpTypes.less -> (op1 < op2),
      AluOpTypes.ge   -> (op1 >= op2),
      AluOpTypes.and  -> (op1 & op2),
      AluOpTypes.xor  -> (op1 ^ op2),
      ... ...
    )
  } 
}
```, caption: [ALU模块Chisel代码节选]) <code_alu>


=== AXI 读分用器

AXI 读分用器的代码展现了Chisel对可变端口与函数式编程的支持。

在 Verilog中，数目可变端口往往需要大量的generate语句块来实现具体操作，
工程师容易写出可读性差的代码。
Chisel中，搭配函数式编程，可变数量端口的操作不会引起太多整体代码的变化。
有助于工程师编写更加通用化的模块。
@lst:code_axidecoder 展示了本处理器总线部分的AXI 读分用器实现。
//NOTE：这里我把那些Vecinit去掉了。否则太长视觉效果不好
#fig(```scala
object AXIDecoder{
  val maps = Seq(DMap("h8000_0000".U, "h8800_0000".U), // SRAM
                 DMap("hA000_03F8".U, "hA000_03F8".U), // UART
                 DMap("hA000_0048".U, "ha000_004C".U), // RTC 
                 )
}
case class DMap(val begin: UInt, val end: UInt){
  def hit(addr: UInt):Bool = { addr >= begin && addr <= end }
}

class AXIReadDecoder(val n: Int) extends Module{
  val io = IO(new Bundle{
    val in = new AXIReadOnly
    val out = Vec(n, Flipped(new AXIReadOnly))
  })
  val decodedOH = Wire(UInt(n.W)) // One hot code
  val lastSelectedOH = RegEnable(decodedOH, 0.U(n.W), io.in.ar.arready)

  decodedOH := AXIDecoder.maps.map( _.hit( io.in.ar.araddr ) && 
                                    io.in.ar.arvalid )

  io.in.ar.arready := (decodedOH & io.out.map( _.ar.arready )).orR

  val lastSelected = OHToUInt(lastSelectedOH)
  io.in.r.exclude(_.rvalid) :<= io.out(lastSelected).r.exclude(_.rvalid)
  io.in.r.rvalid := ( lastSelectedOH & 
                      io.out.map(_.r.rvalid)
                    ).orR

  for((out, selected) <- io.out.zip(decodedOH.asBools)){
    out.ar.arvalid := selected
    io.in.ar.exclude(_.arvalid) :>= out.ar.exclude(_.arvalid)
    out.r.rready <> io.in.r.rready

  }
}
```, caption: [AXI 读分用器代码节选]) <code_axidecoder>

#indent AXI读分用器（AXIReadDecoder）是一种一对多信号分配器件，
当输入端请求AXI读操作时，根据操作的地址范围，将请求分配到合适的外设中，并记录当前选择。
本实现还可以根据实例化时提供的参数_n_决定输出端口数量。

_AXIDecoder.maps_ 按连线顺序保存了各个外设对应的地址。其独立于分用器主体代码外，
便于在开发过程中增加新的外设。

_decodedOH_ 使用独热码保存根据当前输入地址选择的输出端口号。它具有n位，对应n个端口。
在计算 _decodedOH_ 的代码中，
_AXIDecoder.maps.map(...)_ 会取出AXIDecoder.maps列表中的所有对象，逐一运行括号中指定的函数。
该函数会将当前输入地址araddr送入列表的各个成员的hit函数，
hit函数会根据输入和自身保存的地址范围返回是否命中。各结果分别和io.in.ar.arvalid进行与操作，
确保分用器只在输入地址有效时进行解码。

按照AXI标准，io.in.ar.arready会向主机汇报所选的外设是否准备完成。
其产生逻辑如下：1. 当前输入地址落在某个从机的地址范围内；
2.该从机准备完成 ； 3.当前输入地址有效 ； 
io.out.map(\_.ar.arready) 会从所有输出中选出arready端口，
并将其和_decodedOH_ 按位与。最终结果进行规约或操作，就可以生成符合语义的io.in.ar.arready

例如，主机发出了向属于UART外设地址的AXI读取请求，
当前SRAM，UART外设空闲，RTC外设正忙。
_decodedOH_ 与 io.in.ar.arready 的生成过程如 @fig:axidecode_OH 所示。

#fig(image("images/axidecode_OH.png", height: 28%) , caption: [选择UART时 独热码与有效信号的生成]) <axidecode_OH>

#indent 通过使用_zip_算子，输出信号端口使能独热码逐一对与输出端口对象绑定，一起进入循环体。
循环体内的代码则会将解码结果派发给各个输出接口所连接的外设。


= 验证

由于芯片生产费用高昂，所以在正式投片前， 需要进行严格的测试，确保功能正确。
本文采用软硬件协同的方式对芯片设计进行验证。首先在Linux下搭建了测试框架，
然后通过实际编译器产生的测试例，使用自动化测试平台批量测试。

== 验证流程

验证平台使用Makefile脚本，KConfig脚本，标准参考实现及以测试例组成。
整体验证流程如 @fig:test_flow 所示。

#fig(image("images/test_flow.png"), caption: [验证平台结构]) <test_flow>

#indent 测试开始前，Chisel代码经过CIRCT编译为Verilog代码。
并根据处理器芯片信号结构，设计C++测试台提供运行期间所需要的输入信号。
自制调试器可以记录调用栈，访存信息，在测试失败时辅助分析。
通过Verilator将前述代码生成为周期等价的仿真程序。
仿真分析可以读入编译好的测试程序，在执行时自动与标准参考实现进行比对。
若比对结果没有差异，表明当前设计功能正确。

== 硬件验证环境

接下来对验证流程中的主要模块进行讲解 

=== Difftest


 Difftest方法源于软件工程领域, 全称Differential Testing(差分测试)。
 其核心思想是: 对于根据同一规范的两种实现, 给定相同的有定义的输入, 它们的行为应当一致 @dft。
 在测试环境中，仿真环境每执行一条指令，都会让标准RISC-V模拟器_Spike_也执行一遍。
 通过对比两侧执行后的通用寄存器与控制寄存器即可判断Chisel实现是否正确。

=== Verilator

Verilator 是一款基于周期的开源 Verilog 仿真工具，可以将 Verilog 代码转化为 C++ 代码，继而编译成可执行文件，从而实现 Verilog 代码的仿真。它支持使用C++开发测试台，并能导出仿真期间的波形文件。

=== 自制调试器

为了最大限度地加速排错，作者在此期间也制作了一些专用调试工具。

- mtrace： 访存监视单元，支持监视指定内存区间的读/写活动。使用方法如附录 @fig:mtrace 所示。
- 单指令执行： 为验证通用性，模拟的存储器读写具有一个随机延迟。
  这导致单条指令的执行周期长度不确定。而传统的单步仿真不能适配这一点。
  为此，作者在测试台中设计了按指令为单位的执行方式，相关代码如附录 @fig:sdb_exec 所示。
- 调用栈分析：为了确定客户程序在仿真器上的执行情况，作者设计了调用栈分析模块。
  在仿真开始前，读取输入程序的符号表，确认所有函数的地址。
  当CPU进行跳转时，根据目标地址和指令形式区分函数调用与函数返回，生成调用栈。该模块可以识别尾递归。
- 波形分析器插件：波形产生后，指令只能以十六进制机器码的形式展示。不便于阅读。作者为波形分析器设计了一个插件。
  使用反汇编工具将机器码转换为易读的汇编指令。如@fig:after @fig:before 所示。相关代码已发布@wave。

  #fig(image("images/before.png",width: 80%), caption: [在波形软件中的原始显示]) <before>
  #fig(image("images/after.png",width: 80%), caption: [使用插件后可显示对应汇编]) <after>

- 自动化性能分析：为提高仿真效率，作者设计了专用于性能分析的Makefile脚本，
  可自动将仿真器编译为分析模式，运行测试程序并呈现可读的性能报告。相关代码如附录 @fig:make_prof 所示。

=== 仿真界面

  仿真环境支持自动运行或用户手动控制。@fig:fzjm 演示了仿真环境运行时的界面，
  在本演示中，用户通过 _si 5_ 要求仿真环境执行5条指令后显示当前的寄存器信息 _info r_。
  仿真器可以成功显示执行指令的反汇编，并以可读的方式输出当期的寄存器信息。


  #fig(image("images/npc-sdb.png",height: 30%), caption: [仿真界面演示]) <fzjm>

  #indent 仿真环境亦可设置断点或直接查看内存，方便开发者观察特定代码区间执行前后的变化。
 
  #fig(```C
volatile int fib[40] = {1, 1};
int main() {
  int i;
  for(i = 2; i < 40; i ++) {
    fib[i] = fib[i - 1] + fib[i - 2];
  }
  return 0;
}
  ```,caption:[简单斐波那契数列程序]) <fib>
 
  #indent 以@lst:fib 中所示的简单斐波那契数列程序为例，
  通过反汇编找出循环体内写入fib数组的指令后，设置断点_b 0x200000b8_，
  即可观察到该写入指令执行前后的内存变化，如@fig:ddts 所示。

  #fig(image("images/fib-debug.png",width:75%),caption:[断点调试]) <ddts>

== 软件验证环境

=== 抽象计算机

鉴于本文所设计的处理器是RISC-V架构，而整体开发环境搭建在X86_64平台中。
因此，为了验证处理器功能，需要使用交叉编译器，生成RISC-V的目标代码。

交叉编译指的是在当前编译平台下，编译能运行在其他平台下的程序。本文使用
_riscv64-linux-gnu-gcc_ 通过指定_march=rv32e_zicsr_ 约束编译器只生成RV32E指令。

由于当前设计的处理器性能较弱，且只能执行RISC-V的核心部分，无法运行现代操作系统。
本文使用了南京大学提供的abstract-machine @am （抽象计算机 简称：AM）框架做为裸机运行时环境。

AM将计算机功能分为以下层级

- 图灵机： 仅限于纯计算任务 （TRM）
- 冯诺伊曼机： 含有复杂的输入输出扩展（IOE）
- 批处理系统： 含有上下文管理能力(CTE)
- 分时多任务： 含有虚拟内存管理功能(VME)
- 多处理机： 含有多个硬件线程（MPE）

#indent 通过实现更加复杂的CPU功能，可以开启更多的AM层级，进而运行更多更复杂的程序。
而当CPU功能较弱时，则可以关闭一些AM层级，使得系统可以继续运行基础应用程序。
CPU提供硬件功能，AM提供运行时环境。

客户程序使用AM提供的统一接口，面向抽象的计算机体系进行编程，AM向客户程序屏蔽底层细节。
在本架构中，只要完成AM对某个环境的适配，为AM编写的程序就可以运行在其上。
如@fig:AM 所示。

#fig(image("images/AM.png",width:90%),caption:[AM整体层次]) <AM>

=== 适配抽象计算机

通过在硬件中实现某种机制，然后在AM中使用该机制填充相应的API。
就可以完成AM对该架构的一部分支持。AM大部分由C语言写成。 

由于CPU复位完成后不具备C语言的运行条件，需要使用汇编准备堆栈后才能进入AM。
启动脚本如 @lst:start 所示 。由以下几个步骤组成：
+ 清空帧寄存器
+ 设置栈指针到链接脚本指定的栈起始区
+ 跳转到 \_trm_init。进入C环境

#fig(```asm
.section entry, "ax"
.globl _start
.type  _start, @function

_start:
  mv s0, zero
  la sp, _stack_pointer
  jal _trm_init

```,caption:[start.S]) <start>

#indent 在进入C环境后，AM的需要完成以下操作

+ 实现基本字符输出函数 putch
+ 初始化串口输出
+ 调用客户程序主函数
+ 根据主函数返回值，向硬件发出停机指令。

#fig(```c
#define DEVICE_BASE 0x10000000
#define SERIAL_PORT (DEVICE_BASE + 0x0000000)

void uart_init(){
  outb(SERIAL_PORT + 3, 0b10000011); // 8N1 with Divisor Latch Access
  outb(SERIAL_PORT + 1, 0x00); // No interrupt
  outb(SERIAL_PORT + 0, 0x01); // Set Divisor
  outb(SERIAL_PORT + 3, 0b00000011); // 8N1 without Divisor Latch Access
}
void putch(char ch) {
  while((inb(SERIAL_PORT + 5) & 0b01000000) == 0){} // busy 
  outb(SERIAL_PORT, ch);
}
void halt(int code) {
  asm volatile("mv a0, %0; ebreak" : :"r"(code));
  while (1); // should not reach here
}
void _trm_init() {
  uart_init();
  int ret = main(mainargs);
  halt(ret);
}
```,caption:[trm.c]) <start2>




== 仿真分析

=== 运行测试

基础测试包括基本的算数运算、跳转、加载储存等指令。使用C语言编写，测试列表见 @tbl:basic_test

由@fig:basic_test_result 可见，CPU顺利通过基本测试

=== 特权指令集测试 

特权指令集使用yield-os进行测试。yield-os是一个具有3个内核线程的协作式操作系统。
线程需要调用`yield()`函数主动让出处理器，操作系统提供一个基本的上下文保护和任务切换。

#fig(image("images/cte_switch.png"), caption: [线程切换流程])


//==== 特权指令集实现


//=== 启动RT-thread

//== 性能分析





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


#if (twoside) {
  pagebreak() + " "
}

// 致谢
#acknowledgement[
  【有要求致谢】
  //感谢 NJU-LUG，提供 NJUThesis Typst 模板。
]


// 手动分页
#if (twoside) {
  pagebreak() + " "
}

#show: appendix

= 附录

#fig(image("images/Screenshot_mtrace.png", height: 32%), caption: [mtrace使用截图]) <mtrace>
#fig(image("images/sdb_exec.png", height:  40%), caption: [单指令执行相关代码]) <sdb_exec>
#fig(image("images/Screenshot_profile.png"), caption: [自动性能分析相关代码]) <make_prof>

#fig(tlt(
  columns: 4,
  repeat-header: true,
  
  [测试程序名称] , [测试内容], vlinex() , [测试程序名称] , [测试内容],
  [add],[普通加法], [add-longlong],[长加法],
  [bit],[位操作], [bubble-sort],[冒泡排序],
  [crc32],[循环冗余校验], [div],[软除法],
  [dummy],[空函数跳转], [fact],[阶乘],
  [fib],[斐波那契数列], [goldbach],[歌德巴赫猜想],
  [hello-str],[字符串输出], [if-else],[分支语句],
  [leap-year],[闰年],  [load-simple],[读内存],
  [load-store],[读写内存],  [matrix-mul],[矩阵乘法],
  [max],[大小比较],  [mersenne],[梅森数],
  [min3],[排列],  [mov-c],[写后读],
  [movsx],[32位写后读],  [mul-longlong],[长乘法],
  [pascal],[帕斯卡算法],  [prime],[素数],
  [quick-sort],[快速排序],  [recursion],[递归],
  [select-sort],[选择排序],  [shift],[移位计算],
  [shuixianhua],[水仙花数],  [simple],[1+1],
  [string],[字符串操作],  [sub-longlong],[长减法],
  [sum],[求和],  [switch],[switch语句],
  [to-lower-case],[小写转换],  [unalign],[不对齐访存],
  [wanshu],[完数],
), caption:[基本测试程序]) <basic_test>

#fig(image("images/basic_test.png",height : 47% ), caption: [基本测试结果]) <basic_test_result>

 
