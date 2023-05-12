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

function checkJob(job)
    for i = 1, #Config.AuthorizedJobs do
        for status, value in pairs(Config.AuthorizedJobs[i]) do
            if job == value then
                return true, status == "onduty", i
            end
        end
    end
    return false, false, nil
end

local function isAuthorized(source, authorizedJob)
    if source == nil or GetPlayerName(source) == nil then
        return false
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        return false
    end

    local job = xPlayer.job
    if job == nil then
        return false
    end
    if type(authorizedJob) ~= "table" then
        authorizedJob = {authorizedJob}
    end
    
    local tabletype = table.type(authorizedJob)
    if tabletype == "hash" then
        local grade = authorizedJob[job.name]
        if grade and grade <= job.grade then
            return true
        end
    end
    if tabletype == "mixed" then
        if authorizedJob[job.name] then
            return authorizedJob[job.name] <= job.grade
        end
        for index, value in pairs(authorizedJob) do
            if value == job.name then
                return true
            end
        end
    end
    if tabletype == "array" then
        for i = 1, #authorizedJob do
            if authorizedJob[i] == job.name then
                return true
            end
        end
    end
    return false
end

exports("isAuthorized", isAuthorized)
exportHandler("isAuthorized", isAuthorized)