module Linecook
  module LinuxBuilder
    extend self
    LXC_MIN_VERSION = '1.1.4'

    def backend
      check_lxc_version
      config = Linecook::Config.load_config[:builder]
      images = Linecook::Config.load_config[:image][:images]
      Linecook::Lxc::Container.new(name: config[:name], home: config[:home], image: config[:image], bridge: true)
    end

    private

    # FIXME: move to dependency check during initial setup if on linux
    def check_lxc_version
      version = `lxc-info --version`
      fail "lxc too old (<#{LXC_MIN_VERSION}) or not present" unless Gem::Version.new(version) >= Gem::Version.new(LXC_MIN_VERSION)
    end
  end
end