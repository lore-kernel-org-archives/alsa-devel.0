From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: 2.6.29 regression: left audio channel broken after resume from
	suspend with Intel HDA
Date: Tue, 21 Apr 2009 09:32:19 +0200
Message-ID: <20090421073219.GA5866@dose.home.local>
References: <20090420184024.GA10155@dose.home.local> <s5hmyab15bh.wl%tiwai@suse.de> <20090420194659.GA11399@dose.home.local> <s5h8wluinon.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753950AbZDUHcd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h8wluinon.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 21, 2009 at 07:24:40 +0200, Takashi Iwai wrote:
> The commit is fcad94a4c71c36a05f4d5c6dcb174534b4e0b136:
>     ALSA: hda - Fix the cmd cache keys for amp verbs

Thanks for the reply. However, the patch doesn't work. I just got
distorted sound again.

Regards,
Tino
