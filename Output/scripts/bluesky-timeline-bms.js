
// How many posts to retrieve
const limit = 9;

// Bluesky ID for the user
const actor = "did:plc:kzveixxrgji2clk5o74rf4hd";



// Request (GET https://public.api.bsky.app/xrpc/app.bsky.feed.getAuthorFeed)

jQuery.ajax({
    url: "https://public.api.bsky.app/xrpc/app.bsky.feed.getAuthorFeed",
    type: "GET",
    data: {
        "actor": actor,
        "limit": limit,
        "filter": "posts_and_author_threads",
    },
})
.done(function(data, textStatus, jqXHR) {
    for (var i in data.feed){

        let post = data.feed[i].post;
        console.log(post);
        
        let embeddedCode = ""
        if ("embed" in post) {
            if ("images" in post.embed && post.embed.images[0] !== null) {
                let link = post.embed.images[0].thumb;
                embeddedCode = `<div class="bsky-post-media"><img src="${link}" alt="" loading="lazy"></div>`;
            }
    
            if("record" in post.embed) {
                let link = getUrl(post.embed.record.author.handle, post.embed.record.uri);
                console.log(link);
                
                embeddedCode = `<div class="bsky-post-media">...in response to <a href="${link}" target="_blank">this other post...</a></div>`;
                
                jQuery.ajax({
                    url: "https://embed.bsky.app/oembed",
                    type: "GET",
                    data: { "url" : link },
                    beforeSend: function(request) {
                        request.setRequestHeader("Origin", "https://theskinnyonbenny.com");
                    }
                }).done(function(data1) {
                    console.log(data1);
                }).fail(function() {
                    embeddedCode = '<div class="bsky-post-media">...in response to <a href="${link}" target="_blank">${link}</a></div>';
                });
            }
        }

//  let postHtml = tweetbox(url(post.author.handle, post.uri)
//                                    , profile(post.author.handle)
//                                    , post.author.avatar
//                                    , post.record.text
//                                    , formattedDate(post.record.createdAt)
//                                    , post.author.did
//                                    , post.record); 
        let postHtml = tweetbox(post.author, post.record, post.uri, embeddedCode);
//        $('.mt-timeline').append(postHtml);
        addEvents();
    }
})
.fail(function(jqXHR, textStatus, errorThrown) {
    console.log("HTTP Request for Bluesky posts Failed");
})



function getId(uri) {
    return /[^/]*$/.exec(uri)[0];
}

function getProfile(handle) {
    return  `https://bsky.app/profile/${handle}`;
}

function getUrl(handle, uri) {
    return  `${getProfile(handle)}/post/${getId(uri)}`;
}

function getFormattedDateString(dateString) {
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
  return `${monthNames[dt.getMonth()]} ${dt.getDate()}, ${dt.getFullYear()}`;
}

// function tweetbox(location, profile, avatar, text, dateString, id, mediaId) 
function tweetbox(author, record, uri, embeddedCode){
    var profile = getProfile(author.handle)
    var url = getUrl(author.handle, uri);
    var dateString = getFormattedDateString(record.createdAt);
  
    return `
      <article class="bsky-post" aria-posinset="1" aria-setsize="30" data-location="${url}" tabindex="0">
        <a href="${profile}" class="mt-avatar" style="background-image:url(${author.avatar}" target="_blank"><span class="visually-hidden">bens4lsu avatar</span></a>
        <div class="mt-user">
          <a href="${profile}" target="_blank">${author.handle}</a>
        </div>
        <div class="bsky-post-text">
          <div>
            <p>${record.text}</p>
          </div>
        </div>
        ${embeddedCode}
        <div class="bsky-post-date">
          <a href="${url}" rel="nofollow noopener noreferrer" tabindex="-1" target="_blank">${dateString}</a>
        </div>
      </article>
  `;
}

function addEvents() {
    $('.bsky-post').click(function() {
        console.log(event.target);
    });
}


