
--[[		Little Hud		]]--

--[[ Create Font ]]--
surface.CreateFont( "LittleFont", {
	font = "Arial",
	extended = false,
	size = 20,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	strikeout = false,
	symbol = false,
	shadow = false,
	additive = false,
	outline = true,

})
--[[ Declare Icons ]]--

local health_icon = Material( "icon16/heart.png" )
local shield_icon = Material( "icon16/shield.png" )
local cash_icon = Material( "icon16/money.png" ) 
local cash_add_icon = Material( "icon16/money_add.png" )
local star_icon = Material( "icon16/star.png" )
local script_icon = Material( "icon16/script.png" )

--[[ Hide Hud ]]--
k = { "DarkRP_HUD", "CHudBattery", "CHudHealth" }

hook.Add( "HUDShouldDraw", "hidehud", function( v )
	if table.HasValue( k, v ) then return false end
end)

--[[ Call Hud ]]--
hook.Add( "HUDPaint", "painthud", function()
	drawHUD()
end)

--[[ Draw Boxes ]]--
function drawRoundedBox( cR, x, y, w, h, col )
	draw.RoundedBox( cR, x, y, w, h, col )
end

--[[ Draw Texts ]]--
function drawSimpleText( msg, fnt, x, y, c, align )
	draw.SimpleText( msg, fnt, x, y, c, align and align or TEXT_ALIGN_CENTER )
end

--[[ Draw Icons ]]--
local function CreateImageIcon( icon, x, y, col, val )
	surface.SetDrawColor( col )
	surface.SetMaterial( icon )
	local w, h = 16, 16
	if val then
		surface.SetDrawColor( Color( 255, 255, 255 ) )
	end
	surface.DrawTexturedRect( x, y, w, h )
end

--[[ Draw Hud ]]--
function drawHUD()

	local ply = LocalPlayer()

	local scrW, scrH	= ScrW(), ScrH() - 50

	local cR, bX, bH	= 0, 0, 50

	local mainBack			= Color( 70, 70, 70, 255 )
	local backGround		= Color( 255, 128, 0, 200 )

	local black				= Color( 20, 20, 20, 200 )

	local CHudHealth		= Color( 255, 102, 102, 255 )
	local CHudBattery		= Color( 0, 102, 204, 255 )
	local CHudHealthHigh	= Color( 255, 153, 153, 255 )
	local CHudBatteryHigh	= Color( 0, 128, 255, 255 )

	local wallsal			= Color( 0, 153, 76, 255 )
	local wallsalhigh		= Color( 0, 204, 102, 255 )

	local text				= Color( 255, 255, 255, 255 )



	-- Main Boxes --
	drawRoundedBox( cR, bX, scrH+13, scrW, bH-15, backGround )
	drawRoundedBox( cR, bX, scrH+15, scrW, bH-15, mainBack )

	-- Health/Armor Empty Boxes
	drawRoundedBox( cR+5, bX+55, scrH+19, 200, bH-22, black )
	drawRoundedBox( cR+5, bX+320, scrH+19, 200, bH-22, black )

	-- Health/Armor Boxes
	drawRoundedBox( cR+5, bX+55, scrH+19, math.Clamp( ply:Health(), 0, 100) * 2, bH-22, CHudHealth )
	drawRoundedBox( cR+5, bX+320, scrH+19, math.Clamp( ply:Armor(), 0, 100) * 2, bH-22, CHudBattery )

	-- Health/Armor Highlights
	drawRoundedBox( cR+5, bX+55, scrH+19, math.Clamp( ply:Health(), 0, 100) * 2, bH-37, CHudHealthHigh )
	drawRoundedBox( cR+5, bX+320, scrH+19, math.Clamp( ply:Armor(), 0, 100) * 2, bH-37, CHudBatteryHigh )

	-- Wallet/Salary Boxes
	drawRoundedBox( cR+5, scrW-530, scrH+19, 200, bH-22, wallsal )
	drawRoundedBox( cR+5, scrW-260, scrH+19, 200, bH-22, wallsal )

	-- Wallet/Salary Highlights
	drawRoundedBox( cR+5, scrW-530, scrH+19, 200, bH-37, wallsalhigh )
	drawRoundedBox( cR+5, scrW-260, scrH+19, 200, bH-37, wallsalhigh )

	-- Health/Armor Text
	drawSimpleText( ply:Health() > 0 and "Health: " .. ply:Health() or "Health: " .. 0, "LittleFont", bX+105, scrH+24, Color( 255, 255, 255 ) )
	drawSimpleText( ply:Armor() > 0 and "Armor: " .. ply:Armor() or "Armor: " .. 0, "LittleFont", bX+370, scrH+24, Color( 255, 255, 255 ) )

	-- Salary/Wallet Text
	drawSimpleText( "Wallet: " .. DarkRP.formatMoney( ply:getDarkRPVar( "money" ) ), "LittleFont", scrW-520, scrH+24, text, TEXT_ALIGN_LEFT )
	drawSimpleText( "Salary: " .. DarkRP.formatMoney( ply:getDarkRPVar( "salary" ) ), "LittleFont", scrW-250, scrH+24, text, TEXT_ALIGN_LEFT )

	-- Icons
	CreateImageIcon( health_icon, bX+30, scrH+25, Color( 255, 255, 255 ) )
	CreateImageIcon( shield_icon, bX+300, scrH+25, Color( 255,255,255 ) )
	CreateImageIcon( cash_icon, scrW-555, scrH+25, Color( 255, 255, 255 ) )
	CreateImageIcon( cash_add_icon, scrW-285, scrH+25, Color( 255, 255, 255 ) )
	CreateImageIcon( star_icon, bX+25, scrH-5, Color( 40, 40, 40 ), ply:isWanted() )
	CreateImageIcon( script_icon, bX+5, scrH-5, Color( 40, 40, 40 ), ply:getDarkRPVar("HasGunlicense") )

end
