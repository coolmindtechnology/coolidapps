# Jangan beri peringatan terkait class yang hilang
-dontwarn com.itgsa.opensdk.mediaunit.KaraokeMediaHelper

# Pastikan class ini tidak dihapus oleh R8
-keep class com.itgsa.opensdk.mediaunit.KaraokeMediaHelper { *; }
-keep class com.itgsa.opensdk.media.** { *; }
