From: Connor McAdams <conmanx360@gmail.com>
Subject: [GIT PULL] Additional firmware files for CA0132 HD-audio codec
Date: Wed, 10 Oct 2018 13:49:23 -0400
Message-ID: <20181010174923.GA29921@connor-Z97X-Gaming-7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-firmware@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:

  Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)

are available in the git repository at:

  git@github.com:Conmanx360/linux-firmware.git 

for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:

  linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)

----------------------------------------------------------------
These are additional firmware files for CA0132 based sound cards.

Creative has given me permission through email to send these to the 
linux-firmware repository under the same license as the previous ca0132 
firmware. I asked my contact if they would sign-off on it, but they said 
to go ahead and submit it and that if there was any issue to contact 
them. 

If you need to contact them, or if there's more info needed, let me know
and I can get see what I can do.
----------------------------------------------------------------
Connor McAdams (1):
      linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec

 WHENCE            |   2 ++
 ctefx-desktop.bin | Bin 0 -> 655856 bytes
 ctefx-r3di.bin    | Bin 0 -> 655816 bytes
 3 files changed, 2 insertions(+)
 create mode 100644 ctefx-desktop.bin
 create mode 100644 ctefx-r3di.bin
