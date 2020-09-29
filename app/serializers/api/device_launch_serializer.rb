module Api
  class DeviceLaunchSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name, :mac, :sn, :version, :test_mode
    attributes :store_id, :store_name


    attributes :program_length do
      GlobalSetting.current.program_length
    end

    attributes :tabs do |object|

      store = object.store
      items = []

      if store.is_information_menu_on?
        items.push(
          name: store.information_menu_name,
          icon: store.information_menu_icon,
          images: store.images_of_information
        )
      end

      if store.is_service_menu_on?
        items.push(
          name: store.service_menu_name,
          icon: store.service_menu_icon,
          images: store.images_of_service
        )
      end

      introdution = {
        name: '店內資訊',
        type: "store_introduction",
        icon: "home",
        items: items
      }

      formated_channels = Channel.active.map &:formated_api

      channel = {
        name: '節目頻道',
        channel: 'channel',
        icon: 'grampad',
        categories: formated_channels
      }

      [
        introdution,
        channel
      ]
    end

    attributes :periods do |object|
      object.store.business_hours.openness.map &:period
    end
  end
end
