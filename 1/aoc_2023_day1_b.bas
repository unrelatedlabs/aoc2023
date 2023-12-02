
3 dim num$(9)
4 num$(1) = "one": num$(2) = "two": num$(3) = "three": num$(4) = "four"
5 num$(5) = "five": num$(6) = "six": num$(7) = "seven": num$(8) = "eight"
6 num$(9) = "nine"
7 num$(0) = "zero"

100 goto 1000

200 rem find first digit in arg$
210 numb = 0
221 ret=0
230 l = len(arg$)
232 for j = 1 to l
234 for i = 0 to 9
235 numb = i
250 if mid$(arg$, j,len(num$(i))) = num$(i) then ret = j: return 
255 if mid$(arg$, j,1) = mid$(str$(i),2,1) then ret = j: return 
260 next
270 next

300 rem first last digit in arg$
310 numb = 0
321 ret=0
330 l = len(arg$)
332 for x = 1 to l 
333 j = l + 1 - x
334 for i = 0 to 9
350 if mid$(arg$, j,len(num$(i))) = num$(i) then ret = j: numb = i: return
355 if mid$(arg$, j,1) = mid$(str$(i),2,1) then ret = j: numb = i: return
360 next
370 next
380 return

1000 acc = 0 
1010 input ": "; t$
1030 if len(t$) = 0 then goto 9000
1050 arg$ = t$
1060 gosub 200
1070 fd$ = str$(numb)
1080 rem print "first digit: "; fd$; "pos: "; ret
1090 arg$ = t$
1100 gosub 300
1110 ld$ = str$(numb)
1120 rem print "last digit: "; ld$; "pos: "; ret
1130 print "calibration value: "; fd$; ld$
1140 acc = acc + val(fd$ + ld$)
1150 print "accumulator: "; acc
1160 goto 1010
9000 print "done", acc
run
