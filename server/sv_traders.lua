local QBCore = exports['qb-core']:GetCoreObject()
local done = false
RegisterNetEvent('Polar-Sub:Server:SetDone', function()


    done = true

end)

RegisterNetEvent('Polar-Sub:Server:Trada', function(item4, amount4, removeitem4, removeitemamount4)
    
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
       
        if Player.Functions.RemoveItem(removeitem4, removeitemamount4) and TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[removeitem4], "remove", removeitemamount4) then
   
           
            
          
            --if done then
           -- TriggerClientEvent('QBCore:Notify', source, 'Couldnt Give Item', 'error')
                --done = false
               
            if Player.Functions.AddItem(item4, amount4) then
                
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item4], 'add',  amount4)
            else
                TriggerClientEvent('QBCore:Notify', source, 'Couldnt Give Item', 'error')
            end
            --[[else
                TriggerClientEvent('QBCore:Notify', source, 'You canceled', 'error')
                Player.Functions.AddItem(removeitem4, removeitemamount4)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[removeitem4], 'add',  removeitemamount4)
            end]]
           
        else
            TriggerClientEvent('QBCore:Notify', source, 'You dont have enough ' .. removeitem4 .. " ", 'error')
        end
   
end)





