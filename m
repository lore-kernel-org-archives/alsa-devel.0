From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sound: use enum names instead of magic numbers
Date: Sat, 29 Nov 2014 20:57:21 -0800
Message-ID: <1417323441.818.4.camel@perches.com>
References: <1417201196-12392-1-git-send-email-KyleChamberlin@project20million.org>
	 <s5h7fydbv6w.wl-tiwai@suse.de> <1417294692.818.3.camel@perches.com>
	 <547AA272.6070308@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547AA272.6070308@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2014-11-30 at 13:52 +0900, Takashi Sakamoto wrote:
> On 2014=E5=B9=B411=E6=9C=8830=E6=97=A5 05:58, Joe Perches wrote:
> > There's an enum defined for these magic numbers,
> > might as well use it.
[]
> I think it better to split this patch into two parts, one is for
> enumeration identifier and another is for variadic macro.

Go ahead then.
