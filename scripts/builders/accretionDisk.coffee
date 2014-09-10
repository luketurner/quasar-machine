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

  build = (scene, settings) ->
    scene.add(accretionParticles(20, 3, settings.num_particles * 0.05, 0xffffff, 0.1))
    scene.add(accretionParticles(20, 3, settings.num_particles * 0.95, 0xff9999, 0.05))
    if settings.show_wireframe
        scene.add(new THREE.Mesh(new THREE.CylinderGeometry(20,20,2,32,1,true), new THREE.MeshBasicMaterial(color: 0xff0000, wireframe: true)))

  return build;
)
