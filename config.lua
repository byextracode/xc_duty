Config  = {}

Config.Locale = "en"

Config.AuthorizedJobs = {
    {
        onduty = "police", -- onduty job
        offduty = "offpolice", -- offduty job
    },
    {
        onduty = "ambulance",
        offduty = "offambulance",
    },
    {
        onduty = "mechanic",
        offduty = "offmechanic",
    },
    {
        onduty = "taxi",
        offduty = "offtaxi",
    }
}

Config.translation = {
    ["en"] = {
        ["unauthorized"] = "Not authorized job",
        ["nowduty"] = "Going %sDuty",
        ["err_p_data"] = "error retrieving player data",
        ["err_p_jobdata"] = "error retrieving player job data"
    }
}