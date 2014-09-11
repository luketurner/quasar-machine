define(() ->
  pointInCylinder = (radius, height) ->
    r = THREE.Math.randFloat(0, radius)
    theta = THREE.Math.randFloat(0, 2 * Math.PI)
    heightRange = THREE.Math.randFloatSpread(height * Math.pow(1 - (r / radius), 2))
    new THREE.Vector3(
      r * Math.cos(theta),
      heightRange,
      r * Math.sin(theta)
    )

  accretionParticles = (radius, height, n, color, size) ->
    geometry = new THREE.Geometry();
    while n -= 1
      geometry.vertices.push(pointInCylinder(radius, height))
    material = new THREE.PointCloudMaterial(color: color, size: size)
    return new THREE.PointCloud(geometry, material)

  return (settings) ->
    accretionDisk = new THREE.Object3D()
    particles = settings.diskParticles
    clouds = settings.diskClouds
    accretionDisk.add(accretionParticles(35 * particles.scale, 5 * particles.scale, particles.quantity * 0.05, new THREE.Color("#222").add(particles.color3()), 0.1 * particles.scale))
    accretionDisk.add(accretionParticles(35 * particles.scale, 5 * particles.scale, particles.quantity * 0.95, particles.color3(), 0.05 * particles.scale))
    return accretionDisk
)
