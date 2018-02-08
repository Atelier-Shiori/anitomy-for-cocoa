cd "$(dirname "$0")"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
jazzy \
  --objc \
  --clean \
  --author "Atelier Shiori" \
  --author_url https://ateliershiori.moe \
  --github_url https://github.com/Atelier-Shiori/anitomy-for-cocoa \
  --github-file-prefix https://github.com/Atelier-Shiori/anitomy-for-cocoa \
  --module-version 1.0 \
  --xcodebuild-arguments --objc,anitomy-osx/anitomy-objc-wrapper.h,--,-x,objective-c,-isysroot,$(xcrun --show-sdk-path),-I,$(pwd) \
  --module anitomy_bridge \
  --root-url hhttps://atelier-shiori.github.io/anitomy-for-cocoa/\
  --output docs/