# Nabisco mini-golf recovery

The user confirmed Nabisco World and supplied six original Director movie/cast files on 2026-11-15. The attachments were copied without modification into `originals/`; SHA-256 was checked against each attachment. Prefixes 1–6 are attachment names, not assumed original dependency names.

| Attachment | SHA-256 |
| --- | --- |
| 1-nabiscocandygolf.dcr | 0c192e3392ee67702eee8433b2362a7d09bb957550b1d95078738cdf0feebb3c |
| 2-Holes.cst | e2680fab2bac5bb763d620736f1ccd216c855919ab2f2858e5d955f99156acad |
| 3-nwmm18holes.cst | 246f29636131257e2d1237ae025a03f25af2dd101d4e5bbc853f60799a417ef5 |
| 4-nabiscoworld.dcr | bf2f70dea53ce9d9f024a6c0df8d0b8cbbd5eba034d207fd7425d5e150cb96ea |
| 5-nwmgholes.cst | 422677072df12e6937ee1c9d5f39d7b44659cefee18ebae237578707da3aa891 |
| 6-nabiscoworldmini.dcr | 6215978c9bdcd395968e5045c8bc45187bcad8672a6543eaa388fa94386a810a |

`nwmgmain.dcr` was independently downloaded from https://oneweakness.com/retro/minig/nwmgmain.dcr and has the same SHA-256 as attachment 4. This does not prove either copy has all its external dependencies.

The user also identified a DCR folder on Synology. Its location and contents have not yet been verified. Related editions, course sets and external casts must be inventoried before asserting complete coverage. Original sound, physics, animation and rules must be established from extracted material and, where possible, original runtime observation; filenames alone do not establish behavior. No remaster, build, device delivery, GitHub publication or Synology archive has yet been completed.

## Initial extraction

LibreShockwave commit `4bc93bf622f498a0296aed5a34d6d28abaa307b2` was built in a temporary directory. Its JPEG decoder namespace needed a local build-only correction. The extractor reported no errors for all six supplied files. Full manifests, images, audio, raw chunks, decompiled Lingo and bytecode listings are under `extracted/`; see `libreshockwave_summary.tsv` for counts. The duplicate online movie was extracted separately.

The three movie outputs include decompiled scripts; the Nabisco World movie includes named code for individual holes. The cast files yielded hundreds of bitmaps and dozens of sound outputs, but no script outputs. This is static extraction, not proof of complete assets, playable behavior, correct decompilation, or preservation of timing/animation. Initial inspection of `06302_Common_Code.ls` suggests Error 21 occurs if required external parameters are absent; this is a decompiler-derived observation, not a runtime test. Original-game comparison, cast dependency mapping and reconstruction remain outstanding.
