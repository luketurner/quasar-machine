define(() ->
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

  makeBeams = (settings) ->
    pillar = new THREE.Object3D()
    n = settings.quantity
    while n -= 1
      heightFactor = THREE.Math.randFloat(1, 4)
      translateSpread = (4 - heightFactor) * settings.scale
      beam = makeBeam(
        0.1 * settings.scale,
        Math.pow(heightFactor, 3) * settings.scale,
        2,
        0.05 * settings.scale,
        settings.color3(),
        settings.opacity)
      beam.translateX(THREE.Math.randFloatSpread(translateSpread))
      beam.translateZ(THREE.Math.randFloatSpread(translateSpread))
      pillar.add(beam)
    return pillar

  return (settings) ->
    lightPillar = new THREE.Object3D()
    lightPillar.add(makeBeams(settings.beamClouds))
    #lightPillar.add(makeParticles(settings.beamParticles))
    return lightPillar
)