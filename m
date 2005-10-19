From: Sander van Grieken <sander@3v8.net>
Subject: audiophile usb and snd-usb-audio report #2
Date: Wed, 19 Oct 2005 17:58:38 +0200
Message-ID: <200510191758.38630.sander@3v8.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ok here are the contents of stream[01]

stream0
-----------
M-Audio Audiophile USB (tm) at usb-0000:00:02.0-2, full speed : USB Audio

Playback:
  Status: Running
    Interface = 2
    Altset = 5
    URBs = 5 [ 4 4 4 4 4 ]
    Packet Size = 192
    Momentary freq = 48000 Hz (0x30.0000)
  Interface 2
    Altset 1
    Format: S24_3BE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 2
    Altset 2
    Format: S24_3BE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 3
    Format: S24_3BE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 4
    Format: S16_BE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 5
    Format: S16_BE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continuous)

Capture:
  Status: Stop
  Interface 5
    Altset 1
    Format: S24_3BE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 48001 - 96000 (continuous)
  Interface 5
    Altset 2
    Format: S24_3BE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 5
    Altset 4
    Format: S16_BE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)





stream1
-----------
M-Audio Audiophile USB (tm) at usb-0000:00:02.0-2, full speed : USB Audio #1

Playback:
  Status: Stop
  Interface 3
    Altset 1
    Format: S24_3BE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 3
    Altset 2
    Format: S24_3BE
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 3
    Altset 3
    Format: S24_3BE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continuous)
  Interface 3
    Altset 4
    Format: S16_BE
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 3
    Altset 5
    Format: S16_BE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continuous)

Capture:
  Status: Stop
  Interface 4
    Altset 1
    Format: S24_3BE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 48001 - 96000 (continuous)
  Interface 4
    Altset 2
    Format: S24_3BE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 4
    Altset 3
    Format: S24_3BE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 4
    Altset 4
    Format: S16_BE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 4
    Altset 5
    Format: S16_BE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 8000 - 48000 (continuous)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
