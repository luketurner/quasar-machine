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

  return (settings) ->
    lightPillar = new THREE.Object3D()
    lightPillar.add(makeBeams(settings.pillar_beams, settings.pillar_scale, settings.pillar_color, 0.1))
    lightPillar.add(makeSphere(1.5 * settings.pillar_scale, settings.pillar_color, 0.7))
    #lightPillar.add(makeParticles(settings.beam_particles))
    return lightPillar
)