import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicId) => {
  let channel = socket.channel(`comments:${topicId}`, {});

  channel.join()
    .receive("ok", resp => {
      renderComments(resp.comments);
    })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on(`comments:${topicId}:new`, renderComment)

  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;

    channel.push('comment:add', { content: content });
  });
}

function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    let email = 'Anonymous';

    if (comment.user) {
      email = comment.user.email;
    }

    return `
      <li class="collection-item">
        ${comment.content}
        <div class="secondary-content">
          ${email}
        </div>
      </li>
    `;
  });

  document.querySelector('.collection').innerHTML = renderedComments.join('');
}

function renderComment(event) {
    let email = 'Anonymous';

    if (comment.user) {
      email = comment.user.email;
    }

  const renderedComment = `
    <li class="collection-item">
      ${event.comment.content}
      <div class="secondary-content">
        ${email}
      </div>
    </li>
  `;

  document.querySelector('.collection').innerHTML += renderedComment;
}

window.createSocket = createSocket;
