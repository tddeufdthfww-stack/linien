# Q'=R/S ? INIT/reset_value : (CE ? D : Q).
# Move the hold mux to D and leave clock/R/S/INIT and number of FFs unchanged.
proc explicit_enable_to_d {cells} {
    set ones [dict create]
    set count 0
    foreach c $cells {
        if {[get_property REF_NAME $c] ni {FDRE FDSE}} {error "Unsupported FF type: $c"}
        if {[get_property DONT_TOUCH $c] eq "1"} {error "Do not override protected FF: $c"}
        set dp [get_pins -of_objects $c -filter {REF_PIN_NAME == D}]
        set ep [get_pins -of_objects $c -filter {REF_PIN_NAME == CE}]
        set qp [get_pins -of_objects $c -filter {REF_PIN_NAME == Q}]
        set dn [get_nets -of_objects $dp]
        set en [get_nets -of_objects $ep]
        set qn [get_nets -of_objects $qp]
        if {[llength $dn]!=1 || [llength $en]!=1 || [llength $qn]!=1} {error "Unexpected FF connectivity: $c"}
        set slash [string last / $c]
        set prefix ""
        if {$slash>=0} {set prefix "[string range $c 0 $slash]"}
        if {![dict exists $ones $prefix]} {
            set vc [create_cell -reference VCC ${prefix}__enable_to_d_vcc]
            set vn [create_net ${prefix}__enable_to_d_one]
            connect_net -net $vn -objects [get_pins -of_objects $vc -filter {REF_PIN_NAME == P}]
            dict set ones $prefix $vn
        }
        set mux [create_cell -reference LUT3 ${c}__enable_to_d_mux]
        # I2=CE, I1=Q, I0=D: lower truth half selects Q, upper selects D.
        set_property INIT 8'hAC $mux
        set nd [create_net ${c}__enable_to_d_data]
        connect_net -net $dn -objects [get_pins -of_objects $mux -filter {REF_PIN_NAME == I0}]
        connect_net -net $qn -objects [get_pins -of_objects $mux -filter {REF_PIN_NAME == I1}]
        connect_net -net $en -objects [get_pins -of_objects $mux -filter {REF_PIN_NAME == I2}]
        connect_net -net $nd -objects [get_pins -of_objects $mux -filter {REF_PIN_NAME == O}]
        disconnect_net -net $dn -objects $dp
        disconnect_net -net $en -objects $ep
        connect_net -net $nd -objects $dp
        connect_net -net [dict get $ones $prefix] -objects $ep
        # Prevent a later pass re-extracting CE or moving this state boundary.
        # Combinational mux inputs/driver logic can still be merged/remapped.
        set_property DONT_TOUCH true $c
        incr count
    }
    return $count
}
