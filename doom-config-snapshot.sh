#!/bin/sh

SOURCE_DIR="$HOME/.config/doom"
DEST_DIR="$(pwd)/doom-snapshot"

mkdir -p "$DEST_DIR"

#------------------------------------------------------------------
#
# NOTE: the following two lines do the exact same thing, they remove
# consecutive blank lines while keeping a single blank line between
# blocks of text. They ensure that there are no more than one
# consecutive blank line in the output.
#
# awk 'NF {print $0; blank=0} !NF && !blank {print ""; blank=1}'
#
# sed '/^$/N;/^\n$/D;P;D'
#------------------------------------------------------------------

# Process init.el
if [ -f "$SOURCE_DIR/init.el" ]; then
    grep -v '^\s*;' "$SOURCE_DIR/init.el" > "$DEST_DIR/init.el"
    echo "Processed init.el and saved to $DEST_DIR/init.el"
else
    echo "no init.el file found"
fi

# Process config.el
if [ -f "$SOURCE_DIR/config.el" ]; then
    grep -v '^\s*;' "$SOURCE_DIR/config.el" | sed '/^$/N;/^\n$/D;P;D' > "$DEST_DIR/config.el"
    echo "Processed config.el and saved to $DEST_DIR/config.el"
else
    echo "no config.el file found"
fi

# Process packages.el
if [ -f "$SOURCE_DIR/packages.el" ]; then
    grep "^(package" "$SOURCE_DIR/packages.el" | sed 's/).*//; s/$/)/' > "$DEST_DIR/packages.el"
    echo "Processed packages.el and saved to $DEST_DIR/packages.el"
else
    echo "no package.el file found"
fi

echo "Snapshot of init.el, config.el, and packages.el has been saved to $DEST_DIR."
