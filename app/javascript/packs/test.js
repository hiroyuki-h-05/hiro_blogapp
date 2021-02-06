
// Promiseクラス

// 1行目の記述はルール（慣習）
// 引数はコールバック関数
// 処理が成功したらresolveが実行される
// 処理が失敗したらrejectが実行される
const promise =new Promise((resolve, reject) => {  
  if (true) {
    resolve('成功')
  } else {
    reject('失敗')
  }
})

// 処理が成功したら（msgにはresolveの引数が渡ってくる）
// 処理が失敗したら（msgにはrejectの引数が渡ってくる）
promise.then((msg) => {
  console.log('then ', msg)
}).catch((msg) => {
  console.log('catch ', msg)
})