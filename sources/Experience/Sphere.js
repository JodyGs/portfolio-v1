import * as THREE from 'three'
import Experience from './Experience.js'
import vertexShader from './Shaders/sphere/vertex.glsl'
import fragmentShader from './Shaders/sphere/fragment.glsl'

export default class Sphere {
  constructor() {
    this.experience = new Experience()
    this.scene = this.experience.scene
    this.debug = this.experience.debug
    this.time = this.experience.time
    this.timeFrequency = 0.0001

    if (this.debug) {
      this.debugFolder = this.debug.addFolder({
        title: 'Sphere',
        expanded: true,
      })
    }

    this.setMaterial()
    this.setGeometry()
    this.setMesh()
  }

  setGeometry() {
    this.geometry = new THREE.SphereGeometry(1, 512, 512)
    this.geometry.computeTangents()
  }

  setMaterial() {
    this.material = new THREE.ShaderMaterial({
      vertexShader: vertexShader,
      fragmentShader: fragmentShader,
      uniforms: {
        uTime: { value: 0 },
        uDistortionFrequency: { value: 2 },
        uDistortionStrength: { value: 1.5 },
        uDisplacementFrequency: { value: 2 },
        uDisplacementStrength: { value: 0.2 },
      },
    })

    if (this.debug) {
      this.debugFolder.addInput(this, 'timeFrequency', {
        min: 0,
        max: 0.001,
        step: 0.000001,
      }),
      this.debugFolder.addInput(this.material.uniforms.uDistortionFrequency, 'value', {
          label: 'uDistortionFrequency',
          min: 0,
          max: 10,
          step: 0.001,
        })
      this.debugFolder.addInput(this.material.uniforms.uDistortionStrength, 'value', {
        label: 'uDistortionStrength',
        min: 0,
        max: 10,
        step: 0.001,
      })
      this.debugFolder.addInput(this.material.uniforms.uDisplacementFrequency, 'value', {
        label: 'uDisplacementFrequency',
        min: 0,
        max: 5,
        step: 0.001,
      })
      this.debugFolder.addInput(this.material.uniforms.uDisplacementStrength, 'value', {
        label: 'uDisplacementStrength',
        min: 0,
        max: 1,
        step: 0.001,
      })
    }
  }

  setMesh() {
    this.mesh = new THREE.Mesh(this.geometry, this.material)
    this.scene.add(this.mesh)
  }

  update() {
    this.material.uniforms.uTime.value += this.time.delta * this.timeFrequency
  }
}