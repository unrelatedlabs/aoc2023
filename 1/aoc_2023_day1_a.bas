rem run in vice 64

2 acc = 0
5 fd$="0": ld$="0"
6 fd$="0": ld$="0"
10 input ": "; t$
15 print "> "; t$
16 if len(t$) = 0 then goto 110
20 l = len(t$)
30 for i = 1 to l
31 c$ = mid$(t$, i, 1)
40 if c$ >= "0" and c$ <= "9" then fd$ = c$
41 if c$ >= "0" and c$ <= "9" then goto 65
50 next
65 for j = l to 1 step -1
66 c$ = mid$(t$, j, 1)
75 if c$ >= "0" and c$ <= "9" then ld$ = c$
77 if c$ >= "0" and c$ <= "9" then goto 90
80 next
90 print "calibration value: "; fd$; ld$
96 acc = acc + val(fd$ + ld$)
97 print "acc: "; acc
100 goto 5
110 print "done"; acc
run
