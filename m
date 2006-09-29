From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove(). Take 2
Date: Fri, 29 Sep 2006 14:26:16 +0200
Message-ID: <20060929122616.GA28111@elte.hu>
References: <200609282228.02611.annabellesgarden@yahoo.de> <s5hmz8j3q59.wl%tiwai@suse.de> <200609291429.21183.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964860AbWI2Me0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200609291429.21183.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Florin's patch fixes it.

great - i've applied Florin's patch to -rt.

	Ingo
