json.array! @notifications do | notification |

    json.message notification.to_notification.message
    json.url notification.to_notification.url
    json.id notification.id
end