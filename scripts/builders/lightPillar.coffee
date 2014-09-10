define(() ->
  debugWireframe = (radius, height) ->
    geometry = new THREE.CylinderGeometry(radius,radius,height,5,1,true)
    material = new THREE.MeshBasicMaterial(color: 0xff0000, wireframe: true)
    return new THREE.Mesh(geometry, material)

  cylinder = (radius, height, color, opacity) ->
    geometry = new THREE.CylinderGeometry(radius, radius, height, 32);
    material = new THREE.MeshBasicMaterial(color: color, transparent: true, opacity: opacity);
    new THREE.Mesh( geometry, material );

  beam = (scene, radius, height, steps, stepSize, color, opacity, spread) ->
    opacity = opacity / steps;
    xtrans = THREE.Math.randFloatSpread(spread)
    ytrans = THREE.Math.randFloatSpread(spread)
    while steps -= 1
      x = cylinder(radius, height, color, opacity)
      x.translateX(xtrans)
      x.translateZ(ytrans)
      scene.add(x)
      radius -= stepSize


  build = (scene, settings) ->
    n = settings.num_beams
    while n -= 1
      heightFactor = THREE.Math.randFloat(1, 4)
      beam(scene, 0.1, Math.pow(heightFactor, 3), 2, 0.05, 0xffaa22, 0.05, 4 - heightFactor)
    if settings.show_wireframe
      scene.add(debugWireframe(1, 25))
      scene.add(debugWireframe(0.5, 45))

  return build;
)