require(["builders/debugWireframes", "builders/accretionDisk", "builders/lightPillar", "builders/starField", "config"], (debugWireframes, accretionDisk, lightPillar, starField, config) ->
  initCamera = () ->
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 4000)
    camera.position.z = 50
    return camera

  initRenderer = () ->
    renderer = new THREE.WebGLRenderer()
    renderer.setSize(window.innerWidth, window.innerHeight)
    document.body.appendChild(renderer.domElement)
    return renderer


  initControls = (camera, element, onChange) ->
    controls = new THREE.TrackballControls(camera, element)
    controls.rotateSpeed = 1.0
    controls.zoomSpeed = 1.2
    controls.panSpeed = 0.8
    controls.noZoom = false
    controls.noPan = false
    controls.staticMoving = true
    controls.dynamicDampingFactor = 0.3
    controls.keys = [65, 83, 68]
    controls.addEventListener('change', onChange)
    return controls

  initStats = () ->
    stats = new Stats
    stats.setMode(0)
    stats.domElement.style.position = 'absolute';
    stats.domElement.style.left = '0px';
    stats.domElement.style.top = '0px';
    document.body.appendChild( stats.domElement );
    return stats

  initScene = (settings) ->
    scene = new THREE.Scene()
    scene.add(debugWireframes(settings))
    scene.add(accretionDisk(settings))
    scene.add(lightPillar(settings))
    scene.add(starField(settings))
    return scene

  init = () ->
    stats = initStats()
    scene = initScene(config.settings)
    camera = initCamera()
    renderer = initRenderer()
    render = () -> renderer.render(scene, camera)
    controls = initControls(camera, renderer.domElement, render)
    animate = () ->
      stats.begin()
      requestAnimationFrame(animate)
      controls.update()
      stats.end()


    config.onFinishChange(() ->
      scene = initScene(config.settings)
      render()
    )
    render()
    animate()


  init()
)