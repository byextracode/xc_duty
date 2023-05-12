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