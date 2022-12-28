Map filtermap1 = {
  // 취득원인맵
  "주택(주거용 오피스텔 포함)": ["자가신축", "매매", "증여", "상속"],
  "조합원 입주권": ["자가신축", "매매", "증여", "상속"],
  "분양권(2020년 이전 취득)": ["매매", "증여", "상속"],
  "분양권(2021년 이후 취득)": ["매매", "증여", "상속"]
};

// 호출하는 법
// 취득시종류맵["주택(주거용 오피스텔 포함)"]["매매"]
// 이렇게 하면 아래 리스트가 출력됨
// [
// "주택",
// "분양권(2020년 이전 취득)",
// "주거용 오피스텔",
// "재건축전 주택",
// "분양권(2021년 이후 취득)",
// "조합원 입주권"
// ]

Map filtermap2 = {
  // 취득시종류맵
  "주택(주거용 오피스텔 포함)": {
    "자가신축": ["재건축전 주택", "주택", "주거용 오피스텔"],
    "매매": [
      "주택",
      "분양권(2020년 이전 취득)",
      "주거용 오피스텔",
      "재건축전 주택",
      "분양권(2021년 이후 취득)",
      "조합원 입주권"
    ],
    "증여": [
      "주택",
      "분양권(2020년 이전 취득)",
      "주거용 오피스텔",
      "재건축전 주택",
      "분양권(2021년 이후 취득)",
      "조합원 입주권"
    ],
    "상속": [
      "주택",
      "분양권(2020년 이전 취득)",
      "주거용 오피스텔",
      "재건축전 주택",
      "분양권(2021년 이후 취득)",
      "조합원 입주권"
    ]
  },
  "조합원 입주권": {
    "자가신축": ["재건축전 주택"],
    "매매": ["재건축전 주택", "분양권(2021년 이후 취득)", "분양권(2020년 이전 취득)", "조합원 입주권"],
    "증여": ["재건축전 주택", "분양권(2021년 이후 취득)", "분양권(2020년 이전 취득)", "조합원 입주권"],
    "상속": ["재건축전 주택", "분양권(2021년 이후 취득)", "분양권(2020년 이전 취득)", "조합원 입주권"]
  },
  "분양권(2020년 이전 취득)": {
    "매매": ["분양권(2020년 이전 취득)"],
    "증여": ["분양권(2020년 이전 취득)"],
    "상속": ["분양권(2020년 이전 취득)"]
  },
  "분양권(2021년 이후 취득)": {
    "매매": ["분양권(2021년 이후 취득)"],
    "증여": ["분양권(2021년 이후 취득)"],
    "상속": ["분양권(2021년 이후 취득)"]
  }
};

