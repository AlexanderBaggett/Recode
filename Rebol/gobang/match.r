Rebol[]

;����ƥ���㷨
match: function [ord [integer!] lib [block!] turn [logic!] ] [len chance] [
	aim: copy trait                           ;������������
	either turn [                             ;��������˳��������������ģ������
		aim/:ord: aim/:ord + 0.1.0.0
	] [
		aim/:ord: aim/:ord + 1.0.0.0
	]
	len: length? aim
	tot-set: 0                                ;��ʼ��ƥ����������ʤ������ʤ��
	win-set: 0
	chance: 50
	
	foreach rp lib [                          ;��һ�ȶ�����������ʷ����
		mate: 0
		either turn [
			for i 1 len 1 [
				matchpix: aim/:i * rp/:i      ;ͨ���˷������ƥ������ӣ���ƥ�����������ڵ�ǰ��������˵����ȫƥ��
				mate: mate + matchpix/2 + matchpix/1
			]
			if (mate = index) [
				tot-set: tot-set + 1
			if (rp/1/4 = 0) [
				win-set: win-set + 1
			]
		]
		] [
			for i 1 len 1 [
				matchpix: aim/:i * rp/:i
				mate: mate + matchpix/1 + matchpix/2
			]
			
			if (mate = index) [
				tot-set: tot-set + 1
				if (rp/1/4 = 1) [
					win-set: win-set + 1
				]
			]
			
		]	
	]

	if (tot-set > 0) [
		chance: win-set / tot-set
		chance: round/to chance 0.01
		chance: to-integer (chance * 100)
	]
	
	return to-block reduce [chance tot-set]
]



