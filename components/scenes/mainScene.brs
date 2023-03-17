sub init()
    m.list = m.top.findNode("list")
    m.header = m.top.findNode("header")
    m.animation = invalid
    m.itemIndex = 1
    setupAnimation()
    createTask()
end sub

sub setFocus()
    if m.list <> invalid and m.list.getChild(m.itemIndex) <> invalid then m.list.getChild(m.itemIndex).setFocus(true)
end sub

sub setupAnimation()
    if m.animation = invalid
        m.animation = CreateObject("RoSGNode", "Animation")
        m.animation.id = "animation"
        m.animation.duration = 0.3
        m.animation.easeFunction = "linear"
        m.animation.optional = true
        m.animationInterp = CreateObject("roSGNode", "Vector2DFieldInterpolator")
        m.animationInterp.id = "animationInterp"
        m.animationInterp.key = [0, 1]
        m.animationInterp.fieldToInterp = "list.translation"

        m.animation.appendChild(m.animationInterp)
    end if
end sub

sub createTask()
    m.contentTask = CreateObject("roSGNode", "contentTask")
    m.contentTask.observeField ("response", "onContentReady")
    m.contentTask.observeField ("error", "errorHandling")
    m.contentTask.control = "run"
end sub

sub onContentReady(event as dynamic)
    m.contentTask.control = "stop"
    m.contentTask = invalid

    data = event.getData()

    m.header.text = data.name

    for each video in data.videos
        listItem = CreateObject("roSGNode", "listItem")
        listItem.title = video.title
        listItem.subtitle = video.subtitle
        listItem.description = video.description
        listItem.thumbnail = video.thumb

        m.list.appendChild(listItem)
    end for

    setFocus()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false

    if press
        if key = "up"
            if m.itemIndex > 1
                m.itemIndex--
                if m.itemIndex > 1 then scrollDown()
                handled = true
            end if
        else if key = "down"
            if m.itemIndex < m.list.getChildCount() - 1
                m.itemIndex++
                if m.itemIndex > 2 and m.itemIndex < m.list.getChildCount() then scrollUp()    
                handled = true
            end if
        else
            return handled
        end if
        setFocus()
    end if

    return handled
end function

sub scrollDown()
    if m.animation <> invalid then m.animation.control = "finish"
    animateList(m.list.translation[0], m.list.translation[1] + 232)
end sub

sub scrollUp()
    if m.animation <> invalid then m.animation.control = "finish"
    animateList(m.list.translation[0], m.list.translation[1] - 232)
end sub

sub animateList(newX, newY)
    m.animationInterp.keyValue = [[m.list.translation[0], m.list.translation[1]], [newX, newY]]
    m.animation.control = "start"
end sub
