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
            name = "mech_harmony",
            coords = vec3(595.44, 2785.73, 42.19),
            radius = 0.5,
            marker = { -- optional, could be nil or removed
                type = 28,
                scale = 0.5
            }
        },
        marker = { -- Config.target = false
            type = 24,
            coords = vec3(595.44, 2785.73, 42.19),
            scale = 0.5
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