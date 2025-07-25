# https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb
class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl", using: :git, branch: "main"
  version "1.16.2"
  sha256 "923aa4c81c0fef651c325e3c27aa5b96771540ca2a0933d1b327db27c6dac839"
  license "MIT"
  # NOTE: use `openssl dgst -sha256 <targ.gz file downloaded from release>` to get sha256

  head "https://github.com/sccn/liblsl.git", branch: "main"

  # To make a bottle:
  # 1 - `brew install --build-bottle lsl`
  # 2 - `brew bottle --root-url="https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.15.0" lsl`
  # 3 - Upload produced bottle to GH release page above. If there's a double-dash in the filename
  #     then you have to remove that first.
  # 4 - Copy the printed information into this block. git add and push this updated formula.
  # Commented out until we can build bottles that are signed and certified.
  # bottle do
  #   root_url "https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.15.0"
  #   rebuild 1
  #   sha256 cellar: :any, big_sur: "8fc06564bd013f15150a3eabbd7606f49fe5bd3360e7da7efa0d2bc8542df396"
  # end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install", "--config", "Release", "-j"
  end

  test do
    system bin/"lslver"
  end
end
