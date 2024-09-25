// Request (GET https://public.api.bsky.app/xrpc/app.bsky.feed.getAuthorFeed)

jQuery.ajax({
    url: "https://public.api.bsky.app/xrpc/app.bsky.feed.getAuthorFeed",
    type: "GET",
    data: {
        "actor": "did:plc:kzveixxrgji2clk5o74rf4hd",
        "limit": "9",
        "filter": "posts_and_author_threads",
    },
})
.done(function(data, textStatus, jqXHR) {
    for (var i in data.feed){

        let post = data.feed[i].post;
        console.log(post);
        let postHtml = tweetbox(url(post.author.handle, post.uri)
                                   , profile(post.author.handle)
                                   , post.author.avatar
                                   , post.record.text
                                   , formattedDate(post.record.createdAt)); 
//        $('.mt-timeline').append(postHtml);
    }
})
.fail(function(jqXHR, textStatus, errorThrown) {
    console.log("HTTP Request Failed");
})


function id(uri) {
    return /[^/]*$/.exec(uri)[0];
}

function profile(handle) {
    return  `https://bsky.app/profile/${handle}`;
}

function url(handle, uri) {
    return  `${profile(handle)}/post/${id(uri)}`;
}

function formattedDate(dateString) {
    const monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  
  let stamp = Date.parse(dateString);
  let dt = new Date(stamp);
  console.log(dt);
  return `${monthNames[dt.getMonth()]} ${dt.getDate()}, ${dt.getFullYear()}`;
}

function tweetbox(location, profile, avatar, text, dateString) {
  return `
      <article class="mt-toot" aria-posinset="1" aria-setsize="30" data-location="${location}" tabindex="0">
        <a href="${profile}" class="mt-avatar" style="background-image:url(${avatar}" target="_blank"><span class="visually-hidden">bens4lsu avatar</span></a>
        <div class="mt-user">
          <a href="${profile}" target="_blank">bens4lsu </a>
        </div>
        <div class="toot-text">
          <div>
            <p>${text}</p>
          </div>
        </div>
        <div class="toot-date">
          <a href="${location}" rel="nofollow noopener noreferrer" tabindex="-1" target="_blank">${dateString}</a>
        </div>
      </article>
  `;
}
