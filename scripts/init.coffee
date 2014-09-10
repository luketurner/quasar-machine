require(["builders/accretionDisk", "builders/lightPillar", "builders/starField"], (accretionDisk, lightPillar, starField) ->
  initCamera = () ->
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
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

  rebuild = (settings) ->
    scene = new THREE.Scene();
    accretionDisk(scene, settings)
    lightPillar(scene, settings)
    starField(scene, settings)
    return scene

  initViewModel = () -> settings: ko.observable(
      num_particles: 5000,
      num_beams: 1000,
      num_stars: 1000,
      show_wireframe: false
    )

  init = () ->
    scene = new THREE.Scene();
    camera = initCamera()
    renderer = initRenderer()
    render = () -> renderer.render(scene, camera)
    controls = initControls(camera, renderer.domElement, render)
    animate = () ->
      requestAnimationFrame(animate)
      controls.update()

    viewModel = initViewModel()
    ko.applyBindings(viewModel)

    viewModel.settings.subscribe((s) ->
      scene = rebuild(s)
      render())

    viewModel.settings.valueHasMutated()

    render()
    animate()

  init()
)