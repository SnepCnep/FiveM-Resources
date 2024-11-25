
function SC.Functions:RayCastCamera()
    local camRot = GetGameplayCamRot()
    local camPos = GetGameplayCamCoord()
    local dir = SC.Functions:RotationToDirection(camRot)
    local dest = camPos + (dir * 7.0)
    local ray = StartShapeTestRay(camPos, dest, 17, -1, 0)
    local _, hit, endPos, surfaceNormal, entityHit = GetShapeTestResult(ray)
    if hit == 0 then endPos = dest end
    return hit, endPos, entityHit, surfaceNormal
end

function SC.Functions:RotationToDirection(rot)
    local rotZ = math.rad(rot.z)
    local rotX = math.rad(rot.x)
    local cosOfRotX = math.abs(math.cos(rotX))
    return vector3(-math.sin(rotZ) * cosOfRotX, math.cos(rotZ) * cosOfRotX, math.sin(rotX))
end