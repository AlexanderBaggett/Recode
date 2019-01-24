Rebol[]

qp-blk: []                      ;�����������ײ�����һ��block��
dir: read %./qp/
cd %./qp/
foreach f dir [
	qpimg: load f
	append qp-blk qpimg
]
cd %..

chance-alg: function [ turn [logic!]] 
	[thr value thr-blk val-blk most-thr most-val choice choice-blk chance-blk pix rs] [
	
	val-blk: copy []            ;����ͨ����ֵ�㷨ѡ����ֵ��ߵ�����λ��
	for i 1 225 1 [
		if (qp/:i/1 = 0) and (qp/:i/2 = 0) [
			value: val i turn
			append val-blk to-tuple reduce [value/1 value/2 i]
			if (value/1 >= 5) [ 
				val-blk: copy []
				append val-blk to-tuple reduce [value/1 value/2 i]
				break
			]
		]
	]
	sort val-blk
	
	thr-blk: copy []
	for i 1 225 1 [
		if (qp/:i/1 = 0) and (qp/:i/2 = 0) [
			thr: val i not turn
			append thr-blk to-tuple reduce [thr/1 thr/2 i]
			if (value/1 >= 5) [ 
				thr-blk: copy []
				append thr-blk to-tuple reduce [thr/1 thr/2 i]
				break
			]
		]
	]
	sort thr-blk

	most-thr: pick thr-blk (length? thr-blk)
	most-val: pick val-blk (length? thr-blk)
	
	choice-blk: copy []
	
	either (most-thr/1 > most-val/1) and (most-thr/1 >= 3) or (index = 2) [
		for x (length? thr-blk) 1 -1 [
			either (thr-blk/:x/1 = most-thr/1) [
				append choice-blk thr-blk/:x
			] [
				break
			]
		]
	
	] [
		for x (length? val-blk) 1 -1 [
			either (val-blk/:x/1 = most-val/1) [
				append choice-blk val-blk/:x
			] [
				break
			]
		]
	]

	chance-blk: copy []                            ;�ж����߼�ֵ���·���ͨ������ʷ����ƥ�䣬ѡ��ʤ�ʸߵ��·�
	for x 1 (length? choice-blk) 1 [
		either (not error? try [ t3/text ]) and ( t3/text = none ) [
			append chance-blk to-tuple reduce [50 0 choice-blk/:x/1 choice-blk/:x/2 choice-blk/:x/3]
		] [
			m: match choice-blk/:x/3 qp-blk turn
			append chance-blk to-tuple reduce [m/1 m/2 choice-blk/:x/1 choice-blk/:x/2 choice-blk/:x/3]
		]
	]
	
	choice-blk: copy []
	sort chance-blk                                 ;ʤ��һ�µ���ͨ���ܼ�ֵ����ɸѡ
	most-chance: pick chance-blk (length? chance-blk)
	for x (length? chance-blk) 1 -1 [
		either ( chance-blk/:x/1 = most-chance/1) [
			if ( chance-blk/:x/4 = most-chance/4) [
				append choice-blk chance-blk/:x
			]
			if ( chance-blk/:x/4 > most-chance/4) [
				choice-blk: copy []
				append choice-blk chance-blk/:x
			]
		] [
			break
		]
	]
	
	random/seed now
	pix: random length? choice-blk
	rs: pick choice-blk pix
	return rs
]


