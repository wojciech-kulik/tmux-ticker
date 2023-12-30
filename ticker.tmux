#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"

ticker_commands=(
  # "#($CURRENT_DIR/scripts/dji.sh)"
  # "#($CURRENT_DIR/scripts/dji_change.sh)"
  # "#($CURRENT_DIR/scripts/nasdaq.sh)"
  # "#($CURRENT_DIR/scripts/nasdaq_change.sh)"
  # "#($CURRENT_DIR/scripts/sp100.sh)"
  # "#($CURRENT_DIR/scripts/sp100_change.sh)"
  # "#($CURRENT_DIR/scripts/sp500.sh)"
  # "#($CURRENT_DIR/scripts/sp500_change.sh)"
  "#($CURRENT_DIR/scripts/stock.sh 1)"
  "#($CURRENT_DIR/scripts/stock.sh 2)"
  "#($CURRENT_DIR/scripts/stock.sh 3)"
  # "#($CURRENT_DIR/scripts/stock_change.sh)"
  # "#($CURRENT_DIR/scripts/crypto.sh)"
  # "#($CURRENT_DIR/scripts/crypto_change.sh)"
)

ticker_interpolation=(
	# "\#{ticker_dji}"
	# "\#{ticker_dji_change}"
	# "\#{ticker_nasdaq}"
	# "\#{ticker_nasdaq_change}"
	# "\#{ticker_sp100}"
	# "\#{ticker_sp100_change}"
	# "\#{ticker_sp500}"
	# "\#{ticker_sp500_change}"
	"\#{ticker_stock1}"
	"\#{ticker_stock2}"
	"\#{ticker_stock3}"
	# "\#{ticker_stock_change}"
	# "\#{ticker_crypto}"
	# "\#{ticker_crypto_change}"
)

set_tmux_options() {
	local option="$1"
	local value="$2"
	tmux set-option -gp "$option" "$value"
}

do_interpolation() {
	local interpolated="$1"

	for ((i=0; i<${#ticker_commands[@]}; i++)); do
    if [[ -z "${ticker_interpolation[$i]}" ]]; then
  		interpolated=${interpolated/${ticker_interpolation[$i]}/${ticker_commands[$i]}}
    fi
	done

	echo "$interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}

main

