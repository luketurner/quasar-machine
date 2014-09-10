define(() ->
  debugWireframe = (radius, height) ->
    geometry = new THREE.CylinderGeometry(radius,radius,height,5,1,true)
    material = new THREE.MeshBasicMaterial(color: 0xff0000, wireframe: true)
    return new THREE.Mesh(geometry, material)

  makeCylinder = (radius, height, color, opacity) ->
    geometry = new THREE.CylinderGeometry(radius, radius, height, 32);
    material = new THREE.MeshBasicMaterial(color: color, transparent: true, opacity: opacity);
    new THREE.Mesh( geometry, material );

  makeBeam = (radius, height, steps, stepSize, color, opacity) ->
    opacity = opacity / steps;
    beam = new THREE.Object3D()
    while steps -= 1
      x = makeCylinder(radius, height, color, opacity)
      beam.add(x)
      radius -= stepSize
    return beam

  makeLightPillar = (settings) ->
    pillar = new THREE.Object3D()
    n = settings.num_beams
    while n -= 1
      heightFactor = THREE.Math.randFloat(1, 4)
      translateSpread = 4 - heightFactor
      beam = makeBeam(0.1, Math.pow(heightFactor, 3), 2, 0.05, 0xffccaa, 0.05)
      beam.translateX(THREE.Math.randFloatSpread(translateSpread))
      beam.translateZ(THREE.Math.randFloatSpread(translateSpread))
      pillar.add(beam)
    return pillar

  build = (settings) ->
    lightPillar = new THREE.Object3D()
    lightPillar.add(makeLightPillar(settings))
    if settings.show_wireframe
      lightPillar.add(debugWireframe(1, 25))
      lightPillar.add(debugWireframe(0.5, 45))
    return lightPillar

  return build;
)