#!/usr/bin/env python

import sys
import requests
import datetime

def checkImport():
    try:
        import xlwt
    except ImportError:
        print("please run `pip install xlwt` first")
        exit(-1)

def main():
    if len(sys.argv) < 2:
        print("usage:%s appstore_id" % sys.argv[0])
        exit(-1)

    url = "https://itunes.apple.com/cn/rss/customerreviews/id=%s/sortBy=mostRecent/json" % sys.argv[1]
    print("get reviews: %s" % url)
    req = requests.get(url)
    data = req.json()
    # print(data)

    import xlwt

    workbook = xlwt.Workbook(encoding = 'utf8')
    worksheet = workbook.add_sheet('sheet1', cell_overwrite_ok=True)
    worksheet.write(0, 0, label = '用户')
    worksheet.write(0, 1, label = '版本')
    worksheet.write(0, 2, label = '评分')
    worksheet.write(0, 3, label = '标题')
    worksheet.write(0, 4, label = '内容')
    i = 1
    for entry in data['feed']['entry']:
        worksheet.write(i, 0, label = entry['author']['name']['label'])
        worksheet.write(i, 1, label = entry['im:version']['label'])
        worksheet.write(i, 2, label = entry['im:rating']['label'])
        worksheet.write(i, 3, label = entry['title']['label'])
        worksheet.write(i, 4, label = entry['content']['label'])
        i += 1
    date = datetime.date.today().strftime("%Y-%m-%d")
    workbook.save('appstore_reviews_%s_%s.xls' % (sys.argv[1], date))


if __name__ == '__main__':
    checkImport()
    main()
