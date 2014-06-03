{
    "site"    : "百度贴吧",

    "domains" : ["tieba.baidu.com"],

    "urls"    : {
                    "base": "http://tieba.baidu.com/f/search/res?isnew=1&kw=&qw=%B2%DC%CF%D8&un=&rn=100&pn=0&sd=&ed=&sm=1&only_thread=#FLAG#",
                    "keywords": {
                        "name": "qw",
                        "file": "#FILENAME#",
                        "enc":  "gbk"
                    }
                },

    "rules": {
        "#1": {
            "xpath": "//a[@class='next']",
            "regex": "pn=(\\d+)",
            "pages": {
                "start": 1,
                "stop": #PAGE#
            }
        },

        "#2": {
            "follow": false,
            "xpath": "//div[@class='s_post' and datetime-delta(font[@class='p_green'], '+08:00', 3*3600)]/span[@class='p_title']/a[@class='bluelink' and contains(@href, '&cid=0#') and not(starts-with(., '回复:'))]",
            "sub": {
                "from": "\\?.*$",
                "to": ""
            }
        }
    },
    
    "fields": {
        "url"     : {"name": "url",         "value": "${URL}"},
        "title"   : {"name": "title",       "xpath": "//h1[@class='core_title_txt']/text()"},
        "author"  : {"name": "source",      "value": "${SITE}"},
        "forum"   : {"name": "siteName",    "value": "${SITE}"},
        "date"    : {"name": "ctime",       "xpath": "//div[contains(@class, 'l_post')][1]/@data-field", "parse":[{"type":"jpath", "query":"$.content.date"}, {"type":"cst"}]},
        "updated" : {"name": "gtime",       "value": "${NOW}", "parse":{"type":"cst"}},
        "content" : {"name": "content",     "xpath": "(//div[contains(@id,'post_content')])[1]", "parse":{"type":"text"}},
        "clicks"  : {"name": "visitCount",  "value": 0},
        "replies" : {"name": "replyCount",  "value": 0},
        "category": {"name": "info_flag",   "value": "02"}
    },

    "proxy":{
        "rate": 1,
        "file": "http://192.168.3.175/proxy.txt"
    },

    "settings": {
        "zmq":   "tcp://192.168.3.196:10086",
        "dedup": "redis://192.168.3.180:6379/0"
    }
}