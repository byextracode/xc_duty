local function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_utils_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end

local function isDuty()
    local job = ESX.PlayerData.job?.name
    if job:find("off") then
        return false
    end
    return true
end

local function isAuthorized(authorizedJob)
    while ESX == nil do
        Wait()
    end
    while not ESX.PlayerLoaded do
        Wait()
    end
    if type(authorizedJob) ~= "table" then
        authorizedJob = {authorizedJob}
    end
    local tabletype = table.type(authorizedJob)
    if tabletype == "hash" then
        local grade = authorizedJob[ESX.PlayerData.job.name]
        if grade and grade <= ESX.PlayerData.job.grade then
            return true
        end
    end
    if tabletype == "mixed" then
        if authorizedJob[ESX.PlayerData.job.name] then
            return authorizedJob[ESX.PlayerData.job.name] <= ESX.PlayerData.job.grade
        end
        for index, value in pairs(authorizedJob) do
            if value == ESX.PlayerData.job.name then
                return true
            end
        end
    end
    if tabletype == "array" then
        for i = 1, #authorizedJob do
            if ESX.PlayerData.job.name == authorizedJob[i] then
                return true
            end
        end
    end
    return false
end

local function setDuty(job)
    local job = ESX.PlayerData.job?.name
    if not job then
        return labelText("unauthorized")
    end
    local authorized = false
    for i = 1, #Config.AuthorizedJobs do
        if job == Config.AuthorizedJobs[i] then
            authorized = true
        end
    end
    if not authorized then
        return labelText("unauthorized")
    end

    local result = lib.callback.await("job:duty")
    if type(result) == "string" then
        return ESX.ShowNotification(result, "error")
    end
    return ESX.ShowNotification(labelText("nowduty", isDuty() and "On" or "Off"), "check")
end

exports("setDuty", setDuty)
exports("isAuthorized", isAuthorized)
exports("isDuty", isDuty)

exportHandler("setDuty", setDuty)
exportHandler("isAuthorized", isAuthorized)
exportHandler("isDuty", isDuty)