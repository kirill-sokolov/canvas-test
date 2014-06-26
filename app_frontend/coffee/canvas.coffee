$(document).on 'ready', () ->
  CanvasClassObject = new CanvasClass
    layer1: '#canvas-layer1'
    layer2: '#canvas-layer2'
    layer3: '#canvas-layer3'
    layer4: '#canvas-layer4'
    layer5: '#canvas-layer5'
    controls: '#canvas-controls'

class CanvasClass
  constructor: (o) ->
    @o = o
    @layer1 = $(o.layer1).get(0)
    @layer2 = $(o.layer2).get(0)
    @layer3 = $(o.layer3).get(0)
    @layer4 = $(o.layer4).get(0)
    @layer5 = $(o.layer5).get(0)
    @$controls = $(o.controls)
    @set_listeners()
    @go()

  go: ->
    ctx = {}
    ctx['layer1'] = @.layer1.getContext('2d')
    ctx['layer2'] = @.layer2.getContext('2d')
    ctx['layer3'] = @.layer3.getContext('2d')
    ctx['layer4'] = @.layer4.getContext('2d')
    ctx['layer5'] = @.layer5.getContext('2d')

    console.debug(ctx)

    ctx.layer1.strokeRect(15, 15, 266, 266)
    ctx.layer1.strokeRect(18, 18, 260, 260)
    ctx.layer1.fillRect(20, 20, 256, 256)


    for i in [1...10]
      for j in [1...10]
        ctx.layer1.clearRect(20 + i * 32, 20 + j * 32, 32, 32)
        ctx.layer1.clearRect(20 + (i + 1) * 32, 20 + (j + 1) * 32, 32, 32)



  set_listeners: ->
    false

  close: ->
    false

  open: ->
    false