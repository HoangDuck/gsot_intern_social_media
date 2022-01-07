const String users='''
[
  {
    "id":1,
    "name":"Hoang Duc",
    "nickname": "@duckute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/..png?alt=media&token=9264e0b5-5c0f-4e24-afeb-c8e6c571b20b",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":2,
    "name":"Minh Thien",
    "nickname": "@thienute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banh-trang.jpg?alt=media&token=8ab88554-3ca5-494c-9662-af6bc7a988cd",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":3,
    "name":"Phuc Minh",
    "nickname": "@minhute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banhtrang.jpg?alt=media&token=778ada73-2694-4665-9ab3-1e60095415bc",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":4,
    "name":"Duc Tinh",
    "nickname": "@tinhute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/cach-lam-nem-nuong-lui-2.jpg?alt=media&token=17fb7222-dc5c-4681-bd57-c1a485edff7c",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":5,
    "name":"Thien Toan",
    "nickname": "@toanute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banhtrang2.jpg?alt=media&token=7b0c5f6f-098d-49f1-9cc9-00f77e19df6b",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":6,
    "name":"Thanh Bao",
    "nickname": "@baoute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/combo.jpg?alt=media&token=72eba609-c5b6-4834-b88b-1d9e32ee14b2",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":7,
    "name":"Bao Toan",
    "nickname": "@btoankute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/v4-460px-Make-Homemade-Spaghetti-Sauce-Step-18-Version-4.jpg?alt=media&token=50ada86c-57a4-4325-8ad2-271f29da3361",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":8,
    "name":"Minh Duc",
    "nickname": "@mduckute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/pho-bo-bap-hoa-500.jpg?alt=media&token=f405ff71-b138-4d8f-9269-90d2d002e890",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":9,
    "name":"Hoang Phuc",
    "nickname": "@phucute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/goodshit.png?alt=media&token=3bab3e0c-878f-417d-a98d-abe8dbd3c2c9",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":10,
    "name":"Vo Tam",
    "nickname": "@tamute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/e-signature.png?alt=media&token=94572a39-a527-4119-a151-d4ee837183ef",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":11,
    "name":"Toan Khanh",
    "nickname": "@khanhute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-2.jpg?alt=media&token=9645f36a-1f07-4716-aff5-fabd1a9cadc4",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":12,
    "name":"Hoang Minh",
    "nickname": "@minhute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-7.jpg?alt=media&token=a167db92-cc8d-45c1-94ed-68aac9c99d59",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  },
  {
    "id":13,
    "name":"Duc Le",
    "nickname": "@leute",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-1.jpg?alt=media&token=87046e84-439a-4419-b528-81a93e33a93d",
    "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
  }
]
''';
const String posts='''
[
  {
    "id":1,
    "user": 
      {
        "id":13,
        "name":"Duc Le",
        "nickname": "@leute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-1.jpg?alt=media&token=87046e84-439a-4419-b528-81a93e33a93d",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Hello this is my first time. I've got to GSOT.",
    "image": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/bamboo_staff_2.jpg?alt=media&token=45fa8353-a38a-4080-a2c2-72dffcb3c8ac",
    "numberlikes": 12,
    "numbercomments": 13
  },
  {
    "id":2,
    "user": 
      {
        "id":13,
        "name":"Duc Le",
        "nickname": "@leute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-1.jpg?alt=media&token=87046e84-439a-4419-b528-81a93e33a93d",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Hello today i go to school.",
    "image": "",
    "numberlikes": 2,
    "numbercomments": 0
  },
  {
    "id":3,
    "user": 
      {
        "id":2,
        "name":"Minh Thien",
        "nickname": "@thienute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banh-trang.jpg?alt=media&token=8ab88554-3ca5-494c-9662-af6bc7a988cd",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "I met Tim Cook, Bill Gates,...",
    "image": "",
    "numberlikes": 12000,
    "numbercomments": 1300
  },
  {
    "id":4,
    "user":
      {
        "id":11,
        "name":"Toan Khanh",
        "nickname": "@khanhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-2.jpg?alt=media&token=9645f36a-1f07-4716-aff5-fabd1a9cadc4",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Today. I go to HCMUTE.",
    "image": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/cach-lam-sua-chua-don-gian-tai-nha.jpg?alt=media&token=65eb2fd3-b952-4ae5-8832-a207ed08e9b9",
    "numberlikes": 30,
    "numbercomments": 15
  },
  {
    "id":5,
    "user": 
      {
        "id":1,
        "name":"Hoang Duc",
        "nickname": "@duckute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/..png?alt=media&token=9264e0b5-5c0f-4e24-afeb-c8e6c571b20b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Hello I'm Intership of GSOT.",
    "image": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/hqdefault.jpg?alt=media&token=4bb05076-8a6d-4b8f-9d4c-2dd1d8fb8b70",
    "numberlikes": 1,
    "numbercomments": 1
  }
]
''';
const String messages='''
[
  {
    "id": 1,
    "user":
      {
        "id":1,
        "name":"Hoang Duc",
        "nickname": "@duckute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/..png?alt=media&token=9264e0b5-5c0f-4e24-afeb-c8e6c571b20b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Hello how are you today?",
    "time": "2d",
    "numbernew": 0
  },
  {
    "id": 2,
    "user":
      {
        "id":3,
        "name":"Phuc Minh",
        "nickname": "@minhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banhtrang.jpg?alt=media&token=778ada73-2694-4665-9ab3-1e60095415bc",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Hey, dude. We have deadline today.",
    "time": "Just now",
    "numbernew": 1
  },
  {
    "id": 3,
    "user":
      {
        "id":9,
        "name":"Hoang Phuc",
        "nickname": "@phucute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/goodshit.png?alt=media&token=3bab3e0c-878f-417d-a98d-abe8dbd3c2c9",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Are you home now?",
    "time": "1h",
    "numbernew": 0
  },
  {
    "id": 4,
    "user":
      {
        "id":5,
        "name":"Thien Toan",
        "nickname": "@toanute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banhtrang2.jpg?alt=media&token=7b0c5f6f-098d-49f1-9cc9-00f77e19df6b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Want to play a game bro?",
    "time": "2d",
    "numbernew": 0
  },
  {
    "id": 5,
    "user":
      {
        "id":11,
        "name":"Toan Khanh",
        "nickname": "@khanhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-2.jpg?alt=media&token=9645f36a-1f07-4716-aff5-fabd1a9cadc4",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Can you help me?",
    "time": "1d",
    "numbernew": 0
  },
  {
    "id": 6,
    "user":
      {
        "id":2,
        "name":"Minh Thien",
        "nickname": "@thienute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banh-trang.jpg?alt=media&token=8ab88554-3ca5-494c-9662-af6bc7a988cd",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Hello. Good morning",
    "time": "2d",
    "numbernew": 0
  },
  {
    "id": 7,
    "user":
      {
        "id":4,
        "name":"Duc Tinh",
        "nickname": "@tinhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/cach-lam-nem-nuong-lui-2.jpg?alt=media&token=17fb7222-dc5c-4681-bd57-c1a485edff7c",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "Did you finish app?",
    "time": "3d",
    "numbernew": 0
  }
]
''';
const String notifiers='''
[
  {
    "id": 1,
    "user": 
      {
        "id":11,
        "name":"Toan Khanh",
        "nickname": "@khanhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-2.jpg?alt=media&token=9645f36a-1f07-4716-aff5-fabd1a9cadc4",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "mentioned you at a post",
    "time": "10 sec",
    "read": "false"
  },
  {
    "id": 2,
    "user":
      {
        "id":9,
        "name":"Hoang Phuc",
        "nickname": "@phucute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/goodshit.png?alt=media&token=3bab3e0c-878f-417d-a98d-abe8dbd3c2c9",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "share a post",
    "time": "1 minute",
    "read": "false"
  },
  {
    "id": 3,
    "user":
      {
        "id":5,
        "name":"Thien Toan",
        "nickname": "@toanute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banhtrang2.jpg?alt=media&token=7b0c5f6f-098d-49f1-9cc9-00f77e19df6b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "changed profile",
    "time": "12 minute",
    "read": "true"
  },
  {
    "id": 4,
    "user":
      {
        "id":2,
        "name":"Minh Thien",
        "nickname": "@thienute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banh-trang.jpg?alt=media&token=8ab88554-3ca5-494c-9662-af6bc7a988cd",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "tagged you at a post",
    "time": "1 day",
    "read": "true"
  },
  {
    "id": 5,
    "user":
      {
        "id":3,
        "name":"Phuc Minh",
        "nickname": "@minhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banhtrang.jpg?alt=media&token=778ada73-2694-4665-9ab3-1e60095415bc",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "share a post",
    "time": "2 day",
    "read": "true"
  },
  {
    "id": 6,
    "user":
      {
        "id":13,
        "name":"Duc Le",
        "nickname": "@leute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-1.jpg?alt=media&token=87046e84-439a-4419-b528-81a93e33a93d",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "post a timeline",
    "time": "2 day",
    "read": "true"
  },
  {
    "id": 7,
    "user":
      {
        "id":5,
        "name":"Thien Toan",
        "nickname": "@toanute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banhtrang2.jpg?alt=media&token=7b0c5f6f-098d-49f1-9cc9-00f77e19df6b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "share a post",
    "time": "2 day",
    "read": "true"
  },
  {
    "id": 8,
    "user":
      {
        "id":1,
        "name":"Hoang Duc",
        "nickname": "@duckute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/..png?alt=media&token=9264e0b5-5c0f-4e24-afeb-c8e6c571b20b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "change profile",
    "time": "3 day",
    "read": "true"
  },
  {
    "id": 9,
    "user": 
      {
        "id":11,
        "name":"Toan Khanh",
        "nickname": "@khanhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-2.jpg?alt=media&token=9645f36a-1f07-4716-aff5-fabd1a9cadc4",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "change cover",
    "time": "3 day",
    "read": "true"
  },
  {
    "id": 10,
    "user":
      {
        "id":4,
        "name":"Duc Tinh",
        "nickname": "@tinhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/cach-lam-nem-nuong-lui-2.jpg?alt=media&token=17fb7222-dc5c-4681-bd57-c1a485edff7c",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "share a post",
    "time": "3 day",
    "read": "true"
  },
  {
    "id": 11,
    "user":
      {
        "id":1,
        "name":"Hoang Duc",
        "nickname": "@duckute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/..png?alt=media&token=9264e0b5-5c0f-4e24-afeb-c8e6c571b20b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "share a link",
    "time": "3 day",
    "read": "true"
  },
  {
    "id": 12,
    "user":
      {
        "id":1,
        "name":"Hoang Duc",
        "nickname": "@duckute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/..png?alt=media&token=9264e0b5-5c0f-4e24-afeb-c8e6c571b20b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "change profile",
    "time": "3 day",
    "read": "true"
  },
  {
    "id": 13,
    "user":
      {
        "id":12,
        "name":"Hoang Minh",
        "nickname": "@minhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-7.jpg?alt=media&token=a167db92-cc8d-45c1-94ed-68aac9c99d59",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "share a post",
    "time": "4 day",
    "read": "true"
  },
  {
    "id": 14,
    "user":
      {
        "id":5,
        "name":"Thien Toan",
        "nickname": "@toanute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/banhtrang2.jpg?alt=media&token=7b0c5f6f-098d-49f1-9cc9-00f77e19df6b",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "share a post",
    "time": "4 day",
    "read": "true"
  },
  {
    "id": 15,
    "user": 
      {
        "id":11,
        "name":"Toan Khanh",
        "nickname": "@khanhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-2.jpg?alt=media&token=9645f36a-1f07-4716-aff5-fabd1a9cadc4",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "like your post",
    "time": "4 day",
    "read": "true"
  },
  {
    "id": 16,
    "user": 
      {
        "id":11,
        "name":"Toan Khanh",
        "nickname": "@khanhute",
        "picture": "https://firebasestorage.googleapis.com/v0/b/quickstart-1614695450393.appspot.com/o/menu-2.jpg?alt=media&token=9645f36a-1f07-4716-aff5-fabd1a9cadc4",
        "cover": "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/12/14/cay-thong-14-1639467420970451858714.jpg"
      },
    "content": "comment your post",
    "time": "5 day",
    "read": "true"
  }
]
''';