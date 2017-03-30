#!/bin/bash
set -e

pgid=${PGID:-$(id -u nobody)}
puid=${PUID:-$(id -g nobody)}

if [ ! -e "$GHOST_CONTENT/config.js" ]; then
        sed -r '
            s/127\.0\.0\.1/0.0.0.0/g;
            s!path.join\(__dirname, (.)/content!path.join(process.env.GHOST_CONTENT, \1!g;
        ' "$GHOST_SOURCE/config.example.js" > "$GHOST_CONTENT/config.js"
fi

if [[ "$*" == npm*start* ]]; then
    base_dir="$GHOST_SOURCE/content"
    for dir in "$base_dir"/*/ "$base_dir"/themes/*/; do
        target_dir="$GHOST_CONTENT/${dir#$base_dir/}"
        mkdir -p "$target_dir"
        if [ -z "$(ls -A "$target_dir")" ]; then
            tar -c --one-file-system -C "$dir" . | tar xC "$target_dir"
        fi
    done

    chown -R $puid:$pgid $GHOST_SOURCE
    chown -R $puid:$pgid $GHOST_CONTENT
    exec gosu $puid:$pgid "$@"
fi

exec "$@"
