local function lerp_color(a, b, amount)
  return {
    a[1] + amount * (b[1] - a[1]),
    a[2] + amount * (b[2] - a[2]),
    a[3] + amount * (b[3] - a[3]),
    a[4] + amount * (b[4] - a[4]),
  }
end

local function fade(tint, amount) -- fades to minimal opacity grey. Low opacity is good for the mask to let the base layer show htough (instead of having a grey mask)
  return lerp_color(tint, {1, 1, 1, 2}, amount)
end

local function grey_overlay(tint, amount) -- fades to opaque grey. Full opacity is required for body.
  return lerp_color(tint, {127, 127, 127, 255}, amount)
end

return {
  lerp_color = lerp_color,
  fade = fade,
  grey_overlay = grey_overlay,
}
