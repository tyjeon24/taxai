import pandas as pd
EXCEL_FILE = "20220922 메타데이터 제작용 취득일 입력창 전처리.xlsx"
df = pd.read_excel(EXCEL_FILE)
df = df.fillna("")

def set_keys():
	df2 = df.drop_duplicates(subset=['취득원인', '취득시 종류', "양도시 종류", "분양권"])
	

	filter_dict = {}
	for i in range(len(df2)):
		d = df2.iloc[i]
		filter_dict[d["양도시 종류"]] = filter_dict.get(d["양도시 종류"], {})
		filter_dict[d["양도시 종류"]][d["취득원인"]] = filter_dict[d["양도시 종류"]].get(d["취득원인"], {})

		if d["분양권"]:
			filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]] = filter_dict[d["양도시 종류"]][d["취득원인"]].get(d["취득시 종류"], {})
			filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]][d["분양권"]] = {"metadata" : {}, "data" : []}
		else:
			filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]] = filter_dict[d["양도시 종류"]][d["취득원인"]].get(d["취득시 종류"], {"metadata" : {}, "data" : []})


	return filter_dict

filter_dict = set_keys()
for i in range(len(df)):
	d = df.iloc[i]
	if len(d["날짜계산법"])>2: # 날짜를 계산하는 경우 계산에 필요한 메타데이터 추가
		if d["분양권"]:
			data = filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]][d["분양권"]]
			filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]][d["분양권"]]["metadata"]["취득일계약일계산"] = filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]][d["분양권"]]["metadata"].get("취득일계약일계산", {"method" : d["날짜계산법"], "param1" : d["타겟날짜1"], "param2" : d["타겟날짜2"]})

		else:
			data = filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]]
			filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]]["metadata"] = filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]].get("metadata", {})
			filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]]["metadata"]["취득일계약일계산"] = filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]]["metadata"].get("취득일계약일계산", {"method" : d["날짜계산법"], "param1" : d["타겟날짜1"], "param2" : d["타겟날짜2"]})

	widget_data = {"keyValue" : d["입력"], "type" : d["타입"], "condition" : int(d["추가선택조건번호"])}
	if d["분양권"]:
		filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]][d["분양권"]]["data"].append(widget_data)
	else:
		filter_dict[d["양도시 종류"]][d["취득원인"]][d["취득시 종류"]]["data"].append(widget_data)

print(filter_dict)
import json
with open('filterMap.json', 'w', encoding='UTF-8-sig') as f:
    json.dump(filter_dict, f, ensure_ascii=False)