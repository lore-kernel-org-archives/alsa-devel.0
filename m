From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: ALSA/usb-audio: snd_usb_autoresume possible recursive locking detected
Date: Wed, 26 Aug 2015 01:31:27 +0600
Message-ID: <CANCZXo7jFP_j9ymE9xO5kmRoZ0PWUMaj9LimY9ohEokTTnprGA@mail.gmail.com>
References: <20150825133256.GA1804@localhost> <s5hbndvmqb9.wl-tiwai@suse.de>
 <s5h4mjnmnfh.wl-tiwai@suse.de> <20150825171523.GA1413@localhost> <s5ha8tfnrkz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha8tfnrkz.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

I've applied this patch agains your for-next tree
(https//git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git), but
it does not
compile.

Compilation output: http://pastebin.com/hrN196Zs
