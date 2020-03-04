def fav_qs_qotd_response(tags = nil)
  {
    qotd_date: "2020-02-17T00:00:00.000+00:00",
    quote: {
      id: 42,
      tags: tags || ["great", "peace", "time", "war"],
      url: "https://favqs.com/quotes/theodore-roosevelt/29154-if-there-is-n-",
      author: "Theodore Roosevelt",
      body: "If there is not the war...",
    },
  }
end
