
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

// コメントフォームの表示
const handleCommentForm = () => {
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area').removeClass('hidden')
  })
}

// コメント追加
const appendNewComment = (comment) => {
  $('.comments-container').append(
    `<div class='article_comment'><p>${comment.content}</p></div>`
  )
}


// ターボリンク(Railsの機能)があるのでD0MContentLoadedはつかわずturbolinks:loadを使用
document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  // コメント表示(Ajax)
  axios.get(`/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data

      comments.forEach((comment) => {
        appendNewComment(comment)
      })
    })

  handleCommentForm()
  
  // Ajaxでコメント投稿
  $('.add-comment-button').on('click', () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      // 第二引数に送信するパラメーターを指定
      axios.post(`/articles/${articleId}/comments`, {
        comment: {content: content}
      })
      
        .then((res) => {
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')
        })
    }
  })

  // いいねしたかどうを
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