define (() ->
  makeWireframe = (settings, radius, height, segments) ->
    geometry = new THREE.CylinderGeometry(radius,radius,height,segments,1,true)
    material = new THREE.MeshBasicMaterial(color: settings.color3(), wireframe: true, transparent: true, opacity: settings.opacity)
    return new THREE.Mesh(geometry, material)

  return (settings) ->
    wireframes = new THREE.Object3D()
    wireframes.add(makeWireframe(settings.wireframes, 1, 25, 3))
    wireframes.add(makeWireframe(settings.wireframes, 0.5, 50, 6))
    wireframes.add(makeWireframe(settings.wireframes, 20, 2, 32))
    return wireframes
)