'import "pkg:/components/EcpArgs.bs"
'import "pkg:/components/parts/AutoBind/AutoBind.part.bs"
'import "pkg:/components/parts/AutoBind/OnNodeReadyNoOp.bs"
'import "pkg:/source/utils/LoadingScreen.bs"
'import "pkg:/source/utils/Locale.bs"

function Init()
    InitializeBindings() ' auto-generated!
    m.scene = m.top.getScene()
    ' At this point, the "MainScene" node is not yet added to the scene, and does not have a parent yet.
    ' Let's wait until it has one.
    m.MainSceneContainer = m.scene.findNode("MainSceneContainer")
    m.MainSceneContainer.ObserveField("change", FuncName(MainSceneContainerChanged))
end function

function MainSceneContainerChanged()
    AutoBindSceneGraph()
    StartWebServer()
    HideLoadingScreen()
    InitEcpArgs()
    m.scene.signalBeacon("AppLaunchComplete")
    CopyLoadingMessagesToCache()
    ShowAnnouncement()
end function

function StartWebServer()
    m.loungeService = m.top.findNode("LoungeService")
    m.loungeService.callfunc("StartService", invalid)
    m.webServer = m.top.findNode("WebServer")
    m.webServer.callfunc("StartServer", invalid)
    m.dialServer = m.top.findNode("DialServer")
    m.dialServer.callfunc("StartServer", invalid)
end function

function GetDeviceFriendlyName() as string
    deviceInfo = CreateObject("roDeviceInfo")
    deviceFriendlyName = deviceInfo.GetFriendlyName()
    if StringUtils_IsNullOrEmpty(deviceFriendlyName)
        deviceFriendlyName = "Roku TV"
    end if
    return deviceFriendlyName
end function

function ShowAnnouncement()
    title = "Announcement #2 - web app hot fix"
    message = [
        "Invidious servers continue being blocked by YouTube. https://github.com/iBicha/playlet/issues/400"
        "A temporary workaround has been implemented which relies on your Roku device instead of Invidious for streaming data. This workaround is limited, doesn't always work, and doesn't have captions."
        "How to use:"
    ]
    bulletText = [
        "Go to the " + chr(34) + "Remote" + chr(34) + " screen, and open Playlet Web App in your browser"
        "In the web app, tap the video you want to play"
        ("Choose " + chr(34) + "Play on " + bslib_toString(GetDeviceFriendlyName()) + " (HOT FIX)" + chr(34))
    ]
    bottomMessage = [
        "We apologize for the inconvenience."
    ]
    buttons = [
        Tr("OK")
    ]
    dialog = CreateObject("roSGNode", "SimpleDialog")
    dialog.title = title
    dialog.message = message
    dialog.bulletText = bulletText
    dialog.bottomMessage = bottomMessage
    dialog.buttons = buttons
    deviceInfo = CreateObject("roDeviceInfo")
    displaySize = deviceInfo.GetDisplaySize()
    dialog.width = displaySize.w - 180
    m.top.getScene().dialog = dialog
end function
'//# sourceMappingURL=./MainScene.brs.map