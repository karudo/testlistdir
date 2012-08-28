$ ->
  curPath = ''
  curFilesList = []
  curSort = 'asc'
  socket = io.connect()

  sortFuncs =
    all: (a, b)->
      return 0 if a.file is b.file
      if a.file > b.file then 1 else -1

    asc: (a, b)->
      return sortFuncs.all(a,b) if (a.isDir and b.isDir) or (not a.isDir and not b.isDir)
      if a.isDir then -1 else 1
    desc: (a, b)-> sortFuncs.asc(a,b) * -1

  render = ->
    curFilesList.sort(sortFuncs[curSort])
    $('table tbody').html Handlebars.templates.filelist files: curFilesList

  load = (path)->
    socket.emit 'dirlist', path, (err, files)->
      curFilesList = files
      curPath = path
      render()

  $('table').on 'click', '.dir', ->
    load $(@).data('path')
    no

  $('.gototop').on 'click', ->
    tmp = curPath.split '/'
    tmp = tmp[..tmp.length-2]
    tmp = tmp.join '/'
    if not tmp.length then tmp = '/'

    load tmp

    no

  $('.sort').on 'click', ->
    curSort = $(@).data('order')
    console.log curSort
    render()
    no


  load '/'

