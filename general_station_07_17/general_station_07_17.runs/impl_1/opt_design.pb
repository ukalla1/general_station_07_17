
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
	xc7vx485t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
	xc7vx485t2default:defaultZ17-349h px? 
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px? 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px? 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px? 
U
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461h px? 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:02 ; elapsed = 00:00:02 . Memory (MB): peak = 2467.035 ; gain = 32.016 ; free physical = 267 ; free virtual = 30102default:defaulth px? 
g

Starting %s Task
103*constraints2,
Cache Timing Information2default:defaultZ18-103h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
P
;Ending Cache Timing Information Task | Checksum: 1829b38b6
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2475.035 ; gain = 8.000 ; free physical = 237 ; free virtual = 29802default:defaulth px? 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px? 
i

Phase %s%s
101*constraints2
1 2default:default2
Retarget2default:defaultZ18-101h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
K
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49h px? 
<
'Phase 1 Retarget | Checksum: 24fd0fb67
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:08 ; elapsed = 00:00:08 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 197 ; free virtual = 29412default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2
Retarget2default:default2
52default:default2
6842default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2
Retarget2default:default2
12default:defaultZ31-1021h px? 
u

Phase %s%s
101*constraints2
2 2default:default2(
Constant propagation2default:defaultZ18-101h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
H
3Phase 2 Constant propagation | Checksum: 2027e8ed2
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 197 ; free virtual = 29402default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2(
Constant propagation2default:default2
1742default:default2
13232default:defaultZ31-389h px? 
f

Phase %s%s
101*constraints2
3 2default:default2
Sweep2default:defaultZ18-101h px? 
9
$Phase 3 Sweep | Checksum: 2538766f2
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:09 ; elapsed = 00:00:10 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 195 ; free virtual = 29382default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2
Sweep2default:default2
02default:default2
9022default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2
Sweep2default:default2
412default:defaultZ31-1021h px? 
r

Phase %s%s
101*constraints2
4 2default:default2%
BUFG optimization2default:defaultZ18-101h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt22
feedback/clk0_bufgin_BUFG_inst2default:default2
02default:default2-
feedback/clk0_bufgin_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2^
Jtop_sub0/design_1_i/clk_wiz_0/inst/clk_out1_design_1_clk_wiz_0_0_BUFG_inst2default:default2
02default:default2Y
Etop_sub0/design_1_i/clk_wiz_0/inst/clk_out1_design_1_clk_wiz_0_0_BUFG2default:defaultZ31-194h px? 
W
!Inserted %s BUFG(s) on clock nets140*opt2
22default:defaultZ31-193h px? 
h
2Optimized connectivity to %s cascaded buffer cells194*opt2
12default:defaultZ31-274h px? 
E
0Phase 4 BUFG optimization | Checksum: 1cd88d168
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 194 ; free virtual = 29382default:defaulth px? 
?
EPhase %s created %s cells of which %s are BUFGs and removed %s cells.395*opt2%
BUFG optimization2default:default2
02default:default2
02default:default2
12default:defaultZ31-662h px? 
|

Phase %s%s
101*constraints2
5 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px? 
O
:Phase 5 Shift Register Optimization | Checksum: 2aeb217e5
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:11 ; elapsed = 00:00:12 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 195 ; free virtual = 29382default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2/
Shift Register Optimization2default:default2
02default:default2
02default:defaultZ31-389h px? 
x

Phase %s%s
101*constraints2
6 2default:default2+
Post Processing Netlist2default:defaultZ18-101h px? 
K
6Phase 6 Post Processing Netlist | Checksum: 24189ab1d
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 196 ; free virtual = 29402default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2+
Post Processing Netlist2default:default2
02default:default2
02default:defaultZ31-389h px? 
/
Opt_design Change Summary
*commonh px? 
/
=========================
*commonh px? 


*commonh px? 


*commonh px? 
?
z-------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Phase                        |  #Cells created  |  #Cells Removed  |  #Constrained objects preventing optimizations  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Retarget                     |               5  |             684  |                                              1  |
|  Constant propagation         |             174  |            1323  |                                              0  |
|  Sweep                        |               0  |             902  |                                             41  |
|  BUFG optimization            |               0  |               1  |                                              0  |
|  Shift Register Optimization  |               0  |               0  |                                              0  |
|  Post Processing Netlist      |               0  |               0  |                                              0  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px? 


*commonh px? 


*commonh px? 
a

Starting %s Task
103*constraints2&
Connectivity Check2default:defaultZ18-103h px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.06 ; elapsed = 00:00:00.06 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 196 ; free virtual = 29402default:defaulth px? 
J
5Ending Logic Optimization Task | Checksum: 294492470
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 198 ; free virtual = 29412default:defaulth px? 
a

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103h px? 
s
7Will skip clock gating for clocks with period < %s ns.
114*pwropt2
2.002default:defaultZ34-132h px? 
J
5Ending Power Optimization Task | Checksum: 294492470
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.03 ; elapsed = 00:00:00.04 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 199 ; free virtual = 29432default:defaulth px? 
\

Starting %s Task
103*constraints2!
Final Cleanup2default:defaultZ18-103h px? 
E
0Ending Final Cleanup Task | Checksum: 294492470
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 199 ; free virtual = 29432default:defaulth px? 
b

Starting %s Task
103*constraints2'
Netlist Obfuscation2default:defaultZ18-103h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2541.0352default:default2
0.0002default:default2
1992default:default2
29432default:defaultZ17-722h px? 
K
6Ending Netlist Obfuscation Task | Checksum: 294492470
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 2541.035 ; gain = 0.000 ; free physical = 199 ; free virtual = 29432default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
362default:default2
12default:default2
02default:default2
02default:defaultZ4-41h px? 
\
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
opt_design: 2default:default2
00:00:172default:default2
00:00:162default:default2
2541.0352default:default2
114.0202default:default2
1992default:default2
29432default:defaultZ17-722h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:002default:default2
2541.0352default:default2
0.0002default:default2
1992default:default2
29432default:defaultZ17-722h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:00.112default:default2
00:00:00.042default:default2
2541.0352default:default2
0.0002default:default2
1952default:default2
29422default:defaultZ17-722h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:002default:default2
2541.0352default:default2
0.0002default:default2
1932default:default2
29412default:defaultZ17-722h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2?
w/home/ukallakuri/hardware_design/designs/ARL_phase3/general_station_07_17/general_station_07_17.runs/impl_1/top_opt.dcp2default:defaultZ17-1381h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2&
write_checkpoint: 2default:default2
00:00:092default:default2
00:00:112default:default2
2541.0352default:default2
0.0002default:default2
1822default:default2
29292default:defaultZ17-722h px? 
?
%s4*runtcl2o
[Executing : report_drc -file top_drc_opted.rpt -pb top_drc_opted.pb -rpx top_drc_opted.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2b
Nreport_drc -file top_drc_opted.rpt -pb top_drc_opted.pb -rpx top_drc_opted.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
}/home/ukallakuri/hardware_design/designs/ARL_phase3/general_station_07_17/general_station_07_17.runs/impl_1/top_drc_opted.rpt}/home/ukallakuri/hardware_design/designs/ARL_phase3/general_station_07_17/general_station_07_17.runs/impl_1/top_drc_opted.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 


End Record