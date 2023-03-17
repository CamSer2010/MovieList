sub init()
    m.list = m.top.findNode("list")
    m.itemIndex = 0
    setFocus()
end sub

sub setFocus()
    if m.list <> invalid and m.list.getChild(m.itemIndex) <> invalid then m.list.getChild(m.itemIndex).setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false

    if press
        if key = "up"
            if m.itemIndex > 0
                m.itemIndex--
                handled = true
            end if
        else if key = "down"
            if m.itemIndex < m.list.getChildCount() - 1
                m.itemIndex++
                handled = true
            end if
        else
            return handled
        end if
        setFocus()
    end if

    return handled
end function