
// jqueryの読み込み
import $ from 'jquery'

// axiosの読み込み
import axios from 'modules/axios'
import { listenActiveHeartEvent, listenInactiveHeartEvent } from '../modules/handle_heart'

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
  axios.get(`/api/articles/${articleId}/comments`)
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
      axios.post(`/api/articles/${articleId}/comments`, {
        comment: {content: content}
      })
      
        .then((res) => {
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')
        })
    }
  })

  // いいねしたかどうかを判定し、true or falseによってクラスの付与を分岐
  axios.get(`/api/articles/${articleId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })
    
  listenInactiveHeartEvent(articleId) // いいねのクリックイベント
  listenActiveHeartEvent(articleId) // いいねを外すクリックイベント

  
  
})