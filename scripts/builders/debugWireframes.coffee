define (() ->
  makeWireframe = (radius, height, segments) ->
    geometry = new THREE.CylinderGeometry(radius, radius, height, segments, 1, true)
    material = new THREE.MeshBasicMaterial(color: 0xff0000, wireframe: true)
    return new THREE.Mesh(geometry, material)

  return (settings) ->
    wireframes = new THREE.Object3D()
    if (settings.wireframes)
      wireframes.add(makeWireframe(1, 25, 6))
      wireframes.add(makeWireframe(0.5, 65, 3))
      wireframes.add(makeWireframe(30, 2, 32))
    return wireframes
)