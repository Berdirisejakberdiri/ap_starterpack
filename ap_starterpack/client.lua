local animwarlok = false
local locale = Config.ap_starterpackStrings[Config.ap_starterpack.lang]
RegisterNetEvent('ap_starterpack:notif')
AddEventHandler('ap_starterpack:notif', function(desc, types, icon)
    lib.notify({title = locale.titlenotif, description = desc, position = 'top', duration = 5000, type = types, style = {backgroundColor = '#141517', borderRadius = 10, color = '#C1C2C5', ['.description'] = {color = '#909296'}}, icon = icon})
end)

local function Claim()
    if lib.progressCircle({duration = Config.ap_starterpack.durasi, position = 'bottom', label = locale.labelloading, useWhileDead = false, canCancel = true, disable = {move = true, car = true, combat = true}, anim = {dict = "missfam4", clip = "base"}, prop = {bone = 36029, model = 'p_amb_clipboard_01', pos = vec3(0.16, 0.08, 0.10), rot = vec3(-130.0, -50.0, 0.0)}}) then 
        TriggerServerEvent("ap_starterpack:ambil", locale.berhasilambil)
    else
        TriggerEvent('ap_starterpack:notif', locale.dibatalkan, 'inform', 'ban')
    end
    animwarlok = false
    TaskStartScenarioInPlace(apped, 'WORLD_HUMAN_GUARD_STAND')
    if boxapped then DeleteEntity(boxapped) end
end

local function setupLokasiClaim()
    lib.requestModel(Config.ap_starterpack.ped)
    apped = CreatePed(0, Config.ap_starterpack.ped, Config.ap_starterpack.lokasi.x, Config.ap_starterpack.lokasi.y, Config.ap_starterpack.lokasi.z - 1, Config.ap_starterpack.lokasi.w, true, true)
    FreezeEntityPosition(apped, true)
    SetEntityInvincible(apped, true)
    SetBlockingOfNonTemporaryEvents(apped, true)
    TaskStartScenarioInPlace(apped, 'WORLD_HUMAN_GUARD_STAND')
    local options = {}
    table.insert(options, {
        name = 'ap',
        icon = 'fa-solid fa-gift',
        label = locale.labeltarget,
        distance = 1.2,
        onSelect = function()
            lib.callback('ap_starterpack:cekplayer', false, function(bisa)
                if bisa then
                    animwarlok = true
                    while animwarlok do
                        Wait(1)
                        ClearPedTasksImmediately(apped)
                        lib.requestModel(`hei_prop_heist_box`)
                        lib.requestAnimDict('anim@heists@box_carry@')
                        TaskPlayAnim(apped, "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 1, 0, false, false, false)
                        local x, y, z = table.unpack(GetEntityCoords(apped))
                        boxapped = CreateObject(GetHashKey("hei_prop_heist_box"), x, y, z + 0.2, true, true, true)
                        AttachEntityToEntity(boxapped, apped, GetPedBoneIndex(apped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                        SetModelAsNoLongerNeeded("hei_prop_heist_box")
                        local appedPosition = GetOffsetFromEntityInWorldCoords(apped, 0.0, 1.2, 0.0)
                        TaskGoStraightToCoord(cache.ped, appedPosition.x, appedPosition.y, appedPosition.z, 1.0, 1500, GetEntityHeading(apped) +180, 0.0)
                        Wait(500)
                        Claim()
                        return
                    end
                else
                    TriggerEvent('ap_starterpack:notif', locale.sudahambil, 'error', 'xmark')
                end
            end)
        end,
        canInteract = function()
            if IsPedInAnyVehicle(cache.ped) or IsEntityDead(cache.ped) or lib.progressActive() then
                return false
            end
            return true
        end
    })
    exports.ox_target:addModel(Config.ap_starterpack.ped, options)
end

local LokasiPedClaim = lib.points.new(Config.ap_starterpack.lokasi, Config.ap_starterpack.jarak, {})
function LokasiPedClaim:onEnter() setupLokasiClaim() end
function LokasiPedClaim:onExit() DeleteEntity(apped) exports.ox_target:removeModel(Config.ap_starterpack.ped, options) end