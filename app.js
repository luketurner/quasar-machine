// Generated by CoffeeScript 1.7.1
(function() {
  var detriusField, init, initCamera, initControls, initRenderer, initScene, outlineRing, polarToCartesian, vertexField;

  initCamera = function() {
    var camera;
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.z = 25;
    return camera;
  };

  initScene = function() {
    return new THREE.Scene();
  };

  initRenderer = function() {
    var renderer;
    renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(renderer.domElement);
    return renderer;
  };

  initControls = function(camera, onChange) {
    var controls;
    controls = new THREE.TrackballControls(camera);
    controls.rotateSpeed = 1.0;
    controls.zoomSpeed = 1.2;
    controls.panSpeed = 0.8;
    controls.noZoom = false;
    controls.noPan = false;
    controls.staticMoving = true;
    controls.dynamicDampingFactor = 0.3;
    controls.keys = [65, 83, 68];
    controls.addEventListener('change', onChange);
    return controls;
  };

  outlineRing = function(radius, height, segments, color) {
    var geometry, material;
    geometry = new THREE.CylinderGeometry(radius, radius, height, segments, 1, true);
    material = new THREE.MeshBasicMaterial({
      color: color,
      wireframe: true
    });
    return new THREE.Mesh(geometry, material);
  };

  polarToCartesian = function(magnitude, angle) {
    return {
      x: Math.cos(angle) * magnitude,
      y: Math.sin(angle) * magnitude
    };
  };

  vertexField = function(radius, height, n) {
    var coords, _results;
    _results = [];
    while (n -= 1) {
      coords = polarToCartesian(THREE.Math.randFloat(0, radius), THREE.Math.randFloat(0, 2 * Math.PI));
      _results.push(new THREE.Vector3(coords.x, THREE.Math.randFloatSpread(height), coords.y));
    }
    return _results;
  };

  detriusField = function(radius, height, n, color, size) {
    var geometry, material, vector, _i, _len, _ref;
    geometry = new THREE.Geometry();
    _ref = vertexField(radius, height, n);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      vector = _ref[_i];
      geometry.vertices.push(vector);
    }
    material = new THREE.PointCloudMaterial({
      color: color,
      size: size
    });
    return new THREE.PointCloud(geometry, material);
  };

  init = function() {
    var animate, camera, controls, render, renderer, scene;
    scene = initScene();
    camera = initCamera();
    renderer = initRenderer();
    render = function() {
      return renderer.render(scene, camera);
    };
    controls = initControls(camera, render);
    animate = function() {
      requestAnimationFrame(animate);
      return controls.update();
    };
    scene.add(outlineRing(20, 2, 32, 0xff0000));
    scene.add(outlineRing(1, 25, 10, 0xff0000));
    scene.add(outlineRing(0.5, 45, 5, 0xff0000));
    scene.add(detriusField(20, 2, 500, 0xffffff, 0.1));
    scene.add(detriusField(20, 2, 3000, 0xff9999, 0.05));
    render();
    return animate();
  };

  init();

}).call(this);

//# sourceMappingURL=app.map
