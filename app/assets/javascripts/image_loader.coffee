class ImageLoader
  constructor: ->
    @imageLoadingProgressCallback
    @images = {}
    @imageUrls = []
    @imagesLoaded = 0
    @imagesFailedToLoad = 0
    @imagesIndex = 0
  getImage: (imageUrl) ->
    @images[imageUrl]
  imageLoadedCallback: (e) ->
    @imagesLoaded++
  imageLoadErrorCallback: (e) ->
    @imagesFailedToLoad++
  loadImage: (imageUrl) ->
    image = new Image()
    image.src = imageUrl
    image.addEventListener 'load', (e) =>
      @imageLoadedCallback e
    image.addEventListener 'error', (e) =>
      @imageLoadErrorCallback e
    @images[imageUrl] = image
  loadImages: ->
    if @imagesIndex < @imageUrls.length
      @loadImage @imageUrls[@imagesIndex++]
    (@imagesLoaded + @imagesFailedToLoad) / @imageUrls.length * 100
  queueImage: (imageUrl) ->
    @imageUrls.push imageUrl

window.ImageLoader = ImageLoader