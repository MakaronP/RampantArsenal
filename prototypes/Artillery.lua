local artillery = {}

local sounds = require("__base__.prototypes.entity.sounds")

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")

local makeAmmo = ammoUtils.makeAmmo
local addEffectToTech = technologyUtils.addEffectToTech
local makeArtilleryShell = projectileUtils.makeArtilleryShell
local makeRecipe = recipeUtils.makeRecipe

function artillery.enable()
    
    local incendiaryArtilleryShellAmmo = makeAmmo({
            name = "incendiary-artillery",
            icon = "__RampantArsenal__/graphics/icons/incendiary-artillery-shell.png",
            order = "d[explosive-cannon-shell]-d[incendiary]",
            magSize = 1,
            stackSize = 1,
            ammoType = {
                category = "artillery-shell",
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "artillery",
                                projectile = makeArtilleryShell(
                                    {
                                        name = "incendiary"
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            repeat_count = 100,
                                                            type = "create-trivial-smoke",
                                                            smoke_name = "nuclear-smoke",
                                                            offset_deviation = {{-1, -1}, {1, 1}},
                                                            slow_down_factor = 1,
                                                            starting_frame = 3,
                                                            starting_frame_deviation = 5,
                                                            starting_frame_speed = 0,
                                                            starting_frame_speed_deviation = 5,
                                                            speed_from_center = 0.5,
                                                            speed_deviation = 0.2
                                                        },
                                                        {
                                                            type = "show-explosion-on-chart",
                                                            scale = 8/32,
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "big-artillery-explosion"
                                                        },
                                                        {
                                                            type = "damage",
                                                            damage = {amount = 400, type = "fire"}
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "big-scorchmark",
                                                            check_buildability = true
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "massive-fire-cloud-rampant-arsenal",
                                                            show_in_tooltip = true
                                                        }
                                                    }
                                            }
                                }),
                                starting_speed = 1,
                                direction_deviation = 0,
                                range_deviation = 0,
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "artillery-cannon-muzzle-flash"
                                    },
                            }
                    },
            }	    
    })
    
    makeRecipe({
            name = incendiaryArtilleryShellAmmo,
            icon = "__RampantArsenal__/graphics/icons/incendiary-artillery-shell.png",
            enabled = false,
            category = "crafting-with-fluid",
            ingredients = {
                {"artillery-shell", 1},
                {type="fluid", name="napalm-fluid-rampant-arsenal", amount=400}
            },
            result = incendiaryArtilleryShellAmmo,
    })

    addEffectToTech("incendiary-artillery-shells",
                    {
                        type = "unlock-recipe",
                        recipe = incendiaryArtilleryShellAmmo,
    })
    
    local heArtilleryShellAmmo = makeAmmo({
            name = "he-artillery",
            icon = "__RampantArsenal__/graphics/icons/he-artillery-shell.png",
            order = "d[explosive-cannon-shell]-d[he]",
            magSize = 1,
            stackSize = 1,
            ammoType = {
                category = "artillery-shell",
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "artillery",
                                projectile = makeArtilleryShell(
                                    {
                                        name = "he"
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    radius = 10,
                                                                    action_delivery =
                                                                        {
                                                                            type = "instant",
                                                                            target_effects =
                                                                                {
                                                                                    {
                                                                                        type = "damage",
                                                                                        damage = {amount = 500 , type = "physical"}
                                                                                    },
                                                                                    {
                                                                                        type = "damage",
                                                                                        damage = {amount = 2750 , type = "explosion"}
                                                                                    },
                                                                                    {
                                                                                        type = "create-entity",
                                                                                        entity_name = "big-artillery-explosion"
                                                                                    }
                                                                                }
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "invoke-tile-trigger",
                                                            repeat_count = 1,
                                                        },
                                                        {
                                                            type = "destroy-decoratives",
                                                            from_render_layer = "decorative",
                                                            to_render_layer = "object",
                                                            include_soft_decoratives = true,
                                                            include_decals = false,
                                                            invoke_decorative_trigger = true,
                                                            decoratives_with_trigger_only = false,
                                                            radius = 6
                                                        },
                                                        {
                                                            type = "create-trivial-smoke",
                                                            smoke_name = "artillery-smoke",
                                                            initial_height = 0,
                                                            speed_from_center = 0.05,
                                                            speed_from_center_deviation = 0.005,
                                                            offset_deviation = {{-4, -4}, {4, 4}},
                                                            max_radius = 3.5,
                                                            repeat_count = 4 * 4 * 15
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "big-artillery-explosion"
                                                        },
                                                        {
                                                            type = "show-explosion-on-chart",
                                                            scale = 8/32,
                                                        }
                                                    }
                                            }
                                    }
                                ),
                                starting_speed = 1,
                                direction_deviation = 0,
                                range_deviation = 0,
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "artillery-cannon-muzzle-flash"
                                    }				
                            }
                    },
            }	    
    })
    
    makeRecipe({
            name = heArtilleryShellAmmo,
            icon = "__RampantArsenal__/graphics/icons/he-artillery-shell.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {"artillery-shell", 1},
                {"cluster-grenade", 3}
            },
            result = heArtilleryShellAmmo,
    })

    addEffectToTech("he-artillery-shells",
                    {
                        type = "unlock-recipe",
                        recipe = heArtilleryShellAmmo,
    })
    
    local bioArtilleryShellAmmo = makeAmmo({
            name = "bio-artillery",
            icon = "__RampantArsenal__/graphics/icons/bio-artillery-shell.png",
            order = "d[explosive-cannon-shell]-d[bio]",
            magSize = 1,
            stackSize = 1,

            ammoType = {
                category = "artillery-shell",
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "artillery",
                                projectile = makeArtilleryShell(
                                    {
                                        name = "bio"
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            repeat_count = 100,
                                                            type = "create-trivial-smoke",
                                                            smoke_name = "nuclear-smoke",
                                                            offset_deviation = {{-1, -1}, {1, 1}},
                                                            slow_down_factor = 1,
                                                            starting_frame = 3,
                                                            starting_frame_deviation = 5,
                                                            starting_frame_speed = 0,
                                                            starting_frame_speed_deviation = 5,
                                                            speed_from_center = 0.5,
                                                            speed_deviation = 0.2
                                                        },
                                                        {
                                                            type = "show-explosion-on-chart",
                                                            scale = 8/32,
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "big-artillery-explosion"
                                                        },
                                                        {
                                                            type = "damage",
                                                            damage = {amount = 400, type = "poison"}
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "big-toxic-cloud-rampant-arsenal",
                                                            show_in_tooltip = true
                                                        },
                                                        {
                                                            type = "invoke-tile-trigger",
                                                            repeat_count = 1,
                                                        },
                                                        {
                                                            type = "destroy-decoratives",
                                                            from_render_layer = "decorative",
                                                            to_render_layer = "object",
                                                            include_soft_decoratives = true,
                                                            include_decals = false,
                                                            invoke_decorative_trigger = true,
                                                            decoratives_with_trigger_only = false,
                                                            radius = 3
                                                        },
                                                    }
                                            }
                                }),
                                starting_speed = 1,
                                direction_deviation = 0,
                                range_deviation = 0,
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "artillery-cannon-muzzle-flash"
                                    },
                            }
                    },
            }	    
    })
    
    makeRecipe({
            name = bioArtilleryShellAmmo,
            icon = "__RampantArsenal__/graphics/icons/bio-artillery-shell.png",
            enabled = false,
            category = "crafting",
            magSize = 1,
            stackSize = 1,
            ingredients = {
                {"artillery-shell", 1},
                {"toxic-capsule-rampant-arsenal", 5}
            },
            result = bioArtilleryShellAmmo,
    })

    addEffectToTech("bio-artillery-shells",
                    {
                        type = "unlock-recipe",
                        recipe = bioArtilleryShellAmmo,
    })

    
    local nuclearArtilleryShellAmmo = makeAmmo({
            name = "nuclear-artillery",
            icon = "__RampantArsenal__/graphics/icons/nuclear-artillery-shell.png",
            order = "d[explosive-cannon-shell]-d[nuclear]",
            magSize = 1,
            stackSize = 1,
            ammoType = {
                category = "artillery-shell",
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "artillery",
                                projectile = makeArtilleryShell(
                                    {
                                        name = "nuclear"
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "set-tile",
                                                            tile_name = "nuclear-ground",
                                                            radius = 12,
                                                            apply_projection = true,
                                                            tile_collision_mask = { "water-tile" },
                                                        },
                                                        {
                                                            type = "destroy-cliffs",
                                                            radius = 9,
                                                            explosion = "explosion"
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "nuke-explosion"
                                                        },
                                                        {
                                                            type = "camera-effect",
                                                            effect = "screen-burn",
                                                            duration = 60,
                                                            ease_in_duration = 5,
                                                            ease_out_duration = 60,
                                                            delay = 0,
                                                            strength = 6,
                                                            full_strength_max_distance = 200,
                                                            max_distance = 800
                                                        },
                                                        {
                                                            type = "play-sound",
                                                            sound = sounds.nuclear_explosion(0.9),
                                                            play_on_target_position = false,
                                                            -- min_distance = 200,
                                                            max_distance = 1000,
                                                            -- volume_modifier = 1,
                                                            audible_distance_modifier = 3
                                                        },
                                                        {
                                                            type = "play-sound",
                                                            sound = sounds.nuclear_explosion_aftershock(0.4),
                                                            play_on_target_position = false,
                                                            -- min_distance = 200,
                                                            max_distance = 1000,
                                                            -- volume_modifier = 1,
                                                            audible_distance_modifier = 3
                                                        },
                                                        {
                                                            type = "damage",
                                                            damage = {amount = 400, type = "explosion"}
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "huge-scorchmark",
                                                            check_buildability = true,
                                                        },
                                                        {
                                                            type = "invoke-tile-trigger",
                                                            repeat_count = 1,
                                                        },
                                                        {
                                                            type = "destroy-decoratives",
                                                            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                                                            include_decals = true,
                                                            invoke_decorative_trigger = true,
                                                            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                                                            radius = 14 -- large radius for demostrative purposes
                                                        },
                                                        {
                                                            type = "create-decorative",
                                                            decorative = "nuclear-ground-patch",
                                                            spawn_min_radius = 11.5,
                                                            spawn_max_radius = 12.5,
                                                            spawn_min = 30,
                                                            spawn_max = 40,
                                                            apply_projection = true,
                                                            spread_evenly = true
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 1000,
                                                                    radius = 7,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-ground-zero-projectile",
                                                                            starting_speed = 0.6 * 0.8,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 1000,
                                                                    radius = 35,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave",
                                                                            starting_speed = 0.5 * 0.7,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 1000,
                                                                    radius = 26,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave-spawns-cluster-nuke-explosion",
                                                                            starting_speed = 0.5 * 0.7,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 700,
                                                                    radius = 4,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave-spawns-fire-smoke-explosion",
                                                                            starting_speed = 0.5 * 0.65,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 1000,
                                                                    radius = 8,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave-spawns-nuke-shockwave-explosion",
                                                                            starting_speed = 0.5 * 0.65,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 300,
                                                                    radius = 26,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave-spawns-nuclear-smoke",
                                                                            starting_speed = 0.5 * 0.65,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 10,
                                                                    radius = 8,
                                                                    action_delivery =
                                                                        {
                                                                            type = "instant",
                                                                            target_effects =
                                                                                {
                                                                                    {
                                                                                        type = "create-entity",
                                                                                        entity_name = "nuclear-smouldering-smoke-source",
                                                                                        tile_collision_mask = { "water-tile" }
                                                                                    }
                                                                                }
                                                                        }
                                                                }
                                                        }
                                                    }
                                            }
                                }),
                                starting_speed = 1,
                                direction_deviation = 0,
                                range_deviation = 0,
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "artillery-cannon-muzzle-flash"
                                    },
                            }
                    },
            }	    
    })
    
    makeRecipe({
            name = nuclearArtilleryShellAmmo,
            icon = "__RampantArsenal__/graphics/icons/nuclear-artillery-shell.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {"artillery-shell", 1},
                {"atomic-bomb", 1}
            },
            result = nuclearArtilleryShellAmmo,
    })

    addEffectToTech("atomic-bomb",
                    {
                        type = "unlock-recipe",
                        recipe = nuclearArtilleryShellAmmo,
    })
end

return artillery
