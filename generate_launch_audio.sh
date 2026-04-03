#!/bin/bash
# Generate audio for the 3 launch briefs
# Run from Mac terminal: cd ~/HerrinAdvisory && bash grc-site/generate_launch_audio.sh

set -e

PROTO="$HOME/HerrinAdvisory/DailyInfoBriefings/prototype"
SITE="$HOME/HerrinAdvisory/grc-site"

cd "$PROTO"

# Source the .env
set -a
source .env
set +a

echo "=== Generating audio for Monday March 31 ==="
python -c "
import sys; sys.path.insert(0, '.')
from src.output.audio_brief import generate_audio_brief
brief = open('$SITE/briefs/2026-03-31/brief.md').read()
path = generate_audio_brief(brief, output_dir='$SITE/briefs/2026-03-31', cadence='morning')
print(f'Audio: {path}')
"

echo "=== Generating audio for Wednesday April 2 ==="
python -c "
import sys; sys.path.insert(0, '.')
from src.output.audio_brief import generate_audio_brief
brief = open('$SITE/briefs/2026-04-02/brief.md').read()
path = generate_audio_brief(brief, output_dir='$SITE/briefs/2026-04-02', cadence='midweek')
print(f'Audio: {path}')
"

echo "=== Generating audio for Friday April 3 ==="
python -c "
import sys; sys.path.insert(0, '.')
from src.output.audio_brief import generate_audio_brief
brief = open('$SITE/briefs/2026-04-03/brief.md').read()
path = generate_audio_brief(brief, output_dir='$SITE/briefs/2026-04-03', cadence='morning')
print(f'Audio: {path}')
"

echo ""
echo "=== Audio generation complete ==="
echo "Files created:"
ls -la "$SITE/briefs/2026-03-31/"*.mp3 2>/dev/null || echo "  Monday: FAILED"
ls -la "$SITE/briefs/2026-04-02/"*.mp3 2>/dev/null || echo "  Wednesday: FAILED"
ls -la "$SITE/briefs/2026-04-03/"*.mp3 2>/dev/null || echo "  Friday: FAILED"
echo ""
echo "Next: cd $SITE && git add -A && git commit -m 'Launch: 3 briefs with audio' && git push"
