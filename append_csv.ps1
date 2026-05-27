$csvPath = "06_CDO_Data\Posts\note_internal_links.csv"
$line = '"気合いで組織は動かない。やっぱり必要なのは大きな責任を伴う体験だし、それを大きく感じてくれる可能性が高いのは若手だなぁ｜千葉 博文@デジタルプラス","https://note.com/chiba90/n/n4bd104504eb1","無料note","2026年5月10日 14:31"'
Add-Content -Path $csvPath -Value $line -Encoding Default
