lib.callback.register("job:duty", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        return labelText("err_p_data")
    end
    
    local job = xPlayer.job?.name
    local grade = xPlayer.job?.grade
    if job == nil or grade == nil then
        return labelText("err_p_jobdata")
    end

    local isValid, onDuty, index = checkJob(job)
    if not isValid then
        return labelText("unauthorized")
    end

    local setJob = onDuty and Config.AuthorizedJobs[index].offduty or Config.AuthorizedJobs[index].onduty
    xPlayer.setJob(setJob, grade)
    return true
end)

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