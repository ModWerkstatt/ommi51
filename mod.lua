function data()
return {
	info = {
		minorVersion = 1,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		name = _("mod_name"),
		description = _("mod_desc"),
		authors = {
		    {
		        name = "ModWerkstatt",
		        role = "CREATOR",
		    },
		},
		tags = { "europe", "waggon", "schuettgut", "deutschland", "germany", "UIC", "gueterwagen", "db" },
		tfnetId = { },
		minGameVersion = 0,
		dependencies = { },
		url = { "" },
	  
		params = {
			{
				key = "ommifake",
				name = _("Fake_ommiwagen"),
				values = { "No", "Yes", },
				tooltip = _("option_fake_ommiwagen_desc"),
				defaultIndex = 0,
			},	
        },
	},
	options = {
	},
	
	runFn = function (settings, modParams)
	local params = modParams[getCurrentModId()]

        local hidden = {
			["0_fake.mdl"] = true,
			["0_DBAG_fake.mdl"] = true,
			["51_fake.mdl"] = true,
			["_DBAG_fake.mdl"] = true,
			["_fake.mdl"] = true,
        }

		local modelFilter = function(fileName, data)
			local modelName = fileName:match('/Ommi([^/]*.mdl)')
							or fileName:match('/Fz12([^/]*.mdl)')
							or fileName:match('/Schotterkies165([^/]*.mdl)')
			return (modelName==nil or hidden[modelName]~=true)
		end

        if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]
			if params["ommifake"] == 0 then
				addFileFilter("model/vehicle", modelFilter)
			end
		else
			addFileFilter("model/vehicle", modelFilter)
		end
		
		local function metadataHandler(fileName, data)
			if params.soundCheck == 0 then
				if fileName:match('/vehicle/waggon/Ommi51/Ommi([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Ommi51/Fz120([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Ommi51/Schotterkies165([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Ommi51/fake/Ommi([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Ommi51/fake/Fz120([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Ommi51/fake/Schotterkies165([^/]*.mdl)') 
				then
					data.metadata.railVehicle.soundSet.name = "waggon_freight_old"
				end
			end
			return data
		end

		addModifier( "loadModel", metadataHandler )
	end
	}
end
