define(() ->
  makeCylinder = (radius, height, color, opacity) ->
    geometry = new THREE.CylinderGeometry(radius, radius, height, 32);
    material = new THREE.MeshBasicMaterial(color: color, transparent: true, opacity: opacity);
    new THREE.Mesh( geometry, material );

  makeSphere = (radius, color, opacity) ->
    geometry = new THREE.SphereGeometry(radius, 32, 32);
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

  makeBeams = (numBeams, scale, color, opacity) ->
    pillar = new THREE.Object3D()
    while numBeams -= 1
      heightFactor = THREE.Math.randFloat(1, 4)
      translateSpread = (4 - heightFactor) * scale
      beam = makeBeam(
        0.1 * scale,
        Math.pow(heightFactor, 3) * scale,
        2,
        0.05 * scale,
        color,
        opacity)
      beam.translateX(THREE.Math.randFloatSpread(translateSpread))
      beam.translateZ(THREE.Math.randFloatSpread(translateSpread))
      pillar.add(beam)
    return pillar

  makeSoftSphere = (radius, opacity, color, steps, stepSize) ->
    sphere = new THREE.Object3D()
    while steps -= 1
      sphere.add(makeSphere(radius, color, opacity))
      radius -= stepSize
    return sphere

  return (settings) ->
    lightPillar = new THREE.Object3D()
    particles = settings.beamParticles
    clouds = settings.beamClouds
    lightPillar.add(makeBeams(clouds.quantity, clouds.scale, clouds.color3(), clouds.opacity))
    lightPillar.add(makeSphere(1.5 * clouds.scale, clouds.color3(), clouds.opacity * 7))
    #lightPillar.add(makeParticles(settings.beamParticles))
    return lightPillar
)