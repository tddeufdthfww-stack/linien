# R44：Scope因子伴随缓存，移除数据通路32位精确case译码

输入代码R43 4038738/ae98f29（其RTL为R41 9479e4e），实际route−.578/−43.286ns、366端点，最终STA FAIL；R40仍是较好整体TNS对照。R43单靠复制后全局Scope set_dec[17]→adc_a_dat[11]/D仍9级，1.634logic+6.728route。R44不携入失败R42反馈KEEP，也不宣称自动继承R43物理优化。

1. 只改red_pitaya_scope.v：在原FCLK请求捕获沿同时对sys_wdata编码，d=0→zero=1/index0，d=2^k→zero0/indexk，其余含X/Z→zero0/index0；与wdata_o严格同cohort，忙/源复位时同样保持。
2. 在原ADC配置写set_dec的同一沿提交6位伴随缓存，与set_dec复位1对应zero0/index0。原32位set_dec/读回/decimation比较与全部CSR地址/热写/字节语义/触发/采样寄存器不变。
3. 原14位mean对d=0为raw，对2^k为(sum>>k)的低14位（旧16位part-select再截成14位），其余为sum低14位。新数据通路用5位barrel shift及zero标志；avg0仍raw，avg1仍mean，avg X/Z仍在d严格0时raw、其他sum低14。原helper保留不改，用独立冻结case+整数oracle检验实际新decoder+cached helper。
4. 原源码系统沿A捕获wdata，目标沿B捕获set_dec；新编码在A同时捕获、在B同时提交，故每个数据采样沿的cache=decode(当时set_dec)，包括配置写入沿仍读取旧值。新增平行metadata FF12位，不新增数据/反馈/CSR/Scope/触发串行周期；不能把并行寄存器数当新流水延迟。
5. 新native组合161872已知+3000X/Z与整数oracle，完整冻结R38 Scope/bridge四相位、全部配置/忙时变动/高位别名/非法未知地址/未知写数据/avgX-Z/协调复位、源/目标cohort断言；原Scope与其余14/25位/PID/IIR/AXI/CDC/真实CSR完整回归保持原样并重新执行。
6. 新综合、布局、实际route；实际查FCLK编码D/CE/R与Q→ADC缓存/配置、ADC缓存→数据的全部路径，CSR/XDC/输入SHA/CDC/DRC/覆盖。没有false/multicycle/降频，物理bundled-data安全仍须单独验证，不部署；失败保留，不直接合并保护基线。