List<Map> baseInfo = [
  {"smallTitle": "양도예정일", "hintText": "20220731", "type": "date"},
  {"smallTitle": "주소", "hintText": "서울특별시 서초구 반포대로 4(서초동)", "type": "address"},
  {
    "smallTitle": "양도시 종류",
    "type": "dropdown",
    "contents": [
      "주택(주거용 오피스텔 포함)",
      "조합원 입주권",
      "분양권(2020년 이전 취득)",
      "분양권(2021년 이후 취득)"
    ]
  },
  {
    "smallTitle": "취득 원인",
    "type": "dropdown",
    "contents": [],
  },
  {
    "smallTitle": "취득시 종류",
    "type": "dropdown",
    "contents": [
      "주택(주거용 오피스텔 포함)",
      "조합원 입주권",
      "분양권(2020년 이전 취득)",
      "분양권(2021년 이후 취득)"
    ],
  }
];
Map filterMap = {
  "주택(주거용 오피스텔 포함)": {
    "매매": {
      "주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date2"
          }
        },
        "data": [
          {
            "title": "잔금청산일과 등기접수일중 빠른날",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "주택 계약일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          },
          {
            "title": "계약일 당시 무주택 여부 (o,x)",
            "keyValue": "no_house",
            "type": "oxdropdown",
            "condition": 4
          }
        ]
      },
      "재건축전 주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date2"
          }
        },
        "data": [
          {
            "title": "재건축전 주택 잔금청산일과 등기접수일중 빠른날",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "재건축전 주택 계약일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          },
          {
            "title": "신주택 사용 승인일",
            "keyValue": "buy_date3",
            "type": "date",
            "condition": 0
          },
          {
            "title": "계약일 당시 무주택 여부 (o,x)",
            "keyValue": "no_house",
            "type": "oxdropdown",
            "condition": 4
          }
        ]
      },
      "주거용 오피스텔": {
        "metadata": {
          "취득일계약일계산": {
            "method": "late",
            "param1": "buy_date1",
            "param2": "buy_date2"
          }
        },
        "data": [
          {
            "title": "잔금청산일과 등기접수일중 빠른날",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "주거용 사용 시작일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          },
          {
            "title": "주거용 사용 종료일",
            "keyValue": "buy_date3",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "조합원 입주권": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date3"
          }
        },
        "data": [
          {
            "title": "주택 사용 승인일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "조합원 입주권 잔금청산일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          },
          {
            "title": "조합원 입주권 계약일",
            "keyValue": "buy_date3",
            "type": "date",
            "condition": 0
          },
          {
            "title": "계약일 당시 무주택 여부 (o,x)",
            "keyValue": "no_house",
            "type": "oxdropdown",
            "condition": 4
          }
        ]
      },
      "분양권(2020년 이전 취득)": {
        "승계 분양권": {
          "metadata": {
            "취득일계약일계산": {
              "method": "normal",
              "param1": "buy_date1",
              "param2": "buy_date2"
            }
          },
          "data": [
            {
              "title": "주택 잔금청산일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            },
            {
              "title": "분양권 계약일",
              "keyValue": "buy_date2",
              "type": "date",
              "condition": 0
            },
            {
              "title": "계약일 당시 무주택 여부 (o,x)",
              "keyValue": "no_house",
              "type": "oxdropdown",
              "condition": 4
            }
          ]
        },
        "최초당첨 분양권": {
          "metadata": {
            "취득일계약일계산": {
              "method": "normal",
              "param1": "buy_date1",
              "param2": "buy_date2"
            }
          },
          "data": [
            {
              "title": "주택 잔금청산일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            },
            {
              "title": "당첨일",
              "keyValue": "buy_date2",
              "type": "date",
              "condition": 0
            },
            {
              "title": "계약일 당시 무주택 여부 (o,x)",
              "keyValue": "no_house",
              "type": "oxdropdown",
              "condition": 4
            }
          ]
        }
      },
      "분양권(2021년 이후 취득)": {
        "승계 분양권": {
          "metadata": {
            "취득일계약일계산": {
              "method": "normal",
              "param1": "buy_date1",
              "param2": "buy_date2"
            }
          },
          "data": [
            {
              "title": "주택 잔금청산일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            },
            {
              "title": "분양권 잔금청산일",
              "keyValue": "buy_date2",
              "type": "date",
              "condition": 0
            },
            {
              "title": "분양권 계약일",
              "keyValue": "buy_date3",
              "type": "date",
              "condition": 0
            },
            {
              "title": "계약일 당시 무주택 여부 (o,x)",
              "keyValue": "no_house",
              "type": "oxdropdown",
              "condition": 4
            }
          ]
        },
        "최초당첨 분양권": {
          "metadata": {
            "취득일계약일계산": {
              "method": "normal",
              "param1": "buy_date1",
              "param2": "buy_date2"
            }
          },
          "data": [
            {
              "title": "주택 잔금청산일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            },
            {
              "title": "분양권 당첨일",
              "keyValue": "buy_date2",
              "type": "date",
              "condition": 0
            },
            {
              "title": "계약일 당시 무주택 여부 (o,x)",
              "keyValue": "no_house",
              "type": "oxdropdown",
              "condition": 4
            }
          ]
        }
      }
    },
    "증여": {
      "주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "등기 접수일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "재건축전 주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "재건축전 주택 등기접수일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "신주택 사용 승인일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "주거용 오피스텔": {
        "metadata": {
          "취득일계약일계산": {
            "method": "late",
            "param1": "buy_date1",
            "param2": "buy_date2"
          }
        },
        "data": [
          {
            "title": "등기접수일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "주거용 사용 시작일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          },
          {
            "title": "주거용 사용 종료일",
            "keyValue": "buy_date3",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "조합원 입주권": {
        "metadata": {},
        "data": [
          {
            "title": "주택 사용 승인일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "조합원 입주권 명의변경 신고일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2020년 이전 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2021년 이후 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "분양권 명의변경 신고일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          }
        ]
      }
    },
    "상속": {
      "주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "상속개시일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "피상속인 주택 취득일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 1
          },
          {
            "title": "피상속인과 상속인의 동일거주 시작일",
            "keyValue": "buy_date3",
            "type": "date",
            "condition": 3
          }
        ]
      },
      "재건축전 주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "이전주택 상속개시일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "신주택 사용 승인일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          },
          {
            "title": "피상속인과 상속인의 재건축전 주택 동일거주 시작일",
            "keyValue": "buy_date3",
            "type": "date",
            "condition": 3
          }
        ]
      },
      "주거용 오피스텔": {
        "metadata": {
          "취득일계약일계산": {
            "method": "late",
            "param1": "buy_date1",
            "param2": "buy_date2"
          }
        },
        "data": [
          {
            "title": "상속개시일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "주거용 사용 시작일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          },
          {
            "title": "주거용 사용 종료일",
            "keyValue": "buy_date3",
            "type": "date",
            "condition": 0
          },
          {
            "title": "피상속인 오피스텔 취득일",
            "keyValue": "buy_date4",
            "type": "date",
            "condition": 1
          },
          {
            "title": "피상속인과 상속인의 동일거주 시작일",
            "keyValue": "buy_date5",
            "type": "date",
            "condition": 3
          }
        ]
      },
      "조합원 입주권": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "주택 사용 승인일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "상속 개시일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2020년 이전 취득)": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2021년 이후 취득)": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "상속 개시일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          }
        ]
      }
    },
    "자가신축": {
      "주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "사용승인서 교부일, 임시사용일, 사실상 사용일중 빠른날",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "재건축전 주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "이전주택 사용승인서 교부일, 임시사용일, 사실상 사용일중 빠른날",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "신주택 사용 승인일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "주거용 오피스텔": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date1"
          }
        },
        "data": [
          {
            "title": "사용승인서 교부일, 임시사용일, 사실상 사용일중 빠른날",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      }
    }
  },
  "조합원 입주권": {
    "매매": {
      "재건축전 주택": {
        "metadata": {
          "취득일계약일계산": {
            "method": "normal",
            "param1": "buy_date1",
            "param2": "buy_date2"
          }
        },
        "data": [
          {
            "title": "재건축전 주택 잔금청산일과 등기접수일중 빠른날",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "재건축전 주택 계약일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 0
          },
          {
            "title": "계약일 당시 무주택 여부 (o,x)",
            "keyValue": "no_house",
            "type": "oxdropdown",
            "condition": 4
          }
        ]
      },
      "조합원 입주권": {
        "metadata": {},
        "data": [
          {
            "title": "조합원 입주권 잔금 청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2020년 이전 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2021년 이후 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      }
    },
    "증여": {
      "재건축전 주택": {
        "metadata": {},
        "data": [
          {
            "title": "재건축전 주택 등기접수일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "조합원 입주권": {
        "metadata": {},
        "data": [
          {
            "title": "조합원 입주권 명의변경 신고일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2020년 이전 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2021년 이후 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      }
    },
    "상속": {
      "재건축전 주택": {
        "metadata": {},
        "data": [
          {
            "title": "재건축전 주택 상속개시일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "피상속인 주택 취득일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 2
          },
          {
            "title": "피상속인과 상속인의 재건축전 주택 동일거주 시작일",
            "keyValue": "buy_date3",
            "type": "date",
            "condition": 3
          }
        ]
      },
      "조합원 입주권": {
        "metadata": {},
        "data": [
          {
            "title": "상속개시일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          },
          {
            "title": "피상속인 조합원 입주권 취득일",
            "keyValue": "buy_date2",
            "type": "date",
            "condition": 1
          }
        ]
      },
      "분양권(2020년 이전 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      },
      "분양권(2021년 이후 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "주택 잔금청산일",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      }
    },
    "자가신축": {
      "재건축전 주택": {
        "metadata": {},
        "data": [
          {
            "title": "이전주택 사용승인서 교부일, 임시사용일, 사실상 사용일중 빠른날",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      }
    }
  },
  "분양권(2020년 이전 취득)": {
    "매매": {
      "분양권(2020년 이전 취득)": {
        "승계 분양권": {
          "metadata": {},
          "data": [
            {
              "title": "분양권 잔금청산일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            }
          ]
        },
        "최초당첨 분양권": {
          "metadata": {},
          "data": [
            {
              "title": "분양권 당첨일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            }
          ]
        }
      }
    },
    "증여": {
      "분양권(2020년 이전 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "분양권 권리의무 승계일(명의변경일)",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      }
    },
    "상속": {
      "분양권(2020년 이전 취득)": {
        "승계 분양권": {
          "metadata": {},
          "data": [
            {
              "title": "상속개시일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            },
            {
              "title": "분양권 잔금청산일",
              "keyValue": "buy_date2",
              "type": "date",
              "condition": 1
            }
          ]
        },
        "최초당첨 분양권": {
          "metadata": {},
          "data": [
            {
              "title": "상속개시일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            },
            {
              "title": "분양권 당첨일",
              "keyValue": "buy_date2",
              "type": "date",
              "condition": 1
            }
          ]
        }
      }
    }
  },
  "분양권(2021년 이후 취득)": {
    "매매": {
      "분양권(2021년 이후 취득)": {
        "승계 분양권": {
          "metadata": {},
          "data": [
            {
              "title": "분양권 잔금청산일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            }
          ]
        },
        "최초당첨 분양권": {
          "metadata": {},
          "data": [
            {
              "title": "분양권 당첨일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            }
          ]
        }
      }
    },
    "증여": {
      "분양권(2021년 이후 취득)": {
        "metadata": {},
        "data": [
          {
            "title": "분양권 권리의무 승계일(명의변경일)",
            "keyValue": "buy_date1",
            "type": "date",
            "condition": 0
          }
        ]
      }
    },
    "상속": {
      "분양권(2021년 이후 취득)": {
        "승계 분양권": {
          "metadata": {},
          "data": [
            {
              "title": "상속개시일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            },
            {
              "title": "분양권 잔금청산일",
              "keyValue": "buy_date2",
              "type": "date",
              "condition": 1
            }
          ]
        },
        "최초당첨 분양권": {
          "metadata": {},
          "data": [
            {
              "title": "상속개시일",
              "keyValue": "buy_date1",
              "type": "date",
              "condition": 0
            },
            {
              "title": "분양권 당첨일",
              "keyValue": "buy_date2",
              "type": "date",
              "condition": 1
            }
          ]
        }
      }
    }
  }
};
