Config  = {}

Config.Locale = "en"

Config.target = true -- only ox_target compatible

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
        target = { -- if Config.target = true
            name = "mech_ls",
            coords = vec3(-344.88, -127.56, 39.5),
            radius = 0.3
        },
        marker = { -- Config.target = false
            type = 24,
            coords = vec3(-344.88, -127.56, 39.5),
            scale = 0.3
        }
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