#readme_GS:main_phase_retrieval_GS.m


##项目任务
利用角谱衍射理论，用GS算法实现对给定的目标强度，获得一张计算全息图，即相位恢复，实现用全息图恢复目标图像。

##程序结构
 |—readme_GS.txt      // help
 |—main_phase_retrieval_GS.m       // 主函数
 |——propagation_PSF.m  //衍射函数
 |——PSNR.m  //误差函数
 |——SSIM.m  //误差函数

##关键变量解释
--iteration_number  迭代次数
--intensity_target3 目标图像
--amplitude_target3 目标振幅
--intensity_input   入射平面波，振幅为1
--phase_hologram    全息图相位
--amplitude_target  R、G、B各层振幅
--phase             初始相位
--Uz                衍射后光复振幅
--estimate_input    预估入射复振幅

##运行环境及操作
###运行环境
 matlab R2020a
###运行操作
  直接运行主程序main_phase_retrieval_GS.m即可

##readme最后一次更新时间：2020/11/19

##作者：陈伟