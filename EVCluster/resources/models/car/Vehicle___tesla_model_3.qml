import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    property url textureData: "maps/textureData.png"
    property url textureData18: "maps/textureData18.png"
    Texture {
        id: _0_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData
    }
    Texture {
        id: _1_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        source: node.textureData18
    }
    PrincipledMaterial {
        id: vehicle_material
        objectName: "Vehicle"
        baseColorMap: _0_texture
        roughness: 0.699999988079071
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: registration_Plate_material
        objectName: "Registration_Plate"
        baseColorMap: _1_texture
        roughness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }

    // Nodes:
    Node {
        id: sketchfab_model
        objectName: "Sketchfab_model"
        rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
        Node {
            id: node6bdc9915ce8c4881bfbc36655c48a2f7_fbx
            objectName: "6bdc9915ce8c4881bfbc36655c48a2f7.fbx"
            rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)
            Node {
                id: rootNode
                objectName: "RootNode"
                Node {
                    id: body_001
                    objectName: "Body.001"
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: body_001_Vehicle_0
                        objectName: "Body.001_Vehicle_0"
                        source: "meshes/body_001_Vehicle_0_mesh.mesh"
                        materials: [
                            vehicle_material
                        ]
                    }
                }
                Node {
                    id: rlw_001
                    objectName: "RLW.001"
                    position: Qt.vector3d(78.0223, 35.3447, -133.815)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: rlw_001_Vehicle_0
                        objectName: "RLW.001_Vehicle_0"
                        source: "meshes/rlw_001_Vehicle_0_mesh.mesh"
                        materials: [
                            vehicle_material
                        ]
                    }
                }
                Node {
                    id: registration_Plate_001
                    objectName: "Registration Plate.001"
                    position: Qt.vector3d(-1.49012e-06, 74.3503, -224.69)
                    rotation: Qt.quaternion(0.725778, -0.687929, 4.20203e-18, -4.20204e-18)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: registration_Plate_001_Registration_Plate_0
                        objectName: "Registration Plate.001_Registration Plate_0"
                        source: "meshes/registration_Plate_001_Registration_Plate_0_mesh.mesh"
                        materials: [
                            registration_Plate_material
                        ]
                    }
                }
                Node {
                    id: flw_001
                    objectName: "FLW.001"
                    position: Qt.vector3d(78.0223, 35.3447, 156.404)
                    rotation: Qt.quaternion(0.683013, -0.683013, -0.183013, -0.183013)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: flw_001_Vehicle_0
                        objectName: "FLW.001_Vehicle_0"
                        source: "meshes/flw_001_Vehicle_0_mesh.mesh"
                        materials: [
                            vehicle_material
                        ]
                    }
                }
                Node {
                    id: frw_001
                    objectName: "FRW.001"
                    position: Qt.vector3d(-78.0223, 35.3447, 156.404)
                    rotation: Qt.quaternion(0.683013, -0.683013, -0.183013, -0.183013)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: frw_001_Vehicle_0
                        objectName: "FRW.001_Vehicle_0"
                        source: "meshes/frw_001_Vehicle_0_mesh.mesh"
                        materials: [
                            vehicle_material
                        ]
                    }
                }
                Node {
                    id: rrw_001
                    objectName: "RRW.001"
                    position: Qt.vector3d(-78.0223, 35.3447, -133.815)
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
                    scale: Qt.vector3d(100, 100, 100)
                    Model {
                        id: rrw_001_Vehicle_0
                        objectName: "RRW.001_Vehicle_0"
                        source: "meshes/rrw_001_Vehicle_0_mesh.mesh"
                        materials: [
                            vehicle_material
                        ]
                    }
                }
            }
        }
    }

    // Animations:
}
