#!/usr/bin/pwsh
$dataPath = Join-Path $PSScriptRoot -ChildPath data.txt

$lines = Get-Content $dataPath

$files = Get-ChildItem -Path *.mkv

if((Test-Path 'scripts') -eq $false)
{
    mkdir 'scripts'
}

    $notFoundIndex = 0
    $index = 0;

foreach($file in $files)
{
    scenedetect -d 1 -i $file -m 20 time -s 00:11:10 -e 00:16:00 detect-threshold list-scenes  -f file.csv
    if($LastExitCode -ne 0)
    {
        exit(1);
    }
    $csvContent = Get-Content file.csv


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
    if($LastExitCode -ne 0)
    {
        Write-Host "Exit Code" $LastExitCode
        exit(1);
    }

    $segments = $file.Name.Trim('.mp4').Trim('.mkv') -split '-'
    if($segments.Count -eq 3)
    {
        $first = $segments[0].Trim();
        $found = $false;
        $tofind = (($segments[1] -replace 'the','') -replace '[^a-zA-Z0-9 ]','').ToLower().Trim()
        Write-Host $tofind
        $item = $segments[1].Trim();
        $ii = ($index++).ToString("000");
        $file1 = "/mnt/d/tmp/$first - $ii - $item.mkv"
        Move-Item "/mnt/d/tmp/file-001.mkv" $file1
        $item = $segments[2].Trim();
        $ii = ($index++).ToString("000");
        $file2 = "/mnt/d/tmp/$first - $ii - $item.mkv"
        Move-Item "/mnt/d/tmp/file-002.mkv" $file2

        for($i=0;$i -lt $csvContent.Count;$i++)
        {
            $name = $file.Name
            $segments = $csvContent[$i] -split ','
            $splitAt = $segments[2]

            if((Test-Path scripts) -eq $false)
            {
                mkdir scripts
            }

            Set-Content "scripts/$name-$i.sh" -value "#!/bin/bash`nmkvmerge --output /tmp/file.mkv  --language -1:und --language 1:en --language 2:en --split `"timestamps:$splitAt`" `"$file`" --track-order 0:0,0:1,0:2`nmv -f `"/tmp/file-001.mkv`" `"$file1`"`nmv -f `"/tmp/file-002.mkv`" `"$file2`""

        }
    }
    elseif($segments.Count -eq 2)
    {
        $first = $segments[0].Trim();
        $found = $false;
        $item = $segments[1];
        $ii = ($index++).ToString("000");
        $dest = "/mnt/d/tmp/$first - $ii - $item.mkv"
        mkvmerge --output $dest  --language -1:und --language 1:en --language 2:en $file --track-order 0:0,0:1,0:2
    }
    else
    {
        $item = $file.Name
        $dest = "/mnt/d/tmp/$ii - Cannot Split - $item.mkv"
        mkvmerge --output $dest  --language -1:und --language 1:en --language 2:en $file --track-order 0:0,0:1,0:2
    }
}
