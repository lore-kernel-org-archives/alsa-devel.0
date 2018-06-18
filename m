From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] sound/line6: checkpatch: fix block
	comment style
Date: Mon, 18 Jun 2018 13:21:34 +0200
Message-ID: <20180618112134.GA4289@kroah.com>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
 <1529317779-15908-2-git-send-email-roman.sommer@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 791A12673C7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 13:21:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1529317779-15908-2-git-send-email-roman.sommer@fau.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Sommer <roman.sommer@fau.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Kees Cook <keescook@chromium.org>, linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, Daniel Graefe <daniel.graefe@fau.de>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Hans =?iso-8859-1?B?UC4gTfZsbGVy?= Ebner <hmoller@uc.cl>, =?iso-8859-1?Q?Fabi=E1n?= Inostroza <soulsonceonfire@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 18, 2018 at 12:29:37PM +0200, Roman Sommer wrote:
> CC: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.com>
> CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> CC: "Hans P. M=F6ller Ebner" <hmoller@uc.cl>
> CC: Kees Cook <keescook@chromium.org>
> CC: Kate Stewart <kstewart@linuxfoundation.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "Fabi=E1n Inostroza" <soulsonceonfire@gmail.com>
> CC: Bhumika Goyal <bhumirks@gmail.com>
> CC: Philippe Ombredanne <pombredanne@nexb.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: alsa-devel@alsa-project.org
> CC: linux-kernel@vger.kernel.org
> =

> This patch fixed the style of multiline comments in sound/usb/line6.

Why is all of those cc: lines in the changelog body?

Very odd...

greg k-h
