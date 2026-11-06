param([string]$OutputName = 'GZDoomKeypad.pk3')
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.IO.Compression.FileSystem
$root=$PSScriptRoot
$src=Join-Path $root 'mod'
foreach($sound in @('paper.mp3','keypadpress.mp3','keypadopen.mp3','buzz.mp3')) {
 if(-not (Test-Path -LiteralPath (Join-Path $src ('sounds/'+$sound)))) {throw "Som ausente: $sound"}
}
foreach($dir in @('graphics','sprites','fonts/gk')) {New-Item -ItemType Directory -Force (Join-Path $src $dir) | Out-Null}
$im=[Drawing.Image]::FromFile((Join-Path $root 'sprites/papersheet.bmp'))
$im.Save((Join-Path $src 'graphics/paper.png'),[Drawing.Imaging.ImageFormat]::Png)
$im.Save((Join-Path $src 'sprites/KPAPA0.png'),[Drawing.Imaging.ImageFormat]::Png)
$im.Dispose()
$assets=@{'frame.png'='frame.png';'ButtonsNormal.png'='normal.png';'ButtonsPressed.png'='pressed.png';'LEDOff.png'='off.png';'LEDOn.png'='on.png'}
foreach($key in $assets.Keys) {Copy-Item -LiteralPath (Join-Path $root ('sprites/keypad/'+$key)) -Destination (Join-Path $src ('graphics/'+$assets[$key])) -Force}
Copy-Item -LiteralPath (Join-Path $root 'sprites/keypad/keypadwall.png') -Destination (Join-Path $src 'graphics/wall.png') -Force
Copy-Item -LiteralPath (Join-Path $root 'sprites/keypad/keypadwall.png') -Destination (Join-Path $src 'sprites/KPANA0.png') -Force
$fc=New-Object Drawing.Text.PrivateFontCollection
$fc.AddFontFile((Join-Path $root 'DePixelHalbfett.ttf'))
$font=[Drawing.Font]::new($fc.Families[0],28,[Drawing.FontStyle]::Regular,[Drawing.GraphicsUnit]::Pixel)
$defs="GKFont\n{\n"
foreach($code in (@(47..57)+@(65..90))) {
 $bmp=[Drawing.Bitmap]::new(64,64,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
 $g=[Drawing.Graphics]::FromImage($bmp)
 $g.Clear([Drawing.Color]::Transparent)
 $g.TextRenderingHint=[Drawing.Text.TextRenderingHint]::SingleBitPerPixelGridFit
 $g.DrawString([string][char]$code,$font,[Drawing.Brushes]::White,8,0,[Drawing.StringFormat]::GenericTypographic)
 $name='GKF'+$code
 # Equal side bearings and a shared digit baseline make the visible ink centered.
 $left=64;$right=-1
 for($gy=10;$gy -lt 38;$gy++){for($gx=0;$gx -lt 64;$gx++){
  if($bmp.GetPixel($gx,$gy).A -gt 0){$left=[Math]::Min($left,$gx);$right=[Math]::Max($right,$gx)}
 }}
 if($right -lt $left){$left=0;$right=1}
 $ink=$bmp.Clone([Drawing.Rectangle]::new($left,10,$right-$left+1,28),[Drawing.Imaging.PixelFormat]::Format32bppArgb)
 $glyph=[Drawing.Bitmap]::new($ink.Width+4,28,[Drawing.Imaging.PixelFormat]::Format32bppArgb)
 $gg=[Drawing.Graphics]::FromImage($glyph);$gg.Clear([Drawing.Color]::Transparent);$gg.DrawImageUnscaled($ink,2,0)
 $glyph.Save((Join-Path $src ('graphics/'+$name+'.png')),[Drawing.Imaging.ImageFormat]::Png)
 $gg.Dispose();$glyph.Dispose();$ink.Dispose()
 $defs+=' '+[char]$code+' '+$name+"\n"
 $g.Dispose();$bmp.Dispose()
}
$defs+=" SpaceWidth 14\n}\n"
[IO.File]::WriteAllText((Join-Path $src 'FONTDEFS'),$defs.Replace('\n',[Environment]::NewLine))
$font.Dispose();$fc.Dispose()
$pk3=Join-Path $root $OutputName
if(Test-Path -LiteralPath $pk3) {Remove-Item -LiteralPath $pk3 -Force}
[IO.Compression.ZipFile]::CreateFromDirectory($src,$pk3,[IO.Compression.CompressionLevel]::Optimal,$false)
Write-Output "Criado: $pk3"
