local aperto = false
local sirenacc = "siren1"
local pause = false
local volumeset = 50
local vehjob = nil
local soundact = false

function OpenSirenMenu()
    if IsPedInAnyVehicle(PlayerPedId(), false) then 
        local vehiclename = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)))
        for a, b in pairs(Config.EmergencyVeh) do 
            print(vehiclename, b)
            if vehiclename == b then 
                if not aperto then 
                    aperto = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        open = true
                    })
                else
                    aperto = false
                    SetNuiFocus(false, false)
                    SendNUIMessage({
                        open = false
                    })
                end
            end
        end
    end
end
RegisterCommand("sirenmenu", OpenSirenMenu)
RegisterKeyMapping("sirenmenu", "Open Siren Menu", "keyboard", "F3")

RegisterNUICallback("action", function(data)
    local vehiclename = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)))
    if data.acc == 'siren1' then 
        exports["xsound"]:Destroy(sirenacc)
        sirenacc = "siren1"
        exports["xsound"]:PlayUrl("siren1", Config.SoundUrl[vehiclename], volumeset, false, nil) 
        SetVehicleSiren(GetVehiclePedIsIn(PlayerPedId(), false), true) 
        SetVehicleHasMutedSirens(GetVehiclePedIsIn(PlayerPedId(), false), true) 
        soundact = true    
    elseif data.acc == 'siren2' then
        exports["xsound"]:Destroy(sirenacc)
        sirenacc = "siren2"
        SetVehicleSiren(GetVehiclePedIsIn(PlayerPedId(), false), true)
        SetVehicleHasMutedSirens(GetVehiclePedIsIn(PlayerPedId(), false), true)   
        soundact = false
    elseif data.acc == 'siren3' then
        exports["xsound"]:Destroy(sirenacc)
        sirenacc = "siren3"
        SetVehicleSiren(GetVehiclePedIsIn(PlayerPedId(), false), false)
        SetVehicleHasMutedSirens(GetVehiclePedIsIn(PlayerPedId(), false), true)   
        exports["xsound"]:PlayUrl("siren3", Config.SoundUrl[vehiclename], volumeset, false, nil) 
        soundact = true   
    elseif data.acc == 'setvol' then
        if soundact then 
            volumeset = data.vol
            exports["xsound"]:setVolume(sirenacc, volumeset)
        end
    elseif data.acc == 'pause' then 
        if not pause then 
            pause = true 
            exports["xsound"]:Pause(sirenacc)
        else
            pause = false
            exports["xsound"]:Resume(sirenacc)
        end 
    elseif data.acc == 'close' then 
        SetNuiFocus(false, false)
    end
end)

AddEventHandler("onClientResourceStop", function(resname)
    if resname == GetCurrentResourceName() then 
        exports["xsound"]:Destroy("siren1")
        exports["xsound"]:Destroy("siren2")
        exports["xsound"]:Destroy("siren3")
    end
end)