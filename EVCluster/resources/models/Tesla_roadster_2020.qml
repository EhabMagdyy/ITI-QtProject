import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    property url textureData: "maps/textureData.png"
    property url textureData46: "maps/textureData46.png"
    property url textureData109: "maps/textureData109.jpg"
    property url textureData32: "maps/textureData32.png"
    property url textureData111: "maps/textureData111.png"
    property url textureData113: "maps/textureData113.jpg"
    property url textureData30: "maps/textureData30.png"
    property url textureData23: "maps/textureData23.png"
    property url textureData25: "maps/textureData25.png"
    property url textureData44: "maps/textureData44.png"
    Texture {
        id: _1_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData25
    }
    Texture {
        id: _4_texture
        pivotV: 1
        scaleU: 20
        scaleV: 20
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData
    }
    Texture {
        id: _5_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData44
    }
    Texture {
        id: _3_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData32
    }
    Texture {
        id: _2_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData30
    }
    Texture {
        id: _6_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData46
    }
    Texture {
        id: _0_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData23
    }
    Texture {
        id: _9_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData113
    }
    Texture {
        id: _8_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData111
    }
    Texture {
        id: _7_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData109
    }
    PrincipledMaterial {
        id: glass_rear_lights_main_material
        objectName: "Glass_rear_lights_main"
        baseColor: "#ffff0000"
        roughness: 0.3818179965019226
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: ior_1_material
        objectName: "ior_1"
        baseColor: "#ffff0000"
        roughness: 0.6837722063064575
        emissiveFactor: Qt.vector3d(1, 0, 0)
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: glass_Tint_max_material
        objectName: "Glass_Tint_max"
        baseColor: "#67000000"
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Blend
        transmissionFactor: 0.59775310754776
    }
    PrincipledMaterial {
        id: licence_plate_light_material
        objectName: "licence_plate_light"
        metalness: 1
        roughness: 1
        emissiveFactor: Qt.vector3d(1, 1, 1)
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: glass_rear_lights_DHO_material
        objectName: "Glass_rear_lights_DHO"
        baseColor: "#ffff0000"
        roughness: 0.3818179965019226
        emissiveFactor: Qt.vector3d(1, 0, 0)
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: headlights_AHO_material
        objectName: "headlights_AHO"
        baseColor: "#ff1e1e1e"
        metalness: 1
        emissiveFactor: Qt.vector3d(0.628106, 0.642462, 1)
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: calipers_material
        objectName: "calipers"
        baseColor: "#ff0024ff"
        metalness: 0.16554182767868042
        roughness: 0.25826799869537354
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
        clearcoatAmount: 1
        clearcoatRoughnessAmount: 0.03999999910593033
    }
    PrincipledMaterial {
        id: glass_mid_tint_material
        objectName: "Glass_mid_tint"
        baseColor: "#f8020202"
        metalness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Blend
        clearcoatAmount: 1
        clearcoatRoughnessAmount: 0.1569528579711914
        transmissionFactor: 0.02845700830221176
    }
    PrincipledMaterial {
        id: interior_material
        objectName: "interior"
        baseColor: "#ff373737"
        metalness: 1
        roughness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: seats_material
        objectName: "seats"
        metalness: 1
        roughness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: non_lustrous_metal_material
        objectName: "non_lustrous_metal"
        baseColor: "#ff030305"
        roughness: 0.5527859926223755
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: grill_material
        objectName: "grill"
        baseColorMap: _5_texture
        metalness: 0.6618180274963379
        normalMap: _6_texture
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Mask
        depthDrawMode: PrincipledMaterial.OpaquePrePassDepthDraw
    }
    PrincipledMaterial {
        id: car_main_paint_material
        objectName: "car_main_paint"
        metalness: 0.478753924369812
        normalMap: _4_texture
        normalStrength: 0.028952470049262047
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
        clearcoatAmount: 1
        clearcoatRoughnessAmount: 0.11698693782091141
    }
    PrincipledMaterial {
        id: sidewall_material
        objectName: "Sidewall"
        baseColor: "#ff212121"
        baseColorMap: _2_texture
        roughness: 0.36530017852783203
        normalMap: _3_texture
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: thread_material
        objectName: "Thread"
        baseColor: "#ff1f1f1f"
        baseColorMap: _0_texture
        roughness: 0.14697588980197906
        normalMap: _1_texture
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: brake_Disc_material
        objectName: "Brake_Disc"
        baseColor: "#ff4d4d4d"
        metalness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: metal___Black_rough_material
        objectName: "Metal_-_Black_rough"
        baseColor: "#ff030303"
        metalness: 1
        roughness: 0.1668429970741272
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: mirror_material
        objectName: "mirror"
        metalness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
        clearcoatAmount: 1
        clearcoatRoughnessAmount: 0.03999999910593033
    }
    PrincipledMaterial {
        id: rims_material
        objectName: "Rims"
        baseColor: "#ff0c0c0c"
        metalness: 1
        roughness: 0.10385099798440933
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: headlights_main_material
        objectName: "headlights_main"
        baseColor: "#ff1e1e1e"
        metalness: 1
        emissiveFactor: Qt.vector3d(1, 1, 1)
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: glass_Clear_material
        objectName: "Glass_Clear"
        baseColor: "#40ffffff"
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Blend
        clearcoatAmount: 1
        clearcoatRoughnessAmount: 0.03999999910593033
        transmissionFactor: 0.9740535020828247
    }
    PrincipledMaterial {
        id: chrome_material
        objectName: "chrome"
        metalness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: indicator_right_material
        objectName: "indicator_right"
        baseColor: "#ff1e1e1e"
        metalness: 1
        emissiveFactor: Qt.vector3d(1, 0.0153921, 0)
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: indicator_left_material
        objectName: "indicator_left"
        baseColor: "#ff1e1e1e"
        metalness: 1
        emissiveFactor: Qt.vector3d(1, 0.0153921, 0)
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: glass_Amber_material
        objectName: "Glass_Amber"
        baseColor: "#ffff3600"
        roughness: 0.13385799527168274
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: carbon_fibre_material
        objectName: "carbon_fibre"
        baseColorMap: _7_texture
        metalnessMap: _8_texture
        roughnessMap: _8_texture
        metalness: 1
        roughness: 1
        normalMap: _9_texture
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }

    // Nodes:
    Node {
        id: sketchfab_model
        objectName: "Sketchfab_model"
        rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
        scale: Qt.vector3d(0.01, 0.01, 0.01)
        Node {
            id: tesla_roadster_2020_fbx
            objectName: "tesla roadster 2020.fbx"
            rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)
            Node {
                id: rootNode
                objectName: "RootNode"
                Node {
                    id: tr_DEF_Wheel_Ft_R
                    objectName: "TR.DEF-Wheel.Ft.R"
                    position: Qt.vector3d(-83.8029, 31.3331, 153.422)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_Wheel_Ft_R_Rims_0
                        objectName: "TR.DEF-Wheel.Ft.R_Rims_0"
                        source: "meshes/tr_DEF_Wheel_Ft_R_Rims_0_mesh.mesh"
                        materials: [
                            rims_material
                        ]
                    }
                    Model {
                        id: tr_DEF_Wheel_Ft_R_mirror_0
                        objectName: "TR.DEF-Wheel.Ft.R_mirror_0"
                        source: "meshes/tr_DEF_Wheel_Ft_R_mirror_0_mesh.mesh"
                        materials: [
                            mirror_material
                        ]
                    }
                    Model {
                        id: tr_DEF_Wheel_Ft_R_Metal___Black_rough_0
                        objectName: "TR.DEF-Wheel.Ft.R_Metal - Black rough_0"
                        source: "meshes/tr_DEF_Wheel_Ft_R_Metal___Black_rough_0_mesh.mesh"
                        materials: [
                            metal___Black_rough_material
                        ]
                    }
                    Node {
                        id: roadster_080
                        objectName: "roadster.080"
                        position: Qt.vector3d(0.100258, 4.57764e-05, 1.22074e-05)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_080_Brake_Disc_0
                            objectName: "roadster.080_Brake Disc_0"
                            source: "meshes/roadster_080_Brake_Disc_0_mesh.mesh"
                            materials: [
                                brake_Disc_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_002
                        objectName: "roadster.002"
                        position: Qt.vector3d(0.0597706, 0, -1.15382e-08)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_002_Thread_0
                            objectName: "roadster.002_Thread_0"
                            source: "meshes/roadster_002_Thread_0_mesh.mesh"
                            materials: [
                                thread_material
                            ]
                        }
                        Model {
                            id: roadster_002_Sidewall_0
                            objectName: "roadster.002_Sidewall_0"
                            source: "meshes/roadster_002_Sidewall_0_mesh.mesh"
                            materials: [
                                sidewall_material
                            ]
                        }
                    }
                }
                Node {
                    id: tr_DEF_Body
                    objectName: "TR.DEF-Body"
                    position: Qt.vector3d(0, 54.1371, -2.14175)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_Body_car_main_paint_0
                        objectName: "TR.DEF-Body_car main paint_0"
                        source: "meshes/tr_DEF_Body_car_main_paint_0_mesh.mesh"
                        materials: [
                            car_main_paint_material
                        ]
                    }
                    Node {
                        id: roadster_005
                        objectName: "roadster.005"
                        position: Qt.vector3d(3.17767e-06, -2.22083, -0.359173)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_005_grill_0
                            objectName: "roadster.005_grill_0"
                            source: "meshes/roadster_005_grill_0_mesh.mesh"
                            materials: [
                                grill_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_007
                        objectName: "roadster.007"
                        position: Qt.vector3d(0.003219, -0.682503, 0.413236)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_007_Glass_mid_tint_0
                            objectName: "roadster.007_Glass mid tint_0"
                            source: "meshes/roadster_007_Glass_mid_tint_0_mesh.mesh"
                            materials: [
                                glass_mid_tint_material
                            ]
                        }
                        Node {
                            id: roadster_082
                            objectName: "roadster.082"
                            position: Qt.vector3d(-0.003219, 0.682503, -0.413236)
                            rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                            Model {
                                id: roadster_082_car_main_paint_0
                                objectName: "roadster.082_car main paint_0"
                                source: "meshes/roadster_082_car_main_paint_0_mesh.mesh"
                                materials: [
                                    car_main_paint_material
                                ]
                            }
                        }
                    }
                    Node {
                        id: roadster_008
                        objectName: "roadster.008"
                        position: Qt.vector3d(-1.33738e-06, -0.0489321, 0.217313)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_008_interior_0
                            objectName: "roadster.008_interior_0"
                            source: "meshes/roadster_008_interior_0_mesh.mesh"
                            materials: [
                                interior_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_009
                        objectName: "roadster.009"
                        position: Qt.vector3d(0.000353906, 0.103066, -0.064742)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_009_seats_0
                            objectName: "roadster.009_seats_0"
                            source: "meshes/roadster_009_seats_0_mesh.mesh"
                            materials: [
                                seats_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_010
                        objectName: "roadster.010"
                        position: Qt.vector3d(0.000352673, 0.289836, 0.397625)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_010_seats_0
                            objectName: "roadster.010_seats_0"
                            source: "meshes/roadster_010_seats_0_mesh.mesh"
                            materials: [
                                seats_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_011
                        objectName: "roadster.011"
                        position: Qt.vector3d(0.00224999, -0.183268, 0.501365)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_011_mirror_0
                            objectName: "roadster.011_mirror_0"
                            source: "meshes/roadster_011_mirror_0_mesh.mesh"
                            materials: [
                                mirror_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_012
                        objectName: "roadster.012"
                        position: Qt.vector3d(0.000283331, -0.204842, 0.497011)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_012_Metal___Black_rough_0
                            objectName: "roadster.012_Metal - Black rough_0"
                            source: "meshes/roadster_012_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_013
                        objectName: "roadster.013"
                        position: Qt.vector3d(-8.90344e-07, 1.16607, 0.371624)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_013_Metal___Black_rough_0
                            objectName: "roadster.013_Metal - Black rough_0"
                            source: "meshes/roadster_013_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_014
                        objectName: "roadster.014"
                        position: Qt.vector3d(0.349208, -0.461997, 0.108345)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_014_Metal___Black_rough_0
                            objectName: "roadster.014_Metal - Black rough_0"
                            source: "meshes/roadster_014_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_015
                        objectName: "roadster.015"
                        position: Qt.vector3d(6.96629e-07, -0.465068, -0.0154398)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_015_car_main_paint_0
                            objectName: "roadster.015_car main paint_0"
                            source: "meshes/roadster_015_car_main_paint_0_mesh.mesh"
                            materials: [
                                car_main_paint_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_016
                        objectName: "roadster.016"
                        position: Qt.vector3d(-1.19209e-07, 0.772497, 0.384799)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_016_Metal___Black_rough_0
                            objectName: "roadster.016_Metal - Black rough_0"
                            source: "meshes/roadster_016_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_017
                        objectName: "roadster.017"
                        position: Qt.vector3d(3.76254e-07, 0.331558, 0.396484)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_017_Metal___Black_rough_0
                            objectName: "roadster.017_Metal - Black rough_0"
                            source: "meshes/roadster_017_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_018
                        objectName: "roadster.018"
                        position: Qt.vector3d(1.2666e-06, -0.682841, 0.275597)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_018_non_lustrous_metal_0
                            objectName: "roadster.018_non lustrous metal_0"
                            source: "meshes/roadster_018_non_lustrous_metal_0_mesh.mesh"
                            materials: [
                                non_lustrous_metal_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_019
                        objectName: "roadster.019"
                        position: Qt.vector3d(1.78814e-06, -0.769207, 0.241271)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_019_Glass_mid_tint_0
                            objectName: "roadster.019_Glass mid tint_0"
                            source: "meshes/roadster_019_Glass_mid_tint_0_mesh.mesh"
                            materials: [
                                glass_mid_tint_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_020
                        objectName: "roadster.020"
                        position: Qt.vector3d(1.97068e-06, -0.778634, 0.245204)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_020_Metal___Black_rough_0
                            objectName: "roadster.020_Metal - Black rough_0"
                            source: "meshes/roadster_020_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_021
                        objectName: "roadster.021"
                        position: Qt.vector3d(1.52364e-06, -0.679982, 0.410645)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_021_Metal___Black_rough_0
                            objectName: "roadster.021_Metal - Black rough_0"
                            source: "meshes/roadster_021_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_022
                        objectName: "roadster.022"
                        position: Qt.vector3d(-0.000411335, 1.14617, 0.367738)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_022_grill_0
                            objectName: "roadster.022_grill_0"
                            source: "meshes/roadster_022_grill_0_mesh.mesh"
                            materials: [
                                grill_material
                            ]
                        }
                        Model {
                            id: roadster_022_non_lustrous_metal_0
                            objectName: "roadster.022_non lustrous metal_0"
                            source: "meshes/roadster_022_non_lustrous_metal_0_mesh.mesh"
                            materials: [
                                non_lustrous_metal_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_024
                        objectName: "roadster.024"
                        position: Qt.vector3d(2.70456e-06, -2.19764, -0.426716)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_024_carbon_fibre_0
                            objectName: "roadster.024_carbon fibre_0"
                            source: "meshes/roadster_024_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_025
                        objectName: "roadster.025"
                        position: Qt.vector3d(2.68593e-06, -1.92838, -0.138578)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_025_Glass_Amber_0
                            objectName: "roadster.025_Glass Amber_0"
                            source: "meshes/roadster_025_Glass_Amber_0_mesh.mesh"
                            materials: [
                                glass_Amber_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_026
                        objectName: "roadster.026"
                        position: Qt.vector3d(2.59653e-06, -1.92845, -0.13849)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_026_Metal___Black_rough_0
                            objectName: "roadster.026_Metal - Black rough_0"
                            source: "meshes/roadster_026_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                        Model {
                            id: roadster_026_indicator_left_0
                            objectName: "roadster.026_indicator left_0"
                            source: "meshes/roadster_026_indicator_left_0_mesh.mesh"
                            materials: [
                                indicator_left_material
                            ]
                        }
                        Model {
                            id: roadster_026_indicator_right_0
                            objectName: "roadster.026_indicator right_0"
                            source: "meshes/roadster_026_indicator_right_0_mesh.mesh"
                            materials: [
                                indicator_right_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_027
                        objectName: "roadster.027"
                        position: Qt.vector3d(1.99303e-06, -1.13715, 0.0507575)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_027_chrome_0
                            objectName: "roadster.027_chrome_0"
                            source: "meshes/roadster_027_chrome_0_mesh.mesh"
                            materials: [
                                chrome_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_028
                        objectName: "roadster.028"
                        position: Qt.vector3d(2.61888e-06, -1.66702, -0.0485283)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_028_carbon_fibre_0
                            objectName: "roadster.028_carbon fibre_0"
                            source: "meshes/roadster_028_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_029
                        objectName: "roadster.029"
                        position: Qt.vector3d(3.03611e-06, -2.05803, -0.0400772)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_029_Glass_Clear_0
                            objectName: "roadster.029_Glass Clear_0"
                            source: "meshes/roadster_029_Glass_Clear_0_mesh.mesh"
                            materials: [
                                glass_Clear_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_030
                        objectName: "roadster.030"
                        position: Qt.vector3d(3.1814e-06, -2.0614, -0.0373032)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_030_carbon_fibre_0
                            objectName: "roadster.030_carbon fibre_0"
                            source: "meshes/roadster_030_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_031
                        objectName: "roadster.031"
                        position: Qt.vector3d(3.02866e-06, -2.06895, -0.0652905)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_031_carbon_fibre_0
                            objectName: "roadster.031_carbon fibre_0"
                            source: "meshes/roadster_031_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_032
                        objectName: "roadster.032"
                        position: Qt.vector3d(3.39001e-06, -2.08848, -0.052942)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_032_headlights_AHO_0
                            objectName: "roadster.032_headlights AHO_0"
                            source: "meshes/roadster_032_headlights_AHO_0_mesh.mesh"
                            materials: [
                                headlights_AHO_material
                            ]
                        }
                        Model {
                            id: roadster_032_carbon_fibre_0
                            objectName: "roadster.032_carbon fibre_0"
                            source: "meshes/roadster_032_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_033
                        objectName: "roadster.033"
                        position: Qt.vector3d(2.74554e-06, -2.01845, -0.0366402)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_033_headlights_AHO_0
                            objectName: "roadster.033_headlights AHO_0"
                            source: "meshes/roadster_033_headlights_AHO_0_mesh.mesh"
                            materials: [
                                headlights_AHO_material
                            ]
                        }
                        Model {
                            id: roadster_033_carbon_fibre_0
                            objectName: "roadster.033_carbon fibre_0"
                            source: "meshes/roadster_033_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_034
                        objectName: "roadster.034"
                        position: Qt.vector3d(2.86847e-06, -2.01158, -0.0365824)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_034_carbon_fibre_0
                            objectName: "roadster.034_carbon fibre_0"
                            source: "meshes/roadster_034_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_035
                        objectName: "roadster.035"
                        position: Qt.vector3d(3.46079e-06, -2.01943, -0.0366485)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_035_headlights_main_0
                            objectName: "roadster.035_headlights main_0"
                            source: "meshes/roadster_035_headlights_main_0_mesh.mesh"
                            materials: [
                                headlights_main_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_036
                        objectName: "roadster.036"
                        position: Qt.vector3d(3.41982e-06, -2.00235, -0.0365048)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_036_carbon_fibre_0
                            objectName: "roadster.036_carbon fibre_0"
                            source: "meshes/roadster_036_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_037
                        objectName: "roadster.037"
                        position: Qt.vector3d(2.01538e-06, -2.02612, -0.0367048)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_037_Glass_Clear_0
                            objectName: "roadster.037_Glass Clear_0"
                            source: "meshes/roadster_037_Glass_Clear_0_mesh.mesh"
                            materials: [
                                glass_Clear_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_038
                        objectName: "roadster.038"
                        position: Qt.vector3d(3.18512e-06, -2.2096, -0.0502466)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_038_chrome_0
                            objectName: "roadster.038_chrome_0"
                            source: "meshes/roadster_038_chrome_0_mesh.mesh"
                            materials: [
                                chrome_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_039
                        objectName: "roadster.039"
                        position: Qt.vector3d(-0.00469379, 2.10289, 0.225131)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_039_chrome_0
                            objectName: "roadster.039_chrome_0"
                            source: "meshes/roadster_039_chrome_0_mesh.mesh"
                            materials: [
                                chrome_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_040
                        objectName: "roadster.040"
                        position: Qt.vector3d(3.10317e-06, -2.19461, -0.364583)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_040_carbon_fibre_0
                            objectName: "roadster.040_carbon fibre_0"
                            source: "meshes/roadster_040_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_041
                        objectName: "roadster.041"
                        position: Qt.vector3d(-0.00144308, -2.15949, -0.309577)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_041_Metal___Black_rough_0
                            objectName: "roadster.041_Metal - Black rough_0"
                            source: "meshes/roadster_041_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_042
                        objectName: "roadster.042"
                        position: Qt.vector3d(0, 2.23517e-08, 3.48935e-09)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_042_mirror_0
                            objectName: "roadster.042_mirror_0"
                            source: "meshes/roadster_042_mirror_0_mesh.mesh"
                            materials: [
                                mirror_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_043
                        objectName: "roadster.043"
                        position: Qt.vector3d(-9.05246e-07, 1.98821, -0.271724)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_043_carbon_fibre_0
                            objectName: "roadster.043_carbon fibre_0"
                            source: "meshes/roadster_043_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_044
                        objectName: "roadster.044"
                        position: Qt.vector3d(-2.09734e-06, 2.11306, -0.172426)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_044_Glass_Clear_0
                            objectName: "roadster.044_Glass Clear_0"
                            source: "meshes/roadster_044_Glass_Clear_0_mesh.mesh"
                            materials: [
                                glass_Clear_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_045
                        objectName: "roadster.045"
                        position: Qt.vector3d(-1.93343e-06, 2.10788, -0.171354)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_045_Metal___Black_rough_0
                            objectName: "roadster.045_Metal - Black rough_0"
                            source: "meshes/roadster_045_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_046
                        objectName: "roadster.046"
                        position: Qt.vector3d(-2.07871e-06, 2.13507, 0.101365)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_046_Glass_Tint_max_0
                            objectName: "roadster.046_Glass Tint max_0"
                            source: "meshes/roadster_046_Glass_Tint_max_0_mesh.mesh"
                            materials: [
                                glass_Tint_max_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_047
                        objectName: "roadster.047"
                        position: Qt.vector3d(-2.10479e-06, 2.13056, 0.103528)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_047_non_lustrous_metal_0
                            objectName: "roadster.047_non lustrous metal_0"
                            source: "meshes/roadster_047_non_lustrous_metal_0_mesh.mesh"
                            materials: [
                                non_lustrous_metal_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_048
                        objectName: "roadster.048"
                        position: Qt.vector3d(-2.05636e-06, 2.132, 0.114187)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_048_Glass_Clear_0
                            objectName: "roadster.048_Glass Clear_0"
                            source: "meshes/roadster_048_Glass_Clear_0_mesh.mesh"
                            materials: [
                                glass_Clear_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_049
                        objectName: "roadster.049"
                        position: Qt.vector3d(-2.03773e-06, 2.13195, 0.120879)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_049_Metal___Black_rough_0
                            objectName: "roadster.049_Metal - Black rough_0"
                            source: "meshes/roadster_049_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                        Model {
                            id: roadster_049_licence_plate_light_0
                            objectName: "roadster.049_licence plate light_0"
                            source: "meshes/roadster_049_licence_plate_light_0_mesh.mesh"
                            materials: [
                                licence_plate_light_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_050
                        objectName: "roadster.050"
                        position: Qt.vector3d(-2.10479e-06, 2.10952, -0.171204)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_050_Glass_rear_lights_main_0
                            objectName: "roadster.050_Glass rear lights main_0"
                            source: "meshes/roadster_050_Glass_rear_lights_main_0_mesh.mesh"
                            materials: [
                                glass_rear_lights_main_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_051
                        objectName: "roadster.051"
                        position: Qt.vector3d(-1.6354e-06, 1.77879, -0.174903)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_051_Glass_Amber_0
                            objectName: "roadster.051_Glass Amber_0"
                            source: "meshes/roadster_051_Glass_Amber_0_mesh.mesh"
                            materials: [
                                glass_Amber_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_052
                        objectName: "roadster.052"
                        position: Qt.vector3d(-1.83284e-06, 1.77891, -0.175267)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_052_Metal___Black_rough_0
                            objectName: "roadster.052_Metal - Black rough_0"
                            source: "meshes/roadster_052_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                        Model {
                            id: roadster_052_indicator_left_0
                            objectName: "roadster.052_indicator left_0"
                            source: "meshes/roadster_052_indicator_left_0_mesh.mesh"
                            materials: [
                                indicator_left_material
                            ]
                        }
                        Model {
                            id: roadster_052_indicator_right_0
                            objectName: "roadster.052_indicator right_0"
                            source: "meshes/roadster_052_indicator_right_0_mesh.mesh"
                            materials: [
                                indicator_right_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_053
                        objectName: "roadster.053"
                        position: Qt.vector3d(-4.17233e-07, 0.803072, 0.386409)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_053_Glass_mid_tint_0
                            objectName: "roadster.053_Glass mid tint_0"
                            source: "meshes/roadster_053_Glass_mid_tint_0_mesh.mesh"
                            materials: [
                                glass_mid_tint_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_054
                        objectName: "roadster.054"
                        position: Qt.vector3d(-7.0408e-07, 1.07896, 0.479554)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_054_Glass_mid_tint_0
                            objectName: "roadster.054_Glass mid tint_0"
                            source: "meshes/roadster_054_Glass_mid_tint_0_mesh.mesh"
                            materials: [
                                glass_mid_tint_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_055
                        objectName: "roadster.055"
                        position: Qt.vector3d(-6.29574e-07, 1.13018, 0.466346)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_055_Metal___Black_rough_0
                            objectName: "roadster.055_Metal - Black rough_0"
                            source: "meshes/roadster_055_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_056
                        objectName: "roadster.056"
                        position: Qt.vector3d(1.49012e-07, 0.137819, 0.58738)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_056_Glass_Tint_max_0
                            objectName: "roadster.056_Glass Tint max_0"
                            source: "meshes/roadster_056_Glass_Tint_max_0_mesh.mesh"
                            materials: [
                                glass_Tint_max_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_057
                        objectName: "roadster.057"
                        position: Qt.vector3d(6.44475e-07, 0.11081, 0.557)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_057_Glass_Tint_max_0
                            objectName: "roadster.057_Glass Tint max_0"
                            source: "meshes/roadster_057_Glass_Tint_max_0_mesh.mesh"
                            materials: [
                                glass_Tint_max_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_058
                        objectName: "roadster.058"
                        position: Qt.vector3d(5.55068e-07, 0.104899, 0.553037)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_058_car_main_paint_0
                            objectName: "roadster.058_car main paint_0"
                            source: "meshes/roadster_058_car_main_paint_0_mesh.mesh"
                            materials: [
                                car_main_paint_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_059
                        objectName: "roadster.059"
                        position: Qt.vector3d(5.36442e-07, -0.177109, 0.349986)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_059_Glass_mid_tint_0
                            objectName: "roadster.059_Glass mid tint_0"
                            source: "meshes/roadster_059_Glass_mid_tint_0_mesh.mesh"
                            materials: [
                                glass_mid_tint_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_060
                        objectName: "roadster.060"
                        position: Qt.vector3d(-1.88127e-06, 2.04641, 0.277524)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_060_car_main_paint_0
                            objectName: "roadster.060_car main paint_0"
                            source: "meshes/roadster_060_car_main_paint_0_mesh.mesh"
                            materials: [
                                car_main_paint_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_061
                        objectName: "roadster.061"
                        position: Qt.vector3d(-1.9595e-06, 2.11179, 0.270163)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_061_ior_1_0
                            objectName: "roadster.061_ior 1_0"
                            source: "meshes/roadster_061_ior_1_0_mesh.mesh"
                            materials: [
                                ior_1_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_062
                        objectName: "roadster.062"
                        position: Qt.vector3d(-1.75834e-06, 2.084, 0.266578)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_062_car_main_paint_0
                            objectName: "roadster.062_car main paint_0"
                            source: "meshes/roadster_062_car_main_paint_0_mesh.mesh"
                            materials: [
                                car_main_paint_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_063
                        objectName: "roadster.063"
                        position: Qt.vector3d(-2.03028e-06, 2.10545, 0.27018)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_063_carbon_fibre_0
                            objectName: "roadster.063_carbon fibre_0"
                            source: "meshes/roadster_063_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_064
                        objectName: "roadster.064"
                        position: Qt.vector3d(-2.03028e-06, 2.11212, 0.270181)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_064_Glass_rear_lights_main_0
                            objectName: "roadster.064_Glass rear lights main_0"
                            source: "meshes/roadster_064_Glass_rear_lights_main_0_mesh.mesh"
                            materials: [
                                glass_rear_lights_main_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_065
                        objectName: "roadster.065"
                        position: Qt.vector3d(-2.23145e-06, 1.93561, 0.214757)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_065_Glass_rear_lights_DHO_0
                            objectName: "roadster.065_Glass rear lights DHO_0"
                            source: "meshes/roadster_065_Glass_rear_lights_DHO_0_mesh.mesh"
                            materials: [
                                glass_rear_lights_DHO_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_066
                        objectName: "roadster.066"
                        position: Qt.vector3d(-1.46776e-06, 1.83743, 0.226512)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_066_Glass_Clear_0
                            objectName: "roadster.066_Glass Clear_0"
                            source: "meshes/roadster_066_Glass_Clear_0_mesh.mesh"
                            materials: [
                                glass_Clear_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_067
                        objectName: "roadster.067"
                        position: Qt.vector3d(-1.68011e-06, 1.82939, 0.227038)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_067_carbon_fibre_0
                            objectName: "roadster.067_carbon fibre_0"
                            source: "meshes/roadster_067_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_068
                        objectName: "roadster.068"
                        position: Qt.vector3d(-1.91852e-06, 1.914, 0.21458)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_068_carbon_fibre_0
                            objectName: "roadster.068_carbon fibre_0"
                            source: "meshes/roadster_068_carbon_fibre_0_mesh.mesh"
                            materials: [
                                carbon_fibre_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_069
                        objectName: "roadster.069"
                        position: Qt.vector3d(-2.06381e-06, 1.81801, 0.226334)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_069_Glass_rear_lights_main_0
                            objectName: "roadster.069_Glass rear lights main_0"
                            source: "meshes/roadster_069_Glass_rear_lights_main_0_mesh.mesh"
                            materials: [
                                glass_rear_lights_main_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_070
                        objectName: "roadster.070"
                        position: Qt.vector3d(3.53903e-07, -0.0882024, -0.252885)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_070_Metal___Black_rough_0
                            objectName: "roadster.070_Metal - Black rough_0"
                            source: "meshes/roadster_070_Metal___Black_rough_0_mesh.mesh"
                            materials: [
                                metal___Black_rough_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_071
                        objectName: "roadster.071"
                        position: Qt.vector3d(0, 2.23517e-08, 3.48935e-09)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_071_mirror_0
                            objectName: "roadster.071_mirror_0"
                            source: "meshes/roadster_071_mirror_0_mesh.mesh"
                            materials: [
                                mirror_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_077
                        objectName: "roadster.077"
                        position: Qt.vector3d(0, 2.23517e-08, 3.48935e-09)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_077_mirror_0
                            objectName: "roadster.077_mirror_0"
                            source: "meshes/roadster_077_mirror_0_mesh.mesh"
                            materials: [
                                mirror_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_079
                        objectName: "roadster.079"
                        position: Qt.vector3d(0, 2.23517e-08, 3.48935e-09)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_079_mirror_0
                            objectName: "roadster.079_mirror_0"
                            source: "meshes/roadster_079_mirror_0_mesh.mesh"
                            materials: [
                                mirror_material
                            ]
                        }
                    }
                }
                Node {
                    id: tr_DEF_WheelBrake_Ft_R
                    objectName: "TR.DEF-WheelBrake.Ft.R"
                    position: Qt.vector3d(-73.0719, 31.3379, 140.088)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_WheelBrake_Ft_R_calipers_0
                        objectName: "TR.DEF-WheelBrake.Ft.R_calipers_0"
                        source: "meshes/tr_DEF_WheelBrake_Ft_R_calipers_0_mesh.mesh"
                        materials: [
                            calipers_material
                        ]
                    }
                }
                Node {
                    id: tr_DEF_Wheel_Ft_L
                    objectName: "TR.DEF-Wheel.Ft.L"
                    position: Qt.vector3d(83.8029, 31.3313, 153.418)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_Wheel_Ft_L_Rims_0
                        objectName: "TR.DEF-Wheel.Ft.L_Rims_0"
                        source: "meshes/tr_DEF_Wheel_Ft_L_Rims_0_mesh.mesh"
                        materials: [
                            rims_material
                        ]
                    }
                    Model {
                        id: tr_DEF_Wheel_Ft_L_mirror_0
                        objectName: "TR.DEF-Wheel.Ft.L_mirror_0"
                        source: "meshes/tr_DEF_Wheel_Ft_L_mirror_0_mesh.mesh"
                        materials: [
                            mirror_material
                        ]
                    }
                    Model {
                        id: tr_DEF_Wheel_Ft_L_Metal___Black_rough_0
                        objectName: "TR.DEF-Wheel.Ft.L_Metal - Black rough_0"
                        source: "meshes/tr_DEF_Wheel_Ft_L_Metal___Black_rough_0_mesh.mesh"
                        materials: [
                            metal___Black_rough_material
                        ]
                    }
                    Node {
                        id: roadster_072
                        objectName: "roadster.072"
                        position: Qt.vector3d(-0.100258, -4.56572e-05, 1.22074e-05)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_072_Brake_Disc_0
                            objectName: "roadster.072_Brake Disc_0"
                            source: "meshes/roadster_072_Brake_Disc_0_mesh.mesh"
                            materials: [
                                brake_Disc_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_001
                        objectName: "roadster.001"
                        position: Qt.vector3d(-0.0597706, 3.57628e-07, -1.15304e-08)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_001_Thread_0
                            objectName: "roadster.001_Thread_0"
                            source: "meshes/roadster_001_Thread_0_mesh.mesh"
                            materials: [
                                thread_material
                            ]
                        }
                        Model {
                            id: roadster_001_Sidewall_0
                            objectName: "roadster.001_Sidewall_0"
                            source: "meshes/roadster_001_Sidewall_0_mesh.mesh"
                            materials: [
                                sidewall_material
                            ]
                        }
                    }
                }
                Node {
                    id: tr_DEF_WheelBrake_Ft_L
                    objectName: "TR.DEF-WheelBrake.Ft.L"
                    position: Qt.vector3d(83.8029, 31.3313, 153.418)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_WheelBrake_Ft_L_calipers_0
                        objectName: "TR.DEF-WheelBrake.Ft.L_calipers_0"
                        source: "meshes/tr_DEF_WheelBrake_Ft_L_calipers_0_mesh.mesh"
                        materials: [
                            calipers_material
                        ]
                    }
                }
                Node {
                    id: tr_DEF_Wheel_Bk_L
                    objectName: "TR.DEF-Wheel.Bk.L"
                    position: Qt.vector3d(87.4251, 34.1271, -138.741)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_Wheel_Bk_L_Rims_0
                        objectName: "TR.DEF-Wheel.Bk.L_Rims_0"
                        source: "meshes/tr_DEF_Wheel_Bk_L_Rims_0_mesh.mesh"
                        materials: [
                            rims_material
                        ]
                    }
                    Model {
                        id: tr_DEF_Wheel_Bk_L_mirror_0
                        objectName: "TR.DEF-Wheel.Bk.L_mirror_0"
                        source: "meshes/tr_DEF_Wheel_Bk_L_mirror_0_mesh.mesh"
                        materials: [
                            mirror_material
                        ]
                    }
                    Model {
                        id: tr_DEF_Wheel_Bk_L_Metal___Black_rough_0
                        objectName: "TR.DEF-Wheel.Bk.L_Metal - Black rough_0"
                        source: "meshes/tr_DEF_Wheel_Bk_L_Metal___Black_rough_0_mesh.mesh"
                        materials: [
                            metal___Black_rough_material
                        ]
                    }
                    Node {
                        id: roadster_074
                        objectName: "roadster.074"
                        position: Qt.vector3d(-0.118483, -4.8399e-05, 1.29218e-05)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_074_Brake_Disc_0
                            objectName: "roadster.074_Brake Disc_0"
                            source: "meshes/roadster_074_Brake_Disc_0_mesh.mesh"
                            materials: [
                                brake_Disc_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_003
                        objectName: "roadster.003"
                        position: Qt.vector3d(-0.070636, 1.19209e-07, -1.23815e-08)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_003_Thread_0
                            objectName: "roadster.003_Thread_0"
                            source: "meshes/roadster_003_Thread_0_mesh.mesh"
                            materials: [
                                thread_material
                            ]
                        }
                        Model {
                            id: roadster_003_Sidewall_0
                            objectName: "roadster.003_Sidewall_0"
                            source: "meshes/roadster_003_Sidewall_0_mesh.mesh"
                            materials: [
                                sidewall_material
                            ]
                        }
                    }
                }
                Node {
                    id: tr_DEF_WheelBrake_Bk_L
                    objectName: "TR.DEF-WheelBrake.Bk.L"
                    position: Qt.vector3d(87.4251, 34.1271, -138.741)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_WheelBrake_Bk_L_calipers_0
                        objectName: "TR.DEF-WheelBrake.Bk.L_calipers_0"
                        source: "meshes/tr_DEF_WheelBrake_Bk_L_calipers_0_mesh.mesh"
                        materials: [
                            calipers_material
                        ]
                    }
                }
                Node {
                    id: tr_DEF_Wheel_Bk_R
                    objectName: "TR.DEF-Wheel.Bk.R"
                    position: Qt.vector3d(-84.0196, 34.1079, -138.74)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_Wheel_Bk_R_Rims_0
                        objectName: "TR.DEF-Wheel.Bk.R_Rims_0"
                        source: "meshes/tr_DEF_Wheel_Bk_R_Rims_0_mesh.mesh"
                        materials: [
                            rims_material
                        ]
                    }
                    Model {
                        id: tr_DEF_Wheel_Bk_R_mirror_0
                        objectName: "TR.DEF-Wheel.Bk.R_mirror_0"
                        source: "meshes/tr_DEF_Wheel_Bk_R_mirror_0_mesh.mesh"
                        materials: [
                            mirror_material
                        ]
                    }
                    Model {
                        id: tr_DEF_Wheel_Bk_R_Metal___Black_rough_0
                        objectName: "TR.DEF-Wheel.Bk.R_Metal - Black rough_0"
                        source: "meshes/tr_DEF_Wheel_Bk_R_Metal___Black_rough_0_mesh.mesh"
                        materials: [
                            metal___Black_rough_material
                        ]
                    }
                    Node {
                        id: roadster_076
                        objectName: "roadster.076"
                        position: Qt.vector3d(0.118483, 4.8399e-05, 1.29218e-05)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_076_Brake_Disc_0
                            objectName: "roadster.076_Brake Disc_0"
                            source: "meshes/roadster_076_Brake_Disc_0_mesh.mesh"
                            materials: [
                                brake_Disc_material
                            ]
                        }
                    }
                    Node {
                        id: roadster_004
                        objectName: "roadster.004"
                        position: Qt.vector3d(0.070636, -1.19209e-07, -1.23818e-08)
                        rotation: Qt.quaternion(1, -1.32349e-23, 0, 0)
                        Model {
                            id: roadster_004_Thread_0
                            objectName: "roadster.004_Thread_0"
                            source: "meshes/roadster_004_Thread_0_mesh.mesh"
                            materials: [
                                thread_material
                            ]
                        }
                        Model {
                            id: roadster_004_Sidewall_0
                            objectName: "roadster.004_Sidewall_0"
                            source: "meshes/roadster_004_Sidewall_0_mesh.mesh"
                            materials: [
                                sidewall_material
                            ]
                        }
                    }
                }
                Node {
                    id: tr_DEF_WheelBrake_Bk_R
                    objectName: "TR.DEF-WheelBrake.Bk.R"
                    position: Qt.vector3d(-84.0196, 34.1079, -138.74)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: tr_DEF_WheelBrake_Bk_R_calipers_0
                        objectName: "TR.DEF-WheelBrake.Bk.R_calipers_0"
                        source: "meshes/tr_DEF_WheelBrake_Bk_R_calipers_0_mesh.mesh"
                        materials: [
                            calipers_material
                        ]
                    }
                }
            }
        }
    }

    // Animations:
}
