function youtube-dl-blry --description "Download youtube videos in compatible format for BLRY"
    youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=aac]/best" --merge-output-format mp4 --write-description --write-info-json --write-annotations "$argv"
end
