local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    --traderpeds()
end)
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        traderpeds()
    end
end)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(100)
    traderpeds()
    
end)



RegisterNetEvent('Polar-Sub:Client:Transfer', function(data)
    
    print('transfering')
    Wait(50)
    item4 = data.item2
    amount4 = data.amount2
    removeitem4 = data.removeitem2
    removeitemamount4 = data.removeitemamount2
    local hasamount = QBCore.Functions.HasItem(removeitem4, removeitemamount4) 
    if Config.Debug then
        print(item4)
        print(amount4)
        print(removeitem4)
        print(removeitemamount4)
    end
    pp = math.random(1,100)
    if pp < 50 then
        emote = 'argue1'
    elseif pp < 101 then
        emote = 'argue2'
    end
    Wait(5)
    if hasamount then
        TriggerEvent('animations:client:EmoteCommandStart', {emote})
   -- exports["Polar-Emotes"]:EmoteCommandStart(emote, 1)
    QBCore.Functions.Progressbar("hi", "Arguing Over "  .. removeitemamount4 .. " " .. QBCore.Shared.Items[removeitem4].label .. " " , 15000, false, true, 
    {disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    {}, {}, {}, 
    function() -- Done

        TriggerServerEvent('Polar-Sub:Server:Trada', item4, amount4, removeitem4, removeitemamount4)
       -- exports["Polar-Emotes"]:EmoteCancel(emote)
TriggerEvent('animations:client:EmoteCommandStart', {"c"})

    end, function()
      --  exports["Polar-Emotes"]:EmoteCancel(emote)
      TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        -- cancel notification
        QBCore.Functions.Notify('Canceled', 'error')

        -- debug
        if Config.Debug then print('canceled') end

    end)  
    else
        QBCore.Functions.Notify('You dont have enough ' .. removeitem4 .. " ", 'error')
    end
end)


function traderpeds()
   
    if Config.Debug then print('starting') end

for i = 1, #Config.TraderPeds do
    exports['qb-target']:SpawnPed({
        model = Config.TraderPeds[i].model,
        coords = Config.TraderPeds[i].coords,
        minusOne = true,
        freeze = true,
        invincible = false,
        blockevents = true,
        scenario =  Config.TraderPeds[i].scenario,
        target = {
            options = {
            {
                type = "Client",
                icon = Config.TraderPeds[i].icon,
                label = Config.TraderPeds[i].label,
                --job = {"mechanic", "tuner", "otto"},
               -- action = function()
               --     TriggerEvent('Polar-Sub:Client:CryptoPartMenu')
               -- end,
                --isserver = true,
                event = 'Polar-Sub:Client:Trade',
                --item = Config.TraderPeds[i].product,
                --amount = Config.TraderPeds[i].amount,
               -- removeitem = Config.TraderPeds[i].removeitem,
                product = Config.TraderPeds[i].product,
                --weapon = {
                --    name = `weapon_carbinerifle`,
                --    ammo = 0,
                --    hidden = false,
                --},
            }
            },
            distance = 2.5,
        },
    })

end
end


RegisterNetEvent('Polar-Sub:Client:Trade', function(data)

    product = data.product.item
    amount = data.product.amount
    removeitem = data.product.removeitem
    removeitemamount = data.product.removeitemamount

    if Config.Debug then print(product) print(amount) print(removeitem) print(removeitemamount) end

    Wait(50)

    trada(product, amount, removeitem, removeitemamount)
    
end)

function trada(item, amount, removeitem, removeitemamount)



    exports['qb-menu']:openMenu({
        { 
            header = 'Material Trader',
            icon = 'fa-solid fa-recycle',
            txt = " "..QBCore.Shared.Items[item].label .. " Trader",
            isMenuHeader = true
        },
        {   
            --icon = 'fa-solid fa-recycle',
            header = "<img src=nui://"..Config.img..QBCore.Shared.Items[item].image.." " .. amount .. " width=45px onerror='this.onerror=null; this.remove();'>"..QBCore.Shared.Items[item].label,
            txt = "Required: <p> <img src=nui://"..Config.img..QBCore.Shared.Items[removeitem].image.." " .. removeitemamount .. " width=45px onerror='this.onerror=null; this.remove();'>"..QBCore.Shared.Items[removeitem].label,
            params = { 
                event = "Polar-Sub:Client:Transfer",
                args = {
                    item2 = item,
                    amount2 = amount,
                    removeitem2 = removeitem,
                    removeitemamount2 = removeitemamount,
                }
            }
        },
          
    })
    

end