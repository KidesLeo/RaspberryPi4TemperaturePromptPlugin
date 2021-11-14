#
# Raspberry Pi Temp
#
# A simple temp updater on the spacebar prompt.
# Link: https://www.raspberrypi4temp.xyz

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_RASPBERRYPI4TEMP_SHOW="${SPACESHIP_RASPBERRYPI4TEMP_SHOW=true}"
SPACESHIP_RASPBERRYPI4TEMP_PREFIX="${SPACESHIP_RASPBERRYPI4TEMP_PREFIX=""}"
SPACESHIP_RASPBERRYPI4TEMP_SUFFIX="${SPACESHIP_RASPBERRYPI4TEMP_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_RASPBERRYPI4TEMP_SYMBOL="${SPACESHIP_RASPBERRYPI4TEMP_SYMBOL="🌡️"}" 
SPACESHIP_RASPBERRYPI4TEMP_COLOR="${SPACESHIP_RASPBERRYPI4TEMP_COLOR="white"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show raspberrypi4temp status
# spaceship_ prefix before section's name is required!
# Otherwise this section won't be loaded.
spaceship_raspberrypi4temp() {
  # If SPACESHIP_RASPBERRYPI4TEMP_SHOW is false, don't show raspberrypi4temp section

  [[ $SPACESHIP_RASPBERRYPI4TEMP_SHOW == false ]] && return
  
  # # Check if raspberrypi4temp command is available for execution
  # spaceship::exists raspberrypi4temp || return

  local 'cpu_temp'
  local 'gpu_temp'

  cpu_temp="CPU $(($(</sys/class/thermal/thermal_zone0/temp)/1000))'C"
  gpu_temp="GPU ${$(vcgencmd measure_temp): -6}"

  # Exit section if variable is empty
  [[ -z $cpu_temp ]] && return
  [[ -z $gpu_temp ]] && return

  # Display raspberrypi4temp section
  spaceship::section \
    "$SPACESHIP_RASPBERRYPI4TEMP_COLOR" \
    "$SPACESHIP_RASPBERRYPI4TEMP_PREFIX" \
    "$SPACESHIP_RASPBERRYPI4TEMP_SYMBOL $cpu_temp $gpu_temp" \
    "$SPACESHIP_RASPBERRYPI4TEMP_SUFFIX"
}