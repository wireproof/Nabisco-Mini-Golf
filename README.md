# Mini Golf

An early iOS prototype bringing together the Nabisco World, Nabisco/Candystand, and Mini Mini Golf games. The app opens to a game selector and currently offers one experimental Mini Mini Golf scene built with recovered artwork and sound.

## Current status

This is not a completed remaster. The Nabisco World and Nabisco/Candystand choices are disabled. The playable scene uses approximate physics; original obstacles, animation timing, scoring, course progression, and gameplay fidelity are not yet reconstructed or validated. The original movies and casts have been extracted for research; extraction is not proof of complete or accurate recovery. See `research/RECOVERY.md` for provenance and limitations.

The unsigned IPA is an experimental build and requires suitable iOS signing and provisioning to install. The simulator selector was visually checked; gameplay and audio have not been validated. Physical-device installation does not establish runtime or visual testing.

## Build

Install Xcode and XcodeGen, then run `xcodegen generate` and build the `MiniGolf` scheme. Set a development team locally for device signing. The app targets iOS 16 or later on iPhone and iPad.

The selected desktop-course icon is the current provisional icon. Original Director files, extracted assets, scripts, and alternate icon concepts are included for continued reconstruction.
