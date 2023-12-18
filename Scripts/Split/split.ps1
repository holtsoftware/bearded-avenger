#!/usr/bin/pwsh
$dataPath = Join-Path $PSScriptRoot -ChildPath data.txt

$lines = Get-Content $dataPath

$files = Get-ChildItem -Path . -Filter *.mp4

if((Test-Path 'scripts') -eq $false)
{
    mkdir 'scripts'
}

    $notFoundIndex = 0

foreach($file in $files)
{
    scenedetect -d 1 -i $file -m 20 time -s 00:11:10 -e 00:16:00 detect-threshold list-scenes  -f file.csv
    if($LastExitCode -ne 0)
    {
        exit(1);
    }
    $csvContent = Get-Content file.csv


    for($i=3;$i -lt $csvContent.Count;$i++)
    {
        $name = $file.Name
        $segments = $csvContent[$i] -split ','
        $splitAt = $segments[2]

        Set-Content "scripts/$name-$i.sh" -value "#!/bin/bash`nmkvmerge --output /mnt/d/tmp/file.mkv  --language -1:und --language 1:en --language 2:en --split 'timestamps:00:00:06,$splitAt' `"$file`" --track-order 0:0,0:1,0:2"

    }
    $segments = $csvContent[3] -split ','

    #$splitAt = New-timespan $segments[2]
    #$splitAt = $splitAt.Add((New-TimeSpan -Seconds "-2"))
    #$sAt = $splitAt.ToString()
    $sAt = $segments[2]

    if ($sAt -eq $null)
    {
        $sAt = "01:00:00"
    }

    mkvmerge --output /mnt/d/tmp/file.mkv  --language -1:und --language 1:en --language 2:en --split "timestamps:$sAt" $file --track-order 0:0,0:1,0:2
    if($LastExitCode -ne 1)
    {
        Write-Host "Exit Code" $LastExitCode
        exit(1);
    }

    $segments = $file.Name.Trim('.mp4') -split '-'
    if($segments.Count -eq 3)
    {
        $found = $false;
        $tofind = (($segments[1] -replace 'the','') -replace '[^a-zA-Z0-9 ]','').ToLower().Trim()
        Write-Host $tofind
        foreach($line in $lines)
        {
            $line = $line -replace '[^a-zA-Z0-9 ]',''
            if($line.ToLower().Contains($tofind))
            {
                $found = $true
                $p1 = $line.SubString(0, 6).ToLower()
                $p2 = $line.SubString(7)
                $l = "$p1 - $p2"
                $dest = "/mnt/d/tmp/$l.mkv"
                Move-Item "/mnt/d/tmp/file-001.mkv" $dest
                Write-Host "Created File" $dest
                break;
            }
        }

        if($found -eq $false)
        {
            Move-Item "/mnt/d/tmp/file-001.mkv" "/mnt/d/tmp/zz - $notFoundIndex - $tofind.mkv"
            $notFoundIndex++
        }

        $found = $false
        $tofind = (($segments[2] -replace 'the','') -replace '[^a-zA-Z0-9 ]','').ToLower().Trim()
        Write-Host $tofind
        foreach($line in $lines)
        {
            $line = $line -replace '[^a-zA-Z0-9 ]',''
            if($line.ToLower().Contains($tofind))
            {
                $found = $true
                $p1 = $line.SubString(0, 6).ToLower()
                $p2 = $line.SubString(7)
                $l = "$p1 - $p2"
                $dest = "/mnt/d/tmp/$l.mkv"
                Move-Item "/mnt/d/tmp/file-002.mkv" $dest
                Write-Host "Created File" $dest
                break;
            }
        }
        if($found -eq $false)
        {
            Move-Item "/mnt/d/tmp/file-002.mkv" "/mnt/d/tmp/zz - $notFoundIndex - $tofind.mkv"
            $notFoundIndex++
        }
    }
    elseif($segments.Count -eq 2)
    {
        $found = $false;
        $tofind = (($segments[1] -replace 'the','') -replace '[^a-zA-Z0-9 ]','').ToLower().Trim()
        Write-Host $tofind
        foreach($line in $lines)
        {
            $line = $line -replace '[^a-zA-Z0-9 ]',''
            if($line.ToLower().Contains($tofind))
            {
                $found = $true
                $p1 = $line.SubString(0, 6).ToLower()
                $p2 = $line.SubString(7)
                $l = "$p1 - $p2"
                $dest = "/mnt/d/tmp/$l.mkv"
                mkvmerge --output $dest  --language -1:und --language 1:en --language 2:en $file --track-order 0:0,0:1,0:2
                #Copy-Item $file $dest
                Write-Host "Created File" $dest
                break;
            }
        }

        if($found -eq $false)
        {
            $dest = "/mnt/d/tmp/zz - $notFoundIndex - $tofind.mkv"
            mkvmerge --output $dest  --language -1:und --language 1:en --language 2:en $file --track-order 0:0,0:1,0:2
            $notFoundIndex++
        }
    }
    else
    {
        Write-Host "Unsure about file" $file.Name
        exit(1);
    }
}
