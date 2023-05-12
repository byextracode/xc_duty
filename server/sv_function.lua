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

exports("isAuthorized", isAuthorized)
exportHandler("isAuthorized", isAuthorized)