CreateThread(function()
    for i = 1, #Config.AuthorizedJobs do
        local authorizedJob = {
            Config.AuthorizedJobs[i].onduty,
            Config.AuthorizedJobs[i].offduty
        }

        if Config.target and Config.AuthorizedJobs[i].target then
            local coords = Config.AuthorizedJobs[i].target.coords
            local point = lib.points.new({
                coords = coords,
                distance = 5.0
            })
            local options = Config.AuthorizedJobs[i].target
            options.options = {
                {
                    name = options.name,
                    icon = "fa-solid fa-clipboard-check",
                    label = "Set Duty",
                    distance = 2.0,
                    onSelect = function()
                        setDuty()
                    end,
                    canInteract = function(entity, distance, coords, name, bone)
                        return isAuthorized(authorizedJob)
                    end,
                },
            }

            local id
            function point:onEnter()
                id = exports["ox_target"]:addSphereZone(options)
            end

            function point:onExit()
                exports["ox_target"]:removeZone(id)
            end

            local textUI, lastJob
            function point:nearby()
                local job = ESX.PlayerData.job.name
                if self.currentDistance <= 2.0 and isAuthorized(authorizedJob) then
                    if not textUI or job ~= lastJob then
                        lib.showTextUI(("%s Duty"):format(isDuty() and "Off" or "On"), { icon = "eye" })
                        textUI = true
                        lastJob = job
                    end
                else
                    if textUI then
                        textUI = nil
                        lib.hideTextUI()
                    end
                end
                if options.marker then
                    DrawMarker(options.marker.type, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, options.marker.scale, options.marker.scale, options.marker.scale, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)    
                else
                    Wait(1000)
                end
            end
        elseif Config.AuthorizedJobs[i].marker then
            local coords = Config.AuthorizedJobs[i].marker.coords
            local point = lib.points.new({
                coords = coords,
                distance = 5.0
            })

            local textUI, lastJob
            function point:nearby()
                local job = ESX.PlayerData.job.name
                if self.currentDistance <= 1.0 and isAuthorized(authorizedJob) then
                    if not textUI or job ~= lastJob then
                        lib.showTextUI(("%s Duty"):format(isDuty() and "Off" or "On"), { icon = "e" })
                        textUI = true
                        lastJob = job
                    end
                    if IsControlJustPressed(0, 38) then
                        setDuty()
                        Wait(1000)
                    end
                else
                    if textUI then
                        textUI = nil
                        lib.hideTextUI()
                    end
                end
                DrawMarker(Config.AuthorizedJobs[i].marker.type, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.AuthorizedJobs[i].marker.scale, Config.AuthorizedJobs[i].marker.scale, Config.AuthorizedJobs[i].marker.scale, 200, 20, 20, 150, false, true, 2, false, nil, nil, false)
            end
        end
    end
end)