sub init()
    m.dataGroup = m.top.findNode("dataGroup")
    m.focusRing = m.top.findNode("focusRing")
    m.top.observeField("focusedChild", "onFocusChange")
end sub

sub onFocusChange()
    if m.top.hasFocus()
        m.focusRing.visible = true
    else
        m.focusRing.visible = false
    end if
end sub


