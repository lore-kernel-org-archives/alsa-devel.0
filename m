From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] Workable vintage driver support mechanism? (Re:
	[PATCH v3] ES938 support for ES18xx driver)
Date: Mon, 06 Oct 2014 21:41:20 +0200
Message-ID: <5432F060.5060307@ladisch.de>
References: <1412027079-15876-1-git-send-email-linux@rainbow-software.org>
	<s5h7g0dzgd5.wl-tiwai@suse.de>
	<201410061555.19007.linux@rainbow-software.org>
	<s5ha959xp53.wl-tiwai@suse.de>
	<20141006184150.GA2465@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141006184150.GA2465@rhlx01.hs-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Andreas Mohr wrote:
> I think I have an idea which might be useful to accept:
> for every piece of sufficiently "vintage" submission,
> people would be tasked with offering (or somehow ensuring)
> a sufficiently closely time-related cleanup in other places.

The problem that such a new driver imposes is not a one-time reduction
in overall kernel quality, but the ongoing maintenance effort.


Regards,
Clemens
