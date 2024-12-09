#!/system/bin/sh

MODDIR=${0%/*}
FONTS_XML_PATH="/system/etc/fonts.xml"
FONT_FALLBACK_XML_PATH="/system/etc/font_fallback.xml"
MODIFIED_FONTS_XML_PATH="$MODDIR/system/etc/fonts.xml"
MODIFIED_FONT_FALLBACK_XML_PATH="$MODDIR/system/etc/font_fallback.xml"
APILEVEL=$(getprop ro.build.version.sdk)

mkdir -p "$MODDIR/system/etc"

if [ "$APILEVEL" -le 30 ]; then
    cp "$FONTS_XML_PATH" "$MODIFIED_FONTS_XML_PATH"
    sed -i '/<!-- fallback fonts -->/a \
    <family lang="ur-Arab" variant="elegant"> \
        <font weight="400" style="normal"> NotoNastaliqUrdu-Regular.ttf </font> \
        <font weight="700" style="normal"> NotoNastaliqUrdu-Bold.ttf </font> \
    </family>' "$MODIFIED_FONTS_XML_PATH"
elif [ "$APILEVEL" -ge 31 ] && [ "$APILEVEL" -lt 34 ]; then
    cp "$FONTS_XML_PATH" "$MODIFIED_FONTS_XML_PATH"
    sed -i '/<family lang="und-Ethi">/i \
    <family lang="ur-Arab" variant="elegant"> \
        <font weight="400" style="normal" postScriptName="NotoNastaliqUrdu"> NotoNastaliqUrdu-Regular.ttf </font> \
        <font weight="700" style="normal"> NotoNastaliqUrdu-Bold.ttf </font> \
    </family>' "$MODIFIED_FONTS_XML_PATH"
elif [ "$APILEVEL" -ge 34 ]; then
    cp "$FONT_FALLBACK_XML_PATH" "$MODIFIED_FONT_FALLBACK_XML_PATH"
    sed -i '/<family lang="und-Ethi">/i \
    <family lang="ur-Arab" variant="elegant"> \
        <font weight="400" style="normal" postScriptName="NotoNastaliqUrdu"> NotoNastaliqUrdu-Regular.ttf </font> \
        <font weight="700" style="normal"> NotoNastaliqUrdu-Bold.ttf </font> \
    </family>' "$MODIFIED_FONT_FALLBACK_XML_PATH"
else
    exit 1
fi
