## 0.0.3-beta-2

### Added
* Comprehensive Dartdoc documentation for all public API elements
  - Added detailed documentation for `DeviceEmulator` class and constructor
  - Documented all public properties (`builder`, `enableThemeToggle`, `enableOrientationToggle`, `enableLanguageToggle`)
  - Added library-level documentation with usage examples
  - Documentation coverage now exceeds 20% requirement

### Fixed
* Fixed undefined method error in screenshot functionality
  - Corrected function call from `saveScreenshot` to `saveScreenshotPlatform`
  - Fixed conditional import structure for platform-specific screenshot saving
* Removed unused `screenshot` dependency from pubspec.yaml
* Fixed linter warnings and analyzer issues
  - Removed unnecessary null-aware operator in web screenshot saver
  - Fixed dead code warnings

### Improved
* Enhanced code quality and maintainability
* Better platform compatibility with proper conditional imports
* Cleaner dependency management

## 0.0.3-beta-1
* Update and remove deprecated dependaed package

## 0.0.1

* TODO: Describe initial release.
