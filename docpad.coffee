# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig =

  # Template Data
  # =============
  # These are variables that will be accessible via our templates
  # To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

  templateData:

    # Specify some site properties
    site:
      # The production url of our website
      url: "http://devatwork.nl"

      # Here are some old site urls that you would like to redirect from
      oldUrls: [
        'www.devatwork.nl'
      ]

      # The default title of our website
      title: "Dev @ Work"

      # The website description (for SEO)
      description: """
        A day in the life of a developer
        """

      # The website keywords (for SEO) separated by commas
      keywords: """
       Trilobyte, Bert Willems, Dev @ Work, dev at work, Bert, Willems, developer, software, programmer, lead developer, architect, JavaScript, dotNET
        """

      # The website author's name
      author: "Bert Willems"

      # The website author's email
      email: "b.willems@premotion.nl"

      # Your company's name
      copyright: "© Bert Willems 2014"

      services:
        buttons: ['TwitterTweet', 'GooglePlusOne', 'RedditSubmit', 'TwitterFollow', 'GithubFollow']
        twitterTweetButton: 'devatwork'
        twitterFollowButton: 'devatwork'
        githubFollowButton: 'devatwork'
        googleAnalytics: 'UA-4409537-1'


    # Helper Functions
    # ----------------

    # Get the prepared site/document title
    # Often we would like to specify particular formatting to our page's title
    # we can apply that formatting here
    getPreparedTitle: ->
      # if we have a document title, then we should use that and suffix the site's title onto it
      if @document.title
        "#{@document.title} | #{@site.title}"
      # if our document does not have it's own title, then we should just use the site's title
      else
        @site.title

    # Get the prepared site/document description
    getPreparedDescription: ->
      # if we have a document description, then we should use that, otherwise use the site's description
      @document.description or @site.description

    # Get the prepared site/document keywords
    getPreparedKeywords: ->
      # Merge the document keywords with the site keywords
      @site.keywords.concat(@document.keywords or @document.tags or []).join(', ')


  # Collections
  # ===========
  # These are special collections that our website makes available to us

  collections:
    # For instance, this one will fetch in all documents that have pageOrder set within their meta data
    pages: (database) ->
      database.findAllLive({pageOrder: $exists: true}, [pageOrder:1,title:1])

    # This one, will fetch in all documents that will be outputted to the posts directory
    posts: (database) ->
      database.findAllLive({relativeOutDirPath:/posts[\/\\]\w+/},[date:-1])

    # This one, will fetch in all documents that will be outputted to the projects directory
    projects: (database) ->
      database.findAllLive({relativeOutDirPath:'projects'}, [pageOrder:1,title:1])

    # This one, will fetch in all documents that will be outputted to the presentations directory
    presentations: (database) ->
      database.findAllLive({relativeOutDirPath:'presentations'}, [date:-1])

    # This one, will contain all the documents thaat need to be indexed
    sitemap: (database) ->
      return @getCollection('documents')
        .createChildCollection()
        .setFilter 'content', (model) ->
          title = model.get('title')
          return title? and not model.get('sitemapIngore')
        .query()


  # DocPad Events
  # =============

  # Here we can define handlers for events that DocPad fires
  # You can find a full listing of events on the DocPad Wiki
  events:

    # Server Extend
    # Used to add our own custom routes to the server before the docpad routes are added
    serverExtend: (opts) ->
      # Extract the server from the options
      {server} = opts
      docpad = @docpad

      # As we are now running in an event,
      # ensure we are using the latest copy of the docpad configuraiton
      # and fetch our urls from it
      latestConfig = docpad.getConfig()
      oldUrls = latestConfig.templateData.site.oldUrls or []
      newUrl = latestConfig.templateData.site.url

      # Redirect any requests accessing one of our sites oldUrls to the new site url
      server.use (req,res,next) ->
        if req.headers.host in oldUrls
          res.redirect 301, newUrl+req.url
        else
          next()


  # Pluin configuration
  # =============
  plugins:

    # GitHub pages configuration
    # =============
    
    ghpages:
      deployRemote: 'target'
      deployBranch: 'master'

    # RSS configuration
    # =============  

    rss:
      collection: 'posts'

    # Sitemap configuration
    # =============  

    sitemap:
      collectionName: 'sitemap'

    # Navlinks configuration
    # =============  

    navlinks:
      collections:
        posts: -1

# Export our DocPad Configuration
module.exports = docpadConfig
