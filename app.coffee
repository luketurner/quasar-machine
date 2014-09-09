initCamera = () ->
  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
  camera.position.z = 25
  return camera

initScene = () -> new THREE.Scene()

initRenderer = () ->
  renderer = new THREE.WebGLRenderer()
  renderer.setSize(window.innerWidth, window.innerHeight)
  document.body.appendChild(renderer.domElement)
  return renderer


initControls = (camera, onChange) ->
  controls = new THREE.TrackballControls(camera)
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

outlineRing = (radius, height, segments, color) ->
  geometry = new THREE.CylinderGeometry(radius,radius,height,segments,1,true)
  material = new THREE.MeshBasicMaterial(color: color, wireframe: true)
  return new THREE.Mesh(geometry, material)

# Angle is assumed in radians
polarToCartesian = (magnitude, angle) ->
  x: Math.cos(angle) * magnitude,
  y: Math.sin(angle) * magnitude

vertexField = (radius, height, n) -> while n -= 1
  coords = polarToCartesian(THREE.Math.randFloat(0, radius), THREE.Math.randFloat(0, 2 * Math.PI))
  new THREE.Vector3(coords.x, THREE.Math.randFloatSpread(height), coords.y)

detriusField = (radius, height, n, color, size) ->
  geometry = new THREE.Geometry();
  geometry.vertices.push(vector) for vector in vertexField(radius, height, n)
  material = new THREE.PointCloudMaterial(color: color, size: size)
  return new THREE.PointCloud(geometry, material)

init = () ->
  scene = initScene()
  camera = initCamera()
  renderer = initRenderer()
  render = () -> renderer.render(scene, camera)
  controls = initControls(camera, render)
  animate = () ->
    requestAnimationFrame(animate)
    controls.update()

  scene.add(outlineRing(20, 2, 32, 0xff0000))
  scene.add(outlineRing(1, 25, 10, 0xff0000))
  scene.add(outlineRing(0.5, 45, 5, 0xff0000))
  scene.add(detriusField(20, 2, 500, 0xffffff, 0.1))
  scene.add(detriusField(20, 2, 3000, 0xff9999, 0.05))
  render()
  animate()

init()