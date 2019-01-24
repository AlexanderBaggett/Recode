Rebol[]

mark: func [ t [tuple!] turn [logic!] ] [       ;���������ת��Ϊ�ַ�
	either (t/1 = 0) and (t/2 = 0) [
		return "0"
	] [
		either (t/1 = (to-integer turn)) [
			return "9"
		] [
			return "1"
		]
	]
]

val: function [ ord [integer!] turn [logic!] ] [ x y p mk value ] [
	x: mod (ord - 1) 15                                             ;�������������
	y: (round/ceiling ord / 15) - 1
	p: to-pair reduce[ x  y ]
	
	;----------------------------------------------------------
	bs-str: copy ""
	append bs-str "1"
	
	for z 1 4 1 [                                                   ;��ȡ��б�ܷ�����������
		either (( x - z) >= 0) and ((y - z) >= 0) [
			mk: mark qp/(to-pair reduce [ (x - z) (y - z) ]) turn
			insert bs-str mk
			if mk = "9" [break]
			
		] [
			insert bs-str "9"
			break
		]	
	]
	for z 1 4 1 [
		either (( x + z) <= 14) and ((y + z) <= 14) [
			mk: mark qp/(to-pair reduce [ (x + z) (y + z) ]) turn
			append bs-str mk
			if mk = "9" [break]
		] [
			insert bs-str "9"
			break
		]
	]
	
	;----------------------------------------------------------
	s-str: copy ""                                                ;��ȡб�ܷ�����������
	append s-str "1"
	
	for z 1 4 1 [
		either (( x - z) >= 0) and ((y + z) <= 14) [
			mk: mark qp/(to-pair reduce [ (x - z) (y + z) ]) turn
			insert s-str mk
			if mk = "9" [break]
		] [
			insert s-str "9"
			break
		]
	]
	for z 1 4 1 [
		either (( x + z) <= 14) and ((y - z) >= 0) [
			mk: mark qp/(to-pair reduce [ (x + z) (y - z) ]) turn
			append s-str mk
			if mk = "9" [break]
		] [
			insert s-str "9"
			break
		]
	]
	
	;----------------------------------------------------------
	h-str: copy ""                                            ;��ȡ������������
	append h-str "1"
	
	for z 1 4 1 [
		either (x - z) >= 0 [
			mk: mark qp/(to-pair reduce [ (x - z) y ]) turn
			insert h-str mk
			if mk = "9" [break]
		] [
			insert h-str "9"
			break
		]
	]
	for z 1 4 1 [
		either (x + z) <= 14 [
			mk: mark qp/(to-pair reduce [ (x + z) y ]) turn
			append h-str mk
			if mk = "9" [break]
		] [
			insert h-str "9"
			break
		]
	]
	
	;----------------------------------------------------------
	v-str: copy ""                                          ;��ȡ��������������
	append v-str "1"
	
	for z 1 4 1 [
		either (y - z) >= 0 [
			mk: mark qp/(to-pair reduce [ x (y - z) ]) turn
			insert v-str mk
			if mk = "9" [break]
		] [
			insert v-str "9"
			break
		]
	]
	for z 1 4 1 [
		either (y + z) <= 14 [
			mk: mark qp/(to-pair reduce [ x (y + z) ]) turn
			append v-str mk
			if mk = "9" [break]
		] [
			insert v-str "9"
			break
		]
	]
	
	;----------------------------------------------------------
	bs-str: rejoin ["9" bs-str "9"]                    ;���˼��Ͻ綨�ַ�
	s-str: rejoin ["9" s-str "9"]
	h-str: rejoin ["9" h-str "9"]
	v-str: rejoin ["9" v-str "9"]

	
	;��ֵ������򣺱߽����ֱ�ӽ������ӣ����Ӳ��Ƽ�ֵ
	;����ÿ�����Ӽ�ֵ+1������֮��ո�ÿ����ֵ-0.5
	;��¼��߼�ֵ���ܼ�ֵ����������ȡ��
	
	value: 0
	tot-value: 0
	v-rule: [
		( v: 0)
		[ some "9" 5 "1" (v: 10) | some "9" some "0" "1" (v: 1) | some "9" "1" (v: v - 1)  ]
		[	
			[ some "0" some "9" | some "9" (v: v - 1) ] |
			some [ "1" (v: v + 1 if v >= 5 [v: 10]) ] [ some "0" some "9" | some "9" (v: v - 1) ] |
			some [ 
				[ some "0" some "9" | some "9" (v: v - 1) ] |
				some [ "0" (v: v - 0.5 )] 
				some [ "1" (v: v + 1 if v >= 5 [v: 10]) ]
			]   	
		]
		(value: max value round/half-ceiling v tot-value: tot-value + v)
	]
	
	parse bs-str v-rule
	parse s-str v-rule
	parse h-str v-rule
	parse v-str v-rule 
	
	if (tot-value < 0) [ tot-value: 0 ]
	
	return to-pair reduce [ value tot-value]  ;������߼�ֵ���ܼ�ֵ
] 

