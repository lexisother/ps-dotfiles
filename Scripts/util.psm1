function pprint {
    param (
      $text
    )

    Write-Host -NoNewline -ForegroundColor DarkGray "==> "
    Write-Host $text
}