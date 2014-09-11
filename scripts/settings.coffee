define(() ->
  makeSetting = (displayName, defaults = {}) ->
    setting =
      _displayName: displayName,
      quantity: defaults.quantity ? 1,
      color: defaults.color ? "#FFFFFF",
      opacity: defaults.opacity ? 1,
      scale: defaults.scale ? 1
    setting.color3 = () => new THREE.Color(setting.color)
    return setting

  beamParticles: makeSetting("Beam particles", quantity: 1000),
  beamClouds: makeSetting("Beam clouds", quantity: 1000, color: "#FFDD99", opacity: 0.05),
  diskClouds: makeSetting("Disk clouds", quantity: 1000),
  diskParticles: makeSetting("Disk particles", quantity: 15000, color: "#FFBBAA"),
  wireframes: makeSetting("Debug Wireframes", color: "#FF0000", opacity: 0),
  starfield: makeSetting("Starfield", quantity: 1000)
)