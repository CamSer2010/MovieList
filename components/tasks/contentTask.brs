sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    urlTransfer = CreateObject("roUrlTransfer")
    urlTransfer.setUrl("https://cdn-media.brightline.tv/recruiting/roku/testapi.json")
    urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    urlTransfer.InitClientCertificates()
    handleResponse(urlTransfer.getToString())
end sub

sub handleResponse(body as object)
    data = ParseJson(body)

    if data <> invalid and data.categories <> invalid and data.categories.count() > 0
        m.top.response = data.categories[0]
    else
        m.top.error = true
    end if
end sub
