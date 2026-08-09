$ErrorActionPreference = 'Stop'

function Read-CaptionEvents([string]$Path) {
    $json = Get-Content -Raw -Encoding UTF8 $Path | ConvertFrom-Json
    foreach ($event in $json.events) {
        if (-not $event.segs) { continue }
        $text = (($event.segs | ForEach-Object { $_.utf8 }) -join '')
        $text = [System.Net.WebUtility]::HtmlDecode($text)
        $text = ($text -replace '[\r\n]+', ' ' -replace '\s+', ' ').Trim()
        if ($text) {
            [PSCustomObject]@{ Start = [int64]$event.tStartMs; Text = $text }
        }
    }
}

function Format-Time([int64]$Milliseconds) {
    $span = [TimeSpan]::FromMilliseconds($Milliseconds)
    '{0:D2}:{1:D2}' -f [int]$span.TotalMinutes, $span.Seconds
}

$english = @(Read-CaptionEvents '.\video_subtitles.en-orig.json3')
$chinese = @(Read-CaptionEvents '.\video_subtitles.zh-Hans.json3')
$duration = [Math]::Max($english[-1].Start, $chinese[-1].Start)
$windowMs = 30000

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# When Will The Benchmaxxing Plague End?')
$lines.Add('')
$lines.Add('**Speaker:** Nick Heiner, Surge AI  ')
$lines.Add('**Channel:** AI Engineer  ')
$lines.Add('**Duration:** 17:24  ')
$lines.Add('**Source:** https://www.youtube.com/watch?v=-npY6XjM8CQ')
$lines.Add('')
$lines.Add('> Note: The video provides no human-authored subtitles. The English text below is YouTube''s auto-generated English (Original) track; the Chinese is YouTube''s aligned Simplified Chinese machine translation. Obvious caption line breaks and whitespace have been cleaned, but wording has not been silently rewritten.')
$lines.Add('')

for ($start = 0; $start -le $duration; $start += $windowMs) {
    $end = $start + $windowMs
    $enText = (($english | Where-Object { $_.Start -ge $start -and $_.Start -lt $end } | ForEach-Object { $_.Text }) -join ' ').Trim()
    $zhText = (($chinese | Where-Object { $_.Start -ge $start -and $_.Start -lt $end } | ForEach-Object { $_.Text }) -join '').Trim()
    if (-not $enText -and -not $zhText) { continue }
    $lines.Add(('## {0}' -f (Format-Time $start)))
    $lines.Add('')
    $lines.Add(('**English:** {0}' -f $enText))
    $lines.Add('')
    $lines.Add(('**Chinese:** {0}' -f $zhText))
    $lines.Add('')
}

[System.IO.File]::WriteAllLines((Join-Path $PWD 'bilingual_transcript_en_zh.md'), $lines, [System.Text.UTF8Encoding]::new($false))
