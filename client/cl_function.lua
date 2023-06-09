function labelText(text, ...)
    local library = Config.translation[Config.Locale]
    if library == nil then
        return ("Translation [%s] does not exist"):format(Config.Locale)
    end
    if library[text] == nil then
        return ("Translation [%s][%s] does not exist"):format(Config.Locale, text)
    end
    return library[text]:format(...)
end

local function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_utils_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end

local function checkJob(job)
    local job = job or ESX.PlayerData.job?.name
    for i = 1, #Config.AuthorizedJobs do
        for status, value in pairs(Config.AuthorizedJobs[i]) do
            if job == value then
                return true, status == "onduty", i
            end
        end
    end
    return false, false, nil
end

function isDuty(job)
    local isValid, onDuty, index = checkJob(job)
    return onDuty
end

function isAuthorized(authorizedJob)
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

function setDuty()
    local job = ESX.PlayerData.job?.name
    if not job then
        return labelText("unauthorized")
    end

    local isValid, onDuty, index = checkJob(job)
    if not isValid then
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