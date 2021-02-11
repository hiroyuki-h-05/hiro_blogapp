// ライブラリの読み込み
import axios from 'axios'

// rails-ujs（ライブラリ）で鍵を持たせる
import { csrfToken } from 'rails-ujs' // rails-ujs（ライブラリ）からcsrgTokenファンクションを読み込み

// axiosでリクエストを送る際に、鍵をつけた状態で送る
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default axios