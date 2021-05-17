local guiEnabled = false

RegisterNetEvent('Login:open')
AddEventHandler('Login:open', function(source)
    openGUI(true)
end)




function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end

function openGUI(state)
    SetNuiFocus(state)
    guiEnabled = state

    SendNUIMessage({
        type = "loginui:enable",
        enable = state
    })
end

RegisterNUICallback('escape', function(data, cb)
    openGUI(false)

    cb('ok')
end)

RegisterNUICallback('login', function(data, cb)
    PrintChatMessage(data.username .. " - " .. data.password)

    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)


