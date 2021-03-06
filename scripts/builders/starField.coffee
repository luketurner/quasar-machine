define(() ->
  makeStar = (minDist, maxDist) ->
    r = THREE.Math.randFloat(minDist, maxDist)
    theta = THREE.Math.randFloat(0, 2 * Math.PI)
    phi = THREE.Math.randFloat(0, 2 * Math.PI)
    new THREE.Vector3(
      r * Math.sin(theta) * Math.cos(phi),
      r * Math.sin(theta) * Math.sin(phi),
      r * Math.cos(theta)
    )

  makeStarField = (n, min, max) ->
    geometry = new THREE.Geometry()
    while n -= 1
      geometry.vertices.push(makeStar(min, max))
    material = new THREE.PointCloudMaterial(color: 0xffffff, size: 0.1)
    return new THREE.PointCloud(geometry, material)


  return (settings) ->
    starField = new THREE.Object3D()
    starField.add(makeStarField(settings.num_stars, 750, 1000))
    return starField
)