Rebol[]

val-alg: function [ turn [logic!]] [thr value thr-blk val-blk most-thr most-val choice] [
	
	val-blk: copy []                              ;����ÿһ���ո������ӵļ�ֵ
	for i 1 225 1 [
		if (qp/:i/1 = 0) and (qp/:i/2 = 0) [
			value: val i turn
			append val-blk to-tuple reduce [value/1 value/2 i]
			if (value/1 >= 5) [return i]
		]
	]
	sort val-blk
	
	thr-blk: copy []                              ;����ÿһ���ո��·��ӵļ�ֵ��Ҳ����вֵ
	for i 1 225 1 [
		if (qp/:i/1 = 0) and (qp/:i/2 = 0) [
			thr: val i not turn
			append thr-blk to-tuple reduce [thr/1 thr/2 i]
			if (thr/1 >= 5) [return i]
		]
	]
	sort thr-blk
	
	most-val: pick val-blk (length? thr-blk)      ;ͨ��֮ǰ�����򣬻�ȡ��߼�ֵ�������вֵ
	most-thr: pick thr-blk (length? thr-blk)
	
	
	
	choice-blk: copy []
	random/seed now
												  ;������߼�ֵ�������вֵ������������Ӿ���
	either ((most-thr/1 > most-val/1) and (most-thr/1 >= 3)) or (index = 2) [
		for x (length? thr-blk) 1 -1 [
			either (thr-blk/:x/1 = most-thr/1) [
				if (thr-blk/:x/2 = most-thr/2) [
					append choice-blk thr-blk/:x
				]
				if (thr-blk/:x/2 > most-thr/2) [
					choice-blk: copy []
					append choice-blk thr-blk/:x
				]
			] [
				break
			]
		]
		choice: take random choice-blk
	] [
		for x (length? val-blk) 1 -1 [
			either (val-blk/:x/1 = most-val/1) [
				if (val-blk/:x/2 = most-val/2) [
					append choice-blk val-blk/:x
				]
				if (val-blk/:x/2 > most-val/2) [
					choice-blk: copy []
					append choice-blk val-blk/:x
				]
			] [
				break
			]
		]	
		choice: take random choice-blk              ;�������ֵ����ֵ����ȡ����ѡ�����ж��ѡ�����ѡȡ
	] 
	return choice/3
]


