local OldModBlueprints = ModBlueprints
local reduceLOD = -0.5
local reduceLOD1 = 1 + reduceLOD

function ModBlueprints(all_blueprints)
OldModBlueprints(all_blueprints)

	for id,bp in all_blueprints.Unit do

		local Categories = {}
		for _, cat in bp.Categories do
			Categories[cat] = true
		end
		
		if Categories.PRODUCTSC1 or Categories.UEF or Categories.AOEN or Categories.SERAPHIM  or Categories.CYBRAN then
			if bp.LODs.LODCutoff then
				bp.LODs.LODCutoff = bp.LODs.LODCutoff * reduceLOD1
			end
		end
	end 
end 
