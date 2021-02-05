
// jqueryの読み込み
import $ from 'jquery'
// axiosの読み込み
import axios from 'axios'

// rails-ujs（ライブラリ）で鍵を持たせる
import { csrfToken } from 'rails-ujs'
// axiosでリクエストを送る際に、鍵をつけた状態で送る
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

// ハートの表示をコントロールするファンクション
const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}


// ターボリンク(Railsの機能)があるのでD0MContentLoadedはつかわずturbolinks:loadを使用
document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  axios.get(`/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data

      comments.forEach((comment) => {
        $('.comments-container').append(
          `<div class='article_comment'><p>${comment.content}</p></div>`
        )
      })
    })

  axios.get(`/articles/${articleId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })

  $('.inactive-heart').on('click', () => {
    axios.post(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-heart').removeClass('hidden')
          $('.inactive-heart').addClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

  $('.active-heart').on('click', () => {
    axios.delete(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-heart').addClass('hidden')
          $('.inactive-heart').removeClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
  
})