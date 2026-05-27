$files = @(
    '99_Shared_Outputs\texts\sado_yabusame_chunk1.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk_extra1.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk2.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk_extra2.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk_extra3.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk3.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk4.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk_extra4.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk5.html',
    '99_Shared_Outputs\texts\sado_yabusame_chunk6.html'
)
Get-Content $files -Encoding UTF8 | Set-Content -Path '99_Shared_Outputs\texts\sado_yabusame_full.html' -Encoding UTF8
& { .\.agent\scripts\strict_word_count.ps1 '99_Shared_Outputs\texts\sado_yabusame_full.html' }
