ESX = exports["es_extended"]:getSharedObject()

lib.callback.register('ap_starterpack:cekplayer', function(source)
    local xPlayers = ESX.GetPlayerFromId(source)
    local result = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {xPlayers.identifier})
    if result[1].starterpack == 0 then
        return true
    else
        return false
    end
end)

RegisterServerEvent("ap_starterpack:ambil")
AddEventHandler("ap_starterpack:ambil", function(locale)
    local xPlayers = ESX.GetPlayerFromId(source)
    local Itemnya = Config.ap_starterpack
    for i=1, #Itemnya.items do
        xPlayers.addInventoryItem(Itemnya.items[i].dapetnya, Itemnya.items[i].jumlahnya)
    end
    TriggerClientEvent('ap_starterpack:notif', source, locale, 'success', 'fa-solid fa-gift')
    MySQL.update('UPDATE users SET starterpack = ? WHERE identifier = ?', {1, xPlayers.identifier})
end)