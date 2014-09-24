define(() ->
  Settings = () ->
    @pillar_particles = 1000
    @pillar_beams = 1000
    @pillar_color = "#fff"
    @num_stars = 1000
    @disk_particles = 1000
    @disk_clouds = 1000
    @disk_color = "#fff"

  settings = new Settings

  gui = new dat.GUI
  pillar = gui.addFolder("Light Pillar")
  disk = gui.addFolder("Accretion Disk")
  misc = gui.addFolder("Miscellaneous")

  pillar.add(settings, 'pillar_particles', 0, 5000)
  pillar.add(settings, 'pillar_beams', 0, 5000)
  pillar.add(settings, 'pillar_color', 'color0')
  disk.add(settings, 'disk_particles', 0, 5000)
  disk.add(settings, 'disk_clouds', 0, 5000)
  disk.add(settings, 'disk_color', 'color0')
  misc.add(settings, 'num_stars', 0, 5000)

  pillar.open();
  disk.open();
  misc.open();

  return settings: settings, gui: gui
)