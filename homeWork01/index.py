import csv
from collections import Counter,defaultdict
from operator import attrgetter,itemgetter
import pathlib
from pathlib import Path  


csv.field_size_limit(100000000)

path = Path('data', 'vacancy.csv')

vacancy = list(csv.DictReader(open(path, encoding = "utf-8")))
likeVacancy=[row for row in vacancy if row ['vactitle']=='Data analyst']
print('likeVacancy')
print(len(likeVacancy))
print()

s = sorted(likeVacancy, key=itemgetter('vacdate'))
print('sorted date likeVacancy')
print(likeVacancy[0]['vacdate'])
print(likeVacancy[1]['vacdate'])
print()

myVacancy=[row for row in vacancy if row ['vactitle']=='Специалист по взысканию задолженности']
print('myVacancy')
print(len(myVacancy))
print()

analitic=[row for row in vacancy if row['vactitle'].lower().find('аналитик данных') != -1]
print('analitiс')
print(len(analitic))
print()

analiticPython=[row for row in vacancy if row['vacdescription'].lower().find('python') != -1 and row['vactitle'].lower().find('аналитик данных') != -1]
print('analiticPython')
print(len(analiticPython))


# вывод всех вакансий
# vac=Counter(row['vactitle']for row in vacancy)
# print(vac.most_common(4003))
