#Emoji bomb your slack channel.  Add your slack webhook to the Send-SlackMessage function
Function Send-SlackMessage {
    Param(
        [Parameter(Position = 0, mandatory = $true)]
        [string]$Message,
        $Webhook = ""
    )
$splat = @{'Uri'  = "https://hooks.slack.com/services/$webhook"
    'Method'      = 'post'
    'ContentType' = 'application/json' 
    'Body'        = "{""text"":""$message"",}"
}
   $response =  Invoke-RestMethod @splat
   if ($response -eq "ok"){$null}

    }
[int]$x = '1'   
while ($x -le 50 ) {
    $x++
    $message = (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json") | Sort-Object {Get-Random} | Select-Object -Last 1
    $message.emoji
    $emoji_message = (":" + $message.description + ":")
    Send-SlackMessage -Message "$emoji_message" -Webhook "here"
}
